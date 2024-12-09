return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf_lua = require("fzf-lua")
		fzf_lua.setup({
			winopts = {
				fullscreen = true,
			},
			grep = {
				rg_opts = [[--hidden -g "!.git" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]],
			},
		})

		vim.keymap.set("n", "<leader>sf", fzf_lua.files, { desc = "[S]earch [f]iles in cwd" })
		vim.keymap.set("n", "<leader>ss", fzf_lua.live_grep, { desc = "[S]earch [s]tring in cwd" })
		vim.keymap.set("n", "<leader>sc", fzf_lua.grep_cword, { desc = "[S]earch string under [c]ursor in cwd" })
		vim.keymap.set("n", "<leader>sb", fzf_lua.buffers, { desc = "[S]earch existing [b]uffers" })
		vim.keymap.set("n", "<leader>sg", fzf_lua.git_files, { desc = "[S]earch [g]it files" })
		vim.keymap.set("n", "<leader>sh", fzf_lua.helptags, { desc = "[S]earch [h]elp" })
		vim.keymap.set("n", "<leader>sr", fzf_lua.resume, { desc = "[S]earch [r]esume" })
	end,
}
