# enable p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### zsh configuration home
ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"

ZSH_DATA="$XDG_DATA_HOME/zsh"
if [[ ! -d "$ZSH_DATA" ]]; then
  command mkdir -p "$ZSH_DATA"
fi

ZSH_CACHE="$XDG_CACHE_HOME/zsh"
if [[ ! -d "$ZSH_CACHE" ]]; then
  command mkdir -p "$ZSH_CACHE"
fi

# save history in cache
export HISTSIZE=290000
export SAVEHIST=290000
export HISTFILE="$ZSH_CACHE/history"

### setopts
setopt interactivecomments nopromptcr

### autoloads
autoload -Uz colors
colors

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

### zstyles
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*:*:*:default' menu yes select search

### zinit
declare -A ZINIT
ZINIT_HOME="$ZSH_DATA/zinit"
ZINIT[HOME_DIR]="$ZINIT_HOME"
ZINIT[BIN_DIR]="$ZINIT_HOME/bin"
ZINIT[ZCOMPDUMP_PATH]="$ZSH_CACHE/zcompdump-$ZSH_VERSION"

if [[ ! -f "$ZINIT_HOME/bin/zinit.zsh" ]]; then
  command mkdir -p "$ZINIT_HOME"
  command git clone "https://github.com/zdharma/zinit" "$ZINIT_HOME/bin"
  zcompile "$ZINIT_HOME/bin/zinit.zsh"
fi

# source zinit
source "$ZINIT_HOME/bin/zinit.zsh"

### theme
# OMZ git library
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
# load theme from OMZ
setopt promptsubst
# zinit snippet OMZ::themes/dieter.zsh-theme

# powerlevel10k theme
zinit ice depth=1
zinit light romkatv/powerlevel10k

### load plugins
# goto
if [[ ! -f "$ZINIT_HOME/plugins/_local---goto/goto.plugin.zsh" ]]; then
  command ln -s "$ZSH_CONFIG/plugins/goto" "$ZINIT_HOME/plugins/_local---goto"
fi
zinit load _local/goto

# enchancd
export ENHANCD_DIR="$XDG_DATA_HOME/zsh/enhancd"
zinit wait lucid for \
    hlissner/zsh-autopair \
    zsh-users/zsh-history-substring-search \
  atload'zsh-startify' \
    zdharma/zsh-startify \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
    zdharma/fast-syntax-highlighting \
  atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  proto'git' pick'init.sh' atclone'rm $ZINIT_HOME/completions/_enhancd_*.fish' \
    b4b4r07/enhancd \
  blockf \
    zsh-users/zsh-completions

### environment
source "$XDG_CONFIG_HOME/sh/env"

### macros / aliases
# change directory on demand after exiting ranger
function ranger {
  local IFS=$'\t\n'
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  local ranger_cmd=(
    command
    ranger
    --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
  )

  ${ranger_cmd[@]} "$@"
  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
    cd -- "$(cat "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
}

# source p10k
if [[ -f "$ZSH_CONFIG/p10k.zsh" ]]; then
  source "$ZSH_CONFIG/p10k.zsh"
fi
