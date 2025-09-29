local dbus = require('music-controls.api.dbus')
local lgi = require('lgi')
local Gio = lgi.Gio
local GLib = lgi.GLib

local M = {}

M.new = function(bus_name)
  local self = {}
  self.bus_name = bus_name
  self.proxy = dbus.get_proxy(bus_name, 'org.freedesktop.DBus.Properties')

  function self.get(iface, prop)
    local res = self.proxy:call_sync('Get', GLib.Variant('(ss)', { iface, prop }), Gio.DBusCallFlags.NONE, -1, nil)
    return res.value[1].value
  end

  function self.set(iface, prop, value, signature)
    self.proxy:call_sync(
      'Set',
      GLib.Variant('(ssv)', { iface, prop, GLib.Variant(signature, value) }),
      Gio.DBusCallFlags.NONE,
      -1,
      nil
    )
  end

  return self
end

return M
