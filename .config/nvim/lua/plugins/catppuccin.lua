return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      auto_integrations = true,
      integrations = {
        -- https://github.com/catppuccin/nvim#integrations
        alpha = true,
        blink_cmp = {
          style = 'bordered',
        },
        dashboard = true,
        dap = true,
        harpoon = true,
        gitsigns = true,
        mason = true,
        render_markdown = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        neotree = true,
        notify = false,
        snacks = {
          enabled = true,
          indent_scope_color = "lavander",
        },
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        which_key = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end
}
