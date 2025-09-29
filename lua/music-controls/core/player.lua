local dbus = require('music-controls.api.dbus')
local PlayerAPI = require('music-controls.api.mpris_player')
local PropsAPI = require('music-controls.api.mpris_props')

local M = {}

local function build_player_map()
  local map = {}
  local buses = dbus.list_players() or {}
  for _, full_name in ipairs(buses) do
    local short_name = full_name:match('^org%.mpris%.MediaPlayer2%.(.+)$')
    if short_name then
      map[short_name:lower()] = full_name
    end
  end
  return map
end

local function get_bus_name(short_name)
  local player_map = build_player_map()

  if not next(player_map) then
    return nil
  end

  if not short_name then
    for _, full_name in pairs(player_map) do
      return full_name
    end
  end

  return player_map[short_name:lower()]
end

M.get_all = function()
  local player_map = build_player_map()
  local names = {}
  for short_name, _ in pairs(player_map) do
    table.insert(names, short_name)
  end
  return names
end

M.new = function(name)
  local bus_name = get_bus_name(name)
  if not bus_name then
    return nil, 'Player not found'
  end

  local self = {}
  self.name = name
  self.player = PlayerAPI.new(bus_name)
  self.props = PropsAPI.new(bus_name)

  function self.play()
    if self.player then
      self.player.play()
    end
  end

  function self.pause()
    if self.player then
      self.player.pause()
    end
  end

  function self.play_pause()
    if self.player then
      self.player.play_pause()
    end
  end

  function self.next(amount)
    amount = amount or 1
    if self.player then
      for _ = 1, amount do
        self.player.next()
      end
    end
  end

  function self.previous(amount)
    amount = amount or 1
    if self.player then
      for _ = 1, amount do
        self.player.previous()
      end
    end
  end

  function self.volume()
    if self.props then
      return self.props.get('org.mpris.MediaPlayer2.Player', 'Volume') or 0
    end
    return 0
  end

  function self.set_volume(vol)
    if self.props then
      self.props.set('org.mpris.MediaPlayer2.Player', 'Volume', vol, 'd')
    end
  end

  function self.metadata()
    if self.props then
      return self.props.get('org.mpris.MediaPlayer2.Player', 'Metadata') or {}
    end
    return {}
  end

  function self.playback_status()
    if self.props then
      return self.props.get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus') or 'Stopped'
    end
    return 'Stopped'
  end

  return self
end

return M
