-- Plugin to format code using various formatters
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				kotlin = { "ktfmt" },
				lua = { "stylua" },
				python = { "ruff" },
				swift = { "swiftformat", "swiftlint" },
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "trim_newlines" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = function(bufnr)
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			log_level = vim.log.levels.ERROR,
		})

		vim.keymap.set({ "n", "v" }, "<leader>fo", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
