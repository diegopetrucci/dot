local ctx = require("vim-pack.context")

local function ensure_harpoon(context)
	context.load_lazy_plugin("plenary.nvim")
	context.ensure_pack_plugin("harpoon", function()
		require("harpoon"):setup()
	end)
end

return {
	spec = {
		src = ctx.gh("ThePrimeagen/harpoon"),
		name = "harpoon",
		version = "harpoon2",
	},
	setup = function(context)
		vim.keymap.set("n", "<leader>hj", function()
			ensure_harpoon(context)
			require("harpoon"):list():add()
		end, { desc = "Add file to harpoon" })

		vim.keymap.set("n", "<leader>hh", function()
			ensure_harpoon(context)
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Toggle harpoon quick menu" })

		for i = 1, 7 do
			vim.keymap.set("n", "<leader>" .. i .. i, function()
				ensure_harpoon(context)
				require("harpoon"):list():select(i)
			end, { desc = "Select harpoon file " .. i })
		end

		vim.keymap.set("n", "<C-S-N>", function()
			ensure_harpoon(context)
			require("harpoon"):list():next()
		end, { desc = "Next harpoon file" })

		vim.keymap.set("n", "<C-S-P>", function()
			ensure_harpoon(context)
			require("harpoon"):list():prev()
		end, { desc = "Previous harpoon file" })
	end,
}
