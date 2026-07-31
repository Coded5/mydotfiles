local map = vim.keymap.set

map("i", "jk", "<esc>")
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- Select line

map("n", "<leader>v", "0vg_", { desc = "Select line" })

-- Clipboard

-- Copy to clipboard (Works with motions: <leader>y + ip)
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })

-- Copy current line to clipboard (The 'YY' equivalent)
map("n", "<leader>Y", '"+Y', { desc = "Copy line to clipboard" })

-- Paste from clipboard
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- "Greatest paste" (Pastes over visual selection without losing current register)
map("x", "<leader>P", '"_dP', { desc = "Paste over selection" })

--Switching between windows

map("n", "<C-k>", "<CMD>wincmd k<CR>")
map("n", "<C-j>", "<CMD>wincmd j<CR>")
map("n", "<C-h>", "<CMD>wincmd h<CR>")
map("n", "<C-l>", "<CMD>wincmd l<CR>")

--Nvim Tree

map("n", "<C-n>", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>e", "<CMD>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })

--Telescope

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

map("n", "<leader>ft", "<CMD>NvimTreeFindFile<CR>", { desc = "Reveal file in NvimTree" })

-- local on_attach = function(_, bufnr)
-- 	map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
-- 	map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
-- 	map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
-- 	map("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
-- 	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
-- 	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
-- 	map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Reference" })

map("n", "<leader>ca", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Obsidian

map("n", "gf", "<cmd>Obsidian follow_link<cr>", { desc = "Enter link" })
map("n", "gF", "<cmd>Obsidian backlinks<cr>", { desc = "Go back" })

map("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Today's daily note" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "Yesterday's daily note" })
map("n", "<leader>oq", "<cmd>Obsidian new_from_template<cr>", { desc = "New note from template" })
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "New note" })

-- Snipe

map("n", "<leader>s", function()
	require("snipe").open_buffer_menu()
end)
