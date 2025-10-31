return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()

    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "slant",

        show_tab_indicators = true,

        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    })

    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "<leader>bc", ":bdelete<CR>")
  end,
}
