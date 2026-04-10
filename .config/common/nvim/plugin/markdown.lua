vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/nvim-lua/plenary.nvim",
			"https://github.com/iamcco/markdown-preview.nvim",
			{ src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
		})

		vim.schedule(function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "second-brain",
						path = "~/personal/second-brain",
					},
				},

				log_level = vim.log.levels.INFO,

				legacy_commands = false,

				daily_notes = {
					folder = "daily-notes",
					date_format = "%Y-%m-%d",
					alias_format = "%B %-d, %Y",
					default_tags = { "daily-note" },
					template = nil,
				},

				completion = {
					nvim_cmp = false,
					blink = true,
					min_chars = 2,
				},

				---@param title string|?
				---@return string
				note_id_func = function(title)
					local suffix = ""
					if title ~= nil then
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,

				picker = {
					name = "mini.pick",
				},
			})
		end)
	end,
})
