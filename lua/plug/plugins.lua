return {
  -- Импорт конфигов из файлов 
  { import = "plug.dashboard" },
  { import = "plug.which_key" },

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
    lazy = false, -- Загружаем сразу, без ленивой загрузки
    priority = 1000, -- Убедимся, что схема загружается первой
    config = function()
        require("github-theme").setup()
        vim.cmd("colorscheme github_dark")

    end
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
}
