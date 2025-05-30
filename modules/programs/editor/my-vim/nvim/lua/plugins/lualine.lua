local function current_dir()
  -- local cwd = vim.fn.getcwd()
  -- return vim.fn.fnamemodify(cwd, ':t')  -- Only show the tail (folder name)
  local filepath = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(filepath, ":p:h:t")
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly', -- palenight
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      {current_dir, icon=' ', color = { fg = '#ffffff', gui = 'bold' }, }, 
      'filename'
    },
  }
}
