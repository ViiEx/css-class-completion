# CSS Class Completion

A Neovim plugin that provides CSS and SCSS class name completion for `nvim-cmp`.

## Installation

Use your favorite plugin manager. For example, with `packer.nvim`:

```lua
use {
  'viiex/css-class-completion',
  config = function()
    require('css-class-completion').setup()
  end
}
```

or `lazy.nvim`:

```lua
{
    "viiex/css-class-completion",
    config = function()
        require('css-class-completion').setup()
    end
}
```

## Configuration

```lua
require('css_class_completion').setup({
  filetypes = { 'html', 'jsx', 'tsx' },
  css_file_patterns = { '**/*.css', '**/*.scss' },
})
```

## Dependencies

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
