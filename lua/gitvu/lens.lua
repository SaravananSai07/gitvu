local M = {}

local ns = vim.api.nvim_create_namespace("gitvu_lens")
local enabled = false
local config = {
  format = "👤 %s"  -- default format
}

function M.setup(opts)
  config = vim.tbl_extend("force", config, opts or {})
  vim.cmd [[command! GitVuToggleLens lua require('gitvu.lens').toggle()]]
end

function M.toggle()
  enabled = not enabled
  if enabled then
    vim.notify("GitVu: Lens enabled", vim.log.levels.INFO)
    vim.cmd [[autocmd CursorMoved * lua require('gitvu.lens').show_author()]]
    M.show_author()
  else
    vim.notify("GitVu: Lens disabled", vim.log.levels.INFO)
    vim.cmd [[autocmd! CursorMoved * lua require('gitvu.lens').show_author()]]
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  end
end

function M.show_author()
  if not enabled then return end

  local line = vim.fn.line('.') - 1
  local file = vim.fn.expand('%:p')

  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  local cmd = string.format("git blame -L %d,%d --porcelain -- %s", line + 1, line + 1, file)
  local output = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 then return end

  local author = output[1]:match("author (.+)")
  if author then
    vim.api.nvim_buf_set_extmark(0, ns, line, 0, {
      virt_text = {{ string.format(config.format, author), "Comment" }},
      virt_text_pos = "eol",
    })
  end
end

return M
