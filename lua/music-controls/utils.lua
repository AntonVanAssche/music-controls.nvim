local M = {}

M.validate_player = function(player)
  if not player then
    vim.api.nvim_err_writeln('MusicControls: No player found')
    return false
  end

  return true
end

M.exec_command = function(cmd)
  local result = vim.system(cmd, { text = true }):wait()
  if result.code ~= 0 then
    return nil, result.stderr
  end

  return result.stdout, nil
end

M.sleep = function(n)
  vim.loop.sleep(n * 1000)
end

return M
