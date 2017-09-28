#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

distro() {
  arch=$(uname -m)
  kernel=$(uname -r)
  if [ -f /etc/lsb-release ]; then
    os=$(lsb_release -is)
  elif [ -f /etc/debian_version ]; then
    os="Debian"
  elif [ -f /etc/redhat-release ]; then
    os="RedHat"
  else
    os="$(uname -s) $(uname -r)"
  fi
}


install_homebrew() {
  # Only install on OS X
  if [[ $platform == 'Darwin' ]]; then
    # Only install if not already installed
    if [[ ! -e /usr/local/bin/brew ]]; then
      echo "Installing homebrew"
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      echo "Not installing homebrew as it is already installed"
    fi
  else
    echo "Not installing homebrew as this is not an OS X machine"
  fi
}


install_fish() {
  echo "Installing fish"
  $install fish
}


install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
      git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    # The zsh executable is not installed, so install it
    $install zsh  
    # Then redo this function to get oh-my-zsh
    install_zsh
  fi
}


install_pandoc () {
  echo "Installing pandoc"
  $install pandoc
}


###################################################################
# Start script here
###################################################################
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc bash_profile \
  zshrc oh-my-zsh \
  vimrc vim \
  tmux.conf \
  hammerspoon \
#  atom \
  config
"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file ~/dotfiles_old/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Get the platform so we can do different things depending on our OS
platform=$(uname);
echo "Detected platform $platform"

# Set the package install command depending on the platform/distro
if [[ $platform == "Darwin" ]]; then
  install_homebrew
  install="brew install"
elif [[ $platform == "Linux" ]]; then
  # Try to detect distribution
  distro
  echo "Detected distribution $os"
  case $os in 
    Ubuntu)
      install="sudo apt-get install"
      ;;
    Debian)
      install="sudo apt-get install"
      ;;
    Centos)
      install="sudo yum install"
      ;;
    *)
      echo "Unknown distribution - can't automatically install packages"
      exit 1
      ;;
  esac
else
  echo "Unknown platform - can't automatically install packages"
  exit 1
fi

#install_fish
install_zsh
