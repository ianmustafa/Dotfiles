# xclip as pbcopy
alias pbcopy='xclip -in -selection clipboard'

# Laravel Artisan
# alias tinker="php artisan tinker"
# alias tinx="php artisan tinx"
# alias serve="php artisan serve"
function tinker() {
  if [[ -e ./artisan ]]; then
    php artisan tinker;
  else
    echo "You're not in Laravel directory.";
  fi
}

# CodeIgniter Spark
function spark() {
  if [[ -e ./spark ]]; then
    php spark;
  else
    echo "You're not in CodeIgniter 4 directory.";
  fi
}


# Various dev server execution
function serve() {
  if [[ -e ./artisan ]]; then
    php artisan serve $1;
  elif [[ -e ./vue.config.json ]]; then
    npm run serve $1;
  else
    /usr/local/bin/serve $1;
  fi
}
function build() {
  if [[ -e ./webpack.mix.js ]]; then
    npm run prod $1;
  elif [[ -e ./package.json ]]; then
    if [[ -e ./pnpm-lock.json ]]; then
      pnpm build $1;
    else
      npm run build $1;
    fi
  fi
}
function rundev() {
  if [[ -e ./package.json ]]; then
    if [[ -e ./webpack.mix.js ]]; then
      npm run watch $1;
    elif [[ -e ./bun.lock ]]; then
      if [[ -e ./nuxt.config.ts ]]; then
        bun --bun run dev --no-fork $1;
      else
        bun --bun run dev $1;
      fi
    elif [[ -e ./pnpm-lock.json ]]; then
      pnpm dev $1;
    else
      npm run dev $1;
    fi
  elif [[ -e ./Makefile ]]; then
    make dev $1;
  fi
}
function cover() {
  clear;
  if [[ -e ./package.json ]]; then
    if npm run | grep -q '^  cover'; then
      npm run cover $1;
    elif npm run | grep -q '^  test:cover'; then
      npm run test:cover $1;
    fi
  fi
}

# EditorConfig creator
function editorconfig() {
  (echo "; https://editorconfig.org

root = true

[**]
charset = utf-8
end_of_line = lf
indent_size = 2
indent_style = space
insert_final_newline = true
trim_trailing_whitespace = true

[{composer.*,*.php}]
indent_size = 4

[*.md]
trim_trailing_whitespace = false
" > .editorconfig)
}
alias edconf="editorconfig"
alias edc="editorconfig"

# Lazygit
alias lg="lazygit"

# Antigravity IDE
alias ag="antigravity-ide"
