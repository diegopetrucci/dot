return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- registry https://mason-registry.dev/registry/list
        "copilot-language-server",
        "lua-language-server",
        "kotlin-lsp",
        "marksman",
        "pyright",
        "ruff",
        "swiftlint",
        "taplo",
        "yaml-language-server",
        "xcbeautify"
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "copilot",
        "lua_ls",
        "kotlin_lsp",
        "marksman",
        "pyright",
        "ruff",
        "taplo",
        "yamlls",
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
              globals = { "Snacks" },
            },
          },
        },
      })

      -- configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      vim.lsp.enable(
        {
          "copilot",
          "lua_ls",
          "kotlin_lsp",
          "marksman",
          "pyright",
          "ruff",
          "taplo",
          "yamlls",
        }
      )

      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  }
}
