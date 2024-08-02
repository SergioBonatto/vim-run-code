# VimRunCode (WIP)

VimRunCode é um plugin Vim que fornece uma maneira rápida e fácil de compilar e executar código em várias linguagens de programação diretamente do Vim.

## Características

- Suporte para mais de 30 linguagens de programação
- Comandos personalizados para compilação e execução
- Mapeamentos de teclas configuráveis
- Fácil de estender para linguagens adicionais

## Instalação

### Usando [vim-plug](https://github.com/junegunn/vim-plug)

Adicione o seguinte ao seu `vimrc`:

```vim
Plug 'sergiobonatto/vim-run-code'
```

Então execute :PlugInstall.

## Instalação manual

Clone este repositório em seu diretório de plugins do Vim:

git clone https://github.com/sergiobonatto/vim-run-code.git ~/.vim/pack/plugins/start/vim-run-code

## Uso

Por padrão, o plugin mapeia as seguintes teclas:

- `r`: Executa o código do arquivo atual
- `R`: Executa uma versão alternativa do código
- `<leader>r`: Executa o código com opções adicionais
- `<leader>R`: Executa uma versão alternativa com opções adicionais
Para usar, simplesmente pressione a tecla mapeada quando estiver editando um arquivo de código suportado.

## Configuração

Para desabilitar os mapeamentos padrão, adicione ao seu vimrc:

```bash
let g:run_code_map_keys = 0
```

Para definir mapeamentos personalizados:

```bash
nnoremap <silent> YourKey :call RunCode()<CR>
nnoremap <silent> YourOtherKey :call RunCodeAlternative()<CR>
```

### Linguagens suportadas

- Python
- JavaScript
- TypeScript
- Rust
- Go
- C/C++
- Haskell
- OCaml
- Scheme
- ... e muitas outras!
Consulte a documentação completa para ver a lista completa de linguagens suportadas.

Para adicionar ou substituir um comando para uma linguagem específica:

```bash
    call SetRunCommand('rust', 'cargo run')
    call SetRunCommand('go', 'go run %')
    call SetRunCommand('custom_lang', 'custom_compiler %')
```

Coloque esses comandos em seu .vimrc para personalizar o comportamento do plugin.

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.
