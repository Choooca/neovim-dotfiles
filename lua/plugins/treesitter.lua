return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'master',
  lazy = false,
  build = function()
    -- Sur Windows, utilise une méthode alternative
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").update({ with_sync = true })
    else
      vim.cmd("TSUpdate")
    end
  end,
  config = function()
    local config = require('nvim-treesitter.configs')

    if vim.fn.has("win32") == 1 then
      require('nvim-treesitter.install').compilers = { "clang", "gcc", "cl" }
    end

    config.setup({
      auto_install = true,
      ensure_installed = { "lua", "c", "cpp", "cmake", "make" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
