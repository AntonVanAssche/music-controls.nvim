local utils = require('music-controls.utils')

local M = {}

M.execute = function(player, amount)
  if not player then
    return vim.api.nvim_err_writeln('MusicControls: No player found')
  end

  local cmd = { 'playerctl', '-p', player, 'next' }
  for _ = 1, amount or 1 do
    local _, err = utils.exec_command(cmd)
    if err then
      vim.api.nvim_err_writeln('MusicControls: ' .. err)
      return nil
    end
  end

  return true
end

return M
