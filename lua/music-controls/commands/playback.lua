local controls = require('music-controls.core.controls')
local feedback = require('music-controls.ui.feedback')
local util = require('music-controls.commands.utils')

local M = {}

local function with_current(player)
  local state, title, artist = controls.current(player)
  feedback.track(state, title, artist)
end

M.MPlay = {
  desc = 'Play/pause track',
  func = function(opts)
    local player = util.get_player(util.parse_args(opts.args))
    local ok, err = controls.play(player)
    if not ok then
      return feedback.error(err or 'Could not play')
    end

    vim.loop.sleep(0.25 * 1000)
    with_current(player)
  end,
}

M.MPause = {
  desc = 'Pause track',
  func = function(opts)
    local player = util.get_player(util.parse_args(opts.args))
    local ok, err = controls.pause(player)
    if not ok then
      return feedback.error(err or 'Could not pause')
    end

    vim.loop.sleep(0.25 * 1000)
    with_current(player)
  end,
}

M.MNext = {
  desc = 'Next track',
  func = function(opts)
    local parts = util.parse_args(opts.args)
    local player = util.get_player(parts)
    local amount = tonumber(parts[2]) or 1
    local ok, err = controls.next(player, amount)
    if not ok then
      return feedback.error(err or 'Could not skip')
    end

    vim.loop.sleep(0.25 * 1000)
    with_current(player)
  end,
}

M.MPrev = {
  desc = 'Previous track',
  func = function(opts)
    local parts = util.parse_args(opts.args)
    local player = util.get_player(parts)
    local amount = tonumber(parts[2]) or 1
    local ok, err = controls.previous(player, amount)
    if not ok then
      return feedback.error(err or 'Could not go back')
    end

    vim.loop.sleep(0.25 * 1000)
    with_current(player)
  end,
}

M.MCurrent = {
  desc = 'Current track',
  func = function(opts)
    local player = util.get_player(util.parse_args(opts.args))

    vim.loop.sleep(0.25 * 1000)
    with_current(player)
  end,
}

return M
