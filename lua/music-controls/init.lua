-- Require 'notify' module in order to display notifications
-- inside the Neovim session.
vim.notify = require('notify')

local M = {}

-- Remove the new line character from the end of the string.
local function remove_newline(str)
    local result = string.gsub(str, '\n', '')
    return result
end

-- In order to make this plugin work, 'playerctl' must be installed.
-- This function will check if 'playerctl' is installed.
-- If not, it will display a notification.
local function check_playerctl_installed()
    if vim.fn.executable('playerctl') == 0 then
        notify('playerctl is not installed', 'error')
        return false
    end

    return true
end

-- Execute the 'playerctl' command.
local function exec_command(cmd)
    -- Execute the command and get the output.
    local handle = io.popen(cmd)

    if handle == nil then
        return nil
    end

    local result = handle:read('*a')
    handle:close()

    -- Show the output in a new vertical split.
    return result
end

-- Since the 'playerctl' command is executed asynchronously,
-- we need to wait for the output to be ready.
-- This function will wait for the output to be ready.
-- We need to make this function ourselves because Lua doesn't
-- have a built-in function to wait for the output.
-- Atleast not that I know of.
local function sleep(n)
    local clock = os.clock
    local t0 = clock()
    while clock() - t0 <= n do end
end

-- This function will return the status of the 'spotify' player.
-- 'Playing' or 'Paused'.
local function status(player)
    local result = exec_command('playerctl -p ' .. remove_newline(player[1]) .. ' status')
    result = remove_newline(result)

    local icon = ''

    if result == 'Playing' then
        icon = '  '
    elseif result == 'Paused' then
        icon = '  '
    end

    return icon .. result
end

-- This function will return the name of the current song.
-- It wil also show a notification that's why we need a small delay.
-- The delay is needed because the output of the 'playerctl' command
-- is not ready yet.
M.current_song = function(player)
    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not player[1] then
        if _G.music_controls_default_player then
            player[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    sleep(0.50)
    local result = exec_command('playerctl -p ' .. player[1] .. ' metadata --format "{{ title }} - {{ artist }}"')
    local status = status(player)

    vim.notify(status .. '\n' .. remove_newline(result), 'info', { title = string.upper(remove_newline(player[1])) })
end

-- Go to the next song or skip the given amount of songs.
M.next = function(args)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not args then
        if _G.music_controls_default_player then
            args[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif not args[1] then
        if _G.music_controls_default_player then
            args[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif args[1] == string.match(args[1], '[1-9]') then
        args[2] = args[1]
        args[1] = _G.music_controls_default_player
    end

    -- When no amount of songs was specified, skip to the next song.
    if args[2] == nil then
        args[2] = 1
    end

    for _ = 1, tonumber(args[2]) do
        exec_command('playerctl -p ' .. remove_newline(args[1]) .. ' next')
    end

    M.current_song(args)
end

-- Go to the previous song or go back the given amount of songs.
M.prev = function(args)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not args then
        if _G.music_controls_default_player then
            args[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif not args[1] then
        if _G.music_controls_default_player then
            args[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif args[1] == string.match(args[1], '[1-9]') then
        args[2] = args[1]
        args[1] = _G.music_controls_default_player
    end

    -- When no amount of songs is specified, go back one song.
    if args[2] == nil then
        args[2] = 1
    end

    for _ = 1, tonumber(args[2]) do
        exec_command('playerctl -p ' .. remove_newline(args[1]) .. ' previous')
    end

    M.current_song(args)
end

-- If the song is paused, it will play the song.
-- If the song is playing, it will pause the song.
M.play = function(player)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not player[1] then
        if _G.music_controls_default_player then
            player[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    if status(player) == '  Playing' then
        exec_command('playerctl -p  '.. remove_newline(player[1]) .. ' pause')
    else
        exec_command('playerctl -p ' .. remove_newline(player[1]) .. ' play')
    end

    M.current_song(player)
end

-- Pause the song.
M.pause = function(player)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not player[1] then
        if _G.music_controls_default_player then
            player[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    exec_command('playerctl -p ' .. remove_newline(player[1]) .. ' pause')
    M.current_song(player)
end

-- Toggle shuffle.
M.shuffle = function(player)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not player[1] then
        if _G.music_controls_default_player then
            player[1] = _G.music_controls_default_player
        else
            vim.notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    exec_command('playerctl -p  '.. remove_newline(player[1]) .. ' shuffle toggle')
    sleep(0.25)
    local result = exec_command('playerctl -p ' .. remove_newline(player[1]) .. ' shuffle')

    vim.notify('Shuffle: ' .. remove_newline(result), 'info', { title = string.upper(remove_newline(player[1])) })
end

M.list_players = function()
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Get the list of players.
    local result = exec_command('playerctl -l')

    local players = {}

    -- Loop through the list of players and add them to the players table.
    for player in string.gmatch(result, '[^\n]+') do
        table.insert(players, player)
    end

    vim.notify(table.concat(players, '\n'), 'info', { title = 'Current Players' })
end

return M
