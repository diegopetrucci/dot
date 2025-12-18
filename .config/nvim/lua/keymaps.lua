-- set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Diagnostic keymaps                                                                                    -
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down keep cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up keep cursor centered" })

-- Keep search terms in the middle of screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clear search highlighting with Esc in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")
