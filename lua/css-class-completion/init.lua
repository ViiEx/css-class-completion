local M = {}

M.config = {
	filetypes = { "html", "javascript", "typescript", "jsx", "tsx", "hbs", "css", "scss", "sass", "less" },
	css_file_patterns = { "**/*.css", "**/*.scss" },
}

-- Configuration override
function M.setup(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

	require("cmp").register_source("css_classes", M.source)
end

M.source = {}

function M.source:is_available()
	local filetype = vim.bo.filetype
	return vim.tbl_contains(M.config.filetypes, filetype)
end

function M.source:get_debug_name()
	return "css_classes"
end

function M.source:complete(params, callback)
	local items = {}
	local class_names = M.get_css_class_names()

	for _, class_name in ipairs(class_names) do
		table.insert(items, {
			label = class_name,
			kind = require("cmp.types").lsp.CompletionItemKind.Class,
		})
	end

	callback({ items = items })
end

-- Function to extract class names from CSS and SCSS files
function M.get_css_class_names()
	local class_names = {}
	local patterns = M.config.css_file_patterns
	local cwd = vim.loop.cwd()

	for _, pattern in ipairs(patterns) do
		local files = vim.fn.globpath(cwd, pattern, true, true)
		for _, file in ipairs(files) do
			local lines = vim.fn.readfile(file)
			for _, line in ipairs(lines) do
				for class_name in line:gmatch("%.([%w_-]+)") do
					class_names[class_name] = true
				end
			end
		end
	end

	-- Convert the class_names table to a list
	local result = {}
	for class_name, _ in pairs(class_names) do
		table.insert(result, class_name)
	end
	return result
end

return M
