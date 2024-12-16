if vim.g.loaded_music_controls then
  return
end

require('music-controls').setup()
require('music-controls.commands').setup()

vim.g.loaded_music_controls = true
