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

			vim.lsp.config("sourcekit", {
				-- Resolve sourcekit-lsp via active Xcode toolchain instead of relying on PATH.
				cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
				-- on_attach = function(client, bufnr)
				-- 	require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				-- end,
			})

			-- Helper function to check if pyright should be enabled
			local function should_enable_pyright()
				local root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" }
				local root_dir = vim.fs.root(0, root_markers)

				if root_dir and vim.fn.filereadable(root_dir .. "/.disable-pyright") == 1 then
					return false
				end
				return true
			end

			-- Build LSP list conditionally
			local lsp_servers = {
				"copilot",
				"lua_ls",
				"kotlin_lsp",
				"marksman",
				"ruff",
				"sourcekit",
				"taplo",
				"yamlls",
			}

			-- Only add pyright if not disabled
			if should_enable_pyright() then
				table.insert(lsp_servers, 5, "pyright") -- Insert after marksman
			end

			-- configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
			vim.lsp.enable(lsp_servers)

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

			for _, client in ipairs(vim.lsp.get_clients()) do
				require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
			end
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
