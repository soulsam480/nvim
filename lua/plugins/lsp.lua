return {
	{
		"neovim/nvim-lspconfig",
		version = "v1.0.0",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
		},
		opts = {
			-- Disable eslint formatting as it's slow and timing out on big projects
			-- taken from
			-- https://github.com/LazyVim/LazyVim/pull/4225/files
			setup = {
				eslint = function() end,
			},
		},
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vtsls",
					"cssls",
					"tailwindcss",
					"marksman",
					"html",
					"emmet_language_server",
					"volar",
					"svelte",
					"astro",
					"jsonls",
					"biome",
				},
			})

			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client, bufnr)
				if client.name == "gleam" then
					client.server_capabilities.documentFormattingProvider = true
				end
				--
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				nmap("<lader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
					require("utils.formatting").format(bufnr)
				end, { desc = "Format current buffer with LSP" })

				nmap("<leader>i", function()
					require("utils.formatting").format(bufnr)
				end, "Format current buffer with LSP")
			end

			--
			local lspconfig = require("lspconfig")

			local lsps = {
				"lua_ls",
				"cssls",
				"tailwindcss",
				"marksman",
				"html",
				"emmet_language_server",
				"astro",
				"svelte",
				"ruff_lsp",
			}

			for _, lsp in ipairs(lsps) do
				require("lspconfig")[lsp].setup({
					capablities = require("blink.cmp").get_lsp_capabilities(),
					on_attach = on_attach,
				})
			end

			lspconfig.gleam.setup({
				capablities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = on_attach,
			})

			lspconfig.vtsls.setup({
				capablities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = on_attach,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					typescript = {
						updateImportsOnFileMove = {
							enabled = "always",
						},
						preferences = {
							importModuleSpecifier = "non-relative",
						},
					},
					javascript = {
						updateImportsOnFileMove = {
							enabled = "always",
						},
					},
					vtsls = {
						tsserver = {
							globalPlugins = {},
						},
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
						autoUseWorkspaceTsdk = true,
					},
				},
				before_init = function(_, config)
					local vuePluginConfig = {
						name = "@vue/typescript-plugin",
						location = require("mason-registry").get_package("vue-language-server"):get_install_path()
							.. "/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					}
					table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
				end,
			})

			lspconfig.volar.setup({})

			lspconfig.solargraph.setup({
				capablities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = on_attach,
				init_options = {
					useBundler = true,
					bundlerPath = "/Users/sambitsahoo/.rbenv/shims/bundle",
					formatting = true,
					diagnostics = true,
					autoformat = false,
					completion = true,
					definitions = true,
					references = true,
					symbols = true,
					checkGemVersion = true,
					rename = false,
					logLevel = "error",
					folding = true,
				},
			})

			require("lspconfig").jsonls.setup({
				capablities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = on_attach,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas({
							ignore = {
								".eslintrc",
								"package.json",
							},
						}),
						validate = { enable = true },
					},
				},
			})

			require("lspconfig").pylsp.setup({
				capablities = require("blink.cmp").get_lsp_capabilities(),
				on_attach = on_attach,
				settings = {
					pylsp = {
						plugins = {
							flake8 = {
								enabled = false,
							},
							autopep8 = {
								enabled = false,
							},
							mccabe = {
								enabled = false,
							},
						},
					},
				},
			})

			if require("utils.linter").has_linter("biome") then
				lspconfig.biome.setup({
					capablities = require("blink.cmp").get_lsp_capabilities(),
					on_attach = on_attach,
				})
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"vue",
					"css",
					"tsx",
					"html",
					"ruby",
				},
				auto_install = true,
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
			})
		end,
	},
	{ "soulsam480/nvim-eslint", branch = "lazy-init", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{
		"soulsam480/nvim-oxlint",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
