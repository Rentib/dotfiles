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
set -o AUTO_CD               # cd by typing directory name
set -o PUSHD_IGNORE_DUPS     # don't pushd duplicates
set -o AUTO_LIST             # list choices on ambiguous completion
set -o AUTO_MENU             # use menu completion after the 2nd completion request
set -o AUTO_NAME_DIRS        # expand directory variables
set -o COMPLETE_IN_WORD      # complete from anywhere in the word
set -o GLOB_COMPLETE         # list options instead of inserting them when matching with for example '*'
set -o REC_EXACT             # if the string exactly matches a possible completion, accept it
set -o MAGIC_EQUAL_SUBST     # unquoted arguments of the form ‘anything=expression’ after the command name have filename expansion
set -o NUMERIC_GLOB_SORT     # sort filenames numerically when it makes sense
set -o HIST_FIND_NO_DUPS     # ignore duplicates when searching history
set -o HIST_IGNORE_ALL_DUPS  # if new command duplicates and old one, the old one is removed
set -o HIST_IGNORE_DUPS      # don't enter commands into history list if they are duplicates of the previous event
set -o HIST_REDUCE_BLANKS    # emove superfluous blanks from each command line being added to the history list
set -o HIST_SAVE_NO_DUPS     # when writing out the history file, older commands that duplicate newer ones are omitted
set -o HIST_VERIFY           # entering a line with history expansion puts it into the editing buffer (doesn't execute)
set -o NO_CLOBBER            # don't overwrite existing files (you can with >!)
set -o CORRECT               # ask to correct mistakes in commands
set -o INTERACTIVE_COMMENTS  # allow for comments in interactive mode
set -o LONG_LIST_JOBS        # print job notifications in the long format by default
set -o NOTIFY                # report the status of a job immediately
set -o PROMPT_SUBST          # expansions are performed in prompts
set -o NO_BEEP               # no beep on zle errors
set -o EMACS                 # emacs mode

WORDCHARS=${WORDCHARS//\/}   # don't consider certain characters part of the word
PROMPT_EOL_MARK=""           # hide EOL sign ('%')
# }}}
# {{{COMPLETION SYSTEM
autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

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

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=32;1=31;1=33;1'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# }}}
# {{{KEYBINDINGS
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
autoload -Uz colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# }}}
# {{{HISTORY
test -d $XDG_STATE_HOME/zsh || mkdir -p $XDG_STATE_HOME/zsh
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=10000
SAVEHIST=20000
# }}}
# {{{ALIASES
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
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
# {{{Enviorenment
env_ghcup() {
    [ -f "$HOME/.local/share/ghcup/env" ] && source "$HOME/.local/share/ghcup/env"
}

env_flutter() {
    export CHROME_EXECUTABLE="/usr/bin/chromium"
    export ANDROID_SDK_ROOT='/opt/android-sdk'
    export PATH="$PATH:$HOME/.local/src/flutter/bin"
    export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools/"
    export PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin/"
    export PATH="$PATH:$ANDROID_ROOT/emulator"
    export PATH="$PATH:$ANDROID_SDK_ROOT/tools/"
}

env_rpipico() {
    export PICO_SDK_PATH=/opt/arm/pico-sdk
    export PICO_EXAMPLES_PATH=/opt/arm/pico-examples
    export PICO_EXTRAS_PATH=/opt/arm/pico-extras
    export PICO_PLAYGROUND_PATH=/opt/arm/pico-playground
}

env_go() {
    export PATH="$PATH:$HOME/.local/share/go/bin"
}
# }}}
# {{{PLUGINS
source /usr/share/fzf/key-bindings.zsh >/dev/null
source /usr/share/fzf/completion.zsh >/dev/null
source ${XDG_DATA_HOME}/zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh >/dev/null # https://github.com/z-shell/F-Sy-H
# }}}

# vim: set fdm=marker fmr={{{,}}}:
