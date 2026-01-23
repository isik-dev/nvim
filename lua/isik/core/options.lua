local opt = vim.opt -- for conciseness

-- language and locale settings
-- Set locale environment variables for LSP servers (especially Python-based ones like pyright)
vim.env.LC_ALL = "en_US.UTF-8"
vim.env.LANG = "en_US.UTF-8"
vim.cmd("language en_US")

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false


-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true 

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Performance optimizations
opt.lazyredraw = true -- Don't redraw screen during macros
opt.timeoutlen = 500 -- Faster key sequence completion
opt.ttimeoutlen = 10 -- Faster key code timeout
