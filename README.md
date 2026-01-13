# Neovim Configuration

Personal Neovim setup with LSP, autocompletion, and file navigation.

## Structure

### Root
- `init.lua` - Main entry point, loads all modules

### Core (`lua/isik/core/`)
- `options.lua` - Editor settings (line numbers, tabs, language)
- `keymaps.lua` - Custom key bindings
- `colorscheme.lua` - Color scheme configuration

### Plugins (`lua/isik/plugins/`)
- `plugins-setup.lua` - Plugin declarations using Packer
- `comment.lua` - Comment toggling (gcc)
- `lualine.lua` - Status line
- `nvim-tree.lua` - File explorer
- `nvim-cmp.lua` - Autocompletion engine
- `telescope.lua` - Fuzzy finder

### LSP (`lua/isik/plugins/lsp/`)
- `mason.lua` - LSP server installer (pyright, ruff, lua_ls)
- `lspconfig.lua` - LSP server configurations and keybindings
- `lspsaga.lua` - Enhanced LSP UI

## Key Features

- **Language Support**: Python, Lua
- **Fuzzy Finding**: Telescope for files and text search
- **File Navigation**: nvim-tree sidebar
- **Autocompletion**: nvim-cmp with LSP integration
- **LSP Features**: Go to definition, hover docs, rename, code actions

## LSP Keybindings

- `gd` - Peek definition
- `gD` - Go to declaration
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `[d` / `]d` - Jump to prev/next diagnostic

## Requirements

- Neovim 0.10+
- Python (for Pyright/Ruff LSP)
