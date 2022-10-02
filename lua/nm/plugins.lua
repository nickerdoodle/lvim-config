lvim.plugins = {
  { "Mofiqul/vscode.nvim" },
  { "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  },
}
