local notify_ok, notify = pcall(require, 'notify')

local M = {}

M.display = function(msg_table)
  local state = msg_table.state or 'Unknown status'
  local msg = msg_table.msg
  local lvl = msg_table.lvl
  local meta = msg_table.meta
  local _msg

  if notify_ok then
    _msg = string.format('%s\n%s', state, msg)
    return notify(_msg, lvl or 'info', meta)
  end

  if lvl == 'error' then
    return vim.api.nvim_err_writeln(msg)
  end

  msg = msg:gsub('\n', ' ')
  _msg = string.format('%s: %s', state, msg)
  print(_msg)
end

return M
