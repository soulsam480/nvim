return {
	{
		"neovim/nvim-lspconfig",
		-- version = "v1.0.0",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
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
					"vue_ls",
					"svelte",
					"jsonls",
					"biome",
					"elixirls",
					"ruff",
					"pylsp",
					"rust_analyzer",
					"astro",
				},
				automatic_enable = {
					exclude = {
						"biome",
						"vtsls",
					},
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

			-- vim.lsp.config("*", {
			-- 	capabilities = require("blink.cmp").get_lsp_capabilities(),
			-- })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					on_attach(client, ev.buf)
				end,
			})

			local vue_language_server_path = vim.fn.expand("$MASON/packages")
				.. "/vue-language-server"
				.. "/node_modules/@vue/language-server"

			local astro_ts_plugin_path = io.popen("npm root -g"):read("*a"):gsub("\n", "") .. "/@astrojs/ts-plugin"

			vim.lsp.config("vtsls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
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
							globalPlugins = {
								{
									name = "@astrojs/ts-plugin",
									languages = { "astro" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersions = true,
									location = astro_ts_plugin_path,
								},
							},
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
						location = vue_language_server_path,
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					}
					table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
				end,
			})

			vim.lsp.enable("vtsls")

			vim.lsp.config("solargraph", {
				cmd = { "bundle", "exec", "solargraph", "stdio" },
				init_options = {
					useBundler = true,
					bundlerPath = "~/.local/share/mise/shims/bundler",
					checkGemVersion = true,
					rename = false,
					logLevel = "error",
					formatting = false,
					diagnostics = true,
					autoformat = false,
					completion = true,
					definitions = true,
					references = true,
					symbols = true,
					folding = true,
				},
			})

			vim.lsp.enable("solargraph")

			vim.lsp.config("jsonls", {
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

			vim.lsp.config("pylsp", {
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
							pyflakes = { enabled = false },
							pylint = { enabled = false },
						},
					},
				},
			})

			if require("utils.linter").has_linter("biome") then
				vim.lsp.config("biome", {})
				vim.lsp.enable("biome")
			end

			vim.lsp.config("tailwindcss", {
				settings = {
					tailwindCSS = {
						experimental = {
							configFile = require("utils.tailwind").get_tailwind_config_file(),
						},
					},
				},
			})

			vim.lsp.enable("gleam")

			vim.lsp.enable("astro")
			vim.lsp.enable("rust_analyzer")
			vim.lsp.enable("jdtls")

			vim.lsp.config("ctags_lsp", {
				cmd = { "ctags-lsp" },
				filetypes = { "ruby" },
				root_dir = function()
					return vim.fn.getcwd()
				end,
			})

			vim.lsp.enable("ctags_lsp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "VeryLazy" },
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
