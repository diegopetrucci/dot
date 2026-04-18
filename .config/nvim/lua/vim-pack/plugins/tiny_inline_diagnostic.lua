local ctx = require("vim-pack.context")

local function ensure_inline_diagnostics(context)
	context.ensure_pack_plugin("tiny-inline-diagnostic.nvim", function()
		require("tiny-inline-diagnostic").setup()
		vim.diagnostic.config({ virtual_text = false })
	end)
end

return {
	spec = ctx.gh("rachartier/tiny-inline-diagnostic.nvim"),
	setup = function(context)
		local group = vim.api.nvim_create_augroup("vim_pack_tiny_inline_diagnostic", { clear = true })

		vim.api.nvim_create_autocmd("VimEnter", {
			group = group,
			once = true,
			callback = function()
				ensure_inline_diagnostics(context)
			end,
		})
	end,
}
