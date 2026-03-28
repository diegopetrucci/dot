return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"bash",
			"diff",
			"html",
			"javascript",
			"json",
			"kotlin",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"swift",
			"toml",
			"typescript",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
