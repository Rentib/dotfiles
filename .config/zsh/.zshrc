# $ZDOTDIR/.zshrc file for zsh interactive shells.

### OPTIONS ###

# Changing Directories
setopt AUTO_CD               # cd by typing directory name
setopt PUSHD_IGNORE_DUPS     # don't pushd duplicates

# Completion
setopt AUTO_LIST             # list choices on ambiguous completion
setopt AUTO_MENU             # use menu completion after the 2nd completion request
setopt AUTO_NAME_DIRS        # expand directory variables
setopt COMPLETE_IN_WORD      # complete from anywhere in the word
setopt GLOB_COMPLETE         # list options instead of inserting them when matching with for example '*'
# setopt MENU_COMPLETE       # automatically choose 1st menu option
setopt REC_EXACT             # if the string exactly matches a possible completion, accept it

# Expansion and Globbing
setopt EXTENDED_GLOB         # treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation
# setopt GLOB_DOTS           # don't require leading . to be completed
setopt MAGIC_EQUAL_SUBST     # unquoted arguments of the form ‘anything=expression’ after the command name have filename expansion
setopt NUMERIC_GLOB_SORT     # sort filenames numerically when it makes sense

# History
setopt HIST_FIND_NO_DUPS     # ignore duplicates when searching history
setopt HIST_IGNORE_ALL_DUPS  # if new command duplicates and old one, the old one is removed
setopt HIST_IGNORE_DUPS      # don't enter commands into history list if they are duplicates of the previous event
setopt HIST_REDUCE_BLANKS    # emove superfluous blanks from each command line being added to the history list
setopt HIST_SAVE_NO_DUPS     # when writing out the history file, older commands that duplicate newer ones are omitted
setopt HIST_VERIFY           # entering a line with history expansion puts it into the editing buffer (doesn't execute)
# setopt SHARE_HISTORY       # share history between all zsh instances

# Input/Output
setopt NO_CLOBBER            # don't overwrite existing files (you can with >!)
setopt CORRECT               # ask to correct mistakes in commands
setopt INTERACTIVE_COMMENTS  # allow for comments in interactive mode

# Job Control
setopt LONG_LIST_JOBS        # print job notifications in the long format by default
setopt NOTIFY                # report the status of a job immediately

# Prompting
setopt PROMPT_SUBST          # expansions are performed in prompts

# Zle (Zsh Line Editor)
setopt NO_BEEP               # no beep on zle errors
setopt EMACS                 # emacs mode

WORDCHARS=${WORDCHARS//\/}   # don't consider certain characters part of the word
PROMPT_EOL_MARK=""           # hide EOL sign ('%')

### COMPLETION WIDGETS ###

# edit line in vim with ctrl+e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

### COMPLETION SYSTEM ###

fpath+=${ZSH_CUSTOM:-${ZSH:-$XDG_DATA_HOME/zsh/completion/}}

autoload -Uz compinit && compinit -i -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:**' use-cache on
zstyle ':completion:**' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':completion:*' completer _prefix _complete _extensions _approximate
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true

### KEYBINDINGS ###

export KEYTIMEOUT=1
bindkey ' ' magic-space    # do history expansion on space
bindkey '^[[1;5C' forward-word  # ctrl+->
bindkey '^[[1;5D' backward-word # ctrl+<-

zmodload - zsh/complist
bindkey -M menuselect 'h' vi-backward-char        # completion menu left
bindkey -M menuselect 'j' vi-down-line-or-history # completion menu down
bindkey -M menuselect 'k' vi-up-line-or-history   # completion menu up
bindkey -M menuselect 'l' vi-forward-char         # completion menu right

### PROMPT ###

# Set up the prompt
autoload -Uz colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

### HISTORY ###

HISTFILE=$XDG_CACHE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=20000

### COLORS ###

export LS_COLORS="su=30;41:sg=30;46:tw=30;42:ow=30;43"
export FZF_DEFAULT_OPTS="--color 16"

### ALIASES ###

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

### PLUGINS ###

# use .local/share/zsh/plugins for place to keep repos with plugins
plugin_dir="${XDG_DATA_HOME}/zsh/plugins"
plugins=("zdharma-continuum/fast-syntax-highlighting")
for plugin in $plugins; do
  user=$(echo $plugin | cut -d '/' -f1)
  repo=$(echo $plugin | cut -d '/' -f2)

  [ -d "$plugin_dir/$repo" ] || \
    git -C "$plugin_dir" \
      clone --depth 1 --single-branch --no-tags -q \
      "https://github.com/$url/$plugin"

  source $(find "$plugin_dir/$repo" -type f -name "*.plugin.zsh")
done
unset plugin_dir plugins user repo

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
