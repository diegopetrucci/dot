local ctx = require("vim-pack.context")

local function ensure_render_markdown(context)
	context.ensure_pack_plugin("render-markdown.nvim", function()
		require("render-markdown").setup({})
	end)
end

return {
	spec = ctx.gh("MeanderingProgrammer/render-markdown.nvim"),
	setup = function(context)
		local group = vim.api.nvim_create_augroup("vim_pack_render_markdown", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "markdown", "gitcommit" },
			callback = function()
				ensure_render_markdown(context)
			end,
		})
	end,
}
