-- Save undo history
vim.o.undofile = true
-- Disable swap files
vim.opt.swapfile = false
vim.opt.backup = false
-- Auto-reload files changed outside vim
vim.opt.autoread = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show search results as you type
vim.opt.incsearch = true

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Always show the sign column (prevents text shifting)
vim.opt.signcolumn = "yes"

-- Open splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,list:full" -- don't insert, show options

-- line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- hide the bottom bar
vim.opt.cmdheight = 0

-- Allow backspace over everything
vim.opt.backspace = "indent,eol,start"

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "›",
	precedes = "‹",
}

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "›",
	precedes = "‹",
}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- indentation for languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "swift", "python" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end,
})
