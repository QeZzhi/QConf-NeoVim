-- ============================================
-- ГЛАВНЫЙ КОНФИГ NEovim
-- ============================================

-- 1. УСТАНОВКА LAZY.NVIM (менеджер плагинов)
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. НАСТРОЙКА ОТОБРАЖЕНИЯ
-- ============================================
vim.opt.number = true           -- Показывать номер текущей строки
vim.opt.relativenumber = true   -- Показывать относительные номера
vim.opt.tabstop = 4             -- Размер табуляции в пробелах
vim.opt.shiftwidth = 4          -- Размер отступа
vim.opt.expandtab = true        -- Превращать табы в пробелы
vim.opt.mouse = 'a'             -- Включить поддержку мыши
vim.opt.ignorecase = true       -- Поиск без учёта регистра
vim.opt.smartcase = true        -- Умный поиск (если есть заглавные, искать с учётом)
vim.opt.wrap = false            -- Не переносить строки
vim.opt.termguicolors = true    -- Включить 24-битные цвета

-- 3. ГОРЯЧИЕ КЛАВИШИ
-- ============================================
-- Быстрый выход из режима вставки (нажми jj)
vim.keymap.set('i', 'jj', '<Esc>')

-- Переключение относительных номеров строк (пробел + r)
vim.keymap.set('n', '<leader>r', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  vim.opt.number = not vim.opt.number:get()
end, { desc = "Toggle relative numbers" })

-- 4. ЗАГРУЗКА ПЛАГИНОВ
-- ============================================
require("lazy").setup("plugins")

-- 5. ГОРЯЧИЕ КЛАВИШИ ДЛЯ C++ (будут работать после установки LSP)
-- ============================================
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})         -- Перейти к определению
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})     -- Перейти к реализации
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})         -- Найти все использования
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})     -- Переименовать
vim.keymap.set('n', '<leader>f', function()                   -- Отформатировать код
  vim.lsp.buf.format({ async = true })
end, {})

-- Настройки командной строки (как в GenesisNvim)
vim.opt.wildmode = "list:longest,full"   -- Показывать список команд
vim.opt.wildoptions = "pum"              -- Показывать подсказки в виде вертикального меню
vim.opt.wildignorecase = true            -- Поиск команд без учёта регистра
vim.g.loaded_matchparen = 1

-- Подсветка парных скобок
vim.api.nvim_set_hl(0, "MatchParen", {
  fg = "#ffffff",
  bg = "#8000ff",
  bold = true,
})
