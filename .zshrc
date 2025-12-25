eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# C拡張を含むgemをコンパイルするために、以下の設定も推奨されます
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"


if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/Users/taguchi.sho/Documents/google-cloud-sdk/completion.zsh.inc'
fi

eval "$(rbenv init - zsh)"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Doom Emacs
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib/

# ruby on Rails
export PATH="/opt/homebrew/bin:$PATH"
eval "$(~/.local/bin/mise activate)"
