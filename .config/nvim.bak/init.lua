-- クリップボード共有
vim.opt.clipboard = "unnamedplus"

-- 削除系のコマンドでレジスタが上書きされないようにする
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('x', 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set('n', 's', '"_s', { noremap = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true })
vim.keymap.set('x', 'c', '"_c', { noremap = true })
vim.keymap.set('x', 'C', '"_C', { noremap = true })

-- xをdに置き換え
vim.keymap.set('n', 'x', 'd', { noremap = true })
vim.keymap.set('n', 'xx', 'dd', { noremap = true })
vim.keymap.set('n', 'X', 'D', { noremap = true })
vim.keymap.set('x', 'x', 'd', { noremap = true })

-- IME OFF設定
if vim.fn.executable('im-select') == 1 then
  vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function()
      vim.fn.system('im-select com.apple.keylayout.ABC')
    end
  })
  vim.api.nvim_create_autocmd('CmdlineLeave', {
    pattern = '*',
    callback = function()
      vim.fn.system('im-select com.apple.keylayout.ABC')
    end
  })
end
