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
  local result = M.exec_command('playerctl -p ' .. player .. ' status')
  local state_icon = {
    Playing = '',
    Paused = ' ',
    Stopped = '',
  }

  return state_icon[result] and (state_icon[result] .. ' ' .. result) or 'Unknown Status'
end

return M
