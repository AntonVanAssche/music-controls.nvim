local config = require('music-controls.config').config

local M = {}

function M.parse_args(args)
  args = args or ''
  if type(args) ~= 'string' then
    args = table.concat(args, ' ')
  end

  local parts = {}
  for part in string.gmatch(args, '%S+') do
    table.insert(parts, part)
  end

  return parts
end

function M.get_player(parts)
  return parts[1] or config.default_player
end

function M.resolve_loop_args(parts)
  if #parts == 1 then
    return config.default_player, parts[1]
  elseif #parts >= 2 then
    return parts[1], parts[2]
  else
    return config.default_player, 'Track'
  end
end

return M
