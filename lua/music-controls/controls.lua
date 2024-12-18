local utils = require('music-controls.utils')

local M = {}

local _execute = function(player, operation, amount)
  local cmd = { 'playerctl', '-p', player, operation }
  for _ = 1, amount or 1 do
    local _, err = utils.exec_command(cmd)
    if err then
      vim.api.nvim_err_writeln('MusicControls: ' .. err)
      return nil
    end
  end

  return true
end

local _get_state = function(player)
  local icons = { Playing = '▶', Paused = '⏸', Stopped = '⏹' }
  local state, err = utils.exec_command({ 'playerctl', '-p', player, 'status' })
  if err then
    return 'Unknown'
  end

  state = state and state:match('^%s*(.-)%s*$') or 'Unknown'
  return icons[state] or icons.Stopped
end

local _get_song = function(player)
  local cmd = { 'playerctl', '-p', player, 'metadata', '--format', '{{title}}\n{{artist}}' }
  local metadata, err = utils.exec_command(cmd)

  if err then
    return 'Unknown', 'Unknown'
  end

  local title = metadata and metadata:match('([^\n]+)') or 'Unknown'
  local artist = metadata and metadata:match('\n([^\n]+)') or 'Unknown'

  return title, artist
end

local _get_loop_mode = function(player)
  local cmd = { 'playerctl', '-p', player, 'loop' }
  local mode, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to get loop mode')
    return nil
  end

  return vim.split(mode, '\n')[1]
end

local _set_loop_mode = function(player, mode)
  local cmd = { 'playerctl', '-p', player, 'loop', mode }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to set loop mode')
    return nil
  end

  return true
end

local _get_shuffle_mode = function(player)
  local cmd = { 'playerctl', '-p', player, 'shuffle' }
  local mode, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to get shuffle mode')
    return nil
  end

  return mode and mode:match('^%s*(.-)%s*$') or 'Unknown'
end

local _set_shuffle_mode = function(player, mode)
  local cmd = { 'playerctl', '-p', player, 'shuffle', mode }
  local _, err = utils.exec_command(cmd)
  if err then
    vim.api.nvim_err_writeln('MusicControls: Failed to set shuffle mode')
    return nil
  end

  return true
end

M.next = function(player, amount)
  if not utils.validate_player(player) then
    return
  end
  return _execute(player, 'next', amount)
end

M.previous = function(player, amount)
  if not utils.validate_player(player) then
    return
  end
  return _execute(player, 'previous', amount)
end

M.play = function(player)
  if not utils.validate_player(player) then
    return
  end
  return _execute(player, 'play-pause', 1)
end

M.pause = function(player)
  if not utils.validate_player(player) then
    return
  end
  return _execute(player, 'pause', 1)
end

M.loop = function(player, mode)
  if not utils.validate_player(player) then
    return
  end

  if not vim.tbl_contains({ 'Track', 'Playlist', 'None' }, mode) then
    mode = 'Track'
  end

  if not _set_loop_mode(player, mode) then
    return
  end

  return mode
end

M.toggle_loop = function(player)
  if not utils.validate_player(player) then
    return
  end

  local current_mode = _get_loop_mode(player)
  if not current_mode then
    return
  end

  local next_mode = (current_mode == 'None') and 'Track' or 'None'
  if not _set_loop_mode(player, next_mode) then
    return
  end
  return next_mode
end

M.shuffle = function(player)
  if not utils.validate_player(player) then
    return
  end

  local current_mode = _get_shuffle_mode(player)
  if not current_mode then
    return
  end

  local next_mode = (current_mode == 'Off') and 'On' or 'Off'
  if not _set_shuffle_mode(player, next_mode) then
    return
  end

  return next_mode
end

M.current = function(player)
  if not utils.validate_player(player) then
    return
  end

  local state = _get_state(player)
  local title, artist = _get_song(player)
  return state, title, artist
end

return M
