local M = {}

local configured = {}

function M.gh(repo)
	return "https://github.com/" .. repo
end

function M.load_lazy_plugin(name)
	local ok, lazy = pcall(require, "lazy")
	if ok then
		lazy.load({ plugins = { name } })
	end
end

function M.ensure_pack_plugin(name, setup)
	if configured[name] then
		return
	end

	vim.cmd.packadd(name)

	if setup ~= nil then
		setup()
	end

	configured[name] = true
end

return M
