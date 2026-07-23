-- vim.lsp.config("svelte", require("configs.lsp.svelte"))

vim.lsp.enable("svelte")

vim.lsp.config("eslint", {
	settings = {
		run = "onSave",
	},
})

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
})
