-- Python-specific configuration
-- The lang.python extra already sets up pyright and ruff-lsp,
-- but we can customize their behavior here if needed.

return {
  -- Configure pyright
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- off, basic, standard, strict
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        ruff_lsp = {
          -- Ruff handles linting and formatting
          -- Disable hover to avoid conflicts with pyright
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
  },
}
