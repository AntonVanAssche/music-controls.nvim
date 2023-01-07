-- Check whether the plugin is already loaded.
if _G.loaded_music_controls then
    return
end

-- Assign commands to the functionality of the plugin.
vim.api.nvim_create_user_command('MusicPlay', function(opt) require('music-controls').play(opt.fargs) end, { nargs = '*' })
vim.api.nvim_create_user_command('MusicPause', function(opt) require('music-controls').pause(opt.fargs) end, { nargs = '*' })
vim.api.nvim_create_user_command('MusicNext', function(opt) require('music-controls').next(opt.fargs) end, { nargs = '*' })
vim.api.nvim_create_user_command('MusicPrev', function(opt) require('music-controls').prev(opt.fargs) end, { nargs = '*' })
vim.api.nvim_create_user_command('MusicCurrent', function(opt) require('music-controls').current_song(opt.fargs) end, { nargs = '*' })
vim.api.nvim_create_user_command('MusicListPlayers', function() require('music-controls').list_players() end, { nargs = 0 })

-- Set the plugin as loaded.
_G.loaded_music_controls = true
