vim.loader.enable() -- Must be first line for maximum performance

require("tiagodias.core")

-- PackChanged hook: run TSUpdate after nvim-treesitter install/update
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
			vim.cmd("TSUpdate")
		end
	end,
})

-- PackChanged hook: run markdown-preview build step after install
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "markdown-preview.nvim" and ev.data.kind == "install" then
			if not ev.data.active then vim.cmd.packadd("markdown-preview.nvim") end
			vim.fn["mkdp#util#install"]()
		end
	end,
})
