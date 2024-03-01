# Default programs
# export TERMINAL="st"
export TERMINAL="foot"
export WM="dwm"
export READER="zathura"
# export PAGER="nvim --cmd 'let g:vim_man_pager=1' +Man!"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"
export EDITOR="nvim"
export DIFFTOOL="nvim -d"
export BROWSER="chromium"
export FILEMANAGER="lf"
export GUIFILEMANAGER="thunar"
export DO_NOT_TRACK=1

# ~/ Clean up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/X11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # Breaks some DMs
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export FFMPEG_DATADIR="${XDG_CONFIG_HOME:-$HOME/.config}/ffmpeg"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"
export PYTHONHISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/python/history"
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export GRADLE_USER_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/gradle"
export VAGRANT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/vagrant/aliases"
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# export GHCUP_USE_XDG_DIRS=true
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal
export STACK_ROOT="$XDG_DATA_HOME"/stack
export STACK_XDG=1
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"

export QT_QPA_PLATFORMTHEME="gtk3"

# cargo
export PATH="$PATH:$HOME/.local/share/cargo/bin"
# ghcup
[ -f "/home/rentib/.ghcup/env" ] && source "/home/rentib/.ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.local/share/cabal/bin"
# flutter stuff
export PATH="$PATH:/home/rentib/.local/src/flutter/bin"
export PATH="$PATH:/home/rentib/.local/share/npm/bin"
export CHROME_EXECUTABLE="/usr/bin/brave"
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/

# enable anti-aliasing for java apps
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# raspberry pi pico
export PICO_SDK_PATH=/opt/arm/pico-sdk
export PICO_EXAMPLES_PATH=/opt/arm/pico-examples
export PICO_EXTRAS_PATH=/opt/arm/pico-extras
export PICO_PLAYGROUND_PATH=/opt/arm/pico-playground
