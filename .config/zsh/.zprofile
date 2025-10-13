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

_exists() {
    type $1 >/dev/null 2>&1
}

# pager
if _exists less; then
    PAGER=less
    LESSHISTFILE=-
    LESS="-iFRXPs?f%F    .%lt-%lb?e    END:?p    %pt\%:.."
    export PAGER LESSHISTFILE LESS
elif _exists more; then
    export PAGER=more
fi
_exists less && export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANWIDTH=80
export MANROFFOPT="-P -c"

# default programs
for p in nvim vim vi nano; do
    hash "$p" 2>/dev/null && export EDITOR="$p" VISUAL="$p" && break
done

for p in st foot; do
    hash "$p" 2>/dev/null && export TERMINAL="$p" && break
done

for p in chromium firefox; do
    hash "$p" 2>/dev/null && export BROWSER="$p" && break
done

for p in thunar lf; do
    case "$p" in
    lf) cmd="$TERMINAL -e lf" ;;
    *) cmd="$p" ;;
    esac
    hash "$p" 2>/dev/null && export FILEMANAGER="$cmd" && break
done
unset cmd
unset p

# program settings
export CFLAGS="-O2 -pipe -march=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

export DIFFTOOL="nvim -d"
export AWT_TOOLKIT=MToolkit
export DO_NOT_TRACK=1
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export QT_QPA_PLATFORMTHEME="gtk3"
export STACK_XDG=1

# construct PATH
_mkpath() {
    echo "$(find ~/.local/bin -type d -printf %p:)"
    _exists cargo && echo "$HOME/.local/share/cargo/bin"
    _exists cabal && echo "$HOME/.local/share/cabal/bin"
    _exists npm   && echo "$HOME/.local/share/npm/bin"
}
export PATH=$PATH:$(_mkpath | tr '\n' :)
