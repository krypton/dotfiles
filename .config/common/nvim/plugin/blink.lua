vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/rafamadriz/friendly-snippets",
			"https://github.com/giuxtaposition/blink-cmp-copilot",
			{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("0.x") },
		})

		vim.schedule(function()
			require("blink.cmp").setup({
				keymap = { preset = "default" },

				sources = {
					default = { "lsp", "path", "snippets", "buffer", "copilot" },
					providers = {
						copilot = {
							name = "copilot",
							enabled = true,
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
				},

				snippets = {
					preset = "default",
				},

				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
					kind_icons = {
						Copilot       = "",
						Text          = "󰉿",
						Method        = "󰊕",
						Function      = "󰊕",
						Constructor   = "󰒓",
						Field         = "󰜢",
						Variable      = "󰆦",
						Property      = "󰖷",
						Class         = "󱡠",
						Interface     = "󱡠",
						Struct        = "󱡠",
						Module        = "󰅩",
						Unit          = "󰪚",
						Value         = "󰦨",
						Enum          = "󰦨",
						EnumMember    = "󰦨",
						Keyword       = "󰻾",
						Constant      = "󰏿",
						Snippet       = "󱄽",
						Color         = "󰏘",
						File          = "󰈔",
						Reference     = "󰬲",
						Folder        = "󰉋",
						Event         = "󱐋",
						Operator      = "󰪚",
						TypeParameter = "󰬛",
					},
				},

				signature = {
					enabled = true,
				},

				completion = {
					documentation = {
						auto_show = true,
					},
					ghost_text = {
						enabled = true,
					},
				},
			})
		end)
	end,
})
