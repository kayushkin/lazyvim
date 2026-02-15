local M = {}

local function get_visual_selection()
  local saved_reg = vim.fn.getreg('"')
  local saved_regtype = vim.fn.getregtype('"')

  vim.cmd("normal! gvy")
  local selection = vim.fn.getreg('"')

  vim.fn.setreg('"', saved_reg, saved_regtype)

  return selection
end

local function write_to_log(input, response, log_file)
  local log = io.open(log_file, "a")

  local timestamp = os.time()
  local formatted_time = os.date("%Y-%m-%d %H:%M:%S", timestamp)

  if log then
    log:write("\n=== " .. formatted_time .. " ===\n")
    log:write("Input:\n" .. input .. "\n\n")
    log:write("Response:\n" .. response .. "\n\n")
    log:close()
  end
end

local function getAiQuery(prompt, opts)
  local full_input
  if opts.range > 0 then
    local additional_input = vim.fn.input(prompt)
    full_input = get_visual_selection() .. "\n\n" .. additional_input
  else
    full_input = vim.fn.input(prompt)
  end

  return full_input
end

local function openBufferWithText(text)
  local output_buf = vim.api.nvim_create_buf(false, true)
  vim.bo[output_buf].buftype = "nofile"
  vim.bo[output_buf].swapfile = false

  vim.cmd("30split")
  vim.api.nvim_win_set_buf(0, output_buf)
  vim.api.nvim_buf_set_lines(output_buf, -1, -1, false, text)
end

local function queryModel(log_file, queryScript, prompt, opts)
  local full_input = getAiQuery(prompt, opts)

  local response_lines = {}

  local handle = vim.fn.jobstart("bash " .. queryScript, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        openBufferWithText(data)
        -- Collect response lines
        for _, line in ipairs(data) do
          table.insert(response_lines, line)
        end
      end
    end,
    on_exit = function()
      -- When job completes, write to log
      local response_text = table.concat(response_lines, "\n")
      write_to_log(full_input, response_text, log_file)
    end,
    stdin = "pipe",
  })

  if handle then
    vim.fn.chansend(handle, full_input)
    vim.fn.chanclose(handle, "stdin")
  else
    print("Error: Failed to start job")
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Claude", function(opts)
    local log_file = vim.fn.expand("~/bash/logs/claude.log")
    local queryScript = "~/bash/claude.sh"
    local prompt = "Claude: "
    queryModel(log_file, queryScript, prompt, opts)
  end, { range = true })

  vim.api.nvim_create_user_command("Gemini", function(opts)
    local log_file = vim.fn.expand("~/bash/logs/gemini.log")
    local queryScript = "~/bash/gemini.sh"
    local prompt = "Gemini: "
    queryModel(log_file, queryScript, prompt, opts)
  end, { range = true })

  vim.api.nvim_create_user_command("OpenAI", function(opts)
    local log_file = vim.fn.expand("~/bash/logs/openai.log")
    local queryScript = "~/bash/openai.sh"
    local prompt = "OpenAI: "
    queryModel(log_file, queryScript, prompt, opts)
  end, { range = true })

  vim.keymap.set("v", "<leader>aic", ":Claude<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>aic", ":Claude<CR>", { noremap = true })
  vim.keymap.set("v", "<leader>aig", ":Gemini<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>aig", ":Gemini<CR>", { noremap = true })
  vim.keymap.set("v", "<leader>aio", ":OpenAI<CR>", { noremap = true })
  vim.keymap.set("n", "<leader>aio", ":OpenAI<CR>", { noremap = true })
end

return M
