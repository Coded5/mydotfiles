return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		opts = {
			defaults = {
				file_ignore_patterns = {
					"venv",
					"__pycache__",
					"%.xlsx",
					"%.jpg",
					"%.JPG",
					"%.jpeg",
					"%.png",
					"%.webp",
					"%.pdf",
					"%.odt",
					"%.ico",
				},
			},
		},
	},
}
