local config = require('music-controls.config')
local utils = require('music-controls.utils')
local controls = require('music-controls.controls')
local player = require('music-controls.player')

local M = {}

M.get_players = function()
  local _players = player.get_all() or {}

  vim.api.nvim_echo({ { 'Players:' } }, true, {})
  for _, _player in ipairs(_players) do
    vim.api.nvim_echo({ { _player } }, true, {})
  end
end

M.play = function(_player)
  _player = _player or config.config.default_player
  local result = controls.play(_player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle play/pause')
  end

  utils.sleep(0.25)
  local state, title, artist = controls.current(_player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.pause = function(_player)
  _player = _player or config.config.default_player
  local result = controls.pause(_player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not pause')
  end

  utils.sleep(0.25)
  local state, title, artist = controls.current(_player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.next = function(_player, amount)
  _player = _player or config.config.default_player
  amount = amount or 1

  local result = controls.next(_player, amount)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not skip')
  end

  utils.sleep(0.25)
  local state, title, artist = controls.current(_player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.prev = function(_player, amount)
  _player = _player or config.config.default_player
  amount = amount or 1

  local result = controls.previous(_player, amount)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not go back')
  end

  utils.sleep(0.25)
  local state, title, artist = controls.current(_player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.current = function(_player)
  _player = _player or config.config.default_player
  local state, title, artist = controls.current(_player)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

M.shuffle = function(_player)
  _player = _player or config.config.default_player
  local result = controls.shuffle(_player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle shuffle mode')
  end

  vim.api.nvim_echo({ { string.format('Shuffle mode: %s', result) } }, true, {})
end

M.loop = function(_player, mode)
  _player = _player or config.config.default_player
  mode = mode or 'Track'

  local result = controls.loop(_player, mode)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set loop mode')
  end

  vim.api.nvim_echo({ { string.format('Loop mode: %s', result) } }, true, {})
end

M.toggle_loop = function(_player)
  _player = _player or config.config.default_player
  local result = controls.toggle_loop(_player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not toggle loop mode')
  end

  vim.api.nvim_echo({ { string.format('Loop mode: %s', result) } }, true, {})
end

M.get_volume = function(_player)
  _player = _player or config.config.default_player
  local result = player.get_volume(_player)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set volume')
  end

  vim.api.nvim_echo({ { string.format('Volume: %s%%', result) } }, true, {})
end

M.set_volume = function(_player, vol)
  _player = _player or config.config.default_player
  vol = tonumber(vol) or 0.5

  local result = player.set_volume(_player, vol)
  if not result then
    vim.api.nvim_err_writeln('MusicControls: Could not set volume')
  end

  vim.api.nvim_echo({ { string.format('Volume: %s%%', result) } }, true, {})
end

M._statusline = function()
  local _player = config.config.default_player
  local state, title, artist = controls.current(_player)
  local str = string.format('%s %s - %s', state, title, artist)
  return str
end

M.setup = function(opts)
  config.setup(opts)
end

return M
