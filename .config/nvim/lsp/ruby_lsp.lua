---@diagnostic disable: undefined-global

local function add_ruby_deps_command(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
        local params = vim.lsp.util.make_text_document_params()
        local showAll = opts.args == "all"

        client.request("rubyLsp/workspace/dependencies", params, function(error, result)
            if error then
                print("Error showing deps: " .. error)
                return
            end

            local qf_list = {}
            for _, item in ipairs(result) do
                if showAll or item.dependency then
                    table.insert(qf_list, {
                        text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
                        filename = item.path,
                    })
                end
            end

            vim.fn.setqflist(qf_list)
            vim.cmd("copen")
        end, bufnr)
    end, {
        nargs = "?",
        complete = function()
            return { "all" }
        end,
    })
end

return {
    on_attach = add_ruby_deps_command,
    cmd = { "ruby-lsp" },
    root_markers = { "Gemfile", ".git" },
    filetypes = { "ruby", "eruby" },
    init_options = {
        enabledFeatures = {
            "codeActions",
            "codeLens",
            "completion",
            "definition",
            "diagnostics",
            "documentHighlights",
            "documentLink",
            "documentSymbols",
            "foldingRanges",
            "formatting",
            "hover",
            "inlayHint",
            "onTypeFormatting",
            "selectionRanges",
            "semanticHighlighting",
            "signatureHelp",
            "typeHierarchy",
            "workspaceSymbol",
        },
        formatter = "rubocop",
    },
}
