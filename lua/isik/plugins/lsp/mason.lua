local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- Setup mason
mason.setup()

-- Setup mason-lspconfig with automatic server setup
mason_lspconfig.setup({
  ensure_installed = {
    -- "pyright", -- Disabled: ruff provides sufficient Python LSP features
    "ruff",
    "lua_ls",
  },
  automatic_installation = true,
})

-- Get default capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Optimize LSP performance
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Use incremental sync to reduce network traffic and processing
capabilities.textDocument.synchronization = {
  dynamicRegistration = false,
  willSave = false,
  willSaveWaitUntil = false,
  didSave = true,
}

-- Disable workspace symbols to prevent workspace scanning
capabilities.workspace = {
  workspaceSymbol = {
    symbolKind = {
      valueSet = {},
    },
  },
  configuration = true,
  workspaceFolders = false, -- Disable workspace folder support to prevent scanning
}

-- Configure each server using vim.lsp APIs (Neovim 0.11+)
local servers = {
  -- pyright disabled - ruff provides sufficient LSP features
  ruff = {
    init_options = {
      settings = {
        -- Ruff language server settings
        organizeImports = true,
        fixAll = true,
        lint = {
          enable = true,
        },
        format = {
          preview = false,
        },
      },
    },
    on_attach = function(client, bufnr)
      -- Disable hover in favor of ruff's quick fixes
      client.server_capabilities.hoverProvider = false
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false, -- Disable third-party library checks to prevent errors
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

-- Explicitly disable pyright in the global LSP config
-- This prevents it from auto-starting even if installed
vim.lsp.config('pyright', {
  enabled = false,
  autostart = false,
})

-- Prevent pyright from starting by intercepting LspAttach events
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "pyright" then
      -- Stop pyright immediately
      vim.lsp.stop_client(client.id, true)
      return
    end
  end,
})

-- Setup each server
for server_name, config in pairs(servers) do
  config.capabilities = capabilities
  config.enabled = true
  config.autostart = true

  -- Set shorter timeout to prevent freezing
  config.flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true,
  }

  vim.lsp.config(server_name, config)
  vim.lsp.enable(server_name)
end

-- Set global LSP request timeout to prevent UI freezing
vim.lsp.buf_request_sync = (function()
  local original = vim.lsp.buf_request_sync
  return function(bufnr, method, params, timeout_ms)
    -- Use shorter timeout (default is 1000ms) to prevent freezing
    return original(bufnr, method, params, timeout_ms or 500)
  end
end)()

-- Configure diagnostic display and update behavior
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false, -- Don't update diagnostics while typing
  severity_sort = true,
})

-- Debounce diagnostic updates to reduce lag
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      prefix = "●",
    },
  }
)

-- Optimize LSP responsiveness
-- Reduce the time LSP waits before processing changes
vim.opt.updatetime = 250 -- Faster completion and diagnostics (default is 4000ms)
