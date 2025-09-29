local config = require('music-controls.config').config

local M = {}

local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn

local _check_default_player = function()
  return config.default_player ~= ''
end

M.check = function()
  start('Config:')
  if not _check_default_player() then
    warn('Default player is not set')
  else
    ok('Default player is set')
  end
end

return M
