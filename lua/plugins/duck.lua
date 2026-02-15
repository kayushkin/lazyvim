return {
  "tamton-aquib/duck.nvim",
  config = function()
    vim.keymap.set("n", "<leader>kk", function()
      require("duck").hatch()
    end, {})
    vim.keymap.set("n", "<leader>ka", function()
      require("duck").cook()
    end, {})
    vim.keymap.set("n", "<leader>kd", function()
      require("duck").cook_all()
    end, {})
  end,
}
