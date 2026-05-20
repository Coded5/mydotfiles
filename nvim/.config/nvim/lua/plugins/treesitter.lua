return {
	{
		"neovim-treesitter/nvim-treesitter",
		dependencies = { "nvim-lua/plenary.nvim", "neovim-treesitter/treesitter-parser-registry" },
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
		end,
	},
}
