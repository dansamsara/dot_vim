if vim.g.vscode then
  return
end

require("coverage").setup()

if string.find(vim.o.runtimepath, "copilot.vim") and string.find(vim.o.runtimepath, "CopilotChat.nvim") then
  require("copilot")
end
