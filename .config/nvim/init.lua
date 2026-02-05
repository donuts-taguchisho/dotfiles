-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- クリップボード共有
vim.opt.clipboard = "unnamedplus"

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
