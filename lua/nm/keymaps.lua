M = {}
lvim.leader = "space"

local opts = { noremap = true, silent = true }
-- For the description on keymaps, I have a function getOptions(desc) which returns noremap=true, silent=true and desc=desc. Then call: keymap(mode, keymap, command, getOptions("some randome desc")

local keymap = vim.keymap.set

keymap("n", "J", "5j", opts)
keymap("i", "jj", "<esc>", opts)
-- vim.keymap.del("n", "<C-p>", opts)
-- keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
-- lvim.builtin.telescope.defaults.mappings.n["<C-p>"][1] = ":Telescope find_files<cr>"
keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", opts)

lvim.builtin.breadcrumbs.active = true

-- this was the only way I could find to override K to not hover documentation
lvim.lsp.buffer_mappings.normal_mode["K"][1] = "5k"

M.show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end
-- keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
keymap("n", "gh", ":lua require('nm.keymaps').show_documentation()<CR>", opts)

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

keymap("n", "<m-q>", ":call QuickFixToggle()<cr>", opts)

return M
