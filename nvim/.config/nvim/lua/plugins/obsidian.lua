return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	ft = "markdown",
	dependencies = {
		"folke/snacks.nvim",
	},
	config = function()
		require("obsidian").setup({
			legacy_commands = false, -- this will be removed in the next major release
			workspaces = {
				{
					name = "Obsidian",
					path = "~/Documents/Obsidian/",
				},
				{
					name = "Storyteller",
					path = "~/Documents/Storyteller/Storyteller",
				},
			},
			attachments = {
				img_text_func = function(path)
					local name = vim.fs.basename(tostring(path))
					local encoded_name = require("obsidian.util").urlencode(name)
					return string.format("![%s](%s)", name, encoded_name)
				end,
			},
		})
	end,
}
