local utils = require('music-controls.utils')

local M = {}

M.execute = function(player)
  if not player then
    vim.api.nvim_err_writeln('MusicControls: No player found')
    return
  end

  local cmd = { 'playerctl', '-p', player, 'pause' }
  local result, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  return result
end

return M
