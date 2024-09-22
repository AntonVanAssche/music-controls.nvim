-- tests/music-controls/utils_spec.lua

local utils = require('music-controls.utils')
local assert = require('luassert')
local eq = assert.are.same

describe('Utils Module', function()
  it('checks if playerctl is installed', function()
    local is_installed = utils.check_playerctl_installed()

    eq(type(is_installed), 'boolean') -- it should return a boolean value.
  end)

  it('executes a system command and returns the output', function()
    local output = utils.exec_command('echo Hello, World!')

    eq(output, 'Hello, World!')
  end)

  it('sleeps for the specified duration', function()
    local start = os.time()
    utils.sleep(1)
    local finish = os.time()

    assert(finish - start >= 1)
  end)

  it('gets the player status with valid player', function()
    local mock_exec_command = function(cmd)
      return 'Playing'
    end

    utils.exec_command = mock_exec_command

    local status = utils.get_player_status('spotify')

    eq(status, ' Playing')
  end)

  it('returns unknown status if playerctl returns an unknown state', function()
    local mock_exec_command = function(cmd)
      return 'Unknown'
    end

    utils.exec_command = mock_exec_command

    local status = utils.get_player_status('spotify')

    eq(status, 'Unknown Status')
  end)
end)
