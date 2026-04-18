local ctx = require("vim-pack.context")

local function ensure_which_key(context)
	context.ensure_pack_plugin("which-key.nvim", function()
		require("which-key").setup({
			triggers = {
				{ "<auto>", mode = "nxso" },
				{ "<leader>", mode = { "n", "v" } },
				{ "<localleader>", mode = { "n", "v" } },
			},
		})
	end)
end

return {
	spec = ctx.gh("folke/which-key.nvim"),
	load = true,
	setup = function(context)
		ensure_which_key(context)

		vim.keymap.set("n", "<leader>?", function()
			require("which-key").show({ global = false })
		end, { desc = "Buffer Local Keymaps (which-key)" })
	end,
}
