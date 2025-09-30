local current_buf = vim.api.nvim_get_current_buf()
local ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

if ft and ft == "yaml.docker-compose" then
	vim.lsp.enable("docker_compose_ls")
end
