return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icons = LazyVim.config.icons

    local function pending_status()
      local parts = {}

      -- Recording macro
      local rec = vim.fn.reg_recording()
      if rec ~= "" then
        table.insert(parts, "REC @" .. rec)
      end

      -- Currently executing macro
      local exe = vim.fn.reg_executing()
      if exe ~= "" then
        table.insert(parts, "EXEC @" .. exe)
      end

      -- Count prefix, but only if it's >1 (1 is the default)
      if vim.v.count > 1 then
        table.insert(parts, tostring(vim.v.count))
      end

      if #parts == 0 then
        return ""
      end
      return table.concat(parts, " ")
    end

    opts.options = vim.tbl_extend("force", opts.options or {}, {
      globalstatus = true,
      icons_enabled = true, -- turn off icons if you want it cleaner
      component_separators = "",
      section_separators = "",
      disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
    })
    opts.sections = {
      lualine_a = {
        {
          pending_status,
          color = { fg = "#ff0000" }, -- tweak color to taste
          padding = { left = 1, right = 1 },
        },
      },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            -- info = icons.diagnostics.Info,
            -- hint = icons.diagnostics.Hint,
          },
        },
      },
      lualine_c = { { "filename", path = 1, padding = { left = 1, right = 0 } } }, -- path = 0 name, 1 relative, 2 absolute
      lualine_x = {
        -- { "mode", icon_only = true, padding = { left = 1, right = 0 } },
        { "filetype", icon_only = true, padding = { left = 1, right = 0 } },
      },
      lualine_y = {
        "selectioncount",
        "searchcount",
      },
      lualine_z = { { "location", padding = { left = 0, right = 0 } } }, -- line:col
    }
    opts.inactive_sections = opts.sections
    return opts
  end,
}
