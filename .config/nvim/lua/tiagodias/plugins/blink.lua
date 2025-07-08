local M = {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "giuxtaposition/blink-cmp-copilot" },
			{ "Kaiser-Yang/blink-cmp-avante" }
		},
		version = "v0.*",
		opts = function(_, opts)
			opts.keymap = { preset = "default" }

			opts.sources = {
				-- Lack of obsidian as a source
				default = { "lsp", "path", "snippets", "buffer", "copilot", "avante" },
				providers = {
					copilot = {
						name = "copilot",
						enabled = true,
						module = "blink-cmp-copilot",
						score_offset = 100, -- the higher the number, the higher the priority
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
					avante = {
						module = 'blink-cmp-avante',
						name = 'Avante',
						opts = {
							-- options for blink-cmp-avante
						}
					}
				},
			}

			opts.snippets = {
				preset = "default",
			}

			opts.appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = "",
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			}

			opts.signature = {
				enabled = true,
				window = { border = "rounded" },
			}

			opts.completion = {
				menu = { border = "rounded" },
				documentation = {
					auto_show = true,
					window = { border = "rounded" },
				},
				ghost_text = {
					enabled = true,
				},
			}
		end,
		opts_extend = { "sources.default" }
	},
}

return M
