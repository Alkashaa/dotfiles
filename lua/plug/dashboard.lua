--- nvimdev/dashboard-nvim 

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
        week_header = {
          enable = true,
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
            desc = "⚙️ Settings",
            group = "Number",
            action = ":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "/lua<CR>",
            key = "c",
          },
        },
      },
    })
  end,
}

-- vim.keymap.set("n", "<leader>db", function()
--   require("dashboard").setup()
--   vim.cmd("enew") -- Открывает новый пустой буфер (вызовет Dashboard, если он активен)
-- end, { desc = "Reload Dashboard" })

--- Alpha

-- return {
--   "goolord/alpha-nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" }, -- Иконки (не обязательно)
--   config = function()
--     local alpha = require("alpha")
--     local dashboard = require("alpha.themes.dashboard")
--
--     -- Заголовок (ASCII-арт)
-- dashboard.section.header.val = {
--   [[ _   _                 _     _      ]],
--   [[| \ | |               (_)   | |     ]],
--   [[|  \| | ___  _____   ___  __| | ___ ]],
--   [[| . ` |/ _ \/ _ \ \ / / |/ _` |/ _ \]],
--   [[| |\  |  __/ (_) \ V /| | (_| |  __/]],
--   [[|_| \_|\___|\___/ \_/ |_|\__,_|\___|]],
-- }
--
--     -- Кнопки меню
--     dashboard.section.buttons.val = {
--       dashboard.button("e", "📄  New file", ":lua NewFilePrompt()<CR>"),
--       dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
--       dashboard.button("r", "🕒  Recent files", ":Telescope oldfiles<CR>"),
--       dashboard.button("s", "⚙️  Settings", ":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "/lua<CR>"),
--       dashboard.button("q", "❌  Quit", ":qa<CR>"),
--     }
--
--     -- new file с указанием имени
--     function NewFilePrompt()
--       local filename = vim.fn.input("📄 Enter new file name: ")
--       if filename and filename ~= "" then
--         vim.cmd("edit " .. filename)
--       end
--     end
--
--     -- Настройки альфы
--     alpha.setup(dashboard.config)
--   end
-- }
