-- Learning aids for better Vim habits
return {
  -- Hardtime: break bad habits, build good ones
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      -- Start with gentle hints, not blocking
      max_count = 3, -- Allow some repeated keys before warning
      disable_mouse = false,
      hint = true,
      notification = true,
      -- Disable in these filetypes
      disabled_filetypes = {
        "lazy",
        "mason",
        "neo-tree",
        "help",
        "qf",
      },
    },
  },

  -- which-key is already included in LazyVim
  -- Just ensure it's configured nicely
  {
    "folke/which-key.nvim",
    opts = {
      delay = 300, -- Show popup after 300ms
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true },
      },
    },
  },
}
