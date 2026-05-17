-- set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Diagnostic keymaps                                                                                    -
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Navigation
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down keep cursor centered" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up keep cursor centered" })

-- Keep search terms in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear search highlighting with Esc in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Source current file
vim.keymap.set("n", "<leader>R", "<cmd>source %<CR>", { desc = "Source current file" })

-- Stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Copy relative path (to current working directory)
vim.keymap.set("n", "<leader>cp", function()
	local p = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
	vim.fn.setreg("+", p)
	vim.notify("Copied: " .. p)
end, { desc = "Copy file path (relative)" })

-- Copy absolute path
vim.keymap.set("n", "<leader>cP", function()
	local p = vim.api.nvim_buf_get_name(0)
	vim.fn.setreg("+", p)
	vim.notify("Copied: " .. p)
end, { desc = "Copy file path (absolute)" })

-- Copy filename
vim.keymap.set("n", "<leader>cn", function()
	local p = vim.fn.expand("%:t")
	vim.fn.setreg("+", p)
	vim.notify("Copied: " .. p)
end, { desc = "Copy file name" })

-- Update plugins via vim.pack
vim.keymap.set("n", "<leader>pu", function()
	vim.pack.update()
end, { desc = "Update plugins (vim.pack)" })
