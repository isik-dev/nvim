# Neovim Configuration

Personal Neovim setup optimized for Python and Lua development with LSP, autocompletion, and fuzzy finding.

## Setup

### 1. Install Prerequisites
```bash
brew install neovim ripgrep node
```

### 2. Clone Config
```bash
git clone <your-repo-url> ~/.config/nvim
```

### 3. Configure Shell
Add to `~/.zshrc` (or `~/.bashrc`):
```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

Reload shell:
```bash
source ~/.zshrc
```

### 4. Install Plugins
Open Neovim and let Packer auto-install:
```bash
nvim
```

Wait for plugins to install, then restart Neovim. LSP servers (ruff, lua_ls) will auto-install via Mason.

## Key Bindings

- `<space>ff` - Find files
- `<space>fs` - Search text in project
- `<space>e` - Toggle file explorer
- `gd` - Peek definition
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

## LSP Servers

- **Python**: Ruff (linting, formatting)
- **Lua**: lua_ls (language server)
