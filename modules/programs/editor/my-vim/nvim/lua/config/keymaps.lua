vim.g.mapLeader = ' '
vim.g.maplocalleader = ' '

-- defaults
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- nvim-tree
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- which-key
-- for icons see https://www.nerdfonts.com/cheat-sheet
--            or :NvimWebDeviconsHiTest

local wk = require("which-key")
wk.add({
  -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },    -- execute function
  -- { "<leader>f1", hidden = true },                                     -- hide this keymap

  -- Telescope
  { "<leader><space>", ":Telescope oldfiles<cr>", desc="find old files", mode = "n" },
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", ":Telescope find_files<cr>", desc="find file", mode="n", icon="󰙨"},
  { "<leader>fg", ":Telescope live_grep<cr>", desc="live grep", mode="n" },
  { "<leader>fh", ":Telescope help_tags<cr>", desc="help tags", mode="n" },

  -- file tree (nvimTree)
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open file tree", mode="n" },

  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  }
})
