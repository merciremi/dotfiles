#!/bin/zsh

# Rename a `target` file to `target.backup`
# if the file exists && is an actual file - not just a symlink.
backup() {
  target=$1
  # -e => True if file exists (regardless of type).
  if [ -e "$target" ]; then
    # ! => True if the condition is false
    # -L => True if file exists && is a symbolic link.
    if [ ! -L "$target" ]; then
      mv "$target" "$target.backup"
      echo "-----> Moved the old $target config file to $target.backup"
    fi
  fi
}

# Symlinking files from /dotfiles in root
symlink() {
  file=$1
  link=$2
  if [ ! -e "$link" ]; then
    echo "-----> Symlinking your new $link"
    ln -s $file $link
  fi
}

echo "First step => Backup-ing and symlinking configuration files"

# For all files `$name` in the present folder except `*.sh`, `README.md`, `settings.json`,
# and `config`, backup the target file located at `~/.$name` and symlink `$name` to `~/.$name`
for name in aliases gemrc gitconfig gitignore irbrc rspec zprofile zshrc; do
  if [ ! -d "$name" ]; then
    echo "Currently working on $name"
    target="$HOME/.$name"
    backup $target
    symlink $PWD/$name $target
  fi
done

echo "Second step => Installing zsh-syntax-highlighting"

# Install zsh-syntax-highlighting plugin
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "-----> Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting
fi
cd "$CURRENT_DIR"

echo "Third step => Setting-up Sublime Text."

# Setup Sublime as the global core editor (MAC only)
if [[ `uname` =~ "Darwin" ]]; then
  git config --global core.editor "subl -n -w $@ >/dev/null 2>&1"
  echo 'export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"' >> zshrc
fi

# Define Sublime Text path
if [[ ! `uname` =~ "Darwin" ]]; then
  SUBL_PATH=~/Library/Application\ Support/Sublime\ Text\ 3
fi

# Install Package Control, favourite packages and settings
mkdir -p $SUBL_PATH/Packages/User $SUBL_PATH/Installed\ Packages
backup "$SUBL_PATH/Packages/User/Preferences.sublime-settings"
subl --command "install_package_control"
ln -s $PWD/Preferences.sublime-settings $SUBL_PATH/Packages/User/Preferences.sublime-settings
ln -s $PWD/Package\ Control.sublime-settings $SUBL_PATH/Packages/User/Package\ Control.sublime-settings

echo "Fourth step => Configure SSH"

# Symlink SSH config file to my personal `config` file for macOS
# Add SSH passphrase to the keychain
if [[ `uname` =~ "Darwin" ]]; then
  target=~/.ssh/config
  backup $target
  symlink $PWD/config $target
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519
fi

echo "Fifth step => Configure work-related github identity."

if [ ! -d "$HOME/code/" ]; then
  mkdir -p $HOME/code/merciremi/perso/ $HOME/code/merciremi/work/
  touch $HOME/code/merciremi/work/.gitconfig_include
  echo "# Please write your work-related user information for Github (name, work email)" >> $HOME/code/merciremi/work/.gitconfig_include
fi

# Reload the current terminal with the newly installed configuration.
exec zsh

email=$(gh api user/emails | jq -r '.[].email')
echo "The mail email associated with the /merciremi folder is $email"

echo "✅ Move on to git setup."
