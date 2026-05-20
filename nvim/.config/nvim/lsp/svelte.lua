return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" or vim.uv.fs_stat(fname) == nil then
			return
		end

		-- 1. Look for the CLOSEST package.json to the file being edited
		local closest_pkg = vim.fs.find("package.json", {
			upward = true,
			path = vim.fs.dirname(fname),
			stop = vim.uv.os_homedir(), -- Don't search beyond home
		})[1]

		-- 2. If we found one, get its directory
		local project_root = closest_pkg and vim.fs.dirname(closest_pkg) or vim.fn.getcwd()

		-- 3. Log it to the command area (only for debugging, remove once it works)
		-- print("LSP Root Detected: " .. project_root)

		on_dir(project_root)
	end,
	on_attach = function(client, bufnr)
		-- Workaround to trigger reloading JS/TS files
		-- See https://github.com/sveltejs/language-tools/issues/2008
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			group = vim.api.nvim_create_augroup("lspconfig.svelte", {}),
			callback = function(ctx)
				-- internal API to sync changes that have not yet been saved to the file system
				---@diagnostic disable-next-line: param-type-mismatch
				client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})
		vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
			client:exec_cmd({
				title = "Migrate Component to Svelte 5 Syntax",
				command = "migrate_to_svelte_5",
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, { desc = "Migrate Component to Svelte 5 Syntax" })
	end,
}
