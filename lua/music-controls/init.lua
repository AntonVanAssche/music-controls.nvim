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
local M = {}
local settings = {
  default_player = '',
}

M.current = function(player)
  return cmds.current.current(player[1] or settings.default_player)
end

M.current_volume = function(player)
  return cmds.volume.current_volume(player[1] or settings.default_player)
end

M.list_players = function()
  return cmds.list_players.list_players()
end

M.loop = function(args)
  local player = args[1] or settings.default_player -- Use default player if args[1] is nil.
  local mode = args[2] or 'Track' -- Default to 'Track' if no mode is provided.

  if not args[2] then
    if args[1] == 'Track' or args[1] == 'Playlist' or args[1] == 'None' then
      player = settings.default_player
      mode = args[1]
    end
  end

  return cmds.loop.loop(player, mode)
end

M.next = function(args)
  local player = args[1] or settings.default_player -- Use default player if args[1] is nil.
  local amount = args[2] or 1 -- Default amount to 1 if args[2] is nil.

  if args[1] and tonumber(args[1]) then
    player = settings.default_player
    amount = args[1]
  end

  return cmds.next.next(player, amount)
end

M.pause = function(player)
  return cmds.pause.pause(player[1] or settings.default_player)
end

M.play = function(player)
  return cmds.play.play(player[1] or settings.default_player)
end

M.prev = function(args)
  local player = args[1] or settings.default_player -- Use default player if args[1] is nil.
  local amount = args[2] or 1 -- Default amount to 1 if args[2] is nil.

  if args[1] and tonumber(args[1]) then
    player = settings.default_player
    amount = args[1]
  end

  return cmds.prev.prev(player, amount)
end

M.set_volume = function(args)
  local player = args[1] or settings.default_player -- Use default player if args[1] is nil.
  local volume = args[2] or 0.5 -- Default volume to 0.5 if args[2] is nil.

  if args[1] and tonumber(args[1]) then
    player = settings.default_player
    volume = args[1]
  end

  return cmds.volume.set_volume(player, volume)
end

M.shuffle = function(player)
  return cmds.shuffle.shuffle(player[1] or settings.default_player)
end

M.setup = function(opts)
  if opts then
    for k, v in pairs(opts) do
      settings[k] = v
    end
  end
end

return M
