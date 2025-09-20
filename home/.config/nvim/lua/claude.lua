-- Neovim + tmux integration for Claude: connect to existing or create new Claude panes,
-- send filenames (@file syntax), buffer contents, or visual selections via tmux send-keys

-- Known Issues:
-- When using Amazon Bedrock, authentication doesn't work, requiring claude to be opened manually to authenticate
local M = {}

local claude_pane = nil

-- Configuration
local config = {
  -- Default command using claude directly
  command = "claude",
  -- Whether to create default keymaps
  create_keymaps = true,
}

-- Allow users to override config
function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
end

-- Execute shell command and return trimmed output
-- Used for tmux commands that need to capture output like pane IDs
local function sh(cmd)
  local h = io.popen(cmd)
  if not h then return nil end
  local out = h:read("*a") or ""
  local success = h:close()
  if not success then return nil end  -- Command failed
  return vim.trim(out)
end

-- Search all tmux panes for one running Claude
-- Returns the pane ID if found, nil otherwise
local function find_claude_pane()
  local panes_output = sh("tmux list-panes -a -F '#{pane_id} #{pane_current_command}'")
  if not panes_output then return nil end

  for line in panes_output:gmatch("[^\n]+") do
    local pane_id, command = line:match("^(%%[0-9]+) (.+)$")
    if pane_id and command and command:match("claude") then
      return pane_id
    end
  end
  return nil
end

-- Check if we have a valid Claude pane ID stored
local function ensure_pane()
  if not claude_pane or #claude_pane == 0 then
    return false
  end

  -- Verify the stored pane still exists by checking tmux directly
  local pane_exists = sh(string.format("tmux list-panes -a -F '#{pane_id}' | grep -q '^%s$' && echo 1 || echo 0", claude_pane))
  if pane_exists == "1" then
    return true
  else
    -- Our stored pane no longer exists, clear it
    claude_pane = nil
    return false
  end
end

-- Create a new tmux pane and start Claude in it
-- split_flag: "h" for horizontal (top/bottom), anything else for vertical (left/right)
local function start_claude(split_flag)
  local flag = (split_flag == "h") and "-v" or "-h"  -- tmux flags are inverted from intuition

  local run = config.command or "claude"

  local pane = sh(("tmux split-window %s -P -F '#{pane_id}' %s"):format(flag, vim.fn.shellescape(run)))
  if pane and #pane > 0 then
    claude_pane = pane
    vim.notify("Created new Claude pane: "..pane.." ("..flag..")")
  else
    vim.notify("Failed to start Claude (tmux split-window)", vim.log.levels.ERROR)
  end
end

local function connect_claude()
  local existing_pane = find_claude_pane()
  if existing_pane then
    claude_pane = existing_pane
    vim.notify("Connected to existing Claude pane: " .. existing_pane)
    return true
  else
    local choice = vim.fn.confirm("No existing Claude pane found. Start a new one?", "&Yes\n&No", 1)
    if choice == 1 then
      start_claude("v")  -- Default to vertical split
      return true
    else
      vim.notify("No Claude pane connected", vim.log.levels.INFO)
      return false
    end
  end
end

-- Send text to the Claude pane via tmux send-keys
-- Uses -- separator to prevent text starting with -- from being interpreted as tmux flags
local function send_text(text, press_enter)
  if not ensure_pane() and not connect_claude() then
    return
  end

  local escaped_text = vim.fn.shellescape(text)
  local cmd = string.format("tmux send-keys -t %s -- %s", claude_pane, escaped_text)

  if press_enter then
    cmd = cmd .. string.format(" && tmux send-keys -t %s Enter", claude_pane)
  end

  local result = os.execute(cmd)
  if result ~= 0 then
    vim.notify("Failed to send text to Claude pane", vim.log.levels.ERROR)
  end
end

-- Get current filename or nil with error notification
local function get_filename()
  local filename = vim.fn.expand("%")
  if filename == "" then
    vim.notify("No file name for this buffer.", vim.log.levels.WARN)
    return nil
  end
  return filename
end

local function send_filename()
  local filename = get_filename()
  if not filename then return end
  -- Use @ prefix - this is Claude-specific syntax for file references
  send_text("@" .. filename, false)
end

-- Send the current visual selection to Claude
-- Handles both full line and partial line selections correctly
local function send_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- vim.fn.getline can return string or table depending on line count
  if type(lines) == "string" then
    lines = { lines }
  end

  if #lines == 0 then
    vim.notify("No visual selection found.", vim.log.levels.WARN)
    return
  end

  -- Trim lines to the actual selected portion
  if #lines == 1 then
    -- Single line selection: extract just the selected characters
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Multi-line selection: trim first and last lines
    lines[1] = string.sub(lines[1], start_pos[3])  -- From start column to end
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])  -- From beginning to end column
  end

  local selection_text = table.concat(lines, "\n")
  send_text(selection_text, false)
end

-- Send file path with line range based on visual selection to Claude
-- Example output: @home/.config/nvim/lua/claude.lua:213-215
local function send_visual_range()
  local filename = get_filename()
  if not filename then return end

  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  local range_ref
  if start_line == end_line then
    range_ref = string.format("@%s:%d", filename, start_line)
  else
    range_ref = string.format("@%s:%d-%d", filename, start_line, end_line)
  end

  send_text(range_ref, false)
end

-- Send entire buffer to Claude in manageable chunks
-- Chunking prevents shell command length limit errors that occur with very long lines
-- or large files (e.g., minified code, generated files)
local function send_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  -- Character-based chunking is more reliable than line-based for files with very long lines
  local max_chunk_chars = 10000  -- 10KB chunks avoid tmux command length limits
  local chunk_lines = {}
  local chunk_chars = 0

  for _, line in ipairs(lines) do
    local line_chars = #line + 1  -- +1 accounts for newline character

    -- Send current chunk if adding this line would exceed the limit
    if chunk_chars + line_chars > max_chunk_chars and #chunk_lines > 0 then
      send_text(table.concat(chunk_lines, "\n"), false)
      chunk_lines = {}
      chunk_chars = 0
    end

    table.insert(chunk_lines, line)
    chunk_chars = chunk_chars + line_chars
  end

  -- Send any remaining lines in the final chunk
  if #chunk_lines > 0 then
    send_text(table.concat(chunk_lines, "\n"), false)
  end
end

vim.api.nvim_create_user_command("ClaudeStart", function(opts)
  start_claude(opts.args == "h" and "h" or "v")
end, { nargs = "?" })

vim.api.nvim_create_user_command("ClaudeConnect", function()
  connect_claude()
end, {})

vim.api.nvim_create_user_command("ClaudeSendFile", function()
  send_filename()
end, {})

vim.api.nvim_create_user_command("ClaudeSendBuffer", function()
  send_buffer()
end, {})

vim.api.nvim_create_user_command("ClaudeSendSelection", function()
  send_visual_selection()
end, { range = true })

vim.api.nvim_create_user_command("ClaudeSendRange", function()
  send_visual_range()
end, { range = true })

-- Default keymaps (can be disabled by setting create_keymaps = false in setup)
if config.create_keymaps then
  vim.keymap.set("n", "<leader>cc", ":ClaudeStart v<CR>", { desc = "Start Claude (left/right tmux split)" })
  vim.keymap.set("n", "<leader>cC", ":ClaudeStart h<CR>", { desc = "Start Claude (top/bottom tmux split)" })
  vim.keymap.set("n", "<leader>cn", ":ClaudeConnect<CR>", { desc = "Connect to existing Claude pane" })
  vim.keymap.set("n", "<leader>cs", ":ClaudeSendFile<CR>", { desc = "Send current filename to Claude" })
  vim.keymap.set("n", "<leader>cb", ":ClaudeSendBuffer<CR>", { desc = "Send entire buffer to Claude" })
  vim.keymap.set("v", "<leader>css", ":ClaudeSendSelection<CR>", { desc = "Send visual selection to Claude" })
  vim.keymap.set("v", "<leader>cs", ":ClaudeSendRange<CR>", { desc = "Send file path with line range to Claude" })
end

return M
