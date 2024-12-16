local utils = require('music-controls.utils')
local M = {}

local _get_mode = function(player)
  local cmd = { 'playerctl', '-p', player, 'loop' }
  local result, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to get loop mode')
    return nil
  end

  return vim.trim(result)
end

local _set_mode = function(player, mode)
  local cmd = { 'playerctl', '-p', player, 'loop', mode }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to set loop mode')
    return nil
  end

  return mode
end

M.set = function(player, mode)
  mode = mode or 'Track'

  if not player then
    vim.api.nvim_err_writeln('MusicControls: No player found')
    return nil
  end

  if not vim.tbl_contains({ 'Track', 'Playlist', 'None' }, mode) then
    vim.api.nvim_err_writeln('MusicControls: Invalid mode')
    return nil
  end

  local new_mode = _set_mode(player, mode)
  if not new_mode then
    vim.api.nvim_err_writeln('MusicControls: Unable to set loop mode')
    return nil
  end

  return new_mode
end

M.toggle = function(player)
  if not player then
    vim.api.nvim_err_writeln('MusicControls: No player found')
    return nil
  end

  local mode = _get_mode(player)
  if not mode then
    vim.api.nvim_err_writeln('MusicControls: Unable to get loop mode')
    return nil
  end

  local next_mode = (mode == 'None') and 'Track' or 'None'
  return M.set(player, next_mode)
end

return M
