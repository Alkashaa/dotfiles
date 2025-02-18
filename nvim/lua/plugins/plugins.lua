return {
  -- Импорт конфигов из файлов 
  { import = "plugins.dashboard" },
  { import = "plugins.which_key" },

  -- Цветовые схемы, рейтинг: ** ***
  -- rose-pine-moon св **
  { 
    "rose-pine/neovim",
    lazy = false -- Загружаем сразу, без ленивой загрузки 
  }, 
  -- github-light св ***
  -- github-dark темн ***
  {
      "projekt0n/github-nvim-theme",
      lazy = false,
      priority = 1000,
      config = function()
          local status_ok, theme = pcall(require, "github-theme")
          if not status_ok then
              print("Failed to load github-theme")
              return
          end
          theme.setup({
              -- Ваши настройки, если нужно
          vim.cmd.colorscheme("github_dark")
          })
  end,
  },

  { "preservim/nerdtree" }, -- Файловый менеджер NERDTree
  { "ryanoasis/vim-devicons" }, -- Иконки для NERDTree
  { "tpope/vim-fugitive" }, -- Поддержка Git
  { "airblade/vim-gitgutter" }, -- Подсветка изменений Git
  { "vim-airline/vim-airline" }, -- Красивый статус-бар
  { "neoclide/coc.nvim", branch = "release" }, -- Современный автодополнитель
  { "aveplen/ruscmd.nvim" }, -- Русская раскладка
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Дерево синтаксиса
  { "numToStr/Comment.nvim", config = true }, -- Авто-комментарии
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  { "mrjones2014/legendary.nvim" }, -- Поиск команд и маппингов
  -- Устанавливаем fzf
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },

  -- Плагин для интеграции fzf в vim
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },  -- Убедись, что fzf установлен
    config = function()
      -- Дополнительная конфигурация, если нужно
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
  "akinsho/bufferline.nvim", -- Вкладки буферов в стиле IDE
  dependencies = "nvim-tree/nvim-web-devicons"
  },
  -- улучшает подсветку и добавляет удобные команды для работы с CSV
  {
    "chrisbra/csv.vim",
    ft = "csv"
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json" },
        exclude_dirs = { "C:\\Windows\\", "C:\\Program Files\\" }
      }
      require("telescope").load_extension("projects")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
}
