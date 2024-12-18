return {
	'saghen/blink.cmp',
	lazy = true,
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
		{ "giuxtaposition/blink-cmp-copilot" },
		{ 'L3MON4D3/LuaSnip',                version = 'v2.*' },
	},
	version = 'v0.*',
	opts = {
		keymap = {
			preset = 'enter',
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
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
		snippets = {
			expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
			active = function(filter)
				if filter and filter.direction then
					return require('luasnip').jumpable(filter.direction)
				end
				return require('luasnip').in_snippet()
			end,
			jump = function(direction) require('luasnip').jump(direction) end,
		},
		sources = {
			default = { 'lsp', 'path', 'luasnip', 'snippets', 'buffer', 'copilot' },
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
			},
			completion = {
				enabled_providers = { 'lsp', 'path', 'luasnip', 'snippets', 'buffer', 'copilot' },
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
}
