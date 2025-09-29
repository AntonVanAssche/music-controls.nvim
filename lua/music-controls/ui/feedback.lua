local M = {}

function M.error(msg)
  vim.api.nvim_err_writeln('MusicControls: ' .. msg)
end

function M.warn(msg)
  vim.api.nvim_echo({ { 'MusicControls: ' .. msg, 'WarningMsg' } }, true, {})
end

function M.info(msg)
  vim.api.nvim_echo({ { msg } }, true, {})
end

function M.track(state, title, artist)
  vim.api.nvim_echo({ { string.format('%s %s - %s', state, title, artist) } }, true, {})
end

return M
