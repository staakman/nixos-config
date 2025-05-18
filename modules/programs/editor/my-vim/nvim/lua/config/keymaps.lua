vim.g.mapLeader = ' '
vim.g.maplocalleader = ' '

-- defaults
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- which-key
-- for icons see https://www.nerdfonts.com/cheat-sheet
--            or :NvimWebDeviconsHiTest

local wk = require("which-key")
wk.add({
  -- { "<leader>fb", function() print("hello") end, desc = "Foobar" },    -- execute function
  -- { "<leader>f1", hidden = true },                                     -- hide this keymap

  -- Telescope
  { "<leader><space>", ":Telescope oldfiles<cr>", desc="find recent file", mode = "n" },
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", ":Telescope find_files<cr>", desc="find file (cwd)", mode="n", icon="󰙨"},
  { "<leader>fg", ":Telescope live_grep<cr>", desc="grep in files", mode="n" },
  { "<leader>fh", ":Telescope help_tags<cr>", desc="open help tags", mode="n" },

  -- explorer (nvimTree)
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (root)", mode="n" },
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" }, -- TODO

  -- lazyGit
  { "<leader>lg", function() require("lazygit").lazygit() end, desc="open git", mode="n" },

  -- TODO
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" }, -- TODO
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" }, -- TODO
})
