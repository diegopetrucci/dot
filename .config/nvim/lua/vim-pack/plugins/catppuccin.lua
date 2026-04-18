local ctx = require("vim-pack.context")

return {
	spec = {
		src = ctx.gh("catppuccin/nvim"),
		name = "catppuccin",
	},
	load = true,
	setup = function(context)
		context.ensure_pack_plugin("catppuccin", function()
			require("catppuccin").setup({
				auto_integrations = true,
				integrations = {
					alpha = true,
					blink_cmp = {
						style = "bordered",
					},
					dashboard = true,
					dap = true,
					harpoon = true,
					gitsigns = true,
					mason = true,
					render_markdown = true,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					neotree = true,
					notify = false,
					snacks = {
						enabled = true,
						indent_scope_color = "lavender",
					},
					lsp_trouble = true,
					which_key = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end)
	end,
}
