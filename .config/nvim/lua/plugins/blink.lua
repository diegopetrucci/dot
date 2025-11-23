return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    "fang2hou/blink-copilot",
  },
  version = '1.*',
  opts = {
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'super-tab',
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        snippets = {
          opts = {
            friendly_snippets = true,
            extended_filetypes = {
              -- https://github.com/rafamadriz/friendly-snippets/tree/main/snippets
              markdown = { 'jekyll' },
              python = { 'django' },
            }
          }
        }
      }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
