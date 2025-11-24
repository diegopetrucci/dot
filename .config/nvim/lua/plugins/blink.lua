return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	version = "1.*",
	opts = {
		keymap = {
			-- https://cmp.saghen.dev/configuration/keymap
			preset = "super-tab",
			["<S-p>"] = { "select_prev", "fallback" },
			["<S-n>"] = { "select_next", "fallback" },
			["<S-u>"] = { "scroll_signature_up", "fallback" },
			["<S-d>"] = { "scroll_signature_down", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				auto_show = true,
				draw = {
					treesitter = { "lsp" },
					columns = {
						{
							"kind_icon",
							"label",
							gap = 1,
						},
						{
							"kind",
						},
					},
				},
			},
		},
		signature = {
			enabled = true,
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"copilot",
			},
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
							-- snippets for frameworks https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
							markdown = { "jekyll" },
							python = { "django" },
						},
					},
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = { "sources.default" },
}
