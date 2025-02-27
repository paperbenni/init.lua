local potato = require('mypotato')
return {
    config = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })
    end,
    opts = {
        indent = { enabled = true },
        image = {
            enabled = true,
            doc = {
                conceal = true,
            },
            math = {
                enabled = true,
                latex = {
                    packages = {
                        "amsmath",
                        "amssymb",
                        "amsfonts",
                        "amscd",
                        "mathtools",
                        "dsfont"
                    },
                }
            },
        },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        words = { enabled = not potato },
        scroll = {
            enabled = not potato,
            easing = "quadratic",
        },
        picker = {
            enabled = true,
            matcher = {
                frecency = true,
            }
        },
        input = { enabled = true },
        scratch = { enabled = true },
        quickfile = { enabled = true },
        lazygit = { enabled = true },
    },
    keys = {
        {
            "<leader>Z", 
            function() Snacks.zen.zoom() end,
            desc = "Zoom onto the current buffer"
        },
        {
            "<leader>z", 
            function() Snacks.zen.zen() end,
            desc = "Zen Mode"
        },
        {
            "<leader>G", 
            function()
                local git_dir = Snacks.git.get_root()
                print("Git dir " .. git_dir)
                if git_dir then
                    vim.cmd("cd " .. git_dir)
                end
            end,
            desc = "Cd into Git Root"
        },
        { "<leader>g", function() Snacks.lazygit() end, desc = "Lazygit" },
        {
            "<leader>tt",
            function()
                require("myterm")
                Snacks.terminal.toggle()
            end,
            desc = "Toggle Terminal"
        },
        {
            "<leader>ts",
            function()
                Snacks.picker.lsp_symbols(
                    { layout = { preset = "vscode", preview = "main" } })
            end,
            desc = "LSP Symbols"
        },
        {
            "<leader>tr",
            function()
                Snacks.picker.lsp_references(
                    { layout = { preset = "vscode", preview = "main" } })
            end,
            desc = "LSP References"
        },
        {
            "<leader>tw",
            function()
                Snacks.picker.lsp_workspace_symbols(
                    { layout = { preset = "vscode", preview = "main" } })
            end,
            desc = "LSP Workspace Symbols"
        },
        {
            "<leader>tf",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent files"
        },
        {
            "<leader>tp",
            function()
                Snacks.picker()
            end,
            desc = "View all pickers"
        },
        {
            "<leader><SPACE>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Files"
        },
        {
            "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers"
        },
        {
            "<leader>l", function() Snacks.picker.grep() end, desc = "Grep"
        }

        --     { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        --     { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    }
}
