local controls = require('music-controls.core.controls')
local feedback = require('music-controls.ui.feedback')
local util = require('music-controls.commands.utils')

local M = {}

M.MShuffle = {
  desc = 'Toggle shuffle',
  func = function(opts)
    local player = util.get_player(util.parse_args(opts.args))
    local new_state, err = controls.shuffle(player)
    if new_state == nil then
      return feedback.error(err or 'Could not toggle shuffle')
    end
    feedback.info('Shuffle: ' .. (new_state and 'ON' or 'OFF'))
  end,
}

M.MLoop = {
  desc = 'Set loop mode',
  func = function(opts)
    local parts = util.parse_args(opts.args)
    local player, mode = util.resolve_loop_args(parts)

    local new_mode, err = controls.loop_set(player, mode)
    if not new_mode then
      return feedback.error(err or 'Could not set loop')
    end
    feedback.info('Loop mode: ' .. string.upper(new_mode))
  end,
}

M.MLoopToggle = {
  desc = 'Toggle loop mode',
  func = function(opts)
    local player = util.get_player(util.parse_args(opts.args))
    local new_mode, err = controls.loop_toggle(player)
    if not new_mode then
      return feedback.error(err or 'Could not toggle loop')
    end
    feedback.info('Loop mode: ' .. string.upper(new_mode))
  end,
}

return M
