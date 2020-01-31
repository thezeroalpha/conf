# conf - a personal configuration manager
## Installation
1. Download the `conf` script, make it executable, and put it in your `$PATH`.
2. Set value of `$DOTFILES` to the location of your dotfiles, either in the environment, or in the `conf` script itself.
3. Set up your dotfiles hierarchy in any way you want.
3. Put a map file in the root of $DOTFILES.
   This file defines how your dotfiles/folders map to other locations in your filesystem.
   By default, the file is named "dot.map", but this can be changed by manually editing the script.
4. Use `conf`, and profit, maybe. Run `conf -h` or `conf -man` to get help.

## FAQ
### How do you write a map file?
This is easier by example.

If you have a dotfile directory hierarchy that looks like this:

```
~/dotfiles
├── dot.map
├── shell
│   ├── zprofile
│   └── zshrc
└── vim
│   ├── after
│   │   └── ftplugin
│   ├── autoload
│   └── vimrc
└── tools
    ├── lfrc
    └── polybar
        └── config

```

Then the `dot.map` file listed in the `dotfiles` directory might look like this:

```map
# All file/directory names are relative to the value of the $DOTFILES variable, which is set in the environment
#  or explicitly inside the `conf` script itself.
shell:
- zprofile: ~/.zprofile
- zshrc: ~/.zshrc

vim:
- after/ftplugin: ~/.vim/after/ftplugin
- autoload: ~/.vim/autoload
- vimrc: ~/.vimrc

tools/lfrc: ~/.config/lf/lfrc
tools:
- polybar:
  -- config: ~/.config/polybar/config
```

And would result in the following symbolic links:

* `~/.zprofile` pointing to `~/dotfiles/shell/zprofile`
* `~/.zshrc` pointing to `~/dotfiles/shell/zshrc`
* `~/.vim/after/ftplugin` pointing to `~/dotfiles/vim/after/ftplugin`
* `~/.vim/autoload` pointing to `~/dotfiles/vim/autoload`
* `~/.vimrc` pointing to `~/dotfiles/vimrc`
* `~/.config/lf/lfrc` pointing to `~/dotfiles/tools/lfrc`
* `~/.config/polybar/config` pointing to `~/dotfiles/tools/polybar/config`

### Why would you make _another_ dotfiles manager?
Valid question, there's so many dotfile managers already available.
Why do I think I'm so special that none of the existing ones are good enough?

Well, a few points about this manager:

* It manages your dotfiles, and does nothing else.
  It doesn't have git integration, it doesn't do any smart tracking, it doesn't replace your toilet paper - it just manages links between your configuration and the various configuration directories around your system.
  You want git actions? Use git.
* It reads its configuration from a single, plain-text file that can be named whatever you want.
* It uses a configuration syntax that's intuitive _for me_.
* It leverages the filesystem structure for simpler configuration.
* It essentially runs anywhere out of the box.

All this to make a dotfiles manager that works exactly the way I want it to work.

### Why Perl?
Because:

* It's ubiquitous.
* It's a step up from shell script in data structures, readability, maintainability, abstractions, etc.
* It's still low level enough to work with the shell and filesystem, unlike e.g. Python.
  If I want to test for a file's existence, I can use `-e`, like in Bash.
  Symlink functions are available without having to import anything.
* It's powerful for text manipulation, because it has regex built straight into the language.
* It's still quite fast.
  In fact, it's super fast, compared to my previous version written in Bash.
  On my computer, the "list all" operation is at least five times faster, and "check all" is at least seven times faster.
