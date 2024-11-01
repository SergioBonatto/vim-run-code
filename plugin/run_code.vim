if exists("g:loaded_run_code")
    finish
endif
let g:loaded_run_code = 1

function! s:RunCode()
    write
    let l:cmd = 'clear'
    let l:ft = &filetype

    if has_key(g:run_code_commands, l:ft)
        let l:cmd .= ' && ' . g:run_code_commands[l:ft]
    elseif l:ft == 'agda'
        let l:cmd .= ' && agda-cli check %'
    elseif l:ft == 'bend'
        let l:cmd .= ' && time bend check % && echo "all terms checked"'
    elseif l:ft == 'caramel'
        let l:cmd .= ' && time mel main'
    elseif l:ft == 'c'
        let l:cmd .= ' && clang % -o %:r && time ./%:r'
    elseif l:ft == 'coc'
        let l:cmd .= ' && time (coc type %:r; coc norm %:r)'
    elseif l:ft == 'cpp'
        let l:cmd .= ' && clang++ -std=c++11 -O3 % -o %:r && time ./%:r'
    elseif l:ft == 'csharp'
        let l:cmd .= ' && mcs % && mono %:r'
    elseif l:ft == 'cuda'
        let l:cmd .= ' && rm %:r; nvcc -O3 % -o %:r && time ./%:r'
    elseif l:ft == 'dvl'
        let l:cmd .= ' && dvl run %'
    elseif l:ft == 'eac'
        let l:cmd .= ' && time eac %:r'
    elseif l:ft == 'eatt'
        let l:cmd .= ' && time eatt %:r'
    elseif l:ft == 'elm'
        let l:cmd .= ' && clear && w! && elm % -r elm-runtime.js && osascript ~/.vim/refresh.applescript &'
    elseif l:ft == 'formality'
        let l:cmd .= ' && time fm %'
    elseif l:ft == 'formcore'
        let l:cmd .= ' && time fmcjs %:r'
    elseif l:ft == 'go'
        let l:cmd .= ' && time go run %'
    elseif l:ft == 'haskell'
        let l:cmd .= ' && stack run'
    elseif l:ft == 'html'
        let l:cmd .= ' && npm run build'
    elseif l:ft == 'hvm-lang'
        let l:cmd .= ' && time hvm-lang  % '
    elseif l:ft == 'hvm'
        let l:cmd .= ' && time hvm run-c  %'
    elseif l:ft == 'icvm'
        let l:cmd .= ' && time ic % '
    elseif l:ft == 'ic'
        let l:cmd .= ' && time ic %'
    elseif l:ft == 'idris2'
        let l:cmd .= ' && idris2 % -o %:r && time ./%:r'
    elseif l:ft == 'java'
        let l:cmd .= ' && javac % && time java %:r'
    elseif l:ft == 'javascript'
        let l:cmd .= ' && time node %'
    elseif l:ft == 'kind2'
        let l:cmd .= ' && time kind2 check %'
    elseif l:ft == 'kind'
        let l:cmd .= ' && time kind check %'
    elseif l:ft == 'ksc'
        let l:cmd .= ' && time kindelia-cli local eval --file %'
    elseif l:ft == 'lambda'
        let l:cmd .= ' && time absal -s %'
    elseif l:ft == 'ls'
        let l:cmd .= ' && lsc -c % && node %:r.js'
    elseif l:ft == 'lua'
        let l:cmd .= ' && lua %'
    elseif l:ft == 'moon'
        let l:cmd .= ' && time moon run %:r'
    elseif l:ft == 'morte'
        let l:cmd .= ' && time echo $(cat %) | morte'
    elseif l:ft == 'ocaml'
        let l:cmd .= ' && ocamlc -o %:r % && ./%:r'
    elseif l:ft == 'perl'
        let l:cmd .= ' && perl %'
    elseif l:ft == 'php'
        let l:cmd .= ' && php %'
    elseif l:ft == 'purescript'
        let l:cmd .= ' && pulp run '
    elseif l:ft == 'python'
        let l:cmd .= ' && time python3 %'
    elseif l:ft == 'racket'
        let l:cmd .= ' && racket %'
    elseif l:ft == 'ruby'
        let l:cmd .= ' && ruby %'
    elseif l:ft == 'rust'
        let l:cmd .= ' && time cargo +nightly run --release'
    elseif l:ft == 'scheme'
        let l:cmd .= ' && csc % && time ./%:r'
    elseif l:ft == 'sic'
        let l:cmd .= ' && time sic -s -B %'
    elseif l:ft == 'solidity'
        let l:cmd .= ' && truffle deploy'
    elseif l:ft == 'swift'
        let l:cmd .= ' && time swift %'
    elseif l:ft == 'test.js'
        let l:cmd .= ' && mocha'
    elseif l:ft == 'typescript'
        let l:cmd .= ' && npm run build'
    elseif l:ft == 'sh'
        let l:cmd .= ' && bash %'
    else
        let l:cmd .= ' && time cc %'
    endif

    execute '!' . l:cmd
endfunction

function! s:RunCodeAlternative()
    write
    let l:cmd = 'clear && date'
    let l:ft = &filetype

    if l:ft == 'agda'
        let l:cmd .= ' && agda-cli check %'
    elseif l:ft == 'caramel'
        let l:cmd .= ' && time mel main'
    elseif l:ft == 'ocaml'
        let l:cmd .= ' && ocamlc -o %:r % && ./%:r'
    elseif l:ft == 'factor'
        let l:cmd .= ' && ~/factor/factor %'
    elseif l:ft == 'python'
        let l:cmd .= ' && time python %'
    elseif l:ft == 'coc'
        let l:cmd .= ' && time (coc type %:r; coc norm %:r)'
    elseif l:ft == 'scheme'
        let l:cmd .= ' && csc % && time ./%:r'
    elseif l:ft == 'elm'
        let l:cmd .= ' && elm % -r elm-runtime.js && osascript ~/.vim/refresh.applescript &'
    elseif l:ft == 'racket'
        let l:cmd .= ' && racket %'
    elseif l:ft == 'haskell'
        let l:cmd .= ' && time ghc -O2 % -o .tmp && time ./.tmp 0 && rm %:r.hi %:r.o .tmp'
    elseif l:ft == 'rust'
        let l:cmd .= ' && time cargo run --release'
    elseif l:ft == 'go'
        let l:cmd .= ' && time go run %'
    elseif l:ft == 'purescript'
        let l:cmd .= ' && pulp run'
    elseif l:ft == 'dvl'
        let l:cmd .= ' && dvl run %'
    elseif l:ft == 'lambda'
        let l:cmd .= ' && time absal -s %'
    elseif l:ft == 'javascript'
        let l:cmd .= ' && node %'
    elseif l:ft == 'icvm'
        let l:cmd .= ' && time ic % '
    elseif l:ft == 'ic'
        let l:cmd .= ' && time ic %'
    elseif l:ft == 'typescript'
        let l:cmd .= ' && time deno --unstable run --reload --allow-all %'
    elseif l:ft == 'html'
        let l:cmd .= ' && http-server -c-1'
    elseif l:ft == 'eatt'
        let l:cmd .= ' && time eatt %:r'
    elseif l:ft == 'fmfm' || l:ft == 'formality'
        let l:cmd .= ' && time fmjs %:r --run'
    elseif l:ft == 'kind2'
        let l:cmd .= ' && time kind2 normal %'
        elseif &filetype == 'kind'
            let l:repo_root = fnamemodify(finddir('.git/..', expand('%:p:h').';'), ':p')
            let l:relative_path = fnamemodify(expand('%:p'), ':s?' . l:repo_root . '??')
            let l:cmd .= ' && cd ' . shellescape(l:repo_root) . ' && time kind check ' . shellescape(l:relative_path)
    elseif l:ft == 'lambolt'
        let l:cmd .= ' && time lam % c'
    elseif l:ft == 'bend'
        let l:cmd .= ' && time bend run-c % -s'
    elseif l:ft == 'hvm2'
        let l:cmd .= ' && hvm c %; clang -O2 %:r.c -o %:r; time ./%:r 2; rm %:r %:r.c'
    elseif l:ft == 'hvm-lang'
        let l:cmd .= ' && time hvm-lang run %'
    elseif l:ft == 'hvm'
        let l:cmd .= ' && time hvm run %'
    elseif l:ft == 'icvm' || l:ft == 'ic'
        let l:cmd .= ' && time ic %'
    elseif l:ft == 'ksc'
        let l:cmd .= ' && time kindelia-cli local check --file %'
    elseif l:ft == 'eac'
        let l:cmd .= ' && time eac %:r'
    elseif l:ft == 'formcore'
        let l:cmd .= ' && time fmio %:r'
    elseif l:ft == 'moon'
        let l:cmd .= ' && time moon run %:r'
    elseif l:ft == 'sic'
        let l:cmd .= ' && time sic -s -B %'
    elseif l:ft == 'morte'
        let l:cmd .= ' && time echo $(cat %) | morte'
    elseif l:ft == 'swift'
        let l:cmd .= ' && time swift %'
    elseif l:ft == 'solidity'
        let l:cmd .= ' && truffle deploy'
    elseif l:ft == 'idris2'
        let l:cmd .= ' && idris2 % -o %:r && time ./build/exec/%:r'
    elseif l:ft == 'c'
        let l:cmd .= ' && clang -O3 % -o %:r && time ./%:r'
    elseif l:ft == 'cpp'
        let l:cmd .= ' && clang++ -O3 % -o %:r && time ./%:r'
    elseif l:ft == 'agda'
        let l:cmd .= ' && agda-cli run %'
    elseif l:ft == 'ls'
        let l:cmd .= ' && lsc -c % && node %:r.js'
    else
        let l:cmd .= ' && time cc %'
    endif

    execute '!' . l:cmd
endfunction

" Exposição da função para uso global
function! RunCodeAlternative()
    call s:RunCodeAlternative()
endfunction

" Mapeamento padrão (opcional)
if get(g:, 'run_code_map_keys', 1)
    nnoremap <silent> R :call RunCodeAlternative()<CR>
endif

function! s:RunCodeLeader()
    write
    let l:cmd = 'clear && date'
    if &filetype == 'python'
        let l:cmd .= ' && time python %'
    elseif &filetype == 'javascript'
        let l:cmd .= ' && npm run build'
    elseif &filetype == 'typescript'
        let l:cmd .= ' && npm run build'
    elseif &filetype == 'rust'
        let l:cmd .= ' && time cargo +nightly run --release'
    elseif &filetype == 'go'
        let l:cmd .= ' && time go run %'
    elseif &filetype == 'haskell'
        let l:cmd .= ' && stack run'
    elseif &filetype == 'c'
        let l:cmd .= ' && clang -O3 -Wall % -o %:r && time ./%:r'
    elseif &filetype == 'cpp'
        let l:cmd .= ' && clang++ -O3 % -o %:r && time ./%:r'
    elseif &filetype == 'agda'
        let l:cmd .= ' && agda-cli run %'
        elseif &filetype == 'kind'
            let l:repo_root = fnamemodify(finddir('.git/..', expand('%:p:h').';'), ':p')
            let l:relative_path = fnamemodify(expand('%:p'), ':s?' . l:repo_root . '??')
            let l:cmd .= ' && cd ' . shellescape(l:repo_root) . ' && time kind run ' . shellescape(l:relative_path)
    else
        let l:cmd .= ' && time cc %'
    endif
    execute '!' . l:cmd
endfunction

function! s:RunCodeLeaderAlternative()
    write
    let l:cmd = 'clear && date'
    if &filetype == 'python'
        let l:cmd .= ' && time python %'
    elseif &filetype == 'javascript'
        let l:cmd .= ' && node %'
    elseif &filetype == 'typescript'
        let l:cmd .= ' && npm run build'
    elseif &filetype == 'rust'
        let l:cmd .= ' && time cargo +nightly run --release'
    elseif &filetype == 'go'
        let l:cmd .= ' && time go run %'
    elseif &filetype == 'haskell'
        let l:cmd .= ' && stack run'
    elseif &filetype == 'c'
        let l:cmd .= ' && clang -O3 % -o %:r && time ./%:r'
    elseif &filetype == 'cpp'
        let l:cmd .= ' && clang++ -O3 % -o %:r && time ./%:r'
    elseif &filetype == 'agda'
        let l:cmd .= ' && agda-cli run %'
    elseif &filetype == 'kind'
        let l:cmd .= ' && time kind run %'
    else
        let l:cmd .= ' && time cc %'
    endif
    execute '!' . l:cmd
endfunction

function! SetRunCommand(filetype, command)
    let g:run_code_commands[a:filetype] = a:command
endfunction

nnoremap <silent> r :call <SID>RunCodeAlternative()<CR>
nnoremap <silent> R :call <SID>RunCodeLeader()<CR>
nnoremap <silent> <leader>r :call <SID>RunCodeAlternative()<CR>
nnoremap <silent> <leader>R :call <SID>RunCodeLeaderAlternative()<CR>
