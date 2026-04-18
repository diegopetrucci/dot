local ctx = require("vim-pack.context")

local function ensure_flash(context)
	context.ensure_pack_plugin("flash.nvim", function()
		require("flash").setup({
			modes = {
				search = {
					enabled = true,
				},
				char = {
					jump_labels = true,
				},
			},
		})
	end)
end

return {
	spec = ctx.gh("folke/flash.nvim"),
	setup = function(context)
		vim.keymap.set("n", "s", function()
			ensure_flash(context)
			require("flash").jump()
		end, { desc = "Flash" })
		vim.keymap.set("x", "s", function()
			ensure_flash(context)
			require("flash").jump()
		end, { desc = "Flash" })
		vim.keymap.set("o", "s", function()
			ensure_flash(context)
			require("flash").jump()
		end, { desc = "Flash" })

		vim.keymap.set("n", "S", function()
			ensure_flash(context)
			require("flash").treesitter()
		end, { desc = "Flash Treesitter" })
		vim.keymap.set("x", "S", function()
			ensure_flash(context)
			require("flash").treesitter()
		end, { desc = "Flash Treesitter" })
		vim.keymap.set("o", "S", function()
			ensure_flash(context)
			require("flash").treesitter()
		end, { desc = "Flash Treesitter" })

		vim.keymap.set("o", "r", function()
			ensure_flash(context)
			require("flash").remote()
		end, { desc = "Remote Flash" })
		vim.keymap.set("o", "R", function()
			ensure_flash(context)
			require("flash").treesitter_search()
		end, { desc = "Treesitter Search" })
		vim.keymap.set("x", "R", function()
			ensure_flash(context)
			require("flash").treesitter_search()
		end, { desc = "Treesitter Search" })
		vim.keymap.set("c", "<C-s>", function()
			ensure_flash(context)
			require("flash").toggle()
		end, { desc = "Toggle Flash Search" })
	end,
}
