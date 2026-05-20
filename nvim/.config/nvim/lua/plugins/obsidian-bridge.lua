return {
	"oflisback/obsidian-bridge.nvim",
	-- enabled = false,
	opts = {
		obsidian_server_address = "http://127.0.0.1:27123",
	},
	-- event = {
	-- 	"BufReadPre *.md",
	-- 	"BufNewFile *.md",
	-- },
	-- lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("obsidian-bridge").setup({
			obsidian_server_address = "http://127.0.0.1:27123",
		})
	end,
}
