local M = {}

function M.setup(opts)
  opts = opts or {}

  local default_keymaps = {
    toggle_author = "<Leader>ga",  -- Toggle blame info
    next_conflict = "<Leader>gn",  -- Go to next conflict
    prev_conflict = "<Leader>gp",  -- Go to previous conflict
    take_current = "<Leader>g1",   -- Keep current changes (at cursor)
    take_incoming = "<Leader>g2",   -- Keep incoming changes (at cursor)
    take_both = "<Leader>g3",       -- Combine both (at cursor)
  }

  local keymaps = vim.tbl_extend("force", default_keymaps, opts.keymaps or {})

  if keymaps.toggle_author ~= false then
    vim.keymap.set("n", keymaps.toggle_author, "<Cmd>GitVuToggleAuthor<CR>", { desc = "Toggle Git line author" })
  end

  if keymaps.next_conflict ~= false then
    vim.keymap.set("n", keymaps.next_conflict, "<Cmd>GitVuNextConflict<CR>", { desc = "Next Git conflict" })
  end

  if keymaps.prev_conflict ~= false then
    vim.keymap.set("n", keymaps.prev_conflict, "<Cmd>GitVuPrevConflict<CR>", { desc = "Previous Git conflict" })
  end

  if keymaps.take_current ~= false then
    vim.keymap.set("n", keymaps.take_current, "<Cmd>GitVuTakeCurrent<CR>", { desc = "Take current changes in conflict" })
  end

  if keymaps.take_incoming ~= false then
    vim.keymap.set("n", keymaps.take_incoming, "<Cmd>GitVuTakeIncoming<CR>", { desc = "Take incoming changes in conflict" })
  end

  if keymaps.take_both ~= false then
    vim.keymap.set("n", keymaps.take_both, "<Cmd>GitVuTakeBoth<CR>", { desc = "Combine both changes in conflict" })
  end

  require("gitvu.author").setup(opts.author or {})
  require("gitvu.merge").setup(opts.merge or {})
end

return M
