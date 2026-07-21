return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			local nvim_tree = require("nvim-tree")

			nvim_tree.setup({
				view = {
					width = 40,
					side = "right",
					relativenumber = true,
				},
				on_attach = function(bufnr)
					local api = require("nvim-tree.api")

					-- Keep all default nvim-tree mappings.
					-- api.config.mappings.default_on_attach(bufnr)
					api.map.on_attach.default(bufnr)

					local function open_file()
						local node = api.tree.get_node_under_cursor()

						if not node or node.type == "directory" then
							api.node.open.edit()
							return
						end

						local path = node.absolute_path
						local extension = vim.fn.fnamemodify(path, ":e"):lower()

						if extension == "pdf" then
							vim.system({ "zathura", path }, { detach = true })
						else
							api.node.open.edit()
						end
					end

					vim.keymap.set("n", "<CR>", open_file, {
						buffer = bufnr,
						noremap = true,
						silent = true,
						desc = "Open file",
					})
				end,
			})
		end,
	},
}
