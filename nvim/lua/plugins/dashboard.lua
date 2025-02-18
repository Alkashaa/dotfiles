--- Путь к настройкам
main_dir = "C:/Users/eclipse/AppData/Local/nvim/"
-- Определяем операционку
uname = vim.loop.os_uname().sysname

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",

  config = function()

    -- Хоткей для открытия дашборда в новой вкладке
    vim.api.nvim_set_keymap("n", "<C-t>", ":tabnew | :Dashboard <CR>", { noremap = true, silent = true })

    -- Функция для создания нового файла с вводом имени
    local function NewFilePrompt()
      local filename = vim.fn.input("📄 Enter new file name: ")
      if filename and filename ~= "" then
        vim.cmd("edit " .. filename)
      end
    end

    require("dashboard").setup({
      theme = "hyper",

      config = {
        -- Отображение списка проектов, только для Linux и MacOS
        project = (uname == 'Linux' or uname == 'Darwin') and {
          icon = ' ',
        } or {
          -- не отображать проекты для Windows (они тут не работают)
          enable = false, 
          icon = 'your icon', 
          label = ''
        },

        -- Основные настройки
        week_header = {
          enable = true,
        },
        hide = {
          statusline = false,       -- hide statusline default is true
          tabline = false,      -- hide the tabline
          winbar = false,          -- hide winbar
        },
        shortcut = {
          {
            desc = "📄 New file",
            group = "@property",
            action = NewFilePrompt, -- Передаём функцию без ":lua" и "<CR>"
            key = "n",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            icon = "󰺯 ",
            icon_hl = "@nf-md-text_box_search_outline",
            desc = "Word",
            group = "@y",
            action = "Telescope live_grep",
            key = "g",
          },
          {
            desc = "⚙️ Settings",
            group = "Number",
						action = ":Telescope find_files cwd=" .. main_dir,
            key = "c",
          },
        },
      },
    })
  end,
}
