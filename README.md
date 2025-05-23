This is currently my configuration for Nvim workspace.

Currently i have implemented a few things:

- DAP (Debug Adapter Protocol) for JS/TS and C

You must install the dap debug server separately for now, i'm not automate the process and you have
to tweak a bit in the configuration files especially in `lua/muj/dap/dap.lua` and 'lua/muj/dap/lang/'.
You can however implement your own config for the DAP and maybe add more DAP server for other languages.

- LSP (Language Server Protocol) this one is automated using `Mason`

It provides documentation and information on functions that are inside a buffer. The LSP are also provides
the suggestion and autocompletion for the `nvim-cmp` for several languages. You can however install other languages
inside the config but you have to adjust the LSP handler for the appropriate language.

- Autocompletion (NVIM-CMP)

This plugin enables the autocompletion either from the LSP, Buffer definition, Snippets (yes you can define your own snippet here).
LSP and nvim-cmp is automatically synchronized. If you want to define a snippet, just make a new JSON file inside the `snippet` directory
outside the config directory. Just follow the existing example there.

- Code Highlighting

Code Highlighting done by the `treesitter` plugin. You can add more highlighting features and add more language support in the config.

- Code Auto Format (Prettier-like)

Code formatter for my setup I only enable just for a few language and not all.
The language are: C, C++, JS/TS (ESLint and Prettier supported languages), Lua, Python.
You can add more by adjusting the config inside the `none-ls.lua` file and using `Mason` to help you to download the formatter.
It will automatically format your code whenever you hit the `save` mechanism.

- FZF

To easily find your file, provided by plugin `telescope`. run `<space>ff` to search a file inside a directory and hit Enter and it
will open a buffer with the file content inside.

- Transparent Background

You can enable or disable this feature by using the shortcut command `<space>tt` to toggle in between.

- Auto Session

When you leave the neovim for a while and come back in the same directory you can revive the last buffers you have opened
and don't have to open each file. From the main title screen you can press `r` to retrieve the last session.
Or if you want to select which session you want to use, just hit `<space>w` and it will open up keymaps you can choose.

#### Future Update: I will post all the keymaps i have defined in my config here. And for information, the leader key is <SPACE>
