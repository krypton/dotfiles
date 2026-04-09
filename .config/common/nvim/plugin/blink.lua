vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/rafamadriz/friendly-snippets",
			{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
		})

		vim.schedule(function()
			require("blink.cmp").setup({
				keymap = { preset = "default" },

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
					kind_icons = {
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
