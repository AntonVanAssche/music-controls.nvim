# Music Controls

Control your favorite music players with ease from within Neovim.

![preview](./assets/preview.gif)

## Table of Contents

- [1] [Description](#description)
- [2] [Installation](#installation)
  - [2.1] [Dependencies](#dependencies)
- [3] [Configuration](#configuration)
- [4] [Commands](#commands)
  - [4.1] [MusicCurrent](#musiccurrent)
  - [4.2] [MusicCurrentVolume](#musiccurrentvolume)
  - [4.3] [MusicListPlayers](#musiclistplayers)
  - [4.4] [MusicLoop](#musicloop)
  - [4.5] [MusicLoopToggle](#musiclooptoggle)
  - [4.6] [MusicNext](#musicnext)
  - [4.7] [MusicPause](#musicpause)
  - [4.8] [MusicPlay](#musicplay)
  - [4.9] [MusicPrevious](#musicprevious)
  - [4.10] [MusicSetVolume](#musicsetvolume)
  - [4.11] [MusicShuffle](#musicshuffle)
- [5] [Statusline Integration](#statusline-integration)
  - [5.1] [Example (lualine)](#example-lualine)
- [6] [License](#license)
- [7] [Contributing](#contributing)

## Description

Music Controls is a Neovim plugin that allows you to easily control your favorite
music players from within Neovim. The plugin basically acts as a wrapper around
`playerctl`, a command-line utility that can control media players.
This makes almost any music player compatible with Music Controls, ranging from
Spotify to VLC, etc.

I created Music Controls to make it more convenient and efficient to control my
music player while working within Neovim. Instead of constantly switching workspaces
or opening a terminal to control my music player, I can use this plugin to do it
all within Neovim. You might say that I'm lazy, some say I'm not 😉!

I hope that others who have similar needs will find Music Controls useful as well.

## Installation

This example uses [lazy.nvim](https://github.com/folke/lazy.nvim) to install/load
the plugin. Other plugin managers can be used as well.

```lua
{
  'AntonVanAssche/music-controls.nvim',
}
```

### Dependencies

Music Controls requires `playerctl`  to be installed in order to work properly.

## Configuration

Optionally, you can specify a default music player by adding the following code
to your `init.lua` file:

```lua
{
  'AntonVanAssche/music-controls.nvim',
  opts = {
    default_player = 'spotify'
  }
}
```

The example above sets Spotify as the default music player.
If you don't specify a default player, Music Controls requires you to specify a player.
Refer to the [commands](#commands) section for more information.

## Commands

For more information, refer to the documentation by typing `:h MusicControls`.

### `MusicCurrent`

- **Description**: Displays the current song playing.
  - **Player**: The music player to use (optional).
- **Usage**: `:MusicCurrent [player]`
- **Example**: `:MusicCurrent spotify`

### `MusicCurrentVolume`

- **Description**: Display the current volume as a percentage.
- **Usage**: `:MusicCurrentVolume [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MusicCurrentVolume spotify`

### `MusicListPlayers`

- **Description**: Displays a list of available music players.
- **Usage**: `:MusicListPlayers`
- **Example**: `:MusicListPlayers`

### `MusicLoop`

- **Description**: Set a loop mode for the current music player.
- **Usage**: `:MusicLoop [player] [mode]`
  - **Player**: The music player to use (optional).
  - **Mode**:
    - `Track` (Default)
    - `None`
    - `Playlist`
- **Example**: `:MusicLoop spotify Playlist`

### `MusicLoopToggle`

- **Description**: Toggle loop mode between `None` and `Track`.
- **Usage**: `:MusicLoopToggle [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MusicLoopToggle spotify`

### `MusicNext`

- **Description**: Play the next song.
- **Usage**: `:MusicNext [player] [amount]`
  - **Player**: The music player to use (optional).
  - **Amount**: The number of songs to skip (optional).
    - **Default**: 1
- **Example**: `:MusicNext spotify 2`

### `MusicPause`

- **Description**: Pause the current song.
- **Usage**: `:MusicPause [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MusicPause spotify`

### `MusicPlay`

- **Description**: Toggle play/pause the current song.
- **Usage**: `:MusicPlay [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MusicPlay spotify`

### `MusicPrevious`

- **Description**: Play the previous song.
- **Usage**: `:MusicPrevious [player] [amount]`
  - **Player**: The music player to use (optional).
  - **Amount**: The number of songs to skip (optional).
    - **Default**: 1
- **Example**: `:MusicPrevious spotify 2`

### `MusicSetVolume`

- **Description**: Set the volume for the current music player.
- **Usage**: `:MusicSetVolume [player] [volume]`
  - **Player**: The music player to use (optional).
  - **Volume**: The volume to set as a float between 0 and 1.
    - **Default**: 0.5
- **Example**: `:MusicSetVolume spotify 0.5`

### `MusicShuffle`

- **Description**: Toggle shuffle mode for the current music player.
- **Usage**: `:MusicShuffle [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MusicShuffle spotify`

## Statusline Integration

> Note: This feature requires a `default_player` to be configured.

Music Controls provides integration with statusline plugins such as
[lualine](https://github.com/nvim-lualine/lualine.nvim) and [galaxyline](https://github.com/nvimdev/galaxyline.nvim),
allowing you to display the current music player status directly within your statusline.

### Example (lualine)

This example demonstrates how to integrate Music Controls with lualine.
Other statusline plugins can be used as well, and the process should be similar.
Refer to the documentation of your statusline plugin for more information.

```lua
require('lualine').setup {
  sections = {
    lualine_x = {
      require("music-controls")._statusline,
    }
  }
}
```

An example of the statusline with Music Controls integrated:

![statusline preview](/assets/statusline_preview.png)

## License

Music Controls is licensed under the MIT License. See the [LICENSE.md](./LICENSE.md)
file for more information.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue
for any bugs or feature requests.
