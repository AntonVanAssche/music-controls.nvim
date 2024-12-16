local M = {}

M.config = {
  default_player = '',
}

M.setup = function(opts)
  opts = opts or {}

  for k, v in pairs(opts) do
    M.config[k] = v
  end
end

return M
