return {
	{
		"stevearc/conform.nvim",
		enabled = true,
		opts = {
			log_level = vim.log.levels.DEBUG,
			format_on_save = function(bufnr)
				-- Define filetypes to disable
				local ignore_filetypes = { "yaml", "sql", "conf", "pl" }
				if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
					return
				end
				-- Default formatting options
				return {
					timeout_ms = 1500,
					-- lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				html = { "eslint_lsp" },
				css = { "prettier" },
				json = { "prettier" },
				svelte = { "eslint_lsp", "prettier" },
				javascript = { "eslint_lsp", "prettier" },
				typescript = { "eslint_lsp", "prettier" },
			},
		},
	},
}
