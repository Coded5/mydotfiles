return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function ()
            require("configs.lualine")
            -- require("lualine").setup(opts)
        end
    }
}
