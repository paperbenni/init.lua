return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- enabled = false,
  keys = {
        {
          "<leader>ww",
          "<cmd>ObsidianQuickSwitch<CR>",
          desc = "Open obsidian file"
        },
    },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    follow_url_func = function(url)
        vim.ui.open(url) -- need Neovim 0.10.0+
    end,
    workspaces = {
      {
        name = "wiki",
        path = "~/wiki/vimwiki",
      },
    },
  },
}
