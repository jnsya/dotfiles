-- Keymaps on top of LazyVim's defaults
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Exit insert mode with jk (muscle memory)
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
