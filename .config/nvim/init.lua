-- configure lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- config nvim
require("keymaps")
require("options")

-- vim.pack plugins must be added before lazy.setup() because lazy resets packpath
-- to only $VIMRUNTIME, which causes :packadd to fail with E919 afterwards
local original_packpath = vim.o.packpath
require("vim-pack").add()

-- start lazy
require("lazy").setup("plugins")
vim.o.packpath = original_packpath

require("vim-pack").setup()
