vim.api.nvim_create_user_command("OpenConfig", function()
	vim.fn.chdir(vim.fn.stdpath("config"))
end, {})
