# VimRunCode 🚀

[![Version](https://img.shields.io/badge/version-2.0-blue.svg)](https://github.com/sergiobonatto/vim-run-code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Vim](https://img.shields.io/badge/vim-8.0%2B-orange.svg)](https://www.vim.org)
[![Neovim](https://img.shields.io/badge/neovim-0.5%2B-brightgreen.svg)](https://neovim.io)

A powerful, lightning-fast Vim plugin designed for developers who demand seamless code execution without leaving their editor. VimRunCode transforms your Vim into a complete IDE-like experience with intelligent compilation and execution for 50+ programming languages.

## 🎯 Philosophy

**Save. Execute. Optimize. Repeat.**

VimRunCode eliminates the friction between coding and testing by providing instant code execution with just two keystrokes:
- **`r`** - Development mode: Fast compilation with debugging symbols
- **`R`** - Production mode: Optimized compilation for performance testing

## ✨ Key Features

### 🔥 **Dual Execution Modes**
- **Development Mode (`r`)**: Fast iteration, debugging-friendly compilation
- **Optimized Mode (`R`)**: Production-ready, performance-optimized execution
- **Intelligent Fallbacks**: Automatically uses development mode when optimized commands aren't available

### 🌍 **Extensive Language Support**
- **50+ Programming Languages** supported out of the box
- **Smart Command Detection**: Automatically detects the best compiler/interpreter for your environment
- **Extensible Architecture**: Easy to add new languages or modify existing commands

### ⚡ **Performance & Reliability**
- **Automatic File Saving**: Never lose your changes before execution
- **Command Validation**: Checks if required tools are installed before execution
- **Timeout Protection**: Prevents runaway processes with configurable timeouts
- **Error Recovery**: Comprehensive error handling with informative messages

### 🛠 **Advanced Configuration**
- **Flexible Key Mappings**: Use default mappings or define your own
- **Per-Language Customization**: Override default commands for specific languages
- **Environment Adaptation**: Configurable temporary directories and execution parameters
- **Visual Feedback**: Color-coded messages for different execution states

## 📦 Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'sergiobonatto/vim-run-code'
```

### Using [Vundle](https://github.com/VundleVim/Vundle.vim)
```vim
Plugin 'sergiobonatto/vim-run-code'
```

### Using [dein.vim](https://github.com/Shougo/dein.vim)
```vim
call dein#add('sergiobonatto/vim-run-code')
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim) (Neovim)
```lua
use 'sergiobonatto/vim-run-code'
```

### Manual Installation
```bash
# For Vim
git clone https://github.com/sergiobonatto/vim-run-code.git ~/.vim/pack/plugins/start/vim-run-code

# For Neovim
git clone https://github.com/sergiobonatto/vim-run-code.git ~/.local/share/nvim/site/pack/plugins/start/vim-run-code
```

## 🚀 Quick Start

1. **Install the plugin** using your preferred method
2. **Open any supported code file** in Vim
3. **Press `r`** to run in development mode or **`R`** for optimized mode
4. **Watch your code execute** with automatic saving and intelligent compilation

### Example Workflow
```vim
" Open a Python file
:edit hello.py

" Write some code (plugin auto-saves before execution)
print("Hello, VimRunCode!")

" Press 'r' for development mode execution
" Press 'R' for optimized mode execution
```

## ⚙️ Configuration

### Essential Configuration Options

```vim
" ============================================================================
" Basic Configuration
" ============================================================================

" Enable automatic file saving before execution (default: 1)
let g:run_code_auto_save = 1

" Clear terminal before execution (default: 1)
let g:run_code_clear_terminal = 1

" Show execution feedback messages (default: 1)
let g:run_code_show_feedback = 1

" Set execution timeout in seconds (0 = no timeout, default: 0)
let g:run_code_timeout = 30

" Directory for temporary files (default: '/tmp')
let g:run_code_temp_dir = expand('~/.cache/vim-run-code')

" Disable default key mappings if you want custom ones (default: 0)
let g:run_code_no_default_mappings = 0
```

### Custom Key Mappings

```vim
" Disable default mappings first
let g:run_code_no_default_mappings = 1

" Set custom mappings
nnoremap <leader>r :RunCodeDev<CR>
nnoremap <leader>R :RunCodeOpt<CR>
nnoremap <F5> :RunCodeDev<CR>
nnoremap <F6> :RunCodeOpt<CR>

" Alternative mappings for different workflows
nnoremap <leader>cr :RunCodeDev<CR>
nnoremap <leader>co :RunCodeOpt<CR>
```

### Language-Specific Customization

```vim
" ============================================================================
" Custom Commands per Language
" ============================================================================

" Python with specific flags
call RunCodeSetCommand('python', 'python3 -u -W ignore::DeprecationWarning %')

" Node.js with debugging
call RunCodeSetCommand('javascript', 'node --inspect-brk=127.0.0.1:9229 %')

" Rust with specific features
call RunCodeSetCommand('rust', 'cargo run --features "debug-mode"')

" Go with race detection
call RunCodeSetCommand('go', 'go run -race %')

" C++ with specific standard and warnings
call RunCodeSetCommand('cpp', 'clang++ -std=c++20 -Wall -Wextra % -o %:r && ./%:r')
```

## 📋 Commands Reference

### Execution Commands
```vim
:RunCodeDev          " Execute in development mode
:RunCodeOpt          " Execute in optimized mode
```

### Configuration Commands
```vim
:RunCodeSet {filetype} {command}    " Set custom command for filetype
:RunCodeGet [filetype] [optimized]  " Get command for filetype
:RunCodeList                        " List all supported languages
:RunCodeConfig                      " Show current configuration
```

### Usage Examples
```vim
" Set custom Python command
:RunCodeSet python "python3 -u -B %"

" Get current command for JavaScript
:RunCodeGet javascript

" Get optimized command for C++
:RunCodeGet cpp 1

" List all supported languages
:RunCodeList

" Show current plugin configuration
:RunCodeConfig
```

## 🗣️ Supported Languages

### Compiled Languages

| Language | Development Mode | Optimized Mode |
|----------|------------------|----------------|
| **C** | `clang % -o %:r && ./%:r` | `clang -O3 -march=native % -o %:r && ./%:r` |
| **C++** | `clang++ -std=c++17 % -o %:r && ./%:r` | `clang++ -O3 -march=native -std=c++20 % -o %:r && ./%:r` |
| **Rust** | `cargo run` | `cargo run --release` |
| **Go** | `go run %` | `go build -ldflags="-s -w" % && ./%:r` |
| **Java** | `javac % && java %:r` | `javac % && java -server -XX:+UseG1GC %:r` |
| **C#** | `mcs % && mono %:r.exe` | Same as development |
| **Swift** | `swift %` | Same as development |
| **Kotlin** | `kotlinc % -include-runtime -d %:r.jar && java -jar %:r.jar` | `kotlinc % -include-runtime -d %:r.jar && java -server -jar %:r.jar` |
| **Nim** | `nim compile --run %` | `nim compile --opt:speed --run %` |
| **Zig** | `zig run %` | `zig run -O ReleaseFast %` |
| **Pascal** | `fpc % && ./%:r` | `fpc -O3 % && ./%:r` |
| **Haskell** | `stack run` | `ghc -O2 -threaded % -o /tmp/.tmp_exec && /tmp/.tmp_exec` |
| **OCaml** | `ocamlc -o %:r % && ./%:r` | `ocamlopt -O3 -o %:r % && ./%:r` |
| **Scala** | `scala %` | `scalac % && scala -J-server %:r` |

### Interpreted Languages

| Language | Development Mode | Optimized Mode |
|----------|------------------|----------------|
| **Python** | `python3 -u %` | `python3 -O %` |
| **JavaScript** | `node --inspect-brk=0.0.0.0:9229 %` | `node --max-old-space-size=4096 %` |
| **TypeScript** | `ts-node %` | `tsc % --outDir /tmp && node /tmp/%:r.js` |
| **Ruby** | `ruby %` | Same as development |
| **Perl** | `perl -w %` | Same as development |
| **PHP** | `php %` | Same as development |
| **Lua** | `lua %` | Same as development |
| **R** | `Rscript %` | Same as development |
| **Julia** | `julia %` | `julia -O3 %` |
| **Racket** | `racket %` | Same as development |
| **Scheme** | `csc % && ./%:r` | Same as development |

### Web Technologies

| Language | Development Mode | Optimized Mode |
|----------|------------------|----------------|
| **HTML** | `npm run dev` | `python3 -m http.server 8000` |
| **JSX** | `npm run dev` | Same as development |
| **TSX** | `npm run dev` | Same as development |

### Specialized Languages

| Language | Development Mode | Optimized Mode |
|----------|------------------|----------------|
| **HVM** | `hvm run %` | `hvm run-c %` |
| **Kind** | `kind check %` | `kind run %` |
| **Kind2** | `kind2 check %` | `kind2 normal %` |
| **Agda** | `agda-cli check %` | `agda-cli run %` |
| **Bend** | `bend check %` | `bend run %` |
| **Elm** | `elm make % --output=%:r.js` | Same as development |

## 🔧 Advanced Usage

### Error Handling and Debugging

The plugin provides comprehensive error handling:

```vim
" Example: Handle missing compilers gracefully
" If 'clang' is not found, the plugin will:
" 1. Show an error message
" 2. Suggest installing the required tool
" 3. Provide fallback options when available

" Check what command will be executed
:RunCodeGet c
" Output: clang % -o %:r && ./%:r

" The plugin automatically validates:
" - File existence and readability
" - Compiler/interpreter availability
" - Write permissions for output files
" - Timeout constraints
```

### Integration with Build Systems

```vim
" For projects using specific build systems
:RunCodeSet rust "cargo run --bin my-binary"
:RunCodeSet go "go run ./cmd/myapp"
:RunCodeSet typescript "npm run build && npm start"

" Web development workflows
:RunCodeSet html "npm run dev"
:RunCodeSet jsx "yarn start"
```

### Performance Optimization Tips

```vim
" Set shorter timeout for quick feedback
let g:run_code_timeout = 10

" Use faster temporary directory (SSD/tmpfs)
let g:run_code_temp_dir = '/dev/shm'

" Disable terminal clearing for faster execution
let g:run_code_clear_terminal = 0

" Optimize for specific use cases
let g:run_code_show_feedback = 0  " Disable for minimal output
```

## 🐛 Troubleshooting

### Common Issues and Solutions

#### Issue: "Command not found" error
```vim
" Solution: Check if the compiler/interpreter is installed
:!which python3
:!which clang
:!which node

" Or check plugin configuration
:RunCodeConfig
```

#### Issue: Custom commands not working
```vim
" Verify the command was set correctly
:RunCodeGet python

" Reset to default if needed
unlet g:run_code_commands['python']
```

#### Issue: Files not saving automatically
```vim
" Check auto-save setting
echo g:run_code_auto_save

" Enable if disabled
let g:run_code_auto_save = 1
```

#### Issue: Timeout errors
```vim
" Increase timeout or disable it
let g:run_code_timeout = 60  " 60 seconds
let g:run_code_timeout = 0   " No timeout
```

### Debug Mode

```vim
" Enable verbose output for debugging
let g:run_code_show_feedback = 1

" Check current configuration
:RunCodeConfig

" Verify command execution
:echo RunCodeGetCommand(&filetype, 0)  " Development mode
:echo RunCodeGetCommand(&filetype, 1)  " Optimized mode
```

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Adding New Language Support

1. **Fork the repository**
2. **Add language commands** to both `s:run_commands_dev` and `s:run_commands_opt`
3. **Test thoroughly** with sample code
4. **Update documentation**
5. **Submit a pull request**

Example addition:
```vim
" In plugin/run_code.vim
let s:run_commands_dev = {
    \ 'newlang': 'newlang-interpreter %',
    \ ...
\ }

let s:run_commands_opt = {
    \ 'newlang': 'newlang-compiler -O2 % -o %:r && ./%:r',
    \ ...
\ }
```

### Reporting Issues

When reporting issues, please include:
- Vim/Neovim version (`vim --version`)
- Operating system
- Programming language being used
- Error messages (if any)
- Minimal reproduction steps

### Development Setup

```bash
# Clone the repository
git clone https://github.com/sergiobonatto/vim-run-code.git
cd vim-run-code

# Test with different Vim configurations
vim -u NONE -c "source plugin/run_code.vim"
```

## 🏆 Why Choose VimRunCode?

### vs. Other Solutions

| Feature | VimRunCode | vim-quickrun | AsyncRun |
|---------|------------|--------------|----------|
| Dual execution modes | ✅ | ❌ | ❌ |
| 50+ languages | ✅ | ✅ | ❌ |
| Zero configuration | ✅ | ❌ | ❌ |
| Custom commands | ✅ | ✅ | ✅ |
| Error handling | ✅ | ⚠️ | ✅ |
| Performance focus | ✅ | ⚠️ | ✅ |

### Use Cases

- **Competitive Programming**: Lightning-fast C++/Python execution
- **Learning**: Quick experimentation with new languages
- **Prototyping**: Rapid iteration on algorithms and solutions
- **Teaching**: Demonstrate code concepts in real-time
- **Development**: Test small code snippets instantly

## 📝 Changelog

### Version 2.0 (Current)
- ✅ **Major**: Added optimized execution mode (`R`)
- ✅ **Major**: Expanded to 50+ supported languages
- ✅ **Feature**: Command validation and error handling
- ✅ **Feature**: Configurable timeouts and temporary directories
- ✅ **Feature**: Comprehensive API for customization
- ✅ **Enhancement**: Improved performance and reliability
- ✅ **Enhancement**: Better documentation and examples

### Version 1.5
- ✅ Basic execution functionality
- ✅ Core language support
- ✅ Simple key mappings

### Version 1.0
- ✅ Initial release
- ✅ Basic VimScript foundation

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

This means you can:
- ✅ Use commercially
- ✅ Modify and distribute
- ✅ Use privately
- ✅ Sublicense

## 👨‍💻 Author

**Sergio Bonatto**
- GitHub: [@sergiobonatto](https://github.com/sergiobonatto)
- Email: [your-email@example.com](mailto:your-email@example.com)

## 🙏 Acknowledgments

- The Vim community for inspiration and feedback
- Contributors who helped expand language support
- Beta testers who provided valuable bug reports

## 📚 Related Projects

- [vim-quickrun](https://github.com/thinca/vim-quickrun) - Another code execution plugin
- [AsyncRun](https://github.com/skywind3000/asyncrun.vim) - Asynchronous command execution
- [vim-dispatch](https://github.com/tpope/vim-dispatch) - Asynchronous build and test dispatcher

---

<div align="center">

**⭐ Star this repository if VimRunCode helps you code faster! ⭐**

[🐛 Report Bug](https://github.com/sergiobonatto/vim-run-code/issues) • [✨ Request Feature](https://github.com/sergiobonatto/vim-run-code/issues) • [💬 Discuss](https://github.com/sergiobonatto/vim-run-code/discussions)

</div>
