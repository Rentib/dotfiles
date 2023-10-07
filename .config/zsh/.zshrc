# $ZDOTDIR/.zshrc file for zsh interactive shells.

setopt autocd              # changes directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
# setopt magicequalsubst   # enable filename expansion for arguments of the form 'anything=expression'
# setopt nonomatch         # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
# setopt promptsubst       # enable command substitutions in prompt
setopt noclobber           # don't overwrite existing files (you can with >!)

WORDCHARS=${WORDCHARS//\/} # don't consider certain characters part of the word
PROMPT_EOL_MARK=""         # hide EOL sign ('%')

# auto/tab completion
fpath+=${ZSH_CUSTOM:-${ZSH:-$XDG_DATA_HOME/zsh/completion/}}

autoload -Uz compinit
compinit -i -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)	 # include hidden files

# setopt GLOB_COMPLETE     # show globs in autocompletion menu
# setopt MENU_COMPLETE     # highlight first option of the menu
setopt AUTO_LIST           # list choices on ambiguous completion
setopt COMPLETE_IN_WORD    # complete from anywhere in word

zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zmodload zsh/complist

# define completers
zstyle ':completion:*' completer _complete _extensions _approximate

# keybindings
export KEYTIMEOUT=1
bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # do history expansion on space
bindkey '^[[1;5C' forward-word  # ctrl+->
bindkey '^[[1;5D' backward-word # ctrl+<-
bindkey -M menuselect 'h' vi-backward-char        # completion menu left
bindkey -M menuselect 'j' vi-down-line-or-history # completion menu down
bindkey -M menuselect 'k' vi-up-line-or-history   # completion menu up
bindkey -M menuselect 'l' vi-forward-char         # completion menu right

# Set up the prompt
autoload -Uz colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# history
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=20000
setopt hist_save_no_dups   # don't save duplicates
setopt hist_ignore_dups    # ignore duplicated commands in history list
setopt share_history       # share history between all zsh instances

# colors
export LS_COLORS="su=30;41:sg=30;46:tw=30;42:ow=30;43"
export FZF_DEFAULT_OPTS="--color 16"

# aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# edit line in vim with ctrl+e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# plugins (use .local/share/zsh/plugins for place to keep repos with plugins)
plugin_dir="${XDG_DATA_HOME}/zsh/plugins"
url="https://github.com"
[ -d $plugin_dir/fast-syntax-highlighting ] || {
  echo "Fetching fast-syntax-highlighting"
  git -C "$plugin_dir" \
    clone --depth 1 --single-branch --no-tags -q \
    "$url/zdharma-continuum/fast-syntax-highlighting"
}
source "$plugin_dir/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
unset plugin_dir url

update_plugins() {
  plugin_dir="${XDG_DATA_HOME}/zsh/plugins"
  url="https://github.com"
  for plugin in $plugin_dir/*; do
    echo "Updating $plugin"
    git -C $plugin pull
  done
  unset plugin_dir url
}

# fuzzy finder
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
