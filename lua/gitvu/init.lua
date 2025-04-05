local M = {}

function M.setup(opts)
  opts = opts or {}

  local default_config = {
    keymaps = {
      toggle_lens = "<Leader>ga",  -- Toggle blame info
      next_conflict = "<Leader>gn",  -- Go to next conflict
      prev_conflict = "<Leader>gp",  -- Go to previous conflict
      take_current = "<Leader>g1",   -- Keep current changes (at cursor)
      take_incoming = "<Leader>g2",   -- Keep incoming changes (at cursor)
      take_both = "<Leader>g3",       -- Combine both (at cursor)
    },
    lens = {
      format = "👤 %s",              -- Customize blame format
    },
  }

  local config = vim.tbl_deep_extend("force", default_config, opts or {})

  -- Setup modules first
  require("gitvu.lens").setup(config.lens)
  require("gitvu.conflict_resolver").setup()

  -- Setup keymaps
  if config.keymaps.toggle_lens ~= false then
    vim.keymap.set("n", config.keymaps.toggle_lens, "<Cmd>GitVuToggleLens<CR>", { desc = "Toggle Git lens" })
  end

  if config.keymaps.next_conflict ~= false then
    vim.keymap.set("n", config.keymaps.next_conflict, "<Cmd>GitVuNextConflict<CR>", { desc = "Next Git conflict" })
  end

  if config.keymaps.prev_conflict ~= false then
    vim.keymap.set("n", config.keymaps.prev_conflict, "<Cmd>GitVuPrevConflict<CR>", { desc = "Previous Git conflict" })
  end

  if config.keymaps.take_current ~= false then
    vim.keymap.set("n", config.keymaps.take_current, "<Cmd>GitVuTakeCurrent<CR>", { desc = "Take current changes in conflict" })
  end

  if config.keymaps.take_incoming ~= false then
    vim.keymap.set("n", config.keymaps.take_incoming, "<Cmd>GitVuTakeIncoming<CR>", { desc = "Take incoming changes in conflict" })
  end

  if config.keymaps.take_both ~= false then
    vim.keymap.set("n", config.keymaps.take_both, "<Cmd>GitVuTakeBoth<CR>", { desc = "Combine both changes in conflict" })
  end
end

return M
