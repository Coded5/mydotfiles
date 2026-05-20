return {
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		enabled = false,
		opts = {
			transparent_background = true,
			gamma = 1.00,
		},
		config = function(_, opts)
			require("tokyodark").setup(opts)
			vim.cmd.colorscheme("tokyodark")
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("moonfly").custom_colors({
				grey11 = "#474747",
			})
			vim.g.moonflyTransparent = true
			vim.g.moonflyVirtualTextColor = true
			vim.cmd.colorscheme("moonfly")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = true,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				flavour = "macchiato",
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		enabled = false,
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		enabled = false,
		config = function()
			require("themery").setup({
				-- add the config here
			})
		end,
	},
}
