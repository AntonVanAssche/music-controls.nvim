local dbus = require('music-controls.api.dbus')
local lgi = require('lgi')
local Gio = lgi.Gio

local M = {}

M.new = function(bus_name)
  local self = {}
  self.bus_name = bus_name
  self.proxy = dbus.get_proxy(bus_name, 'org.mpris.MediaPlayer2.Player')

  function self.play()
    self.proxy:call_sync('Play', nil, Gio.DBusCallFlags.NONE, -1, nil)
  end

  function self.pause()
    self.proxy:call_sync('Pause', nil, Gio.DBusCallFlags.NONE, -1, nil)
  end

  function self.play_pause()
    self.proxy:call_sync('PlayPause', nil, Gio.DBusCallFlags.NONE, -1, nil)
  end

  function self.next()
    self.proxy:call_sync('Next', nil, Gio.DBusCallFlags.NONE, -1, nil)
  end

  function self.previous()
    self.proxy:call_sync('Previous', nil, Gio.DBusCallFlags.NONE, -1, nil)
  end

  function self.meta()
    local res = self.proxy:call_sync('GetMetadata', nil, Gio.DBusCallFlags.NONE, -1, nil)
    return res.value[1]
  end

  return self
end

return M
