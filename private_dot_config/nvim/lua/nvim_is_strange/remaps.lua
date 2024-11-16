-- telescope --

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope find git' })

-- lsp --
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })

-- other --
vim.keymap.set('n', '<space>', '<Nop>')
