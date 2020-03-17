zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format $'\e[38;5;247m => %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true


autoload -Uz bashcompinit compinit promptinit colors
bashcompinit
compinit
promptinit
colors

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"

HISTSIZE=10000000
SAVEHIST=10000000

plugins=(
  git
)

# User configuration
bindkey -e
bindkey '^[[1;3D' emacs-backward-word
bindkey '^[[1;3C' emacs-forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line


setopt prompt_subst
setopt promptsubst
setopt promptpercent

autoload colors; colors;

local return_code="%(?..%{$fg[red]%}%? ↵ %{$reset_color%})"

local user_host='%{$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[blue]%}%~%{$reset_color%}'

PROMPT='$(zsh_prompt)'
#RPROMPT="%(?..%{$fg[red]%}%? ! %{$reset_color%})%{$fg_bold[black]%}$(hostname)  %T%{$reset_color%}"

local return_code="%(?..%{$fg[red]%}-> %?\n)"
local color_separator="\e[38;5;243m"
local separator="%{$reset_color$color_separator%}//%{$reset_color%}"
local time="%{$fg[yellow]%}%T"
local user_host="%{$fg[green]%}%n@%m"
local current_dir="%{$fg[blue]%}%~"

function git_info() 
{
    local ref=$(git symbolic-ref HEAD 2> /dev/null)
    local attached=true
    if [[ -z "$ref" ]]; then
        ref=$(git rev-parse --short HEAD 2> /dev/null)
        attached=false
    fi

    if [[ -n "$ref" ]]; then

        echo -n "$separator "

        local repo="$(git rev-parse --show-toplevel)"
        local cwd="$(pwd)"

        if [[ "$repo" = "$cwd" ]]; then
            cwd=$cwd/
        fi

        if [[ "$attached" = false ]]; then
            echo -n "%{$fg[red]%}"
        elif [[ "$(git status --porcelain)" != "" ]]; then
            echo -n "%{$fg[yellow]%}"
        else
            echo -n "%{$fg[green]%}"
        fi

        # Repository name @ branch
        #echo -n "[${ref#refs/heads/}] $(basename "$repo")"
        echo -n "${ref#refs/heads/}"
        #window_title="${window_title} [${ref#refs/heads/}]"

        # Internal path (relative to repository root)
        #echo -n "%{$fg[blue]%}${cwd#$repo}"
    fi
}


function zsh_prompt()
{
    local line="%{$fg_bold[green]%(?..$fg_bold[red])%} ▎"
    window_title="${USER}@$(hostname): ${PWD}"
    echo -n "\n"

    echo -n "%(?..$line %?\n)"

    # Current working directory
    echo -n "$line $time $separator $user_host $separator $current_dir $(git_info) "

    echo -n "$separator $(cat ~/.watson-prompt 2>/dev/null)"
    
    echo -n "\n"

    # Shell $ prompt sign
    echo -n "$line %{$reset_color%}€ "

    # Bell and window title set
    echo -n "%{\a\e]0;$window_title\a%}"
}

function preexec()
{
    cmd=$(echo "$2" | tr -d '\000-\037')
    echo -n "\e]0;${USER}@$(hostname): ${PWD} $ $cmd\a"
}

export LANG=en_US.UTF-8

export EDITOR='nvim'

export PATH="$PATH:/usr/local/sbin/:$HOME/bin"
alias vim="nvim"

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GOPATH=/Users/vincent/go
export PATH=$GOPATH/bin:$PATH

export VULKAN_SDK=$HOME/Code/vulkansdk-macos-1.1.101.0/macOS
export PATH=$VULKAN_SDK/bin:$PATH
export DYLD_LIBRARY_PATH=$VULKAN_SDK/lib:$DYLD_LIBRARY_PATH
export VK_ICD_FILENAMES=$VULKAN_SDK/etc/vulkan/icd.d/MoltenVK_icd.json
export VK_LAYER_PATH=$VULKAN_SDK/etc/vulkan/explicit_layer.d

fortune -s | boxes -a c -d parchment
echo "\n"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/Code/nrf9160/ncs/zephyr/zephyr-env.sh

alias ls='lsd'

alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias w='watson'

watson() {
  /usr/local/bin/watson "$@" && ~/bin/watson-prompt.sh
}

. $HOME/.nix-profile/etc/profile.d/nix.sh

alias yeet="rm"

export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

