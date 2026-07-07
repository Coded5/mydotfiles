return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	ft = "markdown",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("obsidian").setup({
			legacy_commands = false,
			workspaces = {
				{
					name = "Idyll",
					path = "~/Documents/Idyll/",
				},
				{
					name = "Viewfinder",
					path = "~/Documents/Viewfinder",
				},
			},
			picker = {
				name = "telescope.nvim",
			},
			new_notes_location = "notes_subdir",
			notes_subdir = "00 Inbox",
			note_id_func = function(title)
				if title ~= nil then
					return (title:gsub("[^A-Za-z0-9 %-]", ""))
				else
					return tostring(os.time())
				end
			end,
			templates = {
				folder = "99 Templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
				substitutions = {
					carryover = function()
						local vault_path = tostring(Obsidian.dir)
						local yesterday = os.date("%Y-%m-%d", os.time() - 86400)
						local path = vault_path .. "/10 Daily/" .. yesterday .. ".md"

						if vim.fn.filereadable(path) == 0 then
							return "_(no previous daily note found)_"
						end

						local lines = vim.fn.readfile(path)
						local capturing = false
						local todos = {}

						for _, line in ipairs(lines) do
							if line:match("^##%s*Tomorrow") then
								capturing = true
							elseif line:match("^##%s") then
								capturing = false
							elseif capturing then
								-- only pull unfinished checkboxes, skip already-checked ones
								if line:match("^%s*%-%s*%[%s?%]") then
									table.insert(todos, line)
								end
							end
						end

						if #todos == 0 then
							return "_(nothing carried over)_"
						end
						return table.concat(todos, "\n")
					end,
				},
			},
			attachments = {
				folder = "98 Attachments",
				img_text_func = function(path)
					local name = vim.fs.basename(tostring(path))
					local encoded_name = require("obsidian.util").urlencode(name)
					return string.format("![%s](%s)", name, encoded_name)
				end,
			},
			daily_notes = {
				folder = "10 Daily",
				date_format = "%Y-%m-%d",
				template = "Daily Note Template.md",
				default_tags = {},
			},
			note = {
				template = "Note Template.md",
			},
		})
	end,
}
