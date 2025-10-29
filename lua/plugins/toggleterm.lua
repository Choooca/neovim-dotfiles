return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-l>]],
      direction = "horizontal",
      shell = vim.o.shell, -- Auto-détecte : PowerShell/bash/zsh
    })

    -- Sortir du terminal avec Escape
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
  end,
}
