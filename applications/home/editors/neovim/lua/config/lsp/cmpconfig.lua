local M = {}
local icons = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = "ﮜ ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
}

local function generate_config(cmp)
    local snippy = require('snippy')

    local config = {
        enabled = function()
            local context = require("cmp.config.context")
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment") and
                    not context.in_syntax_group("Comment")
            end
        end,
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Up>'] = cmp.mapping.select_prev_item(),
            ['<Down>'] = cmp.mapping.select_next_item(),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                else
                    fallback()
                end
            end),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snippy.can_jump(-1) then
                    snippy.jump(-1)
                else
                    fallback()
                end
            end)
        }),
        sources = {
            { name = 'snippy' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'nvim_lua' },
            { name = 'crates' }
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = require('lspkind').cmp_format({
                    mode       = "text_symbol",
                    maxwidth   = 50,
                    symbol_map = icons
                })(entry, vim_item)

                local strings = vim.split(kind.kind, " ", { triempty = true })

                kind.kind = " + [ " .. strings[2] .. " " .. strings[1] .. " ] "
                kind.menu = ({
                    nvim_lsp = "[ LSP ]",
                    snippy   = "[ SNIPPY ]",
                    buffer   = "[ BUFFER ]",
                    path     = "[ PATH ]",
                    nvim_lua = "[ VIM ]",
                    crates   = "[ CRATES ]",
                    cmdline  = "[ CMD ]"
                })[entry.source.name] .. " "

                return kind
            end,
        },
    }

    config.snippet = {
        expand = function(args) snippy.expand_snippet(args.body) end
    }

    return config
end

local function event_setup(cmp)
    local ok, pair = pcall(require, 'nvim-autopairs.completion.cmp')

    if not ok then
        return nil
    end

    cmp.event:on(
        'confirm_done',
        pair.on_confirm_done()
    )
end

function M.setup()
    local cmp = require('cmp')

    event_setup(cmp)
    cmp.setup(generate_config(cmp))

    -- cmp.setup.cmdline(':', {
    --     mapping = cmp.mapping.preset.cmdline(),
    --     sources = cmp.config.sources({ { name = 'path' } }, { {
    --         name = 'cmdline',
    --         option = {
    --             ignore_cmds = { 'Man', '!' }
    --         }
    --     } })
    -- })

    cmp.setup.cmdline('?', {
        enabled = true,
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
    })

    cmp.setup.cmdline('/', {
        enabled = true,
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
    })

    cmp.setup.cmdline(':', {
        enabled = true,
        complete = { autocomplete = true },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            { { name = 'path' } },
            { { name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            } }
        )
    })

    return true
end

return M
