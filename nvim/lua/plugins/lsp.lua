return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',     config = true },
      { 'hrsh7th/nvim-cmp' },
      { 'vimuser/lsp-inlayhints.nvim', config = true },
      {
        'williamboman/mason-lspconfig.nvim',

        opts = {
          servers = {
            rust_analyzer = {},
            clangd = {},
            bashls = {},
            lua_ls = {
              Lua = {
                format = {
                  enable = true
                }
              }
            },
            jsonls = {},
            pyright = {},
            tsserver = {},
          },
        },
        config = function(_, opts)
          -- keymaps must be set once lsp is running
          local on_attach = function(client, bufnr)
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
            require("lsp-inlayhints").on_attach(client, bufnr)

            vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction', buffer = bufnr })
            vim.keymap.set('n', '<leader>fr', vim.lsp.buf.rename, { desc = '[F]ile rename', buffer = bufnr })


            -- goto
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', buffer = bufnr })
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
              { desc = '[G]oto [D]efinition', buffer = bufnr })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementations, { desc = '[G]oto [I]mplementations', buffer = bufnr })
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definitions,
              { desc = '[G]oto [T]ype definitions', buffer = bufnr })

            -- docs
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', buffer = bufnr })
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation', buffer = bufnr })
          end


          -- setup language servers and cmps

          local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
          )

          local mason_lspconfig = require('mason-lspconfig')
          mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(opts.servers),
          }
          mason_lspconfig.setup_handlers {
            function(server_name)
              require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = opts.servers[server_name],
                filetypes = (opts.servers[server_name] or {}).filetypes,
              }
            end,
          }
        end
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },

    },
    config = function(_, _)
      local cmp = require("cmp")
      local luasnip = require('luasnip');
      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
      }
    end

  },
}
