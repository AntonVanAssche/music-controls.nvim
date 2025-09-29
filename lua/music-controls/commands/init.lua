local playback = require('music-controls.commands.playback')
local players = require('music-controls.commands.players')
local modes = require('music-controls.commands.modes')

local M = {}

local function _create_command(name, def)
  vim.api.nvim_create_user_command(name, def.func, { desc = def.desc, nargs = '*' })
end

M.setup = function()
  local all_cmds = vim.tbl_extend('force', playback, players, modes)
  for name, def in pairs(all_cmds) do
    _create_command(name, def)
  end
end

return M
