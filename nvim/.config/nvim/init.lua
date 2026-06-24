vim.g.mapleader = " "

require("configs.options")
require("configs.lazy")
require("configs.keymaps")

require("configs.lsp")

require("scripts.clean_jdtls")
require("scripts.cd_config")

require("autocmds.nvimtree_changedir")
require("autocmds.buffer_refresh")

-- Enable Treesitter highlighting for specific languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"svelte",
		"javascript",
		"typescript",
		"lua",
		"python",
		"html",
		"css",
		"javascriptreact",
		"typescriptreact",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
