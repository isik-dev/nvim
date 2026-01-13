-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  -- this is how we declare and install plugins using packer
  -- everytime we save this file, packer will check if it needs to
  -- install new packages.
  use("wbthomason/packer.nvim")

  -- lua functions that many plugins use
  use("nvim-lua/plenary.nvim")

  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  -- use("briones-gabriel/darcula-solid.nvim") -- preferred colorscheme

  -- tmux & split window navigation
  use("christoomey/vim-tmux-navigator")

  use("szw/vim-maximizer") -- maximizes and restores current window

  -- essential plugins
  -- with vim-surround we can hover over a word
  -- type 'ysw"' -> to surround the word with ""
  -- type 'ds"' -> to remove surrounded "" from the word
  -- type `cs"'` -> to replace surrounded "(double quote) with '(single quote) 
  use("tpope/vim-surround")

  -- commenting with gc
  -- example usage:
  --- gcc to comment current line
  --- gc9j to comment current to 9 lines down
  use("numToStr/Comment.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- plugin for autocompletion
  use("hrsh7th/cmp-buffer") -- source, it will allow nvim-cmp to recommend text from the current buffer
  use("hrsh7th/cmp-path") -- source for file path, allow nvim-cmp to recommed file path

  -- snippets
  use("L3MON4D3/LuaSnip") -- this our snippet engine
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- managing & installing lsp servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use({ "glepnir/lspsaga.nvim", branch="main" })
  use("onsails/lspkind.nvim")


  if packer_bootstrap then
    require("packer").sync()
  end
end)
