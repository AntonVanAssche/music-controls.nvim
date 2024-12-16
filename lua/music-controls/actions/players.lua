local utils = require('music-controls.utils')

local M = {}

M.get = function()
  local result, err = utils.exec_command({ 'playerctl', '-l' })
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  return result and vim.split(result, '\n') or {}
end

return M
