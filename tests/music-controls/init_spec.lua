-- tests/music-controls/music-controls.lua

local plugin = require('music-controls')

describe('Setup', function()
  it('should load without opts', function()
    plugin.setup()
  end)

  it('should load with empty opts', function()
    plugin.setup({})
  end)

  it('should load with opts', function()
    plugin.setup({
      default_player = 'spotify',
    })
  end)
end)
