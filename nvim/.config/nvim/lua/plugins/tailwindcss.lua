return {
    {
        "luckasRanarison/tailwind-tools.nvim",
        enabled = false,
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim", -- optional
        },
        opts = {}                            -- your configuration
    }
}
