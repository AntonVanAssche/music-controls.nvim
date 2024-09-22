-- tests/music-controls/music-controls.lua

local plugin = require('music-controls')

describe('Setup', function()
  it('without opts', function()
    plugin.setup()
  end)

  it('with empty opts', function()
    plugin.setup({})
  end)

  it('with opts', function()
    plugin.setup({
      default_player = 'spotify',
    })
  end)
end)
