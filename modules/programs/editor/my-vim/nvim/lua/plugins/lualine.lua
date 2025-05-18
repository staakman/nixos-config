require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly', -- palenight
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
  }
}
