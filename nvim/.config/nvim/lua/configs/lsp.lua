vim.lsp.config("svelte", require("configs.lsp.svelte"))

vim.lsp.enable("prolog")

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
})

vim.filetype.add({
	extension = {
		pl = "prolog",
	},
})
