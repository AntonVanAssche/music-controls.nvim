-- tests/music-controls/config_spec.lua
local M = require('music-controls.config')
local assert = require('luassert')
local eq = assert.are.same

describe('Config Module', function()
  -- Reset the config before each test.
  before_each(function()
    M.setup({
      default_player = '',
    })
  end)

  it('should handle empty options', function()
    M.setup()
    eq(M.config.default_player, '')
  end)

  it('should handle nil options', function()
    M.setup(nil)
    eq(M.config.default_player, '')
  end)

  it('should handle empt table options', function()
    M.setup({})
    eq(M.config.default_player, '')
  end)

  it('should handle setting a default player', function()
    M.setup({ default_player = 'spotify' })
    eq(M.config.default_player, 'spotify')
  end)
end)
