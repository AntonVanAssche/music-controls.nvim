local M = {}
local cmds = {
  {
    name = 'MusicPlay',
    description = 'Toggle play/pause',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').play(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicPause',
    description = 'Pause music',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').pause(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicNext',
    description = 'Next track',
    func = function(opt)
      local player = opt.fargs[1]
      local amount = opt.fargs[2]
      require('music-controls').next(player, amount)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicPrev',
    description = 'Previous track',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').prev(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicCurrent',
    description = 'Current track',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').current(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicShuffle',
    description = 'Toggle shuffle',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').shuffle(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicLoop',
    description = 'Loop mode',
    func = function(opt)
      local player = opt.fargs[1]
      local mode = opt.fargs[2]
      require('music-controls').loop(player, mode)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicLoopToggle',
    description = 'Toggle loop mode',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').loop_toggle(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicCurrentVolume',
    description = 'Current volume',
    func = function(opt)
      local player = opt.fargs[1]
      require('music-controls').current_volume(player)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicSetVolume',
    description = 'Set volume',
    func = function(opt)
      local player = opt.fargs[1]
      local volume = opt.fargs[2]
      require('music-controls').set_volume(player, volume)
    end,
    opts = { nargs = '*' },
  },
  {
    name = 'MusicListPlayers',
    description = 'List players',
    func = function()
      require('music-controls').list_players()
    end,
    opts = {},
  },
}

local _create_command = function(name, func, opts)
  vim.api.nvim_create_user_command(name, func, opts)
end

-- Should only be called from plugin directory.
M.setup = function(opts)
  opts = opts or {}

  for _, cmd in ipairs(cmds) do
    _create_command(cmd.name, cmd.func, cmd.opts)
  end
end

return M
