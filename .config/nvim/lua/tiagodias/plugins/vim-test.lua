return {
	"vim-test/vim-test",
	dependencies = { "preservim/vimux" },
	config = function()
		vim.keymap.set("n", "<leader>tt", function()
			vim.cmd("TestNearest")
		end)
		vim.keymap.set("n", "<leader>tf", function()
			vim.cmd("TestFile")
		end)
		vim.keymap.set("n", "<leader>ts", function()
			vim.cmd("TestSuite")
		end)
		vim.keymap.set("n", "<leader>tl", function()
			vim.cmd("TestLast")
		end)
		vim.keymap.set("n", "<leader>tv", function()
			vim.cmd("TestVisit")
		end)
		vim.cmd("let test#strategy = 'vimux'")
	end,
}
