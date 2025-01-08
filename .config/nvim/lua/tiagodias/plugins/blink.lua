local M = {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		'saghen/blink.cmp',
		lazy = false,
		dependencies = {
			{ 'rafamadriz/friendly-snippets' },
			{ "giuxtaposition/blink-cmp-copilot" },
			{ 'L3MON4D3/LuaSnip',                version = 'v2.*' },
			{ "folke/lazydev.nvim", },
		},
		version = 'v0.*',
		opts = {
			keymap = { preset = 'default' },
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = 'mono',
				kind_icons = {
					Copilot = "",
					Text = '󰉿',
					Method = '󰊕',
					Function = '󰊕',
					Constructor = '󰒓',

					Field = '󰜢',
					Variable = '󰆦',
					Property = '󰖷',

					Class = '󱡠',
					Interface = '󱡠',
					Struct = '󱡠',
					Module = '󰅩',

					Unit = '󰪚',
					Value = '󰦨',
					Enum = '󰦨',
					EnumMember = '󰦨',

					Keyword = '󰻾',
					Constant = '󰏿',

					Snippet = '󱄽',
					Color = '󰏘',
					File = '󰈔',
					Reference = '󰬲',
					Folder = '󰉋',
					Event = '󱐋',
					Operator = '󰪚',
					TypeParameter = '󰬛',
				},
			},
			snippets = { preset = 'luasnip' },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev' },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					-- dont show LuaLS require statements when lazydev has items
					lsp = { fallbacks = { "lazydev" } },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100, },
				},
			},
			signature = {
				enabled = true,
				window = { border = 'rounded' },
			},
			completion = {
				menu = { border = 'rounded' },
				documentation = {
					auto_show = true,
					window = { border = 'rounded' },
				},
				ghost_text = {
					enabled = true,
				},
			},
		},
		opts_extend = { "sources.default" }
	},
}

return M
