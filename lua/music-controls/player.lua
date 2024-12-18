local utils = require('music-controls.utils')

local M = {}

local _is_valid_volume = function(volume)
  return volume ~= nil
end

local _to_percentage = function(volume)
  return string.format('%.2f', volume * 100)
end

M.get_all = function()
  local result, err = utils.exec_command({ 'playerctl', '-l' })
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  return result and vim.split(result, '\n') or {}
end

M.get_volume = function(player)
  if not utils.validate_player(player) then
    return nil
  end

  local cmd = { 'playerctl', '-p', player, 'volume' }
  local result, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  local volume = tonumber(result)
  return _to_percentage(volume)
end

M.set_volume = function(player, volume)
  if not utils.validate_player(player) then
    return nil
  end

  if not _is_valid_volume(volume) then
    return vim.api.nvim_err_writeln('MusicControls: Invalid volume')
  end

  local cmd = { 'playerctl', '-p', player, 'volume', volume }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  return _to_percentage(volume)
end

return M
