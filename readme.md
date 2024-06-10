## timber.nvim - minimal logger.

In normal mode, log the word (cexpr) under the cursor.
For more information on cexpr, see `:help <cexpr>`

In visual mode, the selection is stripped of whitespace and logged. This can turn a multiline object into a single line that can be logged.

Consider the below javascript example:
```js
function someFunc({
    hello,
    world
}) { ... }
```
If we select the arguments of the function `someFunc` and log it with timber, we would get the following:
```js
console.log(`{ hello, world }: `, { hello, world });
```

### Mappings

By default, vim-timber doesn't create any mappings.

Mappings can be done however you would like. Please see config below for more information on how mappings can be modified to your liking.

A basic mapping can look like the following:
```lua
vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>TimberLog<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>te', '<cmd>TimberError<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>tw', '<cmd>TimberWarn<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>TimberInfo<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>TimberCustom<cr>', {})
```

### Config
For each language supported, there will be a minimum of two options available to you; the default log, and the custom log.

Note that the string `{{value}}` will be replaced with either the visual selection, or the word under the cursor.

TODO: Implement & allow customisation for custom logs
