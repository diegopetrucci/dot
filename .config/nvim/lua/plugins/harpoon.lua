return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	main = "harpoon",
	opts = {},
	keys = function()
		local harpoon = require("harpoon")
		local list = function()
			return harpoon:list()
		end

		return {
			{
				"<leader>hj",
				function()
					list():add()
				end,
				desc = "Add file to harpoon",
			},
			{
				"<leader>hh",
				function()
					harpoon.ui:toggle_quick_menu(list())
				end,
				desc = "Toggle harpoon quick menu",
			},
			{
				"<leader>11",
				function()
					list():select(1)
				end,
				desc = "Select harpoon file 1",
			},
			{
				"<leader>22",
				function()
					list():select(2)
				end,
				desc = "Select harpoon file 2",
			},
			{
				"<leader>33",
				function()
					list():select(3)
				end,
				desc = "Select harpoon file 3",
			},
			{
				"<leader>44",
				function()
					list():select(4)
				end,
				desc = "Select harpoon file 4",
			},
			{
				"<leader>55",
				function()
					list():select(5)
				end,
				desc = "Select harpoon file 5",
			},
			{
				"<leader>66",
				function()
					list():select(6)
				end,
				desc = "Select harpoon file 6",
			},
			{
				"<leader>77",
				function()
					list():select(7)
				end,
				desc = "Select harpoon file 7",
			},
			{
				"<C-S-N>",
				function()
					list():next()
				end,
				desc = "Next harpoon file",
			},
			{
				"<C-S-P>",
				function()
					list():prev()
				end,
				desc = "Previous harpoon file",
			},
		}
	end,
}
