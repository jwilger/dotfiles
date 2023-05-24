vim.g.mapleader = " " -- easy to reach leader key

vim.keymap.set("n", "-", vim.cmd.Ex, { desc = "Load directory listing" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save current file" })
vim.keymap.set("n", "<leader>c", ":q<cr>", { desc = "Close current window" })

vim.keymap.set("n", "<leader>v", ":vsplit<cr>", { desc = "new vertical split window" })
vim.keymap.set("n", "<leader>h", ":split<cr>", { desc = "new horizontal split window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "jump to window to the right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "jump to window to the left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "jump to window below" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "easier than reaching for the Escape key" })
