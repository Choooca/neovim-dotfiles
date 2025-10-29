local M = {}

M.is_windows = vim.fn.has("win32") == 1
M.is_wsl = vim.fn.has("wsl") == 1
M.is_mac = vim.fn.has("macunix") == 1
M.is_linux = not M.is_windows and not M.is_wsl and not M.is_mac

M.sep = package.config:sub(1, 1)

function M.join_paths(...)
  return table.concat({ ... }, M.sep)
end

function M.mason_bin(tool)
  local bin_path = M.join_paths(vim.fn.stdpath("data"), "mason", "bin", tool)
  if M.is_windows then
    return bin_path .. ".cmd"
  end
  return bin_path
end

return M
