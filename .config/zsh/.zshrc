# Set up the prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Keep 1000 lines of history within the shell and save it to ~/.cache/zsh/history
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt hist_save_no_dups hist_ignore_dups

# vi mode
bindkey -v
export KEYTIMEOUT=1

#  Basic auto/tab complete:
fpath+=${ZSH_CUSTOM:-${ZSH:-$XDG_DATA_HOME/zsh/}}
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# colors
export LS_COLORS="su=30;41:sg=30;46:tw=30;42:ow=30;43"
export FZF_DEFAULT_OPTS="--color 16"

# aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

fcd() {
  cd "$(fd --hidden --type directory | fzf --height 40% --reverse)"
}

# fuzzy finder
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
