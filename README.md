<!-- todo: clean first draft, add fav configuration for mac  -->

How to make a fresh install on a new mac.

## Command Line Tools

### 1) `xcode-select`

The command `xcode-select --install` is used to install the [Command Line Tools package](https://mac.install.guide/commandlinetools/8) for Xcode on a macOS system. This package includes essential tools such as git, make, and clang, which are necessary for compiling software and performing various development tasks directly from the command line.

In a new terminal, install xcode:

```bash
xcode-select --install
```

If you receive the following message, you can just skip this step and go to next step.

```bash
# command line tools are already installed, use "Software Update" to install updates
```

Otherwise, it will open a window asking you if you want to install some software: click on "Install" and wait.

![Install xcode-select on macOS](https://github.com/lewagon/setup/raw/master/images/macos_xcode_select_install.png)

:heavy_check_mark: If you see the message "The software was installed".

:x: If the command `xcode-select --install` fails try again: sometimes the Apple servers are overloaded.

:x: If you see the message "Xcode is not currently available from the Software Update server", you need to update the software update catalog:

```bash
sudo softwareupdate --clear-catalog
```

Once this is done, you can try to install again.

## Homebrew

The main package manager is [Homebrew](http://brew.sh/).

Open a terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

This will ask for your confirmation (hit `Enter`) and your **macOS user account password** (the one you use to [log in](https://support.apple.com/en-gb/HT202860) when you reboot your Macbook).

:warning: When you type your password, nothing will show up on the screen, **that's normal**. This is a security feature to mask not only your password as a whole but also its length. Just type your password and when you're done, press `Enter`.

:warning: If you see this warning :point_down:, run the two commands in the `Next steps` section to add Homebrew to your PATH:

![macOS Homebrew installation warning](https://github.com/lewagon/setup/raw/master/images/macos_homebrew_warning.png)

```bash
# ⚠️ Only execute these commands if you saw this warning ☝
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

If you already have Homebrew, it will tell you so, that's fine, go on.

Then install some useful software:

```bash
brew update
```

If you get a `/usr/local must be writable` error, just run this:

```bash
sudo chown -R $USER:admin /usr/local
```

> The command sudo chown -R $USER:admin /usr/local changes the ownership of the /usr/local directory and its contents to the current user and the admin group. Here's a detailed breakdown of what each part of the command does:
> - sudo: Runs the command with superuser (root) privileges, necessary for modifying system directories.
> - chown: The command used to change the ownership of files and directories.
> - -R: The recursive option, which means the command will apply to all files and subdirectories within /usr/local.
> - $USER: An environment variable that represents the current user's username.
> - admin: The group name. This sets the group ownership to admin.
> - /usr/local: The target directory whose ownership is being changed.

```bash
brew update
```

Proceed running the following in the terminal (you can copy / paste all the lines at once).

Git.
```bash
brew upgrade git || brew install git
```

[GitHub command-line tool](https://cli.github.com/).
```bash
brew upgrade gh || brew install gh
```

Wget is a [free software package for retrieving files using HTTP, HTTPS, FTP and FTPS](https://www.gnu.org/software/wget/).
```bash
brew upgrade wget || brew install wget
```

Imagemagick: [Tools and libraries to manipulate images in many formats](https://imagemagick.org/index.php).
```bash
brew upgrade imagemagick || brew install imagemagick
```

[Command-line JSON processor](https://jqlang.github.io/jq/).
```bash
brew upgrade jq || brew install jq
```

OpenSSL: [Cryptography and SSL/TLS Toolkit](https://openssl.org/).
```bash
brew upgrade openssl || brew install openssl
```

## Submime Text

### Installation

Install command for [Sublime Text](https://www.sublimetext.com/).

```bash
  brew install --cask sublime-text
```

Then launch Sublime by running the following command in your terminal:

```bash
  subl
```

✔️ If Sublime opens, you're good to go 👍.

If not, good luck, but look at symlinks first.

You can check the [Community Documentation](https://docs.sublimetext.io/reference/) for evereything you need to know.

### Extensions

TODO: Extensions are currently installed in `install.sh` (lines ~97-100).

May be have a script file just for Sublime.

## macOS Terminal Theme

First download [Catpuccin theme](https://github.com/merciremi/catpuccin_terminal.app)(personal fork).

Launch a terminal, click on `Terminal > Preferences` and set the "Macchiato" theme as default profile.

Other specs:
  - Font size: 13
  - Cursor: underline NOT blinking (bah!)
  - Window size: columns 140, rows 40

**Quit and restart** your terminal.


## Oh-my-zsh

Let's install the `zsh` plugin [Oh My Zsh](https://ohmyz.sh/).

In a terminal execute the following command:

```bash
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If asked "Do you want to change your default shell to zsh?", press `Y`

At the end your terminal should look like this:

![Ubuntu terminal with OhMyZsh](images/oh_my_zsh.png)

## GitHub CLI

Use [GitHub CLI](https://cli.github.com/) to interact with GitHub directly from the terminal.

It should already be installed on your computer from the previous commands.

First in order to **login**, copy-paste the following command in your terminal:

:warning: **DO NOT edit the `email`**

```bash
gh auth login -s 'user:email' -w
```

gh will ask you few questions:

`What is your preferred protocol for Git operations?` With the arrows, choose `SSH` and press `Enter`. SSH is a protocol to log in using SSH keys instead of the well known username/password pair.

`Generate a new SSH key to add to your GitHub account?` Press `Enter` to ask gh to generate the SSH keys for you.

If you already have SSH keys, you will see instead `Upload your SSH public key to your GitHub account?` With the arrows, select your public key file path and press `Enter`.

`Enter a passphrase for your new SSH key (Optional)`. Type something you want and that you'll remember. It's a password to protect your private key stored on your hard drive. Then press `Enter`.

`Title for your SSH key`. You can leave it at the proposed "GitHub CLI", press `Enter`.

You will then get the following output:

```bash
! First copy your one-time code: 0EF9-D015
- Press Enter to open github.com in your browser...
```

Select and copy the code (`0EF9-D015` in the example), then press `Enter`.

Your browser will open and ask you to authorize GitHub CLI to use your GitHub account. Accept and wait a bit.

Come back to the terminal, press `Enter` again, and that's it.

To check that you are properly connected, type:

```bash
gh auth status
```

:heavy_check_mark: If you get `Logged in to github.com as <YOUR USERNAME> `, then all good :+1:

## Dotfiles (Standard configuration)

Personal dotfiles is located at [`merciremi/dotfiles`](https://github.com/merciremi/dotfiles).

Open your terminal and set a variable for your GitHub username:

```bash
export GITHUB_USERNAME=`gh api user | jq -r '.login'`
```

```bash
echo $GITHUB_USERNAME
```

:heavy_check_mark: You should see your GitHub username printed.

:warning: Please note that this variable is only set for the time your terminal is open. If you close it before or during the next steps, you need to set it again with the two steps above!

Time to clone the repo:

```bash
mkdir -p ~/code/$GITHUB_USERNAME && cd $_
```

```bash
gh repo clone merciremi/dotfiles
```

### Dotfiles installer

Run the `dotfiles` installer:

```bash
cd ~/code/$GITHUB_USERNAME/dotfiles
```

```bash
zsh install.sh
```

Check the emails registered with your GitHub Account. You'll need to pick one at the next step:

```bash
gh api user/emails | jq -r '.[].email'
```

:heavy_check_mark: If you see the list of your registered emails, you can proceed :+1:

:x: If not, please [reauthenticate to GitHub](https://github.com/lewagon/setup/blob/master/macos.md#github-cli) before running this command :point_up: again.

### git installer

Run the `git` installer:

```bash
cd ~/code/$GITHUB_USERNAME/dotfiles && zsh git_setup.sh
```

:point_up: This will **prompt** you for your name (`FirstName LastName`) and your email.

:warning: You **need** to put one of the email listed above thanks to the previous `gh api ...` command. If you don't do that, Kitt won't be able to track your progress.

Please now **reset** your terminal by running:

```bash
exec zsh
```

## rbenv

Let's install [`rbenv`](https://github.com/sstephenson/rbenv), a software to install and manage `ruby` environments.

First, we need to clean up any previous Ruby installation you might have:

```bash
rvm implode && sudo rm -rf ~/.rvm
# If you got "zsh: command not found: rvm", carry on. It means `rvm` is not
# on your computer, that's what we want!

sudo rm -rf $HOME/.rbenv /usr/local/rbenv /opt/rbenv /usr/local/opt/rbenv
```

:warning: This command may prompt for your password.

:warning: When you type your password, nothing will show up on the screen, **that's normal**. This is a security feature to mask not only your password as a whole but also its length. Just type your password and when you're done, press `Enter`.

In the terminal, run:

```bash
brew uninstall --force rbenv ruby-build
```

```bash
exec zsh
```

Then run:

```bash
brew install rbenv
```

## Ruby

### Installation

Now, you are ready to install the latest [ruby](https://www.ruby-lang.org/en/) version and set it as the default version.

Run this command, it will **take a while (5-10 minutes)**

```bash
rbenv install 3.1.2
```

Once the ruby installation is done, run this command to tell the system
to use the 3.1.2 version by default.

```bash
rbenv global 3.1.2
```

**Reset** your terminal and check your Ruby version:

```bash
exec zsh
```

Then run:

```bash
ruby -v
```

:heavy_check_mark: If you see something starting with `ruby 3.1.2p` then you can proceed :+1:

### Installing some gems

In your terminal, copy-paste the following command:

```bash
gem install colored faker http pry-byebug rake rails rest-client rspec rubocop-performance
```

:heavy_check_mark: If you get `xx gems installed`, then all good :+1:

:x: If you encounter the following error:

```bash
ERROR: While executing gem ... (TypeError)
incompatible marshal file format (can't be read)
format version 4.8 required; 60.33 given
```

Run the following command:
```bash
rm -rf ~/.gemrc
```

Rerun the command to install the gems.

:warning: **NEVER** install a gem with `sudo gem install`! Even if you stumble upon a Stackoverflow answer (or the terminal) telling you to do so.


## Node.js - Optionnal

[Node.js](https://nodejs.org/en/) is a JavaScript runtime to execute JavaScript code in the terminal. Let's install it with [nvm](https://github.com/nvm-sh/nvm), a version manager for Node.js.

In a terminal, execute the following commands:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
```

```bash
exec zsh
```

Then run the following command:

```bash
nvm -v
```

You should see a version. If not, ask a teacher.

Now let's install node:

```bash
nvm install 16.15.1
```

When the installation is finished, run:

```bash
node -v
```

If you see `v16.15.1`, the installation succeeded :heavy_check_mark: You can then run:

```bash
nvm cache clear
```

:x: If not, **contact a teacher**


## yarn

[`yarn`](https://yarnpkg.com/) is a package manager to install JavaScript libraries. Let's install it:

In a terminal, run the following commands:

```bash
npm install --global yarn
```

```bash
exec zsh
```

Then run the following command:

```bash
yarn -v
```

:heavy_check_mark: If you see a version, you're good :+1:

:x: If not, **ask for a teacher**


## Databases: pick only what you need

### SQLite

In a few weeks, we'll talk about databases and SQL. [SQLite](https://sqlite.org/index.html) is a database engine used to execute SQL queries on single-file databases. Let's install it:

In a terminal, execute the following commands:

```bash
brew install sqlite
```

Then run the following command:

```bash
sqlite3 -version
```

:heavy_check_mark: If you see a version, you're good :+1:


### PostgreSQL

Sometimes, SQLite is not enough and we will need a more advanced tool called [PostgreSQL](https://www.postgresql.org/), an open-source robust and production-ready database system.

Let's install it now.

Run the following commands:

```bash
brew install postgresql@15 libpq
brew link --force libpq
```

```bash
brew services start postgresql@15
```

Once you've done that, let's check that it worked:

```bash
psql -d postgres
```

You should you see a new prompt like this one :point_down:

```bash
psql (15.2)
Type "help" for help.

postgres=#
```

:heavy_check_mark: If this is the case, type `\q` then `Enter` to quit this prompt. You're good to go :+1:

## Check-up

⚠️ TODO: adapt le Wagon's check file for my own usage.

Let's check if you successfully installed everything.

In you terminal, run the following command:

```bash
exec zsh
```

Then run:

```bash
curl -Ls https://raw.githubusercontent.com/lewagon/setup/master/check.rb > _.rb && ruby _.rb && rm _.rb || rm _.rb
```

:heavy_check_mark: If you get a green `Awesome! Your computer is now ready!`, then you're good :+1:

## macOS settings

### Security

It is mandatory that you protect your session behind a password.If it is not already the case, go to ` > System Preferences > Users & Groups` and change your account password. You should also go to ` > System Preferences > Security > General`. You should require a password `5 seconds` after sleep or screen saver begins.

You can also go to ` > System Preferences > Mission Control` and click on the `Hot Corners` button at the bottom left. Choose for the bottom right corner to start the screen saver. That way, when you leave your desk, you can quickly lock you screen by putting your mouse in the bottom right corner. 5 seconds after, your Macbook will be locked and will ask for a password to get back on the session.

### Keyboard

As you become a programmer, you'll understand that leaving the keyboard takes a lot of time, so you'll want to minimize using the trackpad or the mouse. Here are a few tricks on macOS to help you do that.

#### Keyboard speed

Go to ` > System Preferences > Keyboard`. Set `Key Repeat` to the fastest position (to the right) and `Delay Until Repeat` to the shortest position (to the right).

#### macOS For hackers

[Read this script](https://github.com/mathiasbynens/dotfiles/blob/master/.macos) and cherry-pick some stuff you think will suit you. For instance, you can type in the terminal this one:

```bash
# Expanding the save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save screenshots to the Desktop (or elsewhere)
defaults write com.apple.screencapture location "${HOME}/Desktop"

# etc..
```

### Pin apps to your dock

You are going to use most of the apps you've installed today really often. Let's pin them to your dock so that they are just one click away!

To pin an app to your dock, launch the app, right-click on the icon in the taskbar to bring up the context menu and choose "Options" then "Keep in Dock".

![How to pin an app to the taskbar in macOS](images/macos_dock.png)

You must pin:
- File explorer
- Browser
- Sublime
- Terminal
- Slack and other communication tools
- Email
- Keymapp

## Setup completed!

## Optional steps

- Alternative to defunkt GoToDefinition: https://packagecontrol.io/packages/SublimeCodeIntel (almost 2m downlaods)



Sometimes, you need more for a new job / project.

jmalloc
MacOS

brew install jemalloc

Redis
MacOS

brew install redis

Mimemagic
MacOs

brew install shared-mime-info

Rails setup

    Git clone
    Execute bundle install

Run rails db:setup

Credentials

Some non-sensitive credentials are stored in secrets.yml. Sensitive credentials such as API key are fetch from environment variables.

To share these env vars in our team, we use Doppler. Install the Doppler CLI Ask for your Doppler token.
Without .env

Add to your env var your Doppler Token: export DOPPLER_TOKEN="your_token" Then, run the app prefixed with doppler run -- Ex: doppler run -- bundle exec rails c
With .env

⚠️ Your current .env will be overwritten.

Run DOPPLER_TOKEN="your_token" doppler secrets download --no-file --format=env >| .env

Webhooks development

To test webhooks locally, you can use ngrok.

ngrok http 3000
