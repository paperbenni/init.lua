return {
    "folke/sidekick.nvim",
    opts = {
        cli = {
            prompts = {
                spellcheck = "search for simple typos in {file} and fix them"
            },
            mux = {
                backend = "tmux",
                enabled = true
            }
        }
    },
    keys = {
        {
            "<tab>",
            function()
                if require("sidekick").nes_jump_or_apply() then
                    return
                end
                -- if you are using Neovim's native inline completions
                if vim.lsp.inline_completion.get() then
                  return
                end
                return "<tab>"
            end,
            mode = { "i", "n" },
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion"
        },
        {
            "<leader>aa",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            desc = "Select CLI"
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}"}) end,
            mode = { "x", "n" },
            desc = "Send This"
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<leader>ap",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "x" },
            desc = "Sidekick Select Prompt",
        },
        {
            "<c-.>",
            function() require("sidekick.cli").focus() end,
            mode = { "n", "x", "i", "t" },
            desc = "Sidekick Switch Focus",
        },
        {
            "<leader>ac",
            function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
            desc = "Sidekick Toggle Claude",
        },
    }
}
