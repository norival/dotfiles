# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd noextendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/xavier/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# start tmux
# if [ "$TMUX" = "" ]; then tmux; fi
#
if [ -z "$TMUX" ]
then
    tmux attach -t shell || tmux new -s shell
fi


# complete aliases
setopt COMPLETE_ALIASES
# complete sudo command
zstyle ':completion::complete:*' gain-privileges 1

bindkey -M viins 'jk' vi-cmd-mode

# source aliases
source $HOME/.aliases

# source /usr/share/git/completion/git-prompt.sh
# source /usr/lib/zsh-git-prompt/zshrc.sh
source /usr/share/zsh/scripts/git-prompt.zsh

fpath=(~/newdir $fpath)

# git prompot configuration
# GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWUPSTREAM="verbose"
# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_STATESEPARATOR=" | "
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_HIDE_IF_PWD_IGNORED=1
# GIT_PS1_SHOWCOLORHINTS=1

ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}+"

# prompt command configuration
# PROMPT_COMMAND='__git_ps1 "[\[\033[001;$color\]\u@\h \[\033[00m\]\[\033[01;34m\]\W\[\033[00m\]" "]\$ "'

# PROMPT='[ %B%F{$COLOR}%n@%m%f %F{blue}%2~%b%f $(gitprompt)]%(!.#.$) '
PROMPT='[ %B%F{yellow}%n@%m%f %F{blue}%40<...<%~%b%f $(gitprompt)]%(!.#.$) '
# autoload -U promptinit; promptinit
# prompt spaceship

export TERMINAL="/usr/bin/alacritty"
export EDITOR="/usr/bin/nvim"
export BROWSER=firefox-developer-edition
export R_LIBS_USER="~/.R/lib"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export SYSTEMD_EDITOR="nvim"
export LEDGER_FILE=~/finance/cmmc.journal

# search in history
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# FZF config
# if type rg &> /dev/null; then
#   export FZF_DEFAULT_COMMAND='rg --files'
#   export FZF_DEFAULT_OPTS='-m --height 50% --border'
# fi

# SSH agent auto start
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 12h > /home/xavier/.local/run/ssh-agent.env
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source /home/xavier/.local/run/ssh-agent.env >/dev/null
fi
