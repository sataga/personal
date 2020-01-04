# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/t-sataga/.oh-my-zsh"

# Path to language
export GOROOT=$HOME/go
# export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOROOT/bin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew git vagrant)  

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/local/sbin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LANG=ja_JP.UTF-8
export EDITORP=vim #エディタをvimに設定

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias la='ls -laG'
alias ll='ls -aG'
alias d='docker'
alias kl='kubectl'
alias klc='kubectl config'
alias klg='kubectl get'
alias kld='kubectl describe'
alias kle='kubectl exec -it'
alias ks="kubens"
alias kctx="kubectx"
alias gl='gcloud'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# cdなしでディレクトリ移動
setopt auto_cd

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# zsh-completionsの設定
fpath=(/path/to/homebrew/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

# プロンプトの設定
PROMPT=$'%{%f%b%k%}$(build_prompt)\n-> %% '

# コマンド実行前と実行後の時間を出力
export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

function show_command_end_time() {
  PREV_COMMAND_END_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} -         "
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd show_command_end_time

show_command_begin_time() {
  NEXT_COMMAND_BGN_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} - ${NEXT_COMMAND_BGN_TIME}"
  zle .accept-line
  zle .reset-prompt
}
zle -N accept-line show_command_begin_time

# cdの後にlsを実行
chpwd() { ls -ltrG  }

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# customize
function paste-as-yank() {
    pbpaste
}
zle -N paste-as-yank
bindkey "^y" paste-as-yank

function peco-history-selection() {
    BUFFER=`\\history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# kubernetes's config
source <(kubectl completion zsh)
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# compression config
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
