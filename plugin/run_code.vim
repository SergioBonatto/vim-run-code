" ============================================================================
" File: run_code.vim
" Description: Save and run code with 'r' (dev) and 'R' (optimized)
" Version: 2.0
" Author: Sergio Bonatto
" License: MIT
" ============================================================================

if exists('g:loaded_run_code') || &compatible
    finish
endif
let g:loaded_run_code = 1

" Save current compatibility options
let s:save_cpo = &cpo
set cpo&vim

" ============================================================================
" Configuration Variables
" ============================================================================

" Enable/disable automatic file saving before execution
let g:run_code_auto_save = get(g:, 'run_code_auto_save', 1)

" Enable/disable terminal clearing before execution
let g:run_code_clear_terminal = get(g:, 'run_code_clear_terminal', 1)

" Enable/disable default key mappings
let g:run_code_no_default_mappings = get(g:, 'run_code_no_default_mappings', 0)

" Enable/disable execution feedback messages
let g:run_code_show_feedback = get(g:, 'run_code_show_feedback', 1)

" Timeout for command execution (in seconds, 0 = no timeout)
let g:run_code_timeout = get(g:, 'run_code_timeout', 0)

" Directory for temporary files
let g:run_code_temp_dir = get(g:, 'run_code_temp_dir', '/tmp')

" ============================================================================
" Development Commands (Standard execution)
" ============================================================================

let s:run_commands_dev = {
    \ 'agda': 'agda-cli check %',
    \ 'bend': 'bend run %',
    \ 'c': 'clang % -o %:r && ./%:r',
    \ 'caramel': 'mel main',
    \ 'coc': 'coc type %:r && coc norm %:r',
    \ 'cpp': 'clang++ -std=c++17 % -o %:r && ./%:r',
    \ 'csharp': 'mcs % && mono %:r.exe',
    \ 'cuda': 'nvcc % -o %:r && ./%:r',
    \ 'dart': 'dart %',
    \ 'dvl': 'dvl run %',
    \ 'eac': 'eac %:r',
    \ 'eatt': 'eatt %:r',
    \ 'elm': 'elm make % --output=%:r.js',
    \ 'erlang': 'escript %',
    \ 'fibo': 'fibo %',
    \ 'formality': 'fm %',
    \ 'formcore': 'fmcjs %:r',
    \ 'go': 'go run %',
    \ 'haskell': 'stack run',
    \ 'html': 'npm run dev',
    \ 'hvm': 'hvm run %',
    \ 'hvm-lang': 'hvm-lang %',
    \ 'hvml': 'hvml run % -s',
    \ 'hvms': 'hvms run %',
    \ 'ic': 'ic %',
    \ 'icvm': 'ic %',
    \ 'idris2': 'idris2 % -o %:r && ./%:r',
    \ 'java': 'javac % && java %:r',
    \ 'javascript': 'bun run %',
    \ 'jsx': 'npm run dev',
    \ 'julia': 'julia %',
    \ 'kind': 'kind check %',
    \ 'kind2': 'kind2 check %',
    \ 'kotlin': 'kotlinc % -include-runtime -d %:r.jar && java -jar %:r.jar',
    \ 'ksc': 'kindelia-cli local eval --file %',
    \ 'lambda': 'absal -s %',
    \ 'livescript': 'lsc -c % && node %:r.js',
    \ 'lua': 'lua %',
    \ 'moon': 'moon run %:r',
    \ 'morte': 'echo $(cat %) | morte',
    \ 'nim': 'nim compile --run %',
    \ 'ocaml': 'ocamlc -o %:r % && ./%:r',
    \ 'pascal': 'fpc % && ./%:r',
    \ 'perl': 'perl -w %',
    \ 'phi': 'phi %',
    \ 'php': 'php %',
    \ 'purescript': 'pulp run',
    \ 'python': 'python3 -u %',
    \ 'r': 'Rscript %',
    \ 'racket': 'racket %',
    \ 'ruby': 'ruby %',
    \ 'rust': 'cargo run',
    \ 'scala': 'scala %',
    \ 'scheme': 'csc % && ./%:r',
    \ 'sh': 'bash -x %',
    \ 'sic': 'sic -s -B %',
    \ 'solidity': 'truffle deploy',
    \ 'swift': 'swift %',
    \ 'typescript': 'bun run %',
    \ 'tsx': 'npm run dev',
    \ 'zig': 'zig run %'
\ }

" ============================================================================
" Optimized Commands (Production/Fast execution)
" ============================================================================

let s:run_commands_opt = {
    \ 'agda': 'agda-cli run %',
    \ 'bend': 'bend run %',
    \ 'c': 'clang -O3 -march=native % -o %:r && ./%:r',
    \ 'cpp': 'clang++ -O3 -march=native -std=c++20 % -o %:r && ./%:r',
    \ 'cuda': 'nvcc -O3 % -o %:r && ./%:r',
    \ 'dart': 'dart compile exe % -o %:r && ./%:r',
    \ 'go': 'go build -ldflags="-s -w" % && ./%:r',
    \ 'haskell': 'ghc -O2 -threaded % -o ' . g:run_code_temp_dir . '/.tmp_exec && ' . g:run_code_temp_dir . '/.tmp_exec && rm -f ' . g:run_code_temp_dir . '/.tmp_exec %:r.hi %:r.o',
    \ 'html': 'python3 -m http.server 8000',
    \ 'hvm': 'hvm run-c %',
    \ 'java': 'javac % && java -server -XX:+UseG1GC %:r',
    \ 'javascript': 'node %',
    \ 'julia': 'julia -O3 %',
    \ 'kind': 'kind run %',
    \ 'kind2': 'kind2 normal %',
    \ 'kotlin': 'kotlinc % -include-runtime -d %:r.jar && java -server -jar %:r.jar',
    \ 'nim': 'nim compile --opt:speed --run %',
    \ 'ocaml': 'ocamlopt -O3 -o %:r % && ./%:r',
    \ 'pascal': 'fpc -O3 % && ./%:r',
    \ 'phi': 'phi % -t -s -c',
    \ 'python': 'python3 -O %',
    \ 'rust': 'cargo run --release',
    \ 'scala': 'scalac % && scala -J-server %:r',
    \ 'typescript': 'tsc % --outDir ' . g:run_code_temp_dir . ' && node ' . g:run_code_temp_dir . '/%:r.js',
    \ 'zig': 'zig run -O ReleaseFast %'
\ }

" ============================================================================
" Utility Functions
" ============================================================================

" Check if a command/executable exists in PATH
function! s:CommandExists(cmd) abort
    return executable(split(a:cmd, '\s\+')[0])
endfunction

" Get the base command without arguments for existence check
function! s:GetBaseCommand(cmd) abort
    return split(substitute(a:cmd, '%\|%:[a-z]\+', '', 'g'), '\s\+')[0]
endfunction

" Display feedback message with highlighting
function! s:ShowFeedback(msg, type) abort
    if !g:run_code_show_feedback
        return
    endif

    if a:type ==# 'error'
        echohl ErrorMsg
    elseif a:type ==# 'warning'
        echohl WarningMsg
    elseif a:type ==# 'info'
        echohl MoreMsg
    endif

    echo a:msg
    echohl None
endfunction

" Validate file before execution
function! s:ValidateFile() abort
    " Check if file exists and is readable
    if !filereadable(expand('%'))
        call s:ShowFeedback('Error: File is not readable or does not exist', 'error')
        return 0
    endif

    " Check if file has been modified
    if &modified && g:run_code_auto_save
        call s:ShowFeedback('Saving file before execution...', 'info')
    elseif &modified && !g:run_code_auto_save
        call s:ShowFeedback('Warning: File has unsaved changes', 'warning')
    endif

    return 1
endfunction

" Get command for current filetype
function! s:GetCommand(is_optimized) abort
    let l:ft = &filetype
    let l:commands = a:is_optimized ? s:run_commands_opt : s:run_commands_dev

    " Check for user-defined custom commands first
    if exists('g:run_code_commands') && has_key(g:run_code_commands, l:ft)
        return g:run_code_commands[l:ft]
    endif

    " Check language-specific commands
    if has_key(l:commands, l:ft)
        return l:commands[l:ft]
    endif

    " Try alternative command set if optimized command not found
    if a:is_optimized && has_key(s:run_commands_dev, l:ft)
        call s:ShowFeedback('No optimized command found, using development command', 'warning')
        return s:run_commands_dev[l:ft]
    endif

    " Fallback to generic C compiler
    call s:ShowFeedback('No specific command found for ' . l:ft . ', using C compiler fallback', 'warning')
    return 'cc % -o %:r && ./%:r'
endfunction

" Build the full command with options
function! s:BuildCommand(base_cmd) abort
    let l:cmd = ''

    " Add clear command if enabled
    if g:run_code_clear_terminal
        let l:cmd = 'clear'
    endif

    " Add timeout if specified
    if g:run_code_timeout > 0
        let l:timeout_cmd = 'time && timeout ' . g:run_code_timeout . 's ' . a:base_cmd
        let l:cmd = l:cmd ==# '' ? l:timeout_cmd : l:cmd . ' && ' . l:timeout_cmd
    else
        let l:cmd = l:cmd ==# '' ? 'time ' . a:base_cmd : l:cmd . ' && time ' . a:base_cmd
    endif

    return l:cmd
endfunction

" ============================================================================
" Core Execution Functions
" ============================================================================

" Execute code in development mode
function! s:RunCodeDev() abort
    if !s:ValidateFile()
        return
    endif

    " Auto-save if enabled
    if g:run_code_auto_save
        try
            write
        catch /^Vim\%((\a\+)\)\=:E/
            call s:ShowFeedback('Error: Cannot save file - ' . v:exception, 'error')
            return
        endtry
    endif

    let l:base_cmd = s:GetCommand(0)

    " Check if the required command exists
    if !s:CommandExists(l:base_cmd)
        call s:ShowFeedback('Error: Command not found - ' . s:GetBaseCommand(l:base_cmd), 'error')
        return
    endif

    let l:full_cmd = s:BuildCommand(l:base_cmd)

    call s:ShowFeedback('Running in development mode...', 'info')
    execute '!' . l:full_cmd
endfunction

" Execute code in optimized mode
function! s:RunCodeOpt() abort
    if !s:ValidateFile()
        return
    endif

    " Auto-save if enabled
    if g:run_code_auto_save
        try
            write
        catch /^Vim\%((\a\+)\)\=:E/
            call s:ShowFeedback('Error: Cannot save file - ' . v:exception, 'error')
            return
        endtry
    endif

    let l:base_cmd = s:GetCommand(1)

    " Check if the required command exists
    if !s:CommandExists(l:base_cmd)
        call s:ShowFeedback('Error: Command not found - ' . s:GetBaseCommand(l:base_cmd), 'error')
        return
    endif

    let l:full_cmd = s:BuildCommand(l:base_cmd)

    call s:ShowFeedback('Running in optimized mode...', 'info')
    execute '!' . l:full_cmd
endfunction

" ============================================================================
" Public API for Customization
" ============================================================================

" Set custom command for a filetype
function! RunCodeSetCommand(filetype, command) abort
    if empty(a:filetype) || empty(a:command)
        call s:ShowFeedback('Error: Both filetype and command must be non-empty', 'error')
        return
    endif

    if !exists('g:run_code_commands')
        let g:run_code_commands = {}
    endif

    let g:run_code_commands[a:filetype] = a:command
    call s:ShowFeedback('Custom command set for ' . a:filetype, 'info')
endfunction

" Get current command for filetype
function! RunCodeGetCommand(filetype, ...) abort
    let l:is_optimized = a:0 > 0 ? a:1 : 0
    let l:old_ft = &filetype

    try
        let &filetype = a:filetype
        return s:GetCommand(l:is_optimized)
    finally
        let &filetype = l:old_ft
    endtry
endfunction

" List all supported languages
function! RunCodeListLanguages() abort
    let l:all_languages = extend(copy(s:run_commands_dev), s:run_commands_opt)
    let l:languages = sort(keys(l:all_languages))

    echo 'Supported languages:'
    for l:lang in l:languages
        echo '  ' . l:lang
    endfor
endfunction

" Show current configuration
function! RunCodeShowConfig() abort
    echo 'Run Code Configuration:'
    echo '  Auto-save: ' . (g:run_code_auto_save ? 'enabled' : 'disabled')
    echo '  Clear terminal: ' . (g:run_code_clear_terminal ? 'enabled' : 'disabled')
    echo '  Show feedback: ' . (g:run_code_show_feedback ? 'enabled' : 'disabled')
    echo '  Timeout: ' . (g:run_code_timeout > 0 ? g:run_code_timeout . 's' : 'disabled')
    echo '  Temp directory: ' . g:run_code_temp_dir
    echo '  Default mappings: ' . (g:run_code_no_default_mappings ? 'disabled' : 'enabled')
endfunction

" ============================================================================
" Key Mappings
" ============================================================================

if !g:run_code_no_default_mappings
    " Map 'r' to run code in development mode
    nnoremap <silent> r :call <SID>RunCodeDev()<CR>

    " Map 'R' to run code in optimized mode
    nnoremap <silent> R :call <SID>RunCodeOpt()<CR>
endif

" ============================================================================
" Commands
" ============================================================================

" Set custom command for a filetype
" Usage: :RunCodeSet python "python3 -u %"
command! -nargs=+ RunCodeSet call RunCodeSetCommand(<f-args>)

" Get command for current or specified filetype
" Usage: :RunCodeGet [filetype] [optimized]
command! -nargs=* RunCodeGet echo RunCodeGetCommand(<f-args>)

" List all supported languages
command! RunCodeList call RunCodeListLanguages()

" Show current configuration
command! RunCodeConfig call RunCodeShowConfig()

" Manual execution commands
command! RunCodeDev call <SID>RunCodeDev()
command! RunCodeOpt call <SID>RunCodeOpt()

" ============================================================================
" Autocommands
" ============================================================================

augroup RunCodeGroup
    autocmd!
    " Add any future autocommands here
augroup END

" ============================================================================
" Cleanup
" ============================================================================

" Restore compatibility options
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4 sts=4:
