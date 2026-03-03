-- Keymaps on top of LazyVim's defaults
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Exit insert mode with jk (muscle memory)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Yank the relative filepath of the current buffer to the clipboard
vim.keymap.set("n", "<leader>fY", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Yank relative filepath" })

-- Visual mode: search and replace the selected text across the file
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Search/replace selection" })

-- Rails: toggle between implementation and test file (vim-rails :A)
vim.keymap.set("n", "<leader>a", "<cmd>A<CR>", { desc = "Alternate file (vim-rails)" })

-- Quick access to dotfiles from anywhere
vim.api.nvim_create_user_command("Zshrc",     "e ~/dotfiles/zshrc", {})
vim.api.nvim_create_user_command("Gitconfig", "e ~/dotfiles/gitconfig", {})
vim.api.nvim_create_user_command("Brewfile",  "e ~/dotfiles/Brewfile", {})
vim.api.nvim_create_user_command("Nvimrc",    "e ~/dotfiles/nvim/lua/plugins/", {})
vim.api.nvim_create_user_command("Todo",      "e ~/notes/Todo_Today.md", {})
