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

  -- key bindings for nvim-cmp in nvim/lua/plugins/nvim-cmp.lua

  -- Telescope
  { "<leader><space>", ":Telescope oldfiles<cr>", desc="find recent file", mode = "n" },
  { "<leader>f", group = "Telescope", icon="󰭎" }, -- group
  { "<leader>ff", ":Telescope find_files<cr>", desc="find file (cwd)", mode="n", icon="󰈞"},
  { "<leader>fg", ":Telescope live_grep<cr>", desc="grep in files", mode="n", icon="" },
  { "<leader>fh", ":Telescope help_tags<cr>", desc="open help tags", mode="n", icon="󰡯" },
  { "<leader>ft", ":TodoTelescope<cr>", desc="open todo list", mode="n", icon="󰨻" },

  -- explorer (nvimTree)
  { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (root)", mode="n", icon=" " },
  { "<leader>N", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n", icon=" " },

  -- lazyGit
  { "<leader>g", function() require("lazygit").lazygit() end, desc="open git", mode="n" },

  -- cursor
  { "<leader>c", group = "cursor", icon="󰆿" },
  { "<leader>ce", vim.lsp.buf.hover, desc="explain in hover", mode="n" },
  { "<leader>cd", vim.lsp.buf.defition, desc="goto definition", mode="n" },
  { "<leader>ca", vim.lsp.buf.code_action, desc="code action", mode="n" },


  -- { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" }, -- TODO
  -- { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" }, -- TODO
  -- { "<leader>n", ":NvimTreeToggle<cr>", desc="open explorer (cwd)", mode="n" },
})
