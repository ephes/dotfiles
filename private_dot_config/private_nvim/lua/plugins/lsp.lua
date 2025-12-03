-- LSP configuration
-- Note: Most LSP servers are auto-installed by lazyvim.plugins.extras.lang.* imports
-- This file adds servers not covered by those extras

return {
  -- Ensure taplo (TOML) is installed since there's no lang.toml extra
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "taplo", -- TOML LSP
      },
    },
  },
}
