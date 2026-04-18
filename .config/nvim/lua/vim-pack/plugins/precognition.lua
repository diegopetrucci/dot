local ctx = require("vim-pack.context")

local function ensure_precognition(context)
	context.ensure_pack_plugin("precognition.nvim", function()
		require("precognition").setup({
			startVisible = true,
			showBlankVirtLine = true,
			highlightColor = { link = "Comment" },
			hints = {
				Caret = { text = "^", prio = 2 },
				Dollar = { text = "$", prio = 1 },
				MatchingPair = { text = "%", prio = 5 },
				Zero = { text = "0", prio = 1 },
				w = { text = "w", prio = 10 },
				b = { text = "b", prio = 9 },
				e = { text = "e", prio = 8 },
				W = { text = "W", prio = 7 },
				B = { text = "B", prio = 6 },
				E = { text = "E", prio = 5 },
			},
			gutterHints = {
				G = { text = "G", prio = 10 },
				gg = { text = "gg", prio = 9 },
				PrevParagraph = { text = "{", prio = 8 },
				NextParagraph = { text = "}", prio = 8 },
			},
			disabled_fts = {
				"startify",
			},
		})
	end)
end

return {
	spec = ctx.gh("tris203/precognition.nvim"),
	setup = function(context)
		local group = vim.api.nvim_create_augroup("vim_pack_precognition", { clear = true })

		vim.api.nvim_create_autocmd("VimEnter", {
			group = group,
			once = true,
			callback = function()
				ensure_precognition(context)
			end,
		})
	end,
}
