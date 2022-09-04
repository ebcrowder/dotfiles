-- Adapted from https://github.com/nvim-lua/kickstart.nvim
-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("tpope/vim-surround")
  use("tpope/vim-vinegar")
  use("tpope/vim-repeat")
  use("arcticicestudio/nord-vim")
  use("kyazdani42/nvim-web-devicons")
  use("nvim-lualine/lualine.nvim")
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/null-ls.nvim")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
end)

--Integrate with system clipboard
vim.o.clipboard = "unnamedplus"

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.o.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true
vim.g.nord_uniform_diff_background = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.cmd([[colorscheme nord]])

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

--Remap space as leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- diagnostics setup
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lualine setup
require("lualine").setup({
  options = {
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
})

-- autopairs and autotag
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})

-- Gitsigns
require("gitsigns").setup({})

-- Telescope
require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- Telescope keymaps
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>b", require("telescope.builtin").current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>h", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>t", require("telescope.builtin").tags)
vim.keymap.set("n", "<leader>d", require("telescope.builtin").diagnostics)
vim.keymap.set("n", "<leader>g", require("telescope.builtin").live_grep)
vim.keymap.set('n', '<leader>?', require("telescope.builtin").oldfiles)

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings
vim.diagnostic.config({
  virtual_text = {
    source = "always",
  },
  float = {
    source = "always",
  },
})
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' })
end

-- for tsserver projects, null-ls handles prettier and eslint
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
      condition = function(utils)
        return utils.root_has_file({ "package.json" })
      end,
    }),
    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      condition = function(utils)
        return utils.root_has_file({ "package.json" })
      end,
    }),
  },
})

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { "tsserver", "pyright", "gopls", "rust_analyzer", "phpactor" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- lua language server setup
require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = { enable = false, },
    },
  },
}

-- luasnip setup
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})
-- vim: ts=2 sts=2 sw=2 et
