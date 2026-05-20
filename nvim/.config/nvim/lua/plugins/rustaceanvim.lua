return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension/")
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local cfg = require("rustaceanvim.config")

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.g.rustaceanvim = {
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
				server = {
					capabilities = capabilities,
				},
			}
		end,
	},
}
