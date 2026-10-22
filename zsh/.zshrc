# PATH
export PATH="$HOME/.local/bin:$PATH"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

# Completion
autoload -Uz compinit && compinit

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PROMPT='%F{9}%~%f %F{13}❯%f '

# Functions
y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  command rm -f -- "$tmp"
}

xdl() {
  if [ -z "$1" ]; then
    echo "Usage: xdl <username>"
    return 1
  fi
  gallery-dl -v "https://x.com/search?q=from%3A$1&f=media"
}

run() { setsid -f "$@" >/dev/null 2>&1; exit; }

# Plugins (syntax-highlighting must be last)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

