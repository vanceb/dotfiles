# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

#export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
   #export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias atom='/Users/vance/.atom/atom'
if [[ -f /usr/local/bin/nvim ]]; then
  alias vim='/usr/local/bin/nvim'
elif [[ -f /usr/bin/nvim ]]; then
  alias vim='/usr/bin/nvim'
fi
alias ctags='/usr/local/bin/ctags'
alias mvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
#
# Set my default user name
DEFAULT_USER=vance
#
# Set Vi mode as the default line editing mode
bindkey -v
# Map jj to escape to match my Vim settings
bindkey -M viins 'jj' vi-cmd-mode
# enable incremental history search
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
bindkey -M isearch '^R' history-incremental-pattern-search-backward
bindkey -M isearch '^F' history-incremental-pattern-search-forward
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# remove delay in switching between Vi modes (May need to increase this number if we see sideeffects)
export KEYTIMEOUT=20

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Arm Tools
if [[ -d /Users/vance/mbed-toolchain/gcc-arm/bin ]]; then
  export PATH=/Users/vance/mbed-toolchain/gcc-arm/bin:$PATH
fi

# Brew...
# Ensure user-installed binaries take precedence
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH

# Python specific settings
# Require pip to only install python packages in a virtualenv...
#export PIP_REQUIRE_VIRTUALENV=true
# Create a command that explicitly allows installation in the global environment
#gpip(){
#   PIP_REQUIRE_VIRTUALENV="" pip "$@"
#}
if [[ -f /usr/local/bin/python2 ]]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
elif [[ -f /usr/bin/python ]]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
fi
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi
export WORKON_HOME=~/Virtualenvs

# GPG 2.1.x SSH support
# See : http://incenp.org/notes/2015/gnupg-for-ssh-authentication.html
gpgconf --launch gpg-agent
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vance/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/vance/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vance/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/vance/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
