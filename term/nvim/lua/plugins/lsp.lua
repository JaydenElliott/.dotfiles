return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',      config = true },
      { 'hrsh7th/nvim-cmp' },
      { 'lvimuser/lsp-inlayhints.nvim', config = true },
      {
        'williamboman/mason-lspconfig.nvim',

        opts = {
          servers = {
            rust_analyzer = {
              procMacro = { enable = true },
              inlayHints = {
                bindingModeHints = { enable = true },
                closureCaptureHints = { enable = true },
                closureReturnTypeHints = { enable = true },
                expressionAdjustmentHints = { enable = true }
              },
            },
            wgsl_analyzer = {},
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
            taplo = {},
          },
        },
        config = function(_, opts)
          -- keymaps must be set once lsp is running

          local on_attach = function(client, bufnr)
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
            require("lsp-inlayhints").on_attach(client, bufnr)

            vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = '[G]oto [A]ction', buffer = bufnr })
            vim.keymap.set('n', '<leader>rw', vim.lsp.buf.rename, { desc = '[R]ename [W]ord', buffer = bufnr })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', buffer = bufnr })


            ---- Go to
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', buffer = bufnr })
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
              { desc = '[G]oto [D]efinition', buffer = bufnr })

            vim.keymap.set('n', '<leader>kd', vim.lsp.buf.signature_help,
              { desc = 'Signature Documentation', buffer = bufnr })
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
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp_document_symbol' },
          { { name = 'buffer' } },

        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
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
