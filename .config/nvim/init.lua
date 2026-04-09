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
vim.pack.add({
	'https://github.com/tpope/vim-obsession',
	'https://github.com/ThePrimeagen/vim-be-good',
	'https://github.com/mluders/comfy-line-numbers.nvim',
	'https://github.com/nvim-mini/mini.nvim',
	'https://github.com/rafamadriz/friendly-snippets',
	'https://github.com/norcalli/nvim-colorizer.lua',
	'https://github.com/m4xshen/hardtime.nvim',
})

vim.cmd.packadd('hardtime.nvim')
require('hardtime').setup()

-- start lazy
require("lazy").setup("plugins")
