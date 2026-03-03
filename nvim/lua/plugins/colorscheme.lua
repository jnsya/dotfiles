-- Override LazyVim's default colorscheme (tokyonight) with gruvbox
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      contrast = "hard", -- "hard", "" (medium), or "soft"
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
