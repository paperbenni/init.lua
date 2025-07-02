return {
	-- "neovim/nvim-lspconfig",
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim" },
		"neovim/nvim-lspconfig",
	},
	event = { "VeryLazy", "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		-- local potato = require("mypotato")
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_enable = {
				exclude = {
					"harper_ls",
					"lua_ls",
				},
			},
		})
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local on_attach = function(client, bufnr)
			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions

			local function setkey(mode, key, func, description)
				vim.keymap.set(mode, key, func, { noremap = true, silent = true, buffer = bufnr, desc = description })
			end

			setkey("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
			setkey("n", "gd", vim.lsp.buf.definition, "Go to definition")
			setkey("n", "K", vim.lsp.buf.hover, "Show hover")
			-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
			-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
			-- vim.keymap.set('n', '<space>wl', function()
			--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			-- end, bufopts)
			-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

			setkey("n", "<leader><F2>", vim.lsp.buf.rename, "Rename")
			setkey("n", "<leader>x", vim.lsp.buf.code_action, "Code Action")
			-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			-- setkey('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, 'LSP Format buffer')
			vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
		end
		local lspconfig = require("lspconfig")

		lspconfig.yamlls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				yaml = {
					schemas = {
						["https://raw.githubusercontent.com/canonical/cloud-init/main/cloudinit/config/schemas/versions.schema.cloud-config.json"] = "user-data.yml",
					},
				},
			},
		})

		lspconfig.lua_ls.setup({
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths here.
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
	end,
}
