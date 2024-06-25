if vim.g.vscode then
  return
end

require("coverage").setup()
require("ai-pane").setup({
  command = os.getenv("HOME") .. "/.bin/claude",
  current_window_only = true,
  prompts = {
    Commit = {
      prompt = "Write a concise commit message for the staged changes. Follow the conventional commit format and style guide in @/home/ubuntu/co/backend/.cursor/rules/engbook/git-commit-style-guide.mdc. Include:\n- Clear, imperative mood subject line (50 chars max)\n- Body explaining what and why (if needed)\n- Reference any related issues/tickets\n- Focus on the business impact or technical reasoning. Write the message to @.git/COMMIT_EDITMSG",
    },
    PullRequest = {
      prompt = "Analyze the git diff and commit messages since master branch. Create a pull request description following the template in @/home/ubuntu/co/backend/.github/PULL_REQUEST_TEMPLATE.md. Requirements: 1) Keep ALL template sections intact, 2) Fill each section with relevant details from the code changes, 3) Use clear, professional language, 4) Include a general summary of what changed and why, 5) Mention any breaking changes or migration steps if any, 6) List related issues/tickets if apparent from commit messages. Save the output to the  @.claude/pr_message.md file.",
      mapping = "<leader>cpp",
      normal_mode = "none",
      visual_mode = "none",
    },
  },
})

local is_render_markdown_available, render_markdown = pcall(require, "render-markdown")
if is_render_markdown_available then
  render_markdown.setup({
    file_types = { "markdown", "copilot-chat" },
  })
end

local is_mcphub_available, mcphub = pcall(require, "mcphub")
if is_mcphub_available then
  mcphub.setup({
    extensions = {
      copilotchat = {
        enabled = true,
        convert_tools_to_functions = true,
        convert_resources_to_functions = true,
        add_mcp_prefix = false,
      },
    },
  })
end

local is_copilot_available, _ = pcall(require, "copilot")
local is_copilotchat_available, _ = pcall(require, "CopilotChat")
if is_copilot_available and is_copilotchat_available then
  require("copilot")
end
