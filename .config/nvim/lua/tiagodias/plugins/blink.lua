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
			nerd_font_variant = 'mono'
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
				},
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
