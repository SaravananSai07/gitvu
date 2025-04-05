local M = {}

function M.setup()
  vim.cmd [[
    command! GitVuNextConflict lua require('gitvu.merge').goto_conflict('next')
    command! GitVuPrevConflict lua require('gitvu.merge').goto_conflict('prev')
    command! GitVuTakeCurrent lua require('gitvu.merge').take_at_cursor('current')
    command! GitVuTakeIncoming lua require('gitvu.merge').take_at_cursor('incoming')
    command! GitVuTakeBoth lua require('gitvu.merge').take_at_cursor('both')
  ]]
end

-- Find the conflict nearest to the cursor (or nil if none)
function M.get_conflict_at_cursor()
  local cursor_line = vim.fn.line('.')
  local conflicts = M.find_all_conflicts()

  for _, conflict in ipairs(conflicts) do
    if cursor_line >= conflict.start and cursor_line <= conflict.end_ then
      return conflict
    end
  end
  return nil
end

-- Return all conflicts in the file as a list of {start, mid, end_}
function M.find_all_conflicts()
  local conflicts = {}
  local pos = 1

  while pos <= vim.fn.line('$') do
    local start = vim.fn.search('^<<<<<<<', 'nW')
    if start == 0 then break end

    local mid = vim.fn.search('^=======', 'nW')
    local end_ = vim.fn.search('^>>>>>>>', 'nW')

    if mid > start and end_ > mid then
      table.insert(conflicts, { start = start, mid = mid, end_ = end_ })
      pos = end_ + 1
    else
      pos = start + 1
    end
  end

  return conflicts
end

-- Go to next/previous conflict
function M.goto_conflict(direction)
  local conflicts = M.find_all_conflicts()
  if #conflicts == 0 then
    vim.notify("No conflicts found", vim.log.levels.WARN)
    return
  end

  local cursor_line = vim.fn.line('.')
  local target = nil

  if direction == 'next' then
    for _, c in ipairs(conflicts) do
      if c.start > cursor_line then
        target = c.start
        break
      end
    end
  else -- 'prev'
    for i = #conflicts, 1, -1 do
      if conflicts[i].end_ < cursor_line then
        target = conflicts[i].start
        break
      end
    end
  end

  if target then
    vim.fn.cursor(target, 1)
  else
    vim.notify("No more conflicts in " .. direction .. " direction", vim.log.levels.INFO)
  end
end

function M.take_at_cursor(choice)
  local conflict = M.get_conflict_at_cursor()
  if not conflict then
    vim.notify("Cursor is not inside a conflict", vim.log.levels.ERROR)
    return
  end

  local start, mid, end_ = conflict.start, conflict.mid, conflict.end_

  if choice == 'current' then
    vim.cmd(string.format("%d,%dd", mid, end_))
    vim.cmd(string.format("%dd", start))
  elseif choice == 'incoming' then
    vim.cmd(string.format("%d,%dd", start, mid))
    vim.cmd(string.format("%dd", end_))
  elseif choice == 'both' then
    vim.cmd(string.format("%dd", end_))
    vim.cmd(string.format("%dd", mid))
    vim.cmd(string.format("%dd", start))
  end

  vim.notify("Resolved conflict: " .. choice, vim.log.levels.INFO)
end

return M
