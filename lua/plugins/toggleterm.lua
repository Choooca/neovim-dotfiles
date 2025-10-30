return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local shell
    if vim.fn.has("win32") == 1 then
      if vim.fn.executable("pwsh") == 1 then
        shell = "pwsh.exe"
      else
        shell = "powershell.exe"
      end
    else
      shell = vim.o.shell
    end

    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-l>]],
      direction = "horizontal",
      shell = shell,
    })

    -- Sortir du terminal avec Escape
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
  end,
}
