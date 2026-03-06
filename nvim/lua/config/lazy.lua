-- Bootstrap lazy.nvim (auto-installs if missing)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to continue...", "" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1. LazyVim base
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 2. LazyVim extras (must come before user plugins)
    { import = "lazyvim.plugins.extras.lang.ruby" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    -- 3. Your custom plugin specs (lua/plugins/*.lua)
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  -- Try catppuccin first, fall back to built-in habamax during initial install
  install = { colorscheme = { "catppuccin", "habamax" } },
  -- Check for plugin updates silently in the background
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tomlPlugin", "tutor", "zipPlugin" },
    },
  },
})
