#    ▄███████▄    ▄████████  ▄██████▄     ▄████████  ▄█   ▄█          ▄████████
#   ███    ███   ███    ███ ███    ███   ███    ███ ███  ███         ███    ███
#   ███    ███   ███    ███ ███    ███   ███    █▀  ███▌ ███         ███    █▀
#   ███    ███  ▄███▄▄▄▄██▀ ███    ███  ▄███▄▄▄     ███▌ ███        ▄███▄▄▄
# ▀█████████▀  ▀▀███▀▀▀▀▀   ███    ███ ▀▀███▀▀▀     ███▌ ███       ▀▀███▀▀▀
#   ███        ▀███████████ ███    ███   ███        ███  ███         ███    █▄
#   ███          ███    ███ ███    ███   ███        ███  ███▌    ▄   ███    ███
#  ▄████▀        ███    ███  ▀██████▀    ███        █▀   █████▄▄██   ██████████
#                ███    ███                              ▀
#                                              Rentib <sbitner420@tutanota.com>

# Default programs
export TERMINAL="st"
export READER="zathura"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"
export MANWIDTH=80
export EDITOR="nvim"
export DIFFTOOL="nvim -d"
export BROWSER="chromium"
export FILEMANAGER="lf"
export GUIFILEMANAGER="thunar"

# xdg base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/1000"

# clean ~
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export GHCUP_USE_XDG_DIRS=true
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_CONFIG_HOME/gradle"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export LESSHISTFILE="-"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PYTHON_HISTORY="$XDG_CACHE_HOME/python/history"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export STACK_ROOT="$XDG_DATA_HOME/stack"
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export WINEARCH=win32
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # Breaks some DMs
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Program settings
export CFLAGS="-O3 -march=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

export DO_NOT_TRACK=1
export QT_QPA_PLATFORMTHEME="gtk3"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export AWT_TOOLKIT=MToolkit
export STACK_XDG=1

# cargo
export PATH="$PATH:$HOME/.local/share/cargo/bin"

# ghcup
[ -f "/home/rentib/.local/share/ghcup/env" ] && source "/home/rentib/.local/share/ghcup/env" # ghcup-env
export PATH="$PATH:$HOME/.local/share/cabal/bin"

# flutter stuff
export PATH="$PATH:/home/rentib/.local/src/flutter/bin"
export PATH="$PATH:/home/rentib/.local/share/npm/bin"
export CHROME_EXECUTABLE="/usr/bin/chromium"
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/

# raspberry pi pico
export PICO_SDK_PATH=/opt/arm/pico-sdk
export PICO_EXAMPLES_PATH=/opt/arm/pico-examples
export PICO_EXTRAS_PATH=/opt/arm/pico-extras
export PICO_PLAYGROUND_PATH=/opt/arm/pico-playground
