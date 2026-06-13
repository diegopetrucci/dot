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
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if not lang then
					return
				end

				local has_parser = pcall(vim.treesitter.start, args.buf, lang)
				local has_indent_query, indent_query = pcall(vim.treesitter.query.get, lang, "indents")
				if has_parser and has_indent_query and indent_query then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
