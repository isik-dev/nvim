-- leader key allows us to set up a bunch of
-- different custom keyboard shortcust or keybinds
-- that don't clash with the vim defaults
-- Essentially, all of these keymaps we define will
-- be prefixed with the leader key, in this case, the space key
-- which is really easy to access and can be really powerful
-- The default leader key in vim - is the backslash
vim.g.mapleader = " " 

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>jk", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to the previous tab


---------------------
-- Plugin Keymaps
---------------------

-- vim-maximizer
-- in split window, it maximizes currently active window to its full length
-- when repeated, it minimizes back to its original size
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files in the project
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find text thoughout the project
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find current string, i.e.: string that our cursor is on, thoughout the project
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- show us the active buffer
keymap.set("n", "<leader>fn", "<cmd>Telescope help_tags<cr>") -- show us help tags
