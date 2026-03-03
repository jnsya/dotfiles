-- Language support: Rails tooling, test runner, and Unix helpers.
-- LSPs/formatters/parsers are pulled in via the extras in lua/config/lazy.lua.
return {
  -- Rails-specific navigation: gf, :A, :R, :Emodel, :Econtroller, :Eview etc.
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },

  -- Test runner. <leader>t runs nearest test, <leader>T runs whole file.
  -- To run via docker, uncomment and set the executable below.
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>t", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
      { "<leader>T", "<cmd>TestFile<CR>",    desc = "Run test file" },
    },
    config = function()
      vim.g["test#strategy"]              = "neovim"
      vim.g["test#neovim#term_position"]  = "vert"
      -- Uncomment to run specs inside a docker container:
      -- vim.g["test#ruby#rspec#executable"] = "docker exec -t -e RAILS_ENV=test <container_name> rspec"
    end,
  },

  -- Unix shell commands: :Move, :Rename, :Delete, :SudoWrite etc.
  { "tpope/vim-eunuch" },
}
