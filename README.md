# ema-pe dotfiles

**Author:** Emanuele Petriglia

## Table of Contents

- [What they are](#what-they-are)
- [Requirements](#requirements)
- [Installation](#installation)
  - [Dotfiles installation](#dotfiles-installation)
  - [Repository installation](#repository-installation)
- [Modules](#modules)
  - [bash](#bash)
  - [bin](#bin)
  - [bluetooth](#bluetooth)
  - [clean](#clean)
  - [dotfiles](#dotfiles)
  - [firefox](#firefox)
  - [focuswriter](#focuswriter)
  - [font](#font)
  - [git](#git)
  - [gpg](#gpg)
  - [gtk](#gtk)
  - [icon](#icon)
  - [lightdm](#lightdm)
  - [packages](#packages)
  - [python](#python)
  - [thunar](#thunar)
  - [tlp](#tlp)
  - [vim](#vim)
  - [xfce4](#xfce4)
  - [xfce4-keyboard-shortcuts](#xfce4-keyboard-shortcuts)
  - [xfce4-terminal](#xfce4-terminal)
  - [xfwm4](#xfwm4)
  - [youtube-dl](#youtube-dl)
- [Makefile](#makefile)
- [License](#license)

## What they are

This repository contains some dotfiles, scripts and configurations that I use every day. 

The git repository is available online on both [GitLab](https://gitlab.com/ema-pe/dotfiles) and [GitHub](https://github.com/ema-pe/dotfiles). However, GitHub is a **read-only mirror** of GitLab. 

> **Warning:** As of August 2025, the dotfiles are partially deprecated. I have started rewriting them, as well as the installation script. 

## Requirements

These dotfiles can be used on any operating system, because they are just configuration files, it depends on what you are looking for.  I use a simple Bash script, called `dotfiles`, that automatically installs all dotfiles and it sets up my computer to be ready to use.  This script is specifically created to work with **Fedora** and it is tailored to my needs, so you may not like it or it won't work on your system.

Scripts under the `bin` directory are written to work with any operating system with Bash, GAWK or Python. 

## Installation

### Dotfiles installation

My dotfiles are organized as modules.  A module is a Bash script that can do any things, it can: 

* Run commands (eg. `dnf`, `curl` or `wget`);
* Install configuration files (usually by linking them);
* Manage services (via systemd).

If you want to install a module, you need to run:  `dotfiles install <module>`. With `dotfiles list` you can get a list of available modules.

Note that a module may be not have a dedicated subdirectory (as example the module `gtk` doesn't have `gtk` directory).

### Repository installation

You can directly download this repository and run the `dotfiles` script: 

```bash
$ git clone git@gitlab.com:ema-pe/dotfiles.git ~/. dotfiles
```

Or, if you don't have SSH keys installed: 

```bash
$ git clone https://gitlab.com/ema-pe/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./dotfiles install gpg git
$ # install gpg keys... 
$ git remote set-url origin git@gitlab.com:ema-pe/dotfiles.git
```

If you want to update git submodule to last commit, run this command:

```bash
git submodule foreach git pull origin master
```

If there are new commits, you also need to commit this update. 

## Modules

### bash

These modules simply link my bash configuration, that consists of a `bashrc` and `bash_profile` file. It contains essential environment variables, aliases and small scripts. 

It also provides some autocompletion scripts for `dotfiles` script and other custom scripts.

---

### bin

This module install all scripts in [`bin`](bin) directory to `~/.local/bin`. These scripts are written in various programming languages (Python, Bash) and they can require special software or libraries to run.  Always read the entire script before use! 

Scripts that I no longer use are archived in a [special repository](https://gitlab.com/ema-pe/archived-scripts) on GitLab.

Available scripts:

* [**backup**](bin/backup): this script syncs some data from my laptop to my external HDD.
* [**firefox-tmp**](bin/firefox-tmp): this script launches a temporary Mozilla Firefox instance (useful for testing or debugging).
* [**gandi-aliases**](bin/gandi-aliases): this script manages aliases for my email hosted on [Gandi. net](https://www.gandi.net/en).
* [**odt2adoc**](bin/odt2adoc): a small Python script that extracts text from an OpenDocument file to a pure text file.
* [**open-gpxsee**](bin/open-gpxsee): a small Python script to open `gpxsee` with GPX files according to the location of the first point (Rome or Milan).
* [**screen-off**](bin/screen-off): this simple script turns off the screen. 

---

### bluetooth

This module just disables Bluetooth service via systemd, because it is enabled by default on Fedora. 

---

### clean

This module just removes via `dnf` all pre-installed Fedora packaged that I don't use. For a list of these packages, open the script and go to the `clean` module.

---

### dotfiles

This module installs the `dotfiles` script to `~/.local/bin` folder. It is supposed that this path is added previously to `PATH` environment variable.

---

### firefox

I use Mozilla Firefox as my main browser. I like it because is privacy focused, fast and work really well in Linux.  It is a big and complex software, it is not easy to customize it. 

#### Manual installation process

Unfortunately Firefox needs to be customized from GUI instead on CLI, so there is not a real installer script. The steps to take are:

1. Open a new terminal window and run this command:  `firefox --ProfileManager`.
2. Create a new user with this name: `default-release`.
3. Login to Firefox Sync (or download all extensions you want).
4. Customize Firefox GUI. 
5. To set custom `user.js`, run my installer script. 

> **Important:** You need to create the default profile before run `dotfiles` script! 

#### Extensions

Extensions can't be installed from command line, so you need to install them manually (or use [Firefox Sync](https://www.mozilla.org/en-US/firefox/features/sync/)). I use these extensions:

* [**CanvasBlocker**](https://addons.mozilla.org/en-US/firefox/addon/canvasblocker/): prevent Canvas fingerprinting;
* [**CSS Exfil Protection**](https://addons.mozilla.org/en-US/firefox/addon/css-exfil-protection/): prevent CSS Exfil attacks;
* [**Decentraleyes**](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/): local emulation of CDN;
* [**HTTPS Everywhere**](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/): force HTTPS on sites;
* [**Tridactyl**](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/): VIM keybindings on Firefox;
* [**uBlock Origin**](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/): general AD blocker;
* [**Neat URL**](https://addons.mozilla.org/en-US/firefox/addon/neat-url/): remove garbage from URLs;
* [**Containerise**](https://addons.mozilla.org/en-US/firefox/addon/containerise/): automatically open websites in a container;
* [**Add custom search engine**](https://github.com/evilpie/add-custom-search-engine): add custom search engine. 

All these extensions are automatically updated via Firefox, so you only need to download them the first time.

#### Custom user.js

The `user.js` file is a file with all options to customize Firefox behavior. Many options can be selected from the graphical interface, but lots are hidden. 

I use [ghacks' `user.js`](https://github.com/ghacksuserjs/ghacks-user. js), an `user.js` enhanced for privacy.  I don't like some options, so I have also a custom [`user.js`](firefox/user.js) that overrides some options.

This module will download the latest version of ghacks' `user.js` and move that file to the Firefox profile with suffix `default-release`. At the end it appends my custom options to `user.js` file on the profile.

---

### focuswriter

[FocusWriter](https://gottcode.org/focuswriter) is a simple, distraction free text editor.  I use it to write short stories and novels, with a custom theme and configuration.

This modules will install `focuswriter`, and copy my configuration and custom theme. 

> **Warning:** My custom theme and configuration have my username hard-coded! 

---

### font

This module installs Hack font on the system, but it doesn't activate it. 

---

### git

This module installs `git` and links the configuration. 

---

### gpg

I use GnuPG to manager my PGP keys. GnuPG have also an agent called `gpg-agent`, I use it also for SSH support.  There is some configuration because out-of-the-box Fedora uses `ssh-agent` and `gnome-keyring`.

The GnuPG file configuration is located at `~/.gnupg/gpg.conf`, the agent configuration is located at `~/.gnupg/gpg-agent.conf`. This module installs them. 

There is a default daemon enabled of `gpg-agent`, but I prefer to manage the daemon with `systemd --user`. Luckily GnuPG comes with default files for systemd, but they are not enabled.  This module enables them.

The module also enables `gpg-agent` for SSH support.  It is necessary to specify the environment variable `SSH_AUTH_SOCK` to point to `gpg-agent` socket.  This line is already added in my custom `.bashrc` file:

```bash
export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent. ssh"
```

I use Xfce as desktop environment.  There is only one problem: it auto starts `ssh-agent`. I don't want it, so I kill it every time Xfce is started.  This line is already added in my custom `.bash_profile` file:

```bash
pkill ssh-agent
```

This module also installs `pinentry-gtk`, because I don't like the default installed that uses ncurses.

---

### gtk

This module just installs and activate Arc-Dark GTK theme.

---

### icon

This module just installs and activate `papirus-icon-theme` icon theme.

---

### lightdm

[LightDM](https://github.com/canonical/lightdm) is a desktop manager easy to use, flexible and lightweight. I use it simply because it is pre-installed on Fedora. 

I prefer an auto login method because the disk is encrypted and the computer have only one user.  I do not want to type two password when I boot the computer, and the second is useless because if someone find the disk password he can grab the data without problems.  A display manager is also useless in my case because I have only one user, but I keep it to have a "modern" desktop. 

> **Important:** **DO NOT LOCK THE SCREEN**. If you lock the screen and go back to the greeter, it crashes.  I don't know why. 

---

### packages

This module adds RPM Fusion repository and install lots of application that I use and are not installed by default on Fedora.  They are: 

* pass:  a command line password manager that uses `git` and `gpg`;
* thunderbird: a graphical email client;
* vlc: THE video player;
* telegram-desktop: a Telegram client. 
* ffmpeg: the swiss-knife tool for audio and video. 
* gpxsee: a GUI to see GPX tracks on maps. 
* ImageMagick: the must have to handle images.
* hledger: a tool to manage accounting. 
* syncthing: sync data between devices.
* ShellCheck: linter for Bash scripts.
* libheif-tools: tools to handle HEIC file images. 

---

### python

This module just installs the package `python3-docs`, because it is not installed by default on Fedora.  I prefer to have offline documentation because the search function is faster than the online version, and it can be used without Internet connection.

---

### thunar

This module installs, via `xfconf-query`, my Thunar configuration. Note that if you change the configuration via Thunar GUI, the new configuration will not be synched to dotfiles.  You need to manually update the configuration! 

I use some custom send-to actions, they are basically a wrapper to the original scripts: 

* [**osmgpx**](xfce4/Thunar/send-to/osmgpx. desktop): a shortcut to [`osmgpx`](bin/osmgpx) script. 

---

### tlp

TLP is a useful package to manage power and extends battery life. It works well with other power management software (like `xfce4-powermanager`).

This package can be found via Fedora official repository with the name `tlp`.

The default configuration file, located on `/etc/default/tlp` is good, but I've done some customization (I'm using a Thinkpad laptop).

The basic commands available are:

* Start tlp: `sudo tlp start` (but there is also a unit file for systemd);
* Check the configuration: `sudo tlp stat`;
* Manage Wi-Fi and Bluetooth: `wifi [on/off]` and `bluetooth [on/off]`.

This module will install tlp, copy my configuration, start tlp and enable the unit file (for systemd).

---

### vim

I use VIM as my text editor for programming and writing. I found it very productive and efficient. 

My [vimrc](vim/vimrc) file is well documented, I also use some plugins: 

* [**goyo. vim**](https://github.com/junegunn/goyo.vim): for writing without distractions. 
* [**papercolor-theme**](https://github.com/NLKNguyen/papercolor-theme): a VIM color scheme inspired by Google's Material Design.
* [**python-syntax**](https://github.com/hdima/python-syntax): better Python syntax highlighting.
* [**vim-pencil**](https://github.com/reedes/vim-pencil): better movements for writing prose.
* [**vim-syntax-extra**](https://github.com/justinmk/vim-syntax-extra): better C syntax highlighting. 
* [**SimplylFold**](https://github.com/tmhedberg/SimpylFold): better Python folding. 
* [**redact_pass**](https://git.zx2c4.com/password-store/tree/contrib/vim): improve security when editing a password file with VIM.  It requires `pass` package. 
* [**vim-asciidoctor**](https://github.com/habamax/vim-asciidoctor): better Asciidoc syntax highlighting and also support for folding.

Both **goyo.vim** and **vim-pencil** are not automatically started with VIM, instead you need to run `vim -c Writing`.

---

### xfce4

This modules installs my configuration of Xfce desktop environment.  Some applications, like `xfce4-terminal` or `thunar` are configured by a different module.

It is difficult to configure Xfce applications, because they do not use a plain text configuration, instead they use `xfconf`.

This modules install my `xfce4-panel` configuration, font and size settings for GTK applications and `xfce4-desktop`.

---

### xfce4-keyboard-shortcuts

This module installs my custom application shortcuts to Xfce.  It is a distinct module because I change often these keybindings.  These are the shortcuts (for an updated list always check the source code! ):

* _Super + v_: `vlc`
* _Super + r_: `xfce4-appfinder --disable-server --collapsed`
* _Super + u_: `xfce4-taskmanager`
* _Super + e_: `xfce4-terminal --drop-down`
* _Super + t_: `xfce4-terminal --maximize`
* _Super + l_: `screen-off`
* _Shift + Print_: `xfce4-screenshooter --window`
* _Primary + Print_: `xfce4-screenshooter --region`
* _Alt + Print_: `xfce4-screenshooter --region`
* _Print_: `xfce4-screenshooter --fullscreen`
* _Super + s_: `telegram-desktop`
* _Super + f_: `thunar`
* _Super + x_: `mousepad`
* _Super + q_: `firefox-tmp`
* _Super + w_:  `firefox`
* _Super + m_: `thunderbird`
* _Super + r_: `xfce4-appfinder --collapsed`

---

### xfce4-terminal

This module installs my custom theme, but it doesn't activate it. Other settings are not touched.

---

### xfwm4

I use Thinble Xfwm theme.  In my repository under [xfwm4](xfwm4) diretory you can find the theme, but the original project is hosted on [DevianArt](https://paldepind.deviantart.com/art/Thinble-362276066). The following text is copied from DevianArt. 

Thinble is a Xfwm theme with no title bar and a thin border. It was created to be a good looking, simple and space efficient window theme for people who mainly manage their windows using key bindings.

#### Features

* Minimal and space efficient appearance;
* No large title bar that is otherwise mostly just wasting space;
* Border of a reasonable size for moving/resizing windows using the mouse;
* Slightly darker border on active windows for distinguishing between them an inactive windows;
* Uses colors from your GTK-theme.

#### Installation

Copy [`xfwm4/thinble`](xfwm4/thinble) directory to `~/.themes` for local installation or to `/usr/share/themes` for system-wide installation. Or better use my installer script!

> **Important:** Make the title font very large, otherwise you might still be able to see the top of it in what is left of the title bar which does not look nice at all.

---

### youtube-dl

This module downloads and installs a version of youtube-dl called [yt-dlp](https://github.com/yt-dlp/yt-dlp), a fork with update extractors.

## Makefile

I also provide a custom [Makefile](Makefile) file to lint all scripts in my repository. You need some special software, such as `shellcheck` to lint Bash script or `flake8` to lint Python scripts.

This Makefile is executed on Gitlab CI, to run locally type `make all`. You can also specify with file to lint, with `make` + `TAB`.

## License

Every script is licensed under the [MIT License](LICENSE).
