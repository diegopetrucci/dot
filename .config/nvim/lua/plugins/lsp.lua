return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				-- registry https://mason-registry.dev/registry/list
				"copilot-language-server",
				"lua-language-server",
				"kotlin-lsp",
				"marksman",
				"pyright",
				"ruff",
				"swiftlint",
				"taplo",
				"yaml-language-server",
				"xcbeautify",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"copilot",
				"lua_ls",
				"kotlin_lsp",
				"marksman",
				"pyright",
				"ruff",
				"taplo",
				"yamlls",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"artemave/workspace-diagnostics.nvim",
		},
		config = function()
			local resolved_sourcekit_cmd
			if vim.fn.executable("xcrun") == 1 then
				resolved_sourcekit_cmd = { "xcrun", "sourcekit-lsp" }
			elseif vim.fn.executable("sourcekit-lsp") == 1 then
				resolved_sourcekit_cmd = { "sourcekit-lsp" }
			end

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						diagnostics = {
							globals = { "Snacks" },
						},
					},
				},
			})

			if resolved_sourcekit_cmd then
				vim.lsp.config("sourcekit", {
					-- Resolve sourcekit-lsp at server launch instead of shelling out during startup.
					cmd = resolved_sourcekit_cmd,
				})
			end

			vim.lsp.config("pyright", {
				root_dir = function(bufnr, on_dir)
					local root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" }
					local root = vim.fs.root(bufnr, root_markers)
					if root and vim.uv.fs_stat(root .. "/.disable-pyright") then
						return
					end
					if root then
						on_dir(root)
					end
				end,
				single_file_support = false,
			})

			-- Build LSP list conditionally
			local lsp_servers = {
				"copilot",
				"lua_ls",
				"kotlin_lsp",
				"marksman",
				"pyright",
				"ruff",
				"taplo",
				"yamlls",
			}

			if resolved_sourcekit_cmd then
				table.insert(lsp_servers, "sourcekit")
			end

			-- configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
			vim.lsp.enable(lsp_servers)
			vim.lsp.enable("pylsp", false)

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
			vim.keymap.set("n", "<leader>cc", vim.lsp.buf.incoming_calls, { desc = "Callers (LSP)" })
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "References (LSP)" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Definition (LSP)" })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and vim.tbl_get(client.config, "filetypes") then
						require("workspace-diagnostics").populate_workspace_diagnostics(client, args.buf)
					end
				end,
			})
		end,
	},
	{
		"stevanmilic/nvim-lspimport",
		-- auto imports for pyright
		keys = {
			{
				"<leader>ai",
				function()
					require("lspimport").import()
				end,
				mode = "n",
				noremap = true,
				desc = "Add missing import",
			},
		},
	},
}
