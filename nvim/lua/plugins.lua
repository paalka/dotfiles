local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
  return string.format('require("setup/%s")', name)
end

return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use {
      'andersevenrud/nordic.nvim',
      config = get_config("nordic")
    }

    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      requires = {
        { "nvim-lua/plenary.nvim" },
        {
          "nvim-telescope/telescope-smart-history.nvim",
          requires = "kkharji/sqlite.lua"
        },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "cljoly/telescope-repo.nvim", requires = "airblade/vim-rooter" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
      config = get_config("telescope"),
    })

    use 'RRethy/vim-illuminate'
    use {
      'rmagatti/auto-session',
      config = get_config("auto-session")
    }

    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        require('hop').setup()
      end
    }

    use {
      'rmagatti/session-lens',
      requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
      config = get_config("session-lens")
    }

    use 'ms-jpq/chadtree'

    use {
      'glepnir/dashboard-nvim',
      config = get_config("dashboard")
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = get_config("lualine"),
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = get_config("treesitter"),
        run = function()
          require('nvim-treesitter.install').update({ with_sync = true })
        end,
    }

    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }

    use {
      {
        'mfussenegger/nvim-dap',
        config = get_config("dap"),
        module = 'dap',
      },
      {
        'rcarriga/nvim-dap-ui',
        requires = 'nvim-dap',
        after = 'nvim-dap',
        config = function()
          require('dapui').setup()
        end,
      },
    }

    -- use({
    --   "hrsh7th/nvim-cmp",
    --   requires = {
    --     { "hrsh7th/cmp-nvim-lsp" },
    --     { "hrsh7th/cmp-nvim-lua" },
    --     { "hrsh7th/cmp-buffer" },
    --     { "hrsh7th/cmp-path" },
    --     { "hrsh7th/cmp-cmdline" },
    --     { "hrsh7th/vim-vsnip" },
    --     { "hrsh7th/cmp-vsnip" },
    --     { "hrsh7th/vim-vsnip-integ" },
    --     { "hrsh7th/cmp-calc" },
    --     { "rafamadriz/friendly-snippets" },
    --   },
    --   config = get_config("cmp"),
    -- })

    use({'ms-jpq/coq_nvim',
      requires = { 'ms-jpq/coq.thirdparty', opt = true },
      config = get_config("coq"),
    })

    use "github/copilot.vim"

    use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })
    
    use {
      'neovim/nvim-lspconfig',
      config = get_config("lsp"),
      requires = "ray-x/lsp_signature.nvim",
      after = "coq_nvim"
    }
  end
})

