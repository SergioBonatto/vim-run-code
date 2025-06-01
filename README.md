# VimRunCode 🚀

A lean, reliable Vim/Neovim plugin for executing code files with support for development and optimized compilation modes.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Vim](https://img.shields.io/badge/vim-8.0%2B-yellow.svg?logo=vim)](https://www.vim.org)
[![Neovim](https://img.shields.io/badge/neovim-0.5%2B-green.svg?logo=neovim)](https://neovim.io)

---

## Overview

`vim-run-code` is a minimal yet effective plugin that enables rapid execution of source code files from within Vim or Neovim. It supports both development and production (optimized) execution modes, with optional autosave, terminal clearing, and timeout handling.

The plugin is filetype-driven and supports 50+ programming languages out of the box. Users can override or define custom execution commands per filetype.

---

## Features

* **Execution Modes**:

  * **Development Mode (`:RunCodeDev`)** – Fast iteration with debug flags or interpreted mode.
  * **Optimized Mode (`:RunCodeOpt`)** – Production-oriented execution with optimizations enabled.
* **Automatic saving** of the current buffer before execution.
* **Optional terminal clearing** before each run.
* **Timeout support** for long-running processes.
* **Error handling** for invalid files or commands.
* **Custom command registration** per filetype.
* **Default key mappings** for rapid usage (`r` / `R` in normal mode).
* **Works with Vim 8+ and Neovim 0.5+**.

---

## Installation

### Plugin Managers

```vim
" vim-plug
Plug 'sergiobonatto/vim-run-code'

" Vundle
Plugin 'sergiobonatto/vim-run-code'

" packer.nvim
use 'sergiobonatto/vim-run-code'
```

### Manual Installation

```sh
# Vim
git clone https://github.com/sergiobonatto/vim-run-code ~/.vim/pack/plugins/start/vim-run-code

# Neovim
git clone https://github.com/sergiobonatto/vim-run-code ~/.local/share/nvim/site/pack/plugins/start/vim-run-code
```

---

## Default Configuration

```vim
" Automatically save the buffer before execution
let g:run_code_auto_save = 1

" Clear terminal before running
let g:run_code_clear_terminal = 1

" Show feedback messages after execution
let g:run_code_show_feedback = 1

" Timeout for execution in seconds (0 = no timeout)
let g:run_code_timeout = 0

" Directory for storing temporary files
let g:run_code_temp_dir = '/tmp'

" Disable default mappings if set to 1
let g:run_code_no_default_mappings = 0
```

---

## Supported Languages

### Compiled

| Language | Development Command    | Optimized Command                          |
| -------- | ---------------------- | ------------------------------------------ |
| C        | `clang % -o %:r`       | `clang -O3 -march=native %`                |
| C++      | `clang++ -std=c++17 %` | `clang++ -O3 -march=native -std=c++20 %`   |
| Go       | `go run %`             | `go build -ldflags="-s -w"`                |
| Rust     | `cargo run`            | `cargo run --release`                      |
| Haskell  | `stack run`            | `ghc -O2 -threaded %`                      |
| Java     | `javac % && java %:r`  | `javac % && java -server -XX:+UseG1GC %:r` |

### Interpreted

| Language   | Development Command | Optimized Command |
| ---------- | ------------------- | ----------------- |
| Python     | `python3 -u %`      | `python3 -O %`    |
| JavaScript | `bun run %`         | `node %`          |
| TypeScript | `bun run %`         | `tsc % && node`   |
| Ruby       | `ruby %`            | -                 |
| PHP        | `php %`             | -                 |
| Lua        | `lua %`             | -                 |

---

## Commands

| Command                            | Description                                                         |
| ---------------------------------- | ------------------------------------------------------------------- |
| `:RunCodeDev`                      | Execute current file in development mode                            |
| `:RunCodeOpt`                      | Execute current file in optimized mode                              |
| `:RunCodeSet <filetype> <command>` | Register a custom command for a given filetype                      |
| `:RunCodeGet [filetype] [opt]`     | Show the command used for a filetype (optional `opt` for optimized) |
| `:RunCodeList`                     | Display supported filetypes and their commands                      |
| `:RunCodeConfig`                   | Print current configuration values                                  |

---

## Custom Commands

Set or override execution commands for a given filetype:

```vim
" Custom command for Python
:RunCodeSet python "python3 -u -B %"

" Custom Node.js command
:RunCodeSet javascript "node --inspect %"

" Custom C++ command
:RunCodeSet cpp "g++ -std=c++20 -Wall %"
```

---

## Key Mappings

If `g:run_code_no_default_mappings` is not set or false, the following mappings are enabled:

| Key | Mode   | Action                  |
| --- | ------ | ----------------------- |
| `r` | Normal | Run in development mode |
| `R` | Normal | Run in optimized mode   |

Example of disabling defaults and setting custom mappings:

```vim
let g:run_code_no_default_mappings = 1
nnoremap <leader>r :RunCodeDev<CR>
nnoremap <leader>R :RunCodeOpt<CR>
```

---

## Error Handling

The plugin handles and reports the following cases:

* Unreadable or unsaved files
* Unsupported or unset commands
* Missing external tools in `$PATH`
* Timeout exceeded (if configured)
* General execution errors

---

## Contributing

Contributions are welcome. To contribute:

1. Fork the repository.
2. Create a feature branch.
3. Write or update code/tests.
4. Submit a pull request.

---

## License

MIT License. See the `LICENSE` file for details.

---

## Author

**Sergio Bonatto**
[github.com/sergiobonatto](https://github.com/sergiobonatto)

---

For issues or feature requests, open a [GitHub Issue](https://github.com/sergiobonatto/vim-run-code/issues).
