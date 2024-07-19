-- Require 'notify' module in order to display notifications
-- inside the Neovim session.
local notify = require('notify')

local M = {}
local settings = {
    default_player = '',
}

-- In order to make this plugin work, 'playerctl' must be installed.
-- This function will check if 'playerctl' is installed.
-- If not, it will display a notification.
local function check_playerctl_installed()
    if vim.fn.executable('playerctl') == 0 then
        notify('playerctl is not installed', 'error', { title = 'Music Controls' })
        return false
    end

    return true
end

-- Execute the 'playerctl' command and get its output.
local function exec_command(cmd)
    local output = vim.fn.systemlist(cmd)

    -- Only grab the first line of the output because there should
    -- never be any more than one line for a given command.
    local result = string.gsub(tostring(output[1]), '\n', '')

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

-- This function will return the status of the player.
local function status(player)
    local result = exec_command('playerctl -p ' .. player[1] .. ' status')
    local state = ''

    if result == 'Playing' then
        state = '  Playing'
    elseif result == 'Paused' then
        state = '  Paused'
    elseif result == 'Stopped' then
        state = '  Stopped'
    else
        state = 'Player not running'
    end

    return state
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
        if settings.default_player then
            player[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    sleep(0.50)
    local result = exec_command('playerctl -p ' .. player[1] .. ' metadata --format "{{ title }} - {{ artist }}"')
    local current_status = status(player)

    if result == 'No players found' then
        notify(current_status , 'warn', { title = string.gsub(player[1], '^%l', string.upper) })
    else
        notify(current_status .. '\n' .. result, 'info', { title = string.gsub(player[1], '^%l', string.upper) })
    end
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
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif not args[1] then
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif args[1] == string.match(args[1], '[1-9]') then
        args[2] = args[1]
        args[1] = settings.default_player
    end

    -- When no amount of songs was specified, skip to the next song.
    if args[2] == nil then
        args[2] = 1
    end

    for _ = 1, tonumber(args[2]) do
        exec_command('playerctl -p ' .. args[1] .. ' next')
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
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif not args[1] then
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif args[1] == string.match(args[1], '[1-9]') then
        args[2] = args[1]
        args[1] = settings.default_player
    end

    -- When no amount of songs is specified, go back one song.
    if args[2] == nil then
        args[2] = 1
    end

    for _ = 1, tonumber(args[2]) do
        exec_command('playerctl -p ' .. args[1] .. ' previous')
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
        if settings.default_player then
            player[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    local current_status = status(player)
    if string.find(current_status, 'Playing') then
        exec_command('playerctl -p  '.. player[1] .. ' pause')
    else
        exec_command('playerctl -p ' .. player[1] .. ' play')
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
        if settings.default_player then
            player[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    exec_command('playerctl -p ' .. player[1] .. ' pause')

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
        if settings.default_player then
            player[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    end

    exec_command('playerctl -p  '.. player[1] .. ' shuffle toggle')
    local result = exec_command('playerctl -p ' .. player[1] .. ' shuffle')

    if result == 'No players found' then
        notify('Player not running', 'warn', { title = string.gsub(player[1], '^%l', string.upper) })
    else
        notify('Shuffle: ' .. result, 'info', { title = string.gsub(player[1], '^%l', string.upper) })
    end
end

-- Toggle different repeat modes.
M.loop = function (args)
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Check if a player was passed as an argument.
    -- If not, use the default player when specified in the user's config.
    -- When no default player is specified, notify the user that no player was specified.
    if not args then
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    elseif not args[1] then
        if settings.default_player then
            args[1] = settings.default_player
        else
            notify('No player specified', 'error', { title = 'Music Controls' })
            return
        end
    else
        for _, mode in ipairs({'none', 'playlist', 'track'}) do
            if string.lower(args[1]) == mode then
                args[2] = args[1]
                args[1] = settings.default_player
            end
        end
    end

    -- When no repeat mode is specified, toggle between 'None' and 'Track'.
    -- In case a repeat mode is specified, set the repeat mode to that mode.
    if args[2] == nil then
        local result = exec_command('playerctl -p ' .. args[1] .. ' loop')

        if result == 'None' then
            exec_command('playerctl -p ' .. args[1] .. ' loop track')
        else
            exec_command('playerctl -p ' .. args[1] .. ' loop none')
        end
    else
        exec_command('playerctl -p ' .. args[1] .. ' loop ' .. args[2])
    end

    local result = exec_command('playerctl -p ' .. args[1] .. ' loop')

    if result == 'No players found' then
        notify('Player not running', 'warn', { title = string.gsub(args[1], '^%l', string.upper) })
    else
        notify('Repeat mode: ' .. result, 'info', { title = string.gsub(args[1], '^%l', string.upper) })
    end
end

M.setup = function(opts)
    if opts then
        for k, v in pairs(opts) do
            settings[k] = v
        end
    end
end

M.list_players = function()
    -- Check whether 'playerctl' is installed.
    if not check_playerctl_installed() then
        return
    end

    -- Get the list of players.
    local result = vim.fn.systemlist('playerctl -l')

    local players = {}

    -- Loop through the list of players and add them to the players table.
    for _, player in ipairs(result) do
        table.insert(players, player)
    end

    if result == 'No players found' then
        notify(result, 'warn', { title = 'Music Controls' })
    else
        notify(table.concat(players, '\n'), 'info', { title = 'Current Players' })
    end
end

return M
