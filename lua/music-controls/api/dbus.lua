local lgi = require('lgi')
local Gio = lgi.Gio

local M = {}

M.bus = Gio.bus_get_sync(Gio.BusType.SESSION)

M.get_proxy = function(bus_name, interface)
  return Gio.DBusProxy.new_sync(
    M.bus,
    Gio.DBusProxyFlags.NONE,
    nil,
    bus_name,
    '/org/mpris/MediaPlayer2',
    interface,
    nil
  )
end

M.list_players = function()
  local reply = M.bus:call_sync(
    'org.freedesktop.DBus',
    '/org/freedesktop/DBus',
    'org.freedesktop.DBus',
    'ListNames',
    nil,
    nil,
    Gio.DBusCallFlags.NONE,
    -1
  )

  local players = {}
  local names_variant = reply.value[1]

  for i = 0, names_variant:n_children() - 1 do
    local name = names_variant:get_child_value(i).value
    if name:match('^org%.mpris%.MediaPlayer2') then
      table.insert(players, name)
    end
  end

  return players
end

return M
