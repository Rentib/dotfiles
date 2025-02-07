#  ▄███████▄     ▄████████    ▄█    █▄       ▄████████  ▄████████ 
# ██▀     ▄██   ███    ███   ███    ███     ███    ███ ███    ███ 
#       ▄███▀   ███    █▀    ███    ███     ███    ███ ███    █▀  
#  ▀█▀▄███▀▄▄   ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄▄██▀ ███        
#   ▄███▀   ▀ ▀███████████ ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀▀▀   ███        
# ▄███▀                ███   ███    ███   ▀███████████ ███    █▄  
# ███▄     ▄█    ▄█    ███   ███    ███     ███    ███ ███    ███ 
#  ▀████████▀  ▄████████▀    ███    █▀      ███    ███ ████████▀  
#                                           ███    ███            
#
#                                Rentib <sbitner420@tutanota.com>

# {{{OPTIONS
# {{{Changing Directories
setopt AUTO_CD               # cd by typing directory name
setopt PUSHD_IGNORE_DUPS     # don't pushd duplicates
# }}}
# {{{Completion
setopt AUTO_LIST             # list choices on ambiguous completion
setopt AUTO_MENU             # use menu completion after the 2nd completion request
setopt AUTO_NAME_DIRS        # expand directory variables
setopt COMPLETE_IN_WORD      # complete from anywhere in the word
setopt GLOB_COMPLETE         # list options instead of inserting them when matching with for example '*'
# setopt MENU_COMPLETE       # automatically choose 1st menu option
setopt REC_EXACT             # if the string exactly matches a possible completion, accept it
# }}}
# {{{Expansion and Globbing
# setopt EXTENDED_GLOB       # treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation
# setopt GLOB_DOTS           # don't require leading . to be completed
setopt MAGIC_EQUAL_SUBST     # unquoted arguments of the form ‘anything=expression’ after the command name have filename expansion
setopt NUMERIC_GLOB_SORT     # sort filenames numerically when it makes sense
# }}}
# {{{History
setopt HIST_FIND_NO_DUPS     # ignore duplicates when searching history
setopt HIST_IGNORE_ALL_DUPS  # if new command duplicates and old one, the old one is removed
setopt HIST_IGNORE_DUPS      # don't enter commands into history list if they are duplicates of the previous event
setopt HIST_REDUCE_BLANKS    # emove superfluous blanks from each command line being added to the history list
setopt HIST_SAVE_NO_DUPS     # when writing out the history file, older commands that duplicate newer ones are omitted
setopt HIST_VERIFY           # entering a line with history expansion puts it into the editing buffer (doesn't execute)
# setopt SHARE_HISTORY       # share history between all zsh instances
# }}}
# {{{Input/Output
setopt NO_CLOBBER            # don't overwrite existing files (you can with >!)
setopt CORRECT               # ask to correct mistakes in commands
setopt INTERACTIVE_COMMENTS  # allow for comments in interactive mode
# }}}
# {{{Job Control
setopt LONG_LIST_JOBS        # print job notifications in the long format by default
setopt NOTIFY                # report the status of a job immediately
# }}}
# {{{Prompting
setopt PROMPT_SUBST          # expansions are performed in prompts
# }}}
# {{{Zle (Zsh Line Editor)
setopt NO_BEEP               # no beep on zle errors
setopt EMACS                 # emacs mode
# }}}
# {{{Misc
WORDCHARS=${WORDCHARS//\/}   # don't consider certain characters part of the word
PROMPT_EOL_MARK=""           # hide EOL sign ('%')
# }}}
# }}}
# {{{COMPLETION SYSTEM

# {{{widgets
# edit line in vim with ctrl+e
autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line
# }}}

fpath+=${ZSH_CUSTOM:-${ZSH:-$XDG_DATA_HOME/zsh/completion/}}

autoload -Uz compinit && compinit -i -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:**' use-cache on
zstyle ':completion:**' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':completion:*' completer _prefix _complete _extensions _approximate
zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 pi=33 so=01\;35 bd=00\;35 cd=00\;34 or=00\;41 mi=00\;45 ex=01\;32
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignored-patterns '(_*|*-widget|pre(cmd|exec))'

zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -w -o pid,user,cmd'

# {{{kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=32;1=31;1=33;1'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# }}}

# }}}
# {{{KEYBINDINGS

# {{{fix keys
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
#}}}

export KEYTIMEOUT=1
bindkey ' ' magic-space      # do history expansion on space
bindkey '^[[1;5C' forward-word  # ctrl+->
bindkey '^[[1;5D' backward-word # ctrl+<-

zmodload - zsh/complist
bindkey -M menuselect 'h' vi-backward-char        # completion menu left
bindkey -M menuselect 'j' vi-down-line-or-history # completion menu down
bindkey -M menuselect 'k' vi-up-line-or-history   # completion menu up
bindkey -M menuselect 'l' vi-forward-char         # completion menu right

# }}}
# {{{PROMPT

# Set up the prompt
autoload -Uz colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# }}}
# {{{HISTORY

test -d $XDG_STATE_HOME/zsh || mkdir -p $XDG_STATE_HOME/zsh
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=20000

# }}}
# {{{COLORS

export LS_COLORS="su=30;41:sg=30;46:tw=30;42:ow=30;43"
export FZF_DEFAULT_OPTS="--height=50% --layout=reverse --color 16 --prompt='❯ ' --pointer='-' --marker='+' --ansi --multi"

command -v fd > /dev/null && {
    export FZF_DEFAULT_COMMAND='fd -t f          -H -L -E .git --strip-cwd-prefix'
    export FZF_ALT_C_COMMAND='  fd -t d          -H -L -E .git --strip-cwd-prefix'
    export FZF_CTRL_T_COMMAND=' fd -t f --type d -H -L -E .git --strip-cwd-prefix'
}

# }}}
# {{{ALIASES

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# }}}
# {{{Automatically Activate Python Venv

autoload -Uz add-zsh-hook
add-zsh-hook precmd automatically_activate_python_venv

function automatically_activate_python_venv() {
    local parentdir
    if [[ -z $VIRTUAL_ENV ]] ; then
        activate_venv
    else
        parentdir="$(dirname ${VIRTUAL_ENV})"
        if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            deactivate
            activate_venv
        fi
    fi
}

function activate_venv() {  
    local d
    d=$PWD

    until false 
    do 
        if [[ -f $d/.venv/bin/activate ]] ; then 
            source $d/.venv/bin/activate
            break
        fi
        d=${d%/*}
        [[ $d = *\/* ]] || break
    done
}

# }}}
# {{{PLUGINS

# use .local/share/zsh/plugins for place to keep repos with plugins
plugin_dir="${XDG_DATA_HOME}/zsh/plugins"
plugins=("z-shell/F-Sy-H")
for plugin in $plugins; do
  user=$(echo $plugin | cut -d '/' -f1)
  repo=$(echo $plugin | cut -d '/' -f2)

  [ -d "$plugin_dir/$repo" ] || \
    git -C "$plugin_dir" \
      clone --depth 1 --single-branch --no-tags -q \
      "https://github.com/$plugin"

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

# }}}

# vim: set fdm=marker fmr={{{,}}}:
