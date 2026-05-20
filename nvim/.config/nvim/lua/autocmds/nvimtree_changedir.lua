vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "global",
	callback = function()
		require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
		require("nvim-tree.api").tree.open()
	end,
})
