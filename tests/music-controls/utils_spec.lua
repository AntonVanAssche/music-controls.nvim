-- tests/music-controls/utils_spec.lua

local utils = require('music-controls.utils')
local assert = require('luassert')
local eq = assert.are.same

describe('Utils Module', function()
  it('should return fasle if the player is not valid', function()
    local result = utils.validate_player(nil)
    eq(result, false)
  end)

  it('should return true if the player is valid', function()
    local result = utils.validate_player('spotify')
    eq(result, true)
  end)

  it('executes a system command and returns the output', function()
    local result = utils.exec_command({ 'echo', '-n', 'Hello, World!' })

    eq(result, 'Hello, World!')
  end)

  it('sleeps for the specified duration', function()
    local start = os.time()
    utils.sleep(1)
    local finish = os.time()

    assert(finish - start >= 1)
  end)
end)
