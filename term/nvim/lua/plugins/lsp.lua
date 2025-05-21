return {
  { 'neovim/nvim-lspconfig', },
  { "mason-org/mason.nvim",  opts = {} },
  --{
  --'saghen/blink.cmp',
  --dependencies = { 'rafamadriz/friendly-snippets' },
  --version = '1.*',
  --opts = {
  --sources = {
  --default = { 'lsp', 'path', 'snippets', 'buffer' },
  --},
  --opts_extend = { "sources.default" }
  --}
  --},
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
      --'saghen/blink.cmp'
      { 'hrsh7th/nvim-cmp' },
    },
    opts = {
      servers = {
        rust_analyzer = {
          cargo = { features = "all" },
          procMacro = { enable = true },
          inlayHints = {
            bindingModeHints = { enable = true },
            closureCaptureHints = { enable = true },
            closureReturnTypeHints = { enable = true },
            expressionAdjustmentHints = { enable = true }
          },
          diagnostics = { enable = true },
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
      local lspconfig = require('lspconfig')
      local on_attach = function(client, bufnr)
        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

        --require("lsp-inlayhints").on_attach(client, bufnr)
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { 0 })
        end
      end

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )
      for server, config in pairs(opts.servers) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end
    end
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
