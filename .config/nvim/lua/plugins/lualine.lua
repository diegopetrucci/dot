return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function(_, opts)
		opts.options = opts.options or {}

		-- Override specific highlights after the theme is set
		local custom_horizon = require("lualine.themes.horizon")
		local bg = "#1E1E2E"

		-- Set catppuccin's background for all available modes
		custom_horizon.normal.c.bg = bg
		custom_horizon.insert.c.bg = bg
		custom_horizon.visual.c.bg = bg
		custom_horizon.replace.c.bg = bg
		custom_horizon.command.c.bg = bg
		custom_horizon.inactive.c.bg = bg
		if custom_horizon.terminal then
			custom_horizon.terminal.c.bg = bg
		end
		if custom_horizon.select then
			custom_horizon.select.c.bg = bg
		end

		opts.options.theme = custom_horizon

		local primary_fg = "#CDD6F4"
		local secondary_fg = "#6C7086"

		opts.sections = {
			lualine_a = {
				{
					"mode",
					color = {
						fg = secondary_fg,
						bg = bg,
					},
					fmt = function(str)
						if str == "NORMAL" then
							return ""
						else
							return str:sub(1, 1)
						end
					end,
				},
			},
			lualine_b = {
				{
					"filename",
					color = {
						fg = secondary_fg,
						bg = bg,
						-- gui = 'italic,bold'
					},
					symbols = {
						modified = "",
						readonly = "",
						unnamed = "",
						newfile = "",
					},
				},
				{
					"diagnostics",
					color = {
						fg = primary_fg,
						bg = bg,
					},
				},
			},
			lualine_c = {
				{
					"searchcount",
					color = {
						fg = primary_fg,
						bg = bg,
					},
				},
				{
					"selectioncount",
					color = {
						fg = primary_fg,
						bg = bg,
					},
				},
			},
			lualine_x = {
				{
					"branch",
					color = {
						fg = secondary_fg,
						bg = bg,
					},
				},
				{
					"diff",
					color = {
						fg = secondary_fg,
						bg = bg,
					},
				},
			},
			lualine_y = {
			},
			lualine_z = {},
		}
		return opts
	end,
}
