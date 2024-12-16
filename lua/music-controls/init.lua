local cmds = {
  list_players = require('music-controls.cmds.list_players'),
  current = require('music-controls.cmds.current'),
  loop = require('music-controls.cmds.loop'),
  next = require('music-controls.cmds.next'),
  pause = require('music-controls.cmds.pause'),
  play = require('music-controls.cmds.play'),
  prev = require('music-controls.cmds.prev'),
  shuffle = require('music-controls.cmds.shuffle'),
  volume = require('music-controls.cmds.volume'),
}
local config = require('music-controls.config')
local M = {}

M.current = function(player)
  return cmds.current.current(player or config.config.default_player)
end

M.current_volume = function(player)
  return cmds.volume.current_volume(player or config.config.default_player)
end

M.list_players = function()
  return cmds.list_players.list_players()
end

M.loop = function(player, mode)
  player = player or config.config.default_player
  mode = mode or 'Track'

  local modes = { 'Track', 'Playlist', 'None' }
  if not mode then
    if player and not modes:includes(player) then
      mode = player
      player = config.config.default_player
    end
  end

  return cmds.loop.loop(player, mode)
end

M.loop_toggle = function(player)
  return cmds.loop.loop_toggle(player or config.config.default_player)
end

M.next = function(player, amount)
  player = player or config.config.default_player
  amount = amount or 1

  if player and tonumber(player) then
    player = config.config.default_player
    amount = player
  end

  return cmds.next.next(player, amount)
end

M.pause = function(player)
  return cmds.pause.pause(player or config.config.default_player)
end

M.play = function(player)
  return cmds.play.play(player or config.config.default_player)
end

M.prev = function(player, amount)
  player = player or config.config.default_player
  amount = amount or 1

  if player and tonumber(player) then
    player = config.config.default_player
    amount = player
  end

  return cmds.prev.prev(player, amount)
end

M.set_volume = function(player, volume)
  player = player or config.config.default_player
  volume = volume or 0.5

  if player and tonumber(player) then
    player = config.config.default_player
    volume = player
  end

  return cmds.volume.set_volume(player, volume)
end

M.shuffle = function(player)
  return cmds.shuffle.shuffle(player or config.config.default_player)
end

M._statusline = function()
  local player = config.config.default_player
  if not player then
    return 'No default player set'
  end

  return cmds.current._statusline(player)
end

M.setup = function(opts)
  config.setup(opts)
end

return M
