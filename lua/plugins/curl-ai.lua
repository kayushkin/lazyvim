return {
  {
    dir = vim.fn.stdpath("config") .. "/local-plugins/curl-ai",
    name = "curl-ai",
    -- EITHER load always:
    -- lazy = false,
    -- OR lazy-load on your commands:
    cmd = { "Claude", "Gemini", "OpenAI" },
    -- You can also lazy-load on keys:
    keys = {
      { "<leader>aic", ":Claude<CR>", mode = { "n", "v" }, desc = "Claude" },
      { "<leader>aig", ":Gemini<CR>", mode = { "n", "v" }, desc = "Gemini" },
      { "<leader>aio", ":OpenAI<CR>", mode = { "n", "v" }, desc = "OpenAI" },
    },
  },
}
