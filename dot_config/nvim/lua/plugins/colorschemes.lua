return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      styles = {
        comments = "italic",
        keywords = "italic",
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end,
  },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   lazy = true,
  --   priority = 1000,
  -- },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     italic_comments = true,
  --     borderless_telescope = true,
  --     cache = true,
  --   },
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "warmer",
  --     transparent = true,
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     theme = "onedark",
  --   },
  -- },
}
