local M = {}
local cmds = {
  {
    name = 'MPlayers',
    description = 'List players',
    func = function()
      require('music-controls').get_players()
    end,
    opts = {},
    deprecated = 'MusicListPlayers',
  },
  {
    name = 'MPlay',
    description = 'Toggle play/pause',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').play(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicPlay',
  },
  {
    name = 'MPause',
    description = 'Pause music',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').pause(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicPause',
  },
  {
    name = 'MNext',
    description = 'Next track',
    func = function(args)
      local player, amount = nil, nil
      for _, o in ipairs(args.fargs) do
        if tonumber(o) then
          amount = tonumber(o)
        else
          player = o
        end
      end

      require('music-controls').next(player, amount)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicNext',
  },
  {
    name = 'MPrev',
    description = 'Previous track',
    func = function(args)
      local player, amount = nil, nil
      for _, o in ipairs(args.fargs) do
        if tonumber(o) then
          amount = tonumber(o)
        else
          player = o
        end
      end

      require('music-controls').prev(player, amount)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicPrev',
  },
  {
    name = 'MCurrent',
    description = 'Current track',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').current(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicCurrent',
  },
  {
    name = 'MShuffle',
    description = 'Toggle shuffle',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').shuffle(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicShuffle',
  },
  {
    name = 'MLoop',
    description = 'Loop mode',
    func = function(args)
      local player, mode = nil, nil
      for _, o in ipairs(args.fargs) do
        if vim.tbl_contains({ 'Track', 'Playlist', 'None' }, o) then
          mode = o
        else
          player = o
        end
      end

      require('music-controls').loop(player, mode)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicLoop',
  },
  {
    name = 'MLoopToggle',
    description = 'Toggle loop mode',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').toggle_loop(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicLoopToggle',
  },
  {
    name = 'MVolumeGet',
    description = 'Current volume',
    func = function(args)
      local player = args.fargs[1]
      require('music-controls').get_volume(player)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicCurrentVolume',
  },
  {
    name = 'MVolumeSet',
    description = 'Set volume',
    func = function(args)
      local player, volume = nil, nil
      for _, o in ipairs(args.fargs) do
        if tonumber(o) then
          volume = tonumber(o)
        else
          player = o
        end
      end

      require('music-controls').set_volume(player, volume)
    end,
    opts = { nargs = '*' },
    deprecated = 'MusicSetVolume',
  },
}

local _create_command = function(name, func, opts, deprecated)
  vim.api.nvim_create_user_command(name, func, opts)

  if deprecated then
    vim.api.nvim_create_user_command(deprecated, function(args)
      vim.api.nvim_echo({
        {
          "WARNING: this commands has been marked as deprecated, use '" .. name .. "' instead",
          'WarningMsg',
        },
      }, true, {})

      func(args)
    end, opts)
  end
end

-- Should only be called from plugin directory.
M.setup = function(opts)
  opts = opts or {}

  for _, cmd in ipairs(cmds) do
    _create_command(cmd.name, cmd.func, cmd.opts, cmd.deprecated)
  end
end

return M
