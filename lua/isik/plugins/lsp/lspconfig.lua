-- LSP keybindings configuration
-- Server setup is done in mason.lua

local keymap = vim.keymap

-- Prevent LSP from attaching to Telescope preview buffers and other temporary buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "TelescopePrompt", "TelescopeResults" },
  callback = function(args)
    vim.api.nvim_buf_set_var(args.buf, "lsp_skip_attach", true)
  end,
})

-- Prevent LSP from attaching to buffers that are likely previews
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(args)
    -- Skip LSP for telescope preview buffers
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if bufname:match("telescope://") then
      vim.api.nvim_buf_set_var(args.buf, "lsp_skip_attach", true)
    end
  end,
})

-- Setup keybindings when LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Check if we should skip LSP attachment for this buffer
    local skip_attach = pcall(vim.api.nvim_buf_get_var, ev.buf, "lsp_skip_attach")
    if skip_attach then
      return
    end

    local opts = { buffer = ev.buf, silent = true }

    -- Disable semantic tokens for better performance when navigating quickly
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil

      -- Disable workspace file watching for better performance
      if client.server_capabilities.workspace then
        client.server_capabilities.workspace.fileOperations = nil
      end
    end

    -- Set keybinds
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- go to declaration
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
  end,
})
