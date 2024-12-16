local config = require('music-controls.config')
local utils = require('music-controls.utils')
local actions = {
  players = require('music-controls.actions.players'),
  play = require('music-controls.actions.play'),
  pause = require('music-controls.actions.pause'),
  next = require('music-controls.actions.next'),
  prev = require('music-controls.actions.prev'),
  current = require('music-controls.actions.current'),
  shuffle = require('music-controls.actions.shuffle'),
  loop = require('music-controls.actions.loop'),
  volume = require('music-controls.actions.volume'),
}
local M = {}

M.get_players = function()
  local _players = actions.players.get() or {}

  vim.api.nvim_echo({ { 'Players:' } }, true, {})
  for _, _player in ipairs(_players) do
    vim.api.nvim_echo({ { _player } }, true, {})
  end
end

M.play = function(player)
  player = player or config.config.default_player
  local result = actions.play.execute(player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle play/pause')
  end

  utils.sleep(0.1)
  local state, title, artist = actions.current.get(player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.pause = function(player)
  player = player or config.config.default_player
  local result = actions.pause.execute(player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not pause')
  end

  utils.sleep(0.1)
  local state, title, artist = actions.current.get(player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.next = function(player, amount)
  player = player or config.config.default_player
  if player and tonumber(player) then
    amount = player
    player = config.config.default_player
  end

  local result = actions.next.execute(player, amount)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not skip')
  end

  utils.sleep(0.1)
  local state, title, artist = actions.current.get(player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.prev = function(player, amount)
  player = player or config.config.default_player
  if player and tonumber(player) then
    amount = player
    player = config.config.default_player
  end

  local result = actions.prev.execute(player, amount)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not go back')
  end

  utils.sleep(0.1)
  local state, title, artist = actions.current.get(player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.current = function(player)
  player = player or config.config.default_player
  local state, title, artist = actions.controls.current(player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.shuffle = function(player)
  player = player or config.config.default_player
  local result = actions.shuffle.toggle(player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle shuffle mode')
  end

  vim.api.nvim_echo({ { string.format('Shuffle mode: %s', result) } }, true, {})
end

M.loop = function(player, mode)
  player = player or config.config.default_player

  if not mode then
    local modes = { 'Track', 'Playlist', 'None' }
    if vim.tbl_contains(modes, player) then
      mode = player
      player = config.config.default_player
    end
  end

  local result = actions.loop.set(player, mode)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set loop mode')
  end

  vim.api.nvim_echo({ { string.format('Loop mode: %s', result) } }, true, {})
end

M.toggle_loop = function(player)
  player = player or config.config.default_player
  local result = actions.loop.toggle(player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle loop mode')
  end

  vim.api.nvim_echo({ { string.format('Loop mode: %s', result) } }, true, {})
end

M.get_volume = function(player)
  player = player or config.config.default_player
  local result = actions.volume.get(player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set volume')
  end

  vim.api.nvim_echo({ { string.format('Volume: %s%%', result) } }, true, {})
end

M.set_volume = function(player, vol)
  player = player or config.config.default_player
  vol = tonumber(vol)

  if player and tonumber(player) then
    vol = tonumber(player)
    player = config.config.default_player
  end

  local result = actions.volume.set(player, vol)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set volume')
  end

  vim.api.nvim_echo({ { string.format('Volume: %s%%', result) } }, true, {})
end

M._statusline = function()
  local player = config.config.default_player
  local state, title, artist = actions.current.get(player)
  local str = string.format('%s %s - %s', state, title, artist)
  return str
end

M.setup = function(opts)
  config.setup(opts)
end

return M
