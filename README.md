# jwilger's dotfiles #

## Credit to Thoughtbot ##

This setup is using [Thoughtbot's dotfiles
project](https://github.com/thoughtbot/dotfiles.git) as its starting point,
although I've chosen to just modify things in place rather than using their
approach of having a `~/dotfiles-local` shadow directory for personal
configuration. If you are looking for a starting point for your own
git-managed configuration, you should probably start with their stuff rather
than my fork.

## Requirements ##

Set zsh as your login shell:

    chsh -s $(which zsh)

## Install ##

Clone onto your laptop:

    git clone git://github.com/jwilger/dotfiles.git ~/dotfiles

Install [rcm](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Install the dotfiles:

    env RCRC=$HOME/dotfiles/rcrc rcup

After the initial installation, you can run `rcup` without the one-time variable
`RCRC` being set (`rcup` will symlink the repo's `rcrc` to `~/.rcrc` for future
runs of `rcup`). [See
example](https://github.com/jwilger/dotfiles/blob/master/rcrc).

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

* Exclude the `README.md` and `LICENSE` files, which are part of
  the `dotfiles` repository but do not need to be symlinked in.
* Give precedence to personal overrides which by default are placed in
  `~/dotfiles`
* Please configure the `rcrc` file if you'd like to make personal
  overrides in a different directory


## Update ##

From time to time you should pull down any updates to these dotfiles, and run

    rcup

to link any new files and install new vim plugins. **Note** You _must_ run
`rcup` after pulling to ensure that all files in plugins are properly installed,
but you can safely run `rcup` multiple times so update early and update often!

## zsh Configurations ##

Additional zsh configuration can go under the `~/dotfiles/zsh/configs`
directory. This has two special subdirectories: `pre` for files that must be
loaded first, and `post` for files that must be loaded last.

For example, `~/dotfiles/zsh/configs/pre/virtualenv` makes use of various
shell features which may be affected by your settings, so load it first:

    # Load the virtualenv wrapper
    . /usr/local/bin/virtualenvwrapper.sh

Setting a key binding can happen in `~/dotfiles/zsh/configs/keys`:

    # Grep anywhere with ^G
    bindkey -s '^G' ' | grep '

Some changes, like `chpwd`, must happen in
`~/dotfiles/zsh/configs/post/chpwd`:

    # Show the entries in a directory whenever you cd in
    function chpwd {
      ls
    }

The `~/dotfiles/zshrc.local` is loaded after
`~/dotfiles/zsh/configs`.

## vim Configurations ##

Similarly to the zsh configuration directory as described above, vim
automatically loads all files in the `~/dotfiles/vim/plugin` directory. This
does not have the same `pre` or `post` subdirectory support that our `zshrc`
has.

This is an example `~/dotfiles/vim/plugin/c.vim`. It is loaded every time vim
starts, regardless of the file name:

    # Indent C programs according to BSD style(9)
    set cinoptions=:0,t0,+4,(4
    autocmd BufNewFile,BufRead *.[ch] setlocal sw=0 ts=8 noet
