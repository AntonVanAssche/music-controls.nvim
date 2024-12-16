local utils = require('music-controls.utils')
local M = {}

local _is_valid_volume = function(volume)
  return volume ~= nil
end

local _get_volume = function(player)
  local cmd = { 'playerctl', '-p', player, 'volume' }
  local result, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return nil
  end

  local volume = tonumber(result)
  return string.format('%.2f', volume)
end

local _set_volume = function(player, volume)
  local cmd = { 'playerctl', '-p', player, 'volume', volume }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: ' .. err)
    return false
  end

  return true
end

local _to_percentage = function(volume)
  return string.format('%.2f', volume * 100)
end

M.get = function(player)
  if not player then
    return vim.api.nvim_err_writeln('MusicControls: No player found')
  end

  local volume = _get_volume(player)
  return _to_percentage(volume)
end

M.set = function(player, volume)
  volume = tonumber(volume) or 0.5

  if not player then
    return vim.api.nvim_err_writeln('MusicControls: No player found')
  end

  if not _is_valid_volume(volume) then
    return vim.api.nvim_err_writeln('MusicControls: Invalid volume')
  end

  local result = _set_volume(player, volume)
  if not result then
    return nil
  end

  return _to_percentage(volume)
end

return M
