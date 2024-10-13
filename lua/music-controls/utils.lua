local M = {}

M.check_playerctl_installed = function()
  return vim.fn.executable('playerctl') == 1
end

M.exec_command = function(cmd)
  local output = vim.fn.system(cmd)

  return string.gsub(tostring(output), '\n', '')
end

M.sleep = function(n)
  vim.loop.sleep(n * 1000)
end

M.get_player_status = function(player)
  local cmd = string.format('playerctl -p %s status', player)
  local success, result = pcall(M.exec_command, cmd)
  local state_icon = {
    Playing = '',
    Paused = ' ',
    Stopped = '',
  }

  if not success then
    return 'Failed to get player status'
  end

  return state_icon[result] and (state_icon[result] .. ' ' .. result) or 'Unknown Status'
end

M.fancy_print = function(msg, lvl, meta)
  local notify_ok, notify = pcall(require, 'notify')
  if notify_ok then
    return notify(msg, lvl or 'info', meta)
  end

  if lvl == 'error' then
    return vim.api.nvim_err_writeln(msg)
  end

  local _msg = msg:gsub('\n', ' ')
  print(_msg)
end

return M
