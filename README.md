# Music Controls

Control your favorite music players with ease from within Neovim.

![preview](./assets/preview.gif)

## Table of Contents

- [1] [Description](#description)
- [2] [Installation](#installation)
  - [2.1] [Dependencies](#dependencies)
- [3] [Configuration](#configuration)
- [4] [Commands](#commands)
  - [4.1] [MPlayers](#mplayers)
  - [4.2] [MPlay](#mplay)
  - [4.3] [MPause](#mpause)
  - [4.4] [MNext](#mnext)
  - [4.5] [MPrev](#mprev)
  - [4.6] [MCurrent](#mcurrent)
  - [4.7] [MShuffle](#mshuffle)
  - [4.8] [MLoop](#mloop)
  - [4.9] [MLoopToggle](#mlooptoggle)
  - [4.10] [MVolumeGet](#mvolumeget)
  - [4.11] [MVolumeSet](#mvolumeset)
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

### `Mplayers`

- **Description**: Displays a list of available music players.
- **Usage**: `:Mplayers`
- **Example**: `:Mplayers`

### `MPlay`

- **Description**: Toggle play/pause the current track.
- **Usage**: `:MPlay [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MPlay spotify`

### `MPause`

- **Description**: Pause the current track.
- **Usage**: `:MPause [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MPause spotify`

### `MNext`

- **Description**: Play the next track.
- **Usage**: `:MNext [player] [amount]`
  - **Player**: The music player to use (optional).
  - **Amount**: The number of songs to skip (optional).
    - **Default**: 1
- **Example**: `:MNext spotify 2`

### `MPrev`

- **Description**: Play the previous track.
- **Usage**: `:MPrev [player] [amount]`
  - **Player**: The music player to use (optional).
  - **Amount**: The number of songs to skip (optional).
    - **Default**: 1
- **Example**: `:MPrev spotify 2`

### `MCurrent`

- **Description**: Displays the current track playing.
  - **Player**: The music player to use (optional).
- **Usage**: `:MCurrent [player]`
- **Example**: `:MCurrent spotify`

### `MShuffle`

- **Description**: Toggle shuffle mode.
- **Usage**: `:MShuffle [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MShuffle spotify`

### `MLoop`

- **Description**: Set a loop mode.
- **Usage**: `:MLoop [player] [mode]`
  - **Player**: The music player to use (optional).
  - **Mode**:
    - `Track` (Default)
    - `None`
    - `Playlist`
- **Example**: `:MLoop spotify Playlist`

### `MLoopToggle`

- **Description**: Toggle loop mode between `None` and `Track`.
- **Usage**: `:MLoopToggle [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MLoopToggle spotify`

### `MVolumeGet`

- **Description**: Display the current volume as a percentage.
- **Usage**: `:MVolumeGet [player]`
  - **Player**: The music player to use (optional).
- **Example**: `:MVolumeGet spotify`

### `MVolumeSet`

- **Description**: Set the volume to a specific value.
- **Usage**: `:MVolumeSet [player] [volume]`
  - **Player**: The music player to use (optional).
  - **Volume**: The volume to set as a float between 0 and 1.
    - **Default**: 0.5
- **Example**: `:MVolumeSet spotify 0.5`

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
