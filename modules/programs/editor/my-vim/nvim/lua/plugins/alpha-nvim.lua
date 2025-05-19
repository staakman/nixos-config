local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
local button = dashboard.button

-- Header
dashboard.section.header.val = {
[[ ]],
[[ ]],
[[ ]],
[[      █████ ██                              ███                                              █      ]],
[[   ██████  ███                █        █     ███                                           ██        ]],
[[  ██   █  █ ██               ██       ██      ██                                           ██        ]],
[[ █    █  █  ██               ██       ██      ██                                           ██        ]],
[[     █  █   █      ████    ████████ ████████  ██                                           ██        ]],
[[    ██ ██  █      █ ███  █████████ ████████   ██      ███   ███  ████      ███      ████   ██  ███   ]],
[[    ██ ██ █      █   ████    ██       ██      ██     █ ███   ████ ████ █  █ ███    █ ███  ███ █ ███  ]],
[[    ██ ███      ██    ██     ██       ██      ██    █   ███   ██   ████  █   ███  █   ████ ███   █   ]],
[[    ██ ██ ███   ██    ██     ██       ██      ██   ██    ███  ██    ██  ██    █████        ██   █    ]],
[[    ██ ██   ███ ██    ██     ██       ██      ██   ████████   ██    ██  ████████ ██        ██  █     ]],
[[    █  ██     ████    ██     ██       ██      ██   ███████    ██    ██  ███████  ██        ██ ██     ]],
[[       █      ████    ██     ██       ██      ██   ██         ██    ██  ██       ██        ██████    ]],
[[   ████     ███  ██████      ██       ██      ██   ████    █  ██    ██  ████    ████     █ ██  ███   ]],
[[  █  ████████     ████        ██       ██     ███ █ ███████   ███   ███  ███████  ███████  ██   ███ █]],
[[ █     ████                                    ███   █████     ███   ███  █████    █████    ██   ███ ]],
[[ █                                                                                                   ]],
[[  █                                                                                                  ]],
[[   ██                                                                                                ]]
}

-- Quick Links
dashboard.section.quick_links = {
  type = "group",
  val = {
    { type = "text", val = "🚀 Quick Links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    {
      type = "group",
      val = {
        button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        button("f", "  Find file", ":Telescope find_files<CR>"),
        button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        button("g", "  Grep text", ":Telescope live_grep<CR>"),
        button("q", "  Quit Neovim", ":qa<CR>"),
      },
    },
  },
}

dashboard.section.footer = {
  type = "group",
  val = {
    {
      type = "text",
      val = "BottleVim",
      opts = { position = "center", hl = "Comment" },
    },
    {
      type = "text",
      val = "🕒 " .. os.date("%A, %d %B %Y"),
      opts = { position = "center", hl = "Comment" },
    },
  },
}

-- Final layout
dashboard.config.layout = {
  { type = "padding", val = 2 },
  dashboard.section.header,
  { type = "padding", val = 2 },
  dashboard.section.quick_links,
  { type = "padding", val = 2 },
  dashboard.section.footer,
}

require("alpha").setup(dashboard.config)
