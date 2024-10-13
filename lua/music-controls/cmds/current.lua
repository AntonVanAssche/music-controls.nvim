local utils = require('music-controls.utils')
local M = {}

M.current = function(player)
  if not player or player == '' then
    return 'No player found', 'warn', { title = 'Music Controls' }
  end

  if not utils.check_playerctl_installed() then
    return 'Playerctl is not installed', 'error', { title = 'Music Controls' }
  end

  local cmd = string.format('playerctl -p %s metadata --format "{{ artist }} - {{ title }}"', player)
  local success, result = pcall(utils.exec_command, cmd)
  if not success then
    return 'Failed to get current track', 'error', { title = 'Music Controls' }
  end

  if not result or result == '' then
    return 'Failed to get metadata', 'error', { title = 'Music Controls' }
  end

  local state = utils.get_player_status(player)

  if result == 'No players found' then
    return result, 'warn', { title = string.format('Music Controls (%s)', player) }
  end

  return string.format('%s\n%s', state, result), 'info', { title = string.format('Music Controls (%s)', player) }
end

M._statusline = function(player)
  if not utils.check_playerctl_installed() then
    return 'Playerctl is not installed'
  end

  local cmd = string.format('playerctl -p %s metadata --format "{{ artist }} - {{ title }}"', player)
  local success, result = pcall(utils.exec_command, cmd)
  if not success then
    return 'Failed to get current track'
  end

  if result == 'No players found' then
    return ''
  end

  -- Extract the first UTF-8 character by counting the leading bytes.
  local state_icon = utils.get_player_status(player):match('[\1-\127\194-\244][\128-\191]*')

  return state_icon .. ' ' .. result
end

return M
