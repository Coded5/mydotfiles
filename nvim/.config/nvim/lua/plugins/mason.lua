return {
	{
		"neovim/nvim-lspconfig",
		priority = 1000,
		lazy = false,
	},
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"jdtls",
				"eslint",
				"ts_ls",
				"html",
				"cssls",
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}
