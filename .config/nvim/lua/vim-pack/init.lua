local ctx = require("vim-pack.context")

local plugins = {
	require("vim-pack.plugins.vim_obsession"),
	require("vim-pack.plugins.vim_be_good"),
	require("vim-pack.plugins.comfy_line_numbers"),
	require("vim-pack.plugins.mini"),
	require("vim-pack.plugins.friendly_snippets"),
	require("vim-pack.plugins.nvim_colorizer"),
	require("vim-pack.plugins.catppuccin"),
	require("vim-pack.plugins.lualine"),
	require("vim-pack.plugins.harpoon"),
	require("vim-pack.plugins.trouble"),
	require("vim-pack.plugins.which_key"),
	require("vim-pack.plugins.flash"),
	require("vim-pack.plugins.tiny_inline_diagnostic"),
	require("vim-pack.plugins.precognition"),
	require("vim-pack.plugins.render_markdown"),
}

local M = {}

function M.add()
	local eager_specs = {}
	local lazy_specs = {}

	for _, plugin in ipairs(plugins) do
		if plugin.load then
			table.insert(eager_specs, plugin.spec)
		else
			table.insert(lazy_specs, plugin.spec)
		end
	end

	if #lazy_specs > 0 then
		vim.pack.add(lazy_specs, {
			load = false,
			confirm = false,
		})
	end

	if #eager_specs > 0 then
		vim.pack.add(eager_specs, {
			load = true,
			confirm = false,
		})
	end
end

function M.setup()
	for _, plugin in ipairs(plugins) do
		if plugin.setup then
			plugin.setup(ctx)
		end
	end
end

return M
