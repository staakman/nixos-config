local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {}

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("g", "  Grep text", ":Telescope live_grep<CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = {
  "󰅪 NixOS + Neovim = 💙",
  "🕒 " .. os.date("%A, %d %B %Y"),
}

dashboard.opts.opts.noautocmd = false

alpha.setup(dashboard.opts)
