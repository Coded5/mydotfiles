vim.lsp.config("svelte", require("configs.lsp.svelte"))
vim.lsp.config("eslint", {
	settings = {
		run = "onSave",
	},
})

vim.lsp.enable("prolog")

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
})
