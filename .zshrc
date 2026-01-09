if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc'
fi

# openssl@3（ディレクトリがあるときだけ PATH に追加）
if [ -d "/opt/homebrew/opt/openssl@3/bin" ]; then
  export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Doom Emacs
if [ -f "$HOME/.config/emacs/bin/doom/" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# mise（入っているときだけ有効化）
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# mysql@8.0（ディレクトリがあるときだけ PATH に追加）
if [ -d "/opt/homebrew/opt/mysql@8.0/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
fi
