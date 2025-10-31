return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false,                    -- neo-tree will lazily load itself
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 30,

        mappings = {
          ["t"] = "open_tabnew",
        }
      },

      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_default",
      },

      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    })


    vim.keymap.set('n', '<C-n>', ':Neotree reveal left<CR>')
  end
}
