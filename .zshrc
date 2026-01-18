# ruby
# export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

# Doom Emacs
if [ -f "$HOME/.config/emacs/bin/doom/" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# mysql@8.0（ディレクトリがあるときだけ PATH に追加）
if [ -d "/opt/homebrew/opt/mysql@8.0/bin" ]; then
  export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
fi
