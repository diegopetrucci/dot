return {
  "nvim-treesitter/nvim-treesitter",
  -- TSUpdate ensures that the parsers are up to date
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
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
      "yaml"
    },
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  }
}
