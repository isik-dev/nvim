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
    "pyright",
    "ruff",
    "lua_ls",
  },
  automatic_installation = true,
})

-- Get default capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configure each server using vim.lsp APIs (Neovim 0.11+)
local servers = {
  pyright = {},
  ruff = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  },
}

-- Setup each server
for server_name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(server_name, config)
  vim.lsp.enable(server_name)
end
