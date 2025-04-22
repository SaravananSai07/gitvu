# GitVu

A Neovim plugin that shows git blame information inline and provides easy merge conflict resolution.

## Features

- 👤 Shows git blame information at the end of each line
- 🔄 Navigate and resolve merge conflicts with simple keybindings

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "SaravananSai07/gitvu",
  opts = {
    keymaps = {
      toggle_lens = "<Leader>ga",    -- Toggle git blame
      next_conflict = "<Leader>gn",  -- Next conflict
      prev_conflict = "<Leader>gp",  -- Previous conflict
      take_current = "<Leader>g1",   -- Keep current changes
      take_incoming = "<Leader>g2",  -- Keep incoming changes
      take_both = "<Leader>g3",      -- Keep both changes
    },
    lens = {
      format = "👤 %s",             -- Blame format
    },
  },
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "SaravananSai07/gitvu",
  config = function()
    require("gitvu").setup({
      -- config here (same as above)
    })
  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'SaravananSai07/gitvu'

" In your init.vim
lua << EOF
require("gitvu").setup({
  keymaps = {
    toggle_lens = "<Leader>ga",    -- Toggle git blame
    next_conflict = "<Leader>gn",  -- Next conflict
    prev_conflict = "<Leader>gp",  -- Previous conflict
    take_current = "<Leader>g1",   -- Keep current changes
    take_incoming = "<Leader>g2",  -- Keep incoming changes
    take_both = "<Leader>g3",      -- Keep both changes
  },
  lens = {
    format = "👤 %s",             -- Blame format
  },
})
EOF
```

## Default Configuration

```lua
require("gitvu").setup({
  keymaps = {
    toggle_lens = "<Leader>ga",    -- Toggle git blame
    next_conflict = "<Leader>gn",  -- Next conflict
    prev_conflict = "<Leader>gp",  -- Previous conflict
    take_current = "<Leader>g1",   -- Keep current changes
    take_incoming = "<Leader>g2",  -- Keep incoming changes
    take_both = "<Leader>g3",      -- Keep both changes
  },
  lens = {
    format = "👤 %s",             -- Blame format
  },
})
```

## License

MIT
