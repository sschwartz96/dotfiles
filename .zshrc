#
# ~/.zshrc 
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

########## zsh stuff ########## 
autoload -U colors && colors

# auto complete

# add custom directory
fpath=(~/dotfiles/zsh_completition/ $fpath)
setopt auto_cd
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # corrects capitalization
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # includes hidden files

# Vi mode
bindkey -v
export KEYTIMEOUT=1 # changes the lag time switching mode
# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
			echo -ne '\e[1 q'

		elif [[ ${KEYMAP} == main ]] ||
			[[ ${KEYMAP} == viins ]] ||
			[[ ${KEYMAP} = '' ]] ||
			[[ $1 = 'beam' ]]; then
					echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# zsh syntax highlighting and auto suggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history)
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
#history
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

##########  END zsh stuff ########## 


########## aliases ########## 
alias vim='nvim'
alias tmux='tmux -u'
# arch-based
alias pi='sudo pacman -S'
alias pr='sudo pacman -Rs'
alias pu='sudo pacman -Syu'
alias pq='sudo pacman -Ss'
# void 
alias xi='sudo xbps-install -S'
alias xu='sudo xbps-install -Su'
alias xr='sudo xbps-remove'
alias xq='sudo xbps-query -R -s' 
# alacritty
alias ala='alacritty'
# lsd
alias ls='lsd --group-dirs first'
alias l='lsd -l --group-dirs first'
alias la='lsd -a --group-dirs first'
alias lla='lsd -la --group-dirs first'
alias lt='lsd --tree --group-dirs first'
# etc
alias file-explorer='thunar'
alias lg='lazygit'
alias lzd='lazydocker'
alias gdifft='GIT_EXTERNAL_DIFF=difft git diff'
alias gd='godo'
alias hx='helix'
########## END aliases ########## 


########## variables ########## 
export PS1='%n:%1d$ '

# path additions
export PATH=$PATH:~/bin
export PATH=$PATH:~/go/bin			# used for vim-go
export PATH=$PATH:~/bin/dart-sass
export PATH=$PATH:~/bin/robo3t/bin
export PATH=$PATH:~/bin/discord
export PATH=$PATH:~/github.com/flutter/bin
export PATH=$PATH:~/bin/android-studio/bin
export PATH=$PATH:~/bin/android-studio/jre
export PATH=$PATH:~/Android/Sdk/cmdline-tools/latest/bin
#for python-pip
export PATH=$PATH:/home/sam/.local/bin
export PATH=$PATH:/home/sam/github.com/protobuf.dart/protoc_plugin/bin
# for pnpm packages
export PATH=$PATH:/home/sam/.local/share/pnpm/
# for dart pub executable tools
export PATH="$PATH":"$HOME/.pub-cache/bin"
# for c# / .net
export PATH="$PATH:/home/sam/.dotnet/tools"
# for go
export PATH=$PATH:/usr/local/go/bin
# for my personal scripts
export PATH=$PATH:~/scripts/
# rust local bin
export PATH=$PATH:~/.cargo/bin/
# for neovim-nightly
export PATH=$PATH:~/bin/nvim-linux64/bin

# VARIABLES 
export MYVIMRC="~/.config/nvim/init.lua"
export MYCOCRC="~/.config/nvim/coc-settings.json"
export MOPS=~/projects/m-ops.org
# export GOREP=~/go/src/github.com/sschwartz96
export GO111MODULE=on
export SYNCAPOD_OLD=~/go/src/github.com/sschwartz96/syncapod
export SYNCAPOD=~/projects/syncapod
export BROWSER="/usr/bin/firefox"
# export TERM="xterm-256color"
export EDITOR="nvim"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# for android-studio, prevent blank startup
export _JAVA_AWT_WM_NONREPARENTING=1
# for sdkmanager
export JAVA_HOME=~/bin/android-studio/jbr
# for debug on android device
export NO_PROXY=localhost,127.0.0.1
# for flutter web development
export CHROME_EXECUTABLE=google-chrome-stable
# for flutter linux development
export CMAKE_CXX_COMPILER=/usr/bin/g++
# dart sdk
export DART_SDK=~/github.com/flutter/bin/cache/dart-sdk/bin
# pnpm
export PNPM_HOME="/home/sam/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# manpage to use bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# enables touchpad support for firefox
export MOZ_USE_XINPUT2=1

# used by rofi-connman to center the window
export ROFI_COMMAND="rofi -dmenu -no-fixed-num-lines -no-custom -i -p"

# use difft as the default git diff viewer
export GIT_EXTERNAL_DIFF="difft"

export TZ='America/Chicago'

# used to prevent fzf-lua delay within neovim
export ESCDELAY="1"

########## END variables ########## 

# fzf
#export FZF_DEFAULT_COMMAND="find -L" # finds hidden files too
# export FZF_DEFAULT_COMMAND="rg --files hidden --no-ignore --iglob '!{node_modules,.git,.ccls-cache}'"
export FZF_DEFAULT_COMMAND="fd --type f -E node_modules -E .git"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

autoload -U +X bashcompinit && bashcompinit

# rust config
source "$HOME/.cargo/env"

source /home/sam/.config/broot/launcher/bash/br

## [Completion]
# 
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/sam/.dart-cli-completion/zsh-config.zsh ]] && . /home/sam/.dart-cli-completion/zsh-config.zsh || true

# task (Taskfile)
eval "$(task --completion zsh)"


# docker completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

## [/Completion]


# pnpm
export PNPM_HOME="/home/sam/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
