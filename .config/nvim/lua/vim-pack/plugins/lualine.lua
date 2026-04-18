local ctx = require("vim-pack.context")

local function xcodebuild_device()
	if not vim.g.xcodebuild_platform or vim.g.xcodebuild_platform == "" then
		return ""
	end

	if vim.g.xcodebuild_platform == "macOS" then
		return " macOS"
	end

	local device_icon = ""
	if vim.g.xcodebuild_platform:match("watch") then
		device_icon = "􀟤"
	elseif vim.g.xcodebuild_platform:match("tv") then
		device_icon = "􀡴 "
	elseif vim.g.xcodebuild_platform:match("vision") then
		device_icon = "􁎖 "
	end

	if vim.g.xcodebuild_os then
		return device_icon .. " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
	end

	return device_icon .. " " .. vim.g.xcodebuild_device_name
end

return {
	spec = ctx.gh("nvim-lualine/lualine.nvim"),
	load = true,
	setup = function(context)
		context.ensure_pack_plugin("lualine.nvim", function()
			context.load_lazy_plugin("nvim-web-devicons")

			local custom_horizon = require("lualine.themes.horizon")
			local bg = "#1E1E2E"

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

			local primary_fg = "#CDD6F4"
			local secondary_fg = "#6C7086"

			require("lualine").setup({
				options = {
					theme = custom_horizon,
				},
				sections = {
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
								end

								return str:sub(1, 1)
							end,
						},
					},
					lualine_b = {
						{
							"filename",
							color = {
								fg = secondary_fg,
								bg = bg,
							},
							symbols = {
								modified = "",
								readonly = "",
								unnamed = "",
								newfile = "",
							},
						},
						{
							function()
								return " " .. (vim.g.xcodebuild_last_status or "")
							end,
							color = {
								fg = secondary_fg,
								bg = bg,
							},
						},
						{
							xcodebuild_device,
							color = {
								fg = secondary_fg,
								bg = bg,
							},
						},
						{
							function()
								return "󰙨 " .. (vim.g.xcodebuild_test_plan or "")
							end,
							color = {
								fg = secondary_fg,
								bg = bg,
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
					lualine_y = {},
					lualine_z = {},
				},
			})
		end)
	end,
}
