local bufnr = vim.api.nvim_get_current_buf()

require('configs.keymaps').on_attach(nil, bufnr)

vim.keymap.set(
    "n",
    "<leader>ca",
    function() vim.cmd.RustLsp("codeAction") end,
    { buffer = bufnr, silent = true}
)

vim.keymap.set(
    "n",
    "K",
    function() vim.cmd.RustLsp({"hover", "actions"}) end,
    { buffer = bufnr, silent = true}
)
