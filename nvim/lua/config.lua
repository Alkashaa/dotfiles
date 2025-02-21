 --  ______     _ _                  __   
 -- |  ____|   | (_)                 \ \  
 -- | |__   ___| |_ _ __  ___  ___  (_) | 
 -- |  __| / __| | | '_ \/ __|/ _ \   | | 
 -- | |___| (__| | | |_) \__ \  __/  _| | 
 -- |______\___|_|_| .__/|___/\___| (_) | 
 --                | |               /_/  
 --                |_|                    

-- База (лидер)
vim.keymap.set("", "<Space>", "<Nop>") -- отключаем пробел
vim.g.mapleader = " "
-- vim.api.nvim_set_keymap("n", ",", "<leader>", { noremap = true, silent = true }) -- отключаем пробел

-- Установка Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Подключение конфигурации плагинов
require("lazy").setup("plugins.plugins") 

-- ╭───────────────────────────────────────────────╮
-- │ Основные настройки              
-- ╰───────────────────────────────────────────────╯

vim.o.belloff = 'all'

vim.o.compatible = false              -- Отключаем совместимость с vi
vim.o.encoding = 'utf-8'              -- Кодировка UTF-8
vim.o.fileencoding = 'utf-8'          -- Кодировка файлов UTF-8
vim.wo.number = true                  -- Показывать номера строк
vim.wo.relativenumber = true          -- Относительные номера строк
vim.o.cursorline = true               -- Подсветка текущей строки
vim.o.mouse = 'a'                     -- Включить поддержку мыши
-- vim.o.clipboard = 'unnamedplus'       -- Общий буфер обмена с системой
vim.o.expandtab = true                -- Использовать пробелы вместо табуляции
vim.o.autoindent = true               -- Автоматическое выравнивание
vim.o.smartindent = true              -- Умное выравнивание

vim.o.paste = false                   -- Убирает лишние автоформатирования при вставке


-- Цветовая схема
vim.cmd('syntax on')               -- Включить подсветку синтаксиса
vim.o.termguicolors = true            -- Поддержка 24-битных цветов
vim.o.background = 'dark'             -- Темная тема

-- Поиск
vim.o.ignorecase = true               -- Игнорировать регистр при поиске
vim.o.smartcase = true                -- Учитывать регистр, если есть заглавные буквы
vim.o.hlsearch = true                 -- Подсветка найденного текста
vim.o.incsearch = true                -- Инкрементальный поиск

-- История между сессиями
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("$LOCALAPPDATA") .. "\\nvim-data\\undo"
  
-- Always use very magic mode for searching
vim.keymap.set("n", "/", "/\\v", { noremap = true })

-- ╭───────────────────────────────────────────────╮
-- │  Костыли 
-- ╰───────────────────────────────────────────────╯

-- При открытии CSV-файлов wrap будет включаться автоматически. 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.wo.wrap = true        -- Включаем перенос строк
    vim.wo.linebreak = true   -- Переносим строки по словам
  end,
})

-- После загрузки плагинов перезаписать маппинг (ruscmd) для . 
vim.cmd([[
  augroup SetMappingsAfterPlugins
    autocmd!
    autocmd VimEnter * lua vim.defer_fn(function() vim.api.nvim_set_keymap('n', '.', '.', { noremap = true, silent = true }) end, 100)
  augroup END
]])

-- Удаляем привязку для клавиши "й", плагин Ruscmd
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackerCompileDone',
  callback = function()
    vim.api.nvim_del_keymap('n', 'й')
  end
})

-- ╭───────────────────────────────────────────────╮
-- │ Сочетания клавиш 
-- ╰───────────────────────────────────────────────╯

-- Сочетания клавиш
vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true, silent = true })

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
vim.api.nvim_set_keymap("n", "c", '"_c', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "C", '"_C', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "cc", '"_cc', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "c", '"_c', { noremap = true, silent = true })

-- Сохранение (Ctrl+S)
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-ы>', ':w<CR>', { noremap = true, silent = true }) -- русская "ы" вместо "s"
vim.api.nvim_set_keymap('i', '<C-ы>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-ы>', '<Esc>:w<CR>', { noremap = true, silent = true })

-- Откат назад (Ctrl+Z)
vim.api.nvim_set_keymap('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-z>', 'u', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-я>', 'u', { noremap = true, silent = true }) -- русская "я" вместо "z"
vim.api.nvim_set_keymap('i', '<C-я>', '<C-o>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-я>', 'u', { noremap = true, silent = true })

-- Откат вперед (Ctrl+Shift+Z)
vim.api.nvim_set_keymap('n', '<C-S-z>', '<C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-z>', '<C-o><C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-z>', '<C-r>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-S-я>', '<C-r>', { noremap = true, silent = true }) -- русская "Я"
vim.api.nvim_set_keymap('i', '<C-S-я>', '<C-o><C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-я>', '<C-r>', { noremap = true, silent = true })

-- Копирование (Ctrl+C)
vim.api.nvim_set_keymap('n', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-с>', '"+y', { noremap = true }) -- русская "в"
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-с>', '"+y', { noremap = true })

-- Вставка (Ctrl+V)
vim.api.nvim_set_keymap('n', '<C-v>', ':set paste<CR>"+p:set nopaste<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-м>', ':set paste<CR>"+p:set nopaste<CR>', { noremap = true }) -- русская "м"
vim.api.nvim_set_keymap('v', '<C-v>', ':set paste<CR>"+p:set nopaste<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-м>', ':set paste<CR>"+p:set nopaste<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>:set paste<CR>"+p:set nopaste<CR>a', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-м>', '<Esc>:set paste<CR>"+p:set nopaste<CR>a', { noremap = true }) -- русская "м"
-- Вставка через Ctrl+V в командной строке (:)
vim.api.nvim_set_keymap('c', '<C-v>', '<C-r>+', { noremap = true})
vim.api.nvim_set_keymap('c', '<C-м>', '<C-r>+', { noremap = true})

-- Удобная навигация
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true }) -- Перемещение между окнами влево
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true }) -- Перемещение между окнами вправо
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true }) -- Перемещение между окнами вниз
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true }) -- Перемещение между окнами вверх

-- Бинд рамки/таблички
function InsertBox()
  local lines = {
    "╭───────────────────────────────────────────────╮",
    "│                                               │",
    "╰───────────────────────────────────────────────╯"
  }
  vim.api.nvim_put(lines, "c", true, true)
end
vim.api.nvim_set_keymap('n', '<Leader>1', ':lua InsertBox()<CR>', { noremap = true, silent = true })

-- 🔹 Переключение между вкладками
vim.keymap.set("n", "<S-j>", ":tabnext<CR>", { noremap = true, silent = true })  -- Следующая вкладка (Shift + J)
vim.keymap.set("n", "<S-k>", ":tabprev<CR>", { noremap = true, silent = true })  -- Предыдущая вкладка (Shift + K)
vim.keymap.set("n", "<S-о>", ":tabnext<CR>", { noremap = true, silent = true })  -- Следующая вкладка (Shift + J)
vim.keymap.set("n", "<S-л>", ":tabprev<CR>", { noremap = true, silent = true })  -- Предыдущая вкладка (Shift + K)

-- Между буферами
vim.keymap.set("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":bprevious<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-S-о>", ":bnext<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-S-л>", ":bprevious<CR>", { noremap = true, silent = true })

-- 🔹 Управление вкладками
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true }) -- Закрыть текущую вкладку (Ctrl + W)
vim.keymap.set("n", "<C-ц>", ":tabclose<CR>", { noremap = true, silent = true }) -- Закрыть текущую вкладку (Ctrl + W)
-- vim.keymap.set("n", "<C-t>", ":tabnew<CR>", { noremap = true, silent = true })   -- Открыть новую вкладку (Ctrl + T)
-- vim.keymap.set("n", "<C-е>", ":tabnew<CR>", { noremap = true, silent = true })   -- Открыть новую вкладку (Ctrl + T)

-- 🔹 Теперь Y ведет себя как J (слияние строк)
vim.keymap.set("n", "Y", "J", { noremap = true, silent = true })

-- 🔹 Открытие файла с подсказками по <leader>h
vim.keymap.set("n", "<leader>h", ":tabnew $HOMEPATH/AppData/Local/nvim/README/notes.md<CR>", { noremap = true, silent = true })


-- ╭───────────────────────────────────────────────╮
-- │ Настройки плагинов              
-- ╰───────────────────────────────────────────────╯

-- Телескоп
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fc', ':Telescope commands<CR>', { noremap = true, silent = true })


-- CoC.nvim (автодополнение)
vim.g.coc_global_extensions = {
  'coc-pyright',  -- Для Python
  'coc-tsserver', -- Для JavaScript и TypeScript
  'coc-html',     -- Для HTML
  'coc-css',      -- Для CSS
  'coc-json'      -- Для JSON
}
-- Настройка привязок для автодополнения с использованием <Tab> и <S-Tab>
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true, noremap = true })

-- NERDTree
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- ruscmd русская раскладка
require('ruscmd').setup{
  -- Включает сокращения для команд (например, ':й' для ':q')
  abbreviations = false,

  -- Включает перевод клавиш в NORMAL-режиме (например, 'ц' для 'w')
  keymaps = true,
}

-- FZF
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { noremap = true, silent = true })
-- Цвет

vim.env.FZF_DEFAULT_OPTS = '--color=fg:#8CC9F2,bg:#14161b,hl:#76F2A1,fg+:#FFFFFF,bg+:#4C5C75,hl+:#80B8F7,info:#C7E7FF,border:#5C7F99,prompt:#FFCC00,pointer:#9CD9FF'

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g.airline_extensions = { 'tabline' }

-- Увеличение шрифта в Neovide в реальном времени
vim.g.neovide_scale_factor = 0.7

local function change_scale_factor(delta)
    local current_value = vim.g.neovide_scale_factor or 1.0 -- начальное значение, если не определено
    local new_value = current_value + delta
    new_value = math.max(0.1, math.min(2.0, new_value)) -- ограничение диапазона
    vim.g.neovide_scale_factor = new_value
    vim.o.guifont = vim.o.guifont -- триггер обновления шрифта
    print("New scale factor: " .. vim.g.neovide_scale_factor)
end
-- Новые привязки для теста, чтобы избежать конфликтов
vim.keymap.set("n", "<C-->", function() change_scale_factor(0.1) end)
vim.keymap.set("n", "<C-=>", function() change_scale_factor(-0.1) end)

-- Улучшенная подсветка синтаксиса
require'nvim-treesitter.configs'.setup {
      ensure_installed = { "python", "csv", "lua", "html", "css", "javascript", "java", "markdown", "markdown_inline" },
        highlight = { enable = true },  -- Включает подсветку синтаксиса
          -- indent = { enable = true },      -- Улучшает авто-отступы
        disable = {},   -- Не отключать подсветку для других языков
      }

require('Comment').setup()
-- Настройка горячих клавиш для комментариев
vim.api.nvim_set_keymap('n', '<C-/>', 'gcc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<C-.>', 'gcc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<C-/>', 'gc', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<C-.>', 'gc', { noremap = false, silent = true })

-- Переключение состояния spell с Leader + s и использование обоих языков
vim.api.nvim_set_keymap('n', '<Leader>s', ':set spell! spelllang=en_us,ru_ru<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ы', ':set spell! spelllang=en_us,ru_ru<CR>', { noremap = true, silent = true })

-- Перемещение по визуальным строкам
vim.keymap.set("n", "<leader>j", "gj", {noremap = true, silent = ture})
vim.keymap.set("n", "<leader>k", "gk", {noremap = true, silent = ture})
vim.keymap.set("n", "<leader>о", "gj", {noremap = true, silent = ture})
vim.keymap.set("n", "<leader>л", "gk", {noremap = true, silent = ture})

