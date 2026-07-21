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
					path = "~/Idyll/",
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
