vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		-- Copilot: suggestions and panel disabled, used via blink-cmp-copilot
		vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })

		vim.schedule(function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				-- Use specific Node.js version from asdf if available, else fallback to system node
				copilot_node_command = (function()
					local asdf_node = vim.fn.expand("$HOME") .. "/.asdf/installs/nodejs/23.11.0/bin/node"
					if vim.loop.fs_stat(asdf_node) then
						return asdf_node
					else
						return "node"
					end
				end)(),
			})
		end)

		-- OpenCode AI assistant
		-- opencode uses vim.g.opencode_opts instead of a setup() function
		vim.pack.add({
			"https://github.com/cbochs/grapple.nvim",
			"https://github.com/NickvanDyke/opencode.nvim",
		})

		vim.keymap.set("n", "<leader>oa", function() require("opencode").ask("@cursor: ") end,                          { desc = "Ask opencode" })
		vim.keymap.set("v", "<leader>oa", function() require("opencode").ask("@selection: ") end,                       { desc = "Ask opencode about selection" })
		vim.keymap.set("n", "<leader>ot", function() require("opencode").toggle() end,                                  { desc = "Toggle embedded opencode" })
		vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end,                    { desc = "New session" })
		vim.keymap.set("n", "<leader>oy", function() require("opencode").command("messages_copy") end,                  { desc = "Copy last message" })
		vim.keymap.set("n", "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end,          { desc = "Scroll messages up" })
		vim.keymap.set("n", "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end,        { desc = "Scroll messages down" })
		vim.keymap.set({ "n", "v" }, "<leader>op", function() require("opencode").select_prompt() end,                 { desc = "Select prompt" })
		vim.keymap.set("n", "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, { desc = "Explain code near cursor" })
	end,
})
