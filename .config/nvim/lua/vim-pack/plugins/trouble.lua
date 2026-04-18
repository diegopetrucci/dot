local ctx = require("vim-pack.context")

return {
	spec = ctx.gh("folke/trouble.nvim"),
	load = true,
	setup = function(context)
		context.ensure_pack_plugin("trouble.nvim", function()
			require("trouble").setup({
				diagnostics = {
					auto_open = true,
					auto_close = true,
				},
			})
		end)

		vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
		vim.keymap.set(
			"n",
			"<leader>tX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			{ desc = "Buffer Diagnostics (Trouble)" }
		)
		vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
		vim.keymap.set(
			"n",
			"<leader>tl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			{ desc = "LSP Definitions / references / ... (Trouble)" }
		)
		vim.keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
		vim.keymap.set("n", "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
	end,
}
