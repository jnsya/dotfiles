-- Autocmds on top of LazyVim's defaults
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Jenkinsfiles are Groovy — syntax highlight accordingly
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Jenkinsfile",
  callback = function()
    vim.bo.filetype = "groovy"
  end,
})
