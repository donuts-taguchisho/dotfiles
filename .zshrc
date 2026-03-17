if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc'
fi

# AWS NGT Tools
export PATH="$HOME/.aws-ngt-tools/bin:$PATH"

# AWS ngt認証の自動設定
eval "$(aws-ngt-auth status --export 2>/dev/null || true)"
aws-ngt-login() { aws-ngt-auth login "$1" && export AWS_DEFAULT_PROFILE=ngt; }
aws-ngt-logout() { aws-ngt-auth logout && unset AWS_DEFAULT_PROFILE; }

# openssl@3（ディレクトリがあるときだけ PATH に追加）
if [ -d "/opt/homebrew/opt/openssl@3/bin" ]; then
  export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
fi

# homebrewでインストールしたMySQLのバージョンが複数ある場合、それらを切り替えるのは、以下のコマンドで行う
# brew unlink mysql... && brew link mysql...
if [ -d "opt/homebrew/opt/mysql/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql/bin:$PATH"
fi

if [ -d "opt/homebrew/opt/mysql@8.4/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"
fi

if [ -d "opt/homebrew/opt/mysql-client@8.4/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql-client@8.4/bin:$PATH"
fi

# Doom Emacs
if [ -f "$HOME/.config/emacs/bin/doom/" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
export PATH="/opt/homebrew/opt/emacs-plus@30/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export VISUAL="nvim"
