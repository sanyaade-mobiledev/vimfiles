# Mode Set's Vim Configuration

The default configuration files for Vim used at Mode Set. Tuned to play nice with [MacVim][macvim] and Apple's Terminal but works with most \*nix environments. Setup using [homesick][homesick] for that symlinkn' goodness.


## To Get The Full Effect

Mode Set peops, double check, but you most likely already have the basic requirements installed on your machine.

- [Homebrew][homebrew] - `ruby -e "$(curl -fsSL https://gist.github.com/raw/323731/install_homebrew.rb)"`
- [MacVim][macvim] - `brew install macvim`
- [Homesick][homesick] - `gem install homesick`
- [discount][discount] - `brew install discount `
- [ctags][ctags] - `brew install ctags `

[MacVim][macvim] is not a requirement as the majority of the files work in most \*nix environments including Terminal. It's recommended to use [Homebrew's][homebrew] package of [MacVim][macvim], as it compiles MacVim and Vim at 64 bit with Ruby, Python, Perl, installs the command line link `mvim`, plus a bunch of other goodness. [Homesick][homesick] is required for easy management of dot files with the repository. The [discount][discount] executable is recommended for converting markdown files to html for previewing. The [ctags][ctags] executable is helpful for tagbar (jumping between files) and omni completion.


## Installation

To install the files and default configuration run the following:

    homesick clone git@github.com:bit-theory/vimfiles.git
    cd ~/.homesick/repos/vimfiles
    make install
    homesick symlink vimfiles -f

\* If you don't have commit rights use `homesick clone https://github.com/bit-theory/vimfiles.git`

This will install the default configuration files/directories, submodules, and create symbolic links for bundles. Most of the heavy lifting is done by the [install script][install]. This will also install a `themes` directory on your Desktop. Import these into Terminal for color goodness.

At this point you should have a default setup ready to rock. You're going to want to tune it a bit to your environment, so go forth and "Pimp Your Ride".


## Pimp Your Ride

The `install` script created a `.vimrc.local` file. This stores local configurations based on the user's needs, it is loaded after the `.vimrc` file. Anything created in `.vimrc.local` overrides settings set in `.vimrc`. This file is ignored and not checked back into the repository. It's recommended you keep a backup of this somewhere. If you already have an existing `.vimrc.local` file, the installation will not overwrite it.

You'll want to tune a few settings right off the bat. Open the `.vimrc.local` file (in Vim type `,evl` a mnemonic is "*edit vimrc local*").

1. Uncomment `g:yankring_history_dir` and optionally change it's path, otherwise `yankring` will save it's history in a file in your `$HOME` directory
- Optional, point `g:MarkdownPreviewUserStyles` to the directory where your user specific style sheets for the markdown previewer reside.
- Give yourself a signature with `g:snips_author` by including your name for various [snipmate][snipmate] snippets
- Optionally uncomment one of the `colorschemes`, there are a few included as described below, the default is `colorblind`
- It's recommended to uncomment the entire conditional under *User GUI specific settings*. We roll with the [custom font MesloGM][MesloGM] at 12px. You'll need to download and install it, otherwise roll with Monaco or something if you want to go blind. If you want to set a transparency, you'll need to enable *Use experimental renderer* in MacVim's preferences -> Advanced settings. The primary reason for uncommenting this conditional is, you'll find certain plug-ins need to be disabled or have certain settings applied to work across MacVim and various \*nix environments.

You can apply custom key bindings in `.vimrc.local`, configure plug-ins, or override default settings.


## Updating

Submodule plug-ins generate `doc/tag` files associated with help documents every time Vim is launched. This creates conflicts associated with pulling, updating or committing changes back to the main repository. It's necessary to clean these out before running any pulls or commits.

There are two `make targets` included to help in this process `make clean` and `make update`.

Run `make help` for more information.


### Updating From The Mode Set Repository

To update from the latest changes in the Mode Set repository run the following:

1. Quit out of Vim
- `cd path/to/vimfiles/`
- `make clean`
- `git stash` or `git add` any updates from your environment spit out by the `make clean` call to `git status`
- `git pull --rebase`

Commit your changes back up to the repository.


### Updating Submodules

To pull upstream changes for all of the submodules run the following:

1. Quit out of Vim
- `cd path/to/vimfiles/`
- `make update`
- `git stash` or `git add` any updates from your environment spit out by the `make update` call to `git status`
- `git pull --rebase`

Commit your changes back up to the repository. Mode Set will run this script once a week to keep the submodules as up to date as possible.


## Plug-Ins

Plug-ins are managed using [pathogen][pathogen]. All submodule plug-ins are stored in the `bundle_storage` directory and are not available to Vim until they are symlinked to the `bundle` directory. The `bundle` directory is ignored by the repository allowing custom configurations on a per install basis. To activate a plug-in run:

    make add_bundle name=<bundle-name>

You'll need to restart Vim for the changes to take effect.


### Adding New Plug-Ins As Submodules

New plug-ins need to be added to the `bundle_storage` directory and should be treated as submodules. To add a new one run:

    git submodule add <remote_repository> <home/.vim/bundle_storage/bundle-name.vim>
    git submodule init
    git submodule update
    make add_bundle name=<bundle-name>

Test it out and if it's a keeper, add it to the repository, add it to the list below with a quick description and tell the world about it's greatness.

[Vim Scripts][vim-scripts] has an enormous amount of repositories for all sorts of plug-ins. However, if the original author has their own github repository, try to clone from there instead.


### Removing Submodules

1. Delete the relevant line from the `.gitmodules` file
- Delete the relevant section from `.git/config`
- Run `git rm --cached path_to_submodule` (**no trailing slash!!**)
- Remove the symbolic link from `bundle`
- Remove the directory from `bundle_storage`
- Remove any descriptions from the `README.md` file


### Default Plug-Ins

The [install script][install] created initial symbolic links for the plug-ins listed below. These are primarily file type oriented plus a few must haves. You can disable any of these by removing the symbolic link, but it would be a lot cooler if you didn't.

- [ack.vim](https://github.com/mileszs/ack.vim/blob/master/doc/ack.txt)
- [actionscript.vim](https://github.com/vim-scripts/actionscript.vim--Leider)
- [applescript.vim](https://github.com/vim-scripts/applescript.vim)
- [cocoa.vim](https://github.com/msanders/cocoa.vim/blob/master/doc/cocoa.txt)
- [coffeescript.vim](https://github.com/kchmck/vim-coffee-script)
- [cucumber.vim](https://github.com/tpope/vim-cucumber)
- [delimitMate.vim](https://github.com/Raimondi/delimitMate)
- [fugitive.vim](https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt)
- [gist.vim](https://github.com/mattn/gist-vim)
- [haml.vim](https://github.com/tpope/vim-haml)
- [html5.vim](https://github.com/othree/html5.vim)
- [indexed-search.vim](https://github.com/vim-scripts/IndexedSearch)
- [jade.vim](https://github.com/vim-scripts/jade.vim)
- [javascript.vim](https://github.com/pangloss/vim-javascript)
- [json.vim](https://github.com/vim-scripts/JSON.vim)
- [markdown-preview.vim](https://github.com/mkitt/markdown-preview.vim/blob/master/doc/markdown-preview.txt)
- [markdown.vim](https://github.com/tpope/vim-markdown)
- [mustache.vim](https://github.com/juvenn/mustache.vim)
- [nerdcommenter.vim](https://github.com/scrooloose/nerdcommenter/blob/master/doc/NERD_commenter.txt)
- [nerdtree.vim](https://github.com/scrooloose/nerdtree/blob/master/doc/NERD_tree.txt)
- [processing.vim](https://github.com/vim-scripts/Processing)
- [rails.vim](https://github.com/tpope/vim-rails/blob/master/doc/rails.txt)
- [repeat.vim](https://github.com/tpope/vim-repeat)
- [ruby.vim](https://github.com/vim-ruby/vim-ruby/tree/master/doc)
- [rvm.vim](https://github.com/tpope/vim-rvm)
- [snipmate.vim](https://github.com/msanders/snipmate.vim/blob/master/doc/snipMate.txt)
- [statline.vim](https://github.com/millermedeiros/vim-statline/blob/master/doc/statline.txt)
- [stylus.vim](https://github.com/wavded/vim-stylus)
- [supertab.vim](https://github.com/ervandew/supertab/blob/master/doc/supertab.txt)
- [surround.vim](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt)
- [syntastic.vim](https://github.com/scrooloose/syntastic/blob/master/doc/syntastic.txt)
- [tabular.vim](https://github.com/godlygeek/tabular/blob/master/doc/Tabular.txt)
- [tagbar.vim](https://github.com/majutsushi/tagbar/blob/master/doc/tagbar.txt)
- [unimpaired.vim](https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt)
- [yankring.vim](https://github.com/chrismetcalf/vim-yankring/blob/master/doc/yankring.txt)


### Additional Plug-Ins

These are the additional plug-ins included, but are not required. They are not linked to the `bundle` directory out of the box. If adding any of these, make sure to read the docs on their usage and what variables/settings may be required in `.vimrc.local`

- [argtextobj.vim](https://github.com/vim-scripts/argtextobj.vim) - Motion commands for manipulating function arguments \*\*
- [autocomplpop.vim](https://github.com/vim-scripts/AutoComplPop/blob/master/doc/acp.txt) - Live completion as you type, this can slow Vim down, but is useful in certain situations
- [autocorrect.vim](https://github.com/vim-scripts/autocorrect.vim) - Corrects misspellings as you type i.e. teh -> the \*\*
- [browser-refresh.vim](https://github.com/mkitt/browser-refresh.vim/blob/master/doc/browser-refresh.txt) - refresh the running browser with a key command
- [bufkill.vim](https://github.com/vim-scripts/bufkill.vim) - Unload, delete or wipe a buffer
- [bundler.vim](https://github.com/tpope/vim-bundler) - Lightweight wrapper around bundler
- [camelcasemotion.vim](https://github.com/vim-scripts/camelcasemotion/blob/master/doc/camelcasemotion.txt) - Motion commands for moving between camelCase or words\_with\_underscores \*\*
- [clang-complete.vim](https://github.com/Rip-Rip/clang_complet://github.com/Rip-Rip/clang_complete) - Use clang for completing C/C++ code.
- [colorsel.vim](https://github.com/vim-scripts/colorsel.vim/blob/master/doc/colorsel.txt) - Interactive RGB/HSV color selector
- [css-color.vim](https://github.com/skammer/vim-css-color) - Highlights colors within css files
- [eunuch.vim](https://github.com/tpope/vim-eunuch) - Vim sugar for the UNIX shell commands that need it the most
- [gundo.vim](https://github.com/vim-scripts/Gundo/blob/master/doc/gundo.txt) - Graph Vim's undo tree so it is actually usable
- [html-autoclose.vim](https://github.com/vim-scripts/HTML-AutoCloseTag) - Automatically closes HTML tags, doesn't play well with the delimitMate plugin
- [lusty-juggler.vim](https://github.com/vim-scripts/LustyJuggler) - Enables a window for navigating through open buffers
- [ragtag.vim](https://github.com/tpope/vim-ragtag/blob/master/doc/ragtag.txt) - Ghetto XML/HTML mappings
- [specky.vim](https://github.com/vim-scripts/Specky/blob/master/doc/specky.txt) - Plug-in for testing Ruby code with RSpec
- [speeddating.vim](https://github.com/tpope/vim-speeddating/blob/master/doc/speeddating.txt) - Use CTRL-A/CTRL-X to increment dates, times, and more
- [taglist.vim](https://github.com/vim-scripts/taglist.vim/blob/master/doc/taglist.txt) Deprecated in favor of the tagbar plugin
- [tailminusf.vim](https://github.com/vim-scripts/TailMinusF/blob/master/doc/tailminusf.txt) - Watch the contents of a file in real time

**\*\* - Recommended!**


## Snippets

By default all of the snippet files stored within `snippets_storage` are symlinked into the `snippets` directory. These cover most of the languages used at Mode Set. To see the available snippets for a given file type hit `<F5>`, a snippet is triggered using `<tab>`.

Certain file types like JavaScript have hundreds of snippets based on the native language and various libraries. This can become unmanageable pretty quickly. The solution is to breakout specific libraries into their own files. For example `javascript-jasmine.snippets` where it needs to be named as `language-library.snippets`. Since snippets are saved in the `snippets_storage` directory, you can be selective about what gets a symbolic link within the `snippets` directory.

If you are working in a project that includes jQuery, you would only have symbolic links created for `javascript.snippets`, `javascript-jasmine.snippets`, and `javascript-jquery.snippets`. Another project that uses [node.js][node], you could delete the symbolic link to `javascript-jquery.snippets` and add in `javascript-node.snippets` instead. This will give you a more manageable list of snippets to work with. By default, all snippets are included at installation, you'll want to tune these based on your needs.

To learn more about [snipmate][snipmate] and creating snippets, type `:h snipmate`

There are two `make` targets included to streamline this. If you want to add a snippet run the following:

    make add_snippet name=javascript-jquery

If you want to quickly remove a snippet, run:

    make remove_snippet name=javascript-jquery

Note there is no trailing `.snippets` to the `name=` arguments. This is by design and the targets will append this for you.

You'll need to restart Vim for the snippets to take affect.


## Syntax Checkers

The configuration uses [syntastic][syntastic] quite heavily, most of it is out of the box. Buffers are checked after each save.

To close the syntastic error window type: `<leader>lc`

The JavaScript syntax checker runs [JSHint][jshint] instead of jsl which is included with [syntastic][syntastic]. The executable to [JSHint][jshint] runs on [node.js][node] and needs to be installed via [npm][npm]. Also install the custom configuration JSON file into your `$HOME` directory. Instructions for doing this are located at the [jshintrc][jshintrc] repository. This installation will make it global to your machine. If you need a specific configuration on a per project basis, just drop a `.jshintrc` file in your project directory and tweak the settings.

There is also an Objective C checker included. This uses the `gcc` and requires the `cwd` to have the `.xcodeproj` file in it.

To learn more about [syntastic][syntastic] and syntax checkers, type `:h syntastic`


## Editor Themes

Themes included with this configuration:

1. `bloodshot`: Similar to colorblind but with muted colors
- `cataracts`: Grey background with muted colors
- `colorblind`: Black background, super vibrant colors (Default)
- `snowblind`: White background, vibrant colors
- `solarizeddk`: Mode Set tuned [solarized][solarized] dark colors
- `solarizedlt`: Mode Set tuned [solarized][solarized] light colors

In the `themes` directory are Terminal themes to match the Vim color themes. Install these.

To use the Terminal themes, install [SIMBL](http://www.culater.net/software/SIMBL/SIMBL.php) and save the [64 Bit Terminal Colors](http://github.com/timmfin/terminalcolours) plug-in to:

    ~/Library/Application Support/SIMBL/Plugins/


The color themes have been designed with similarities in the syntax settings. Jumping between multiple languages should be easy on the mind and the eyes. Be adventurous and mix it up once in a while.

**Most themes use the custom [MesloGM font](https://github.com/andreberg/Meslo-Font). Download, install and live the dream.**


## Tips


### MSCheat

Within Vim type `:h mscheat` to view key and leader bindings for the Mode Set configuration.


### Makefile

There are a bunch of targets in the `Makefile` to make life easier, run `make help` for more information.


### Turn Caps Lock Into The Control Key

The control key is in an awkward position and the caps lock key is basically useless. It's right there in the home row, so you might as well put it to good use.

1. Open up System Preferences
- Select `Keyboard`
- Select `Modifier Keys`
- From the drop down, select `^ Control` under the `Caps Lock` setting
- In the `Select Keyboard` drop down, you'll want to set it for both internal and external keyboards


### Alias MacVim

1. Launch [MacVim][macvim] from Terminal by typing `mvim` and hitting enter
- Right click the logo in your dock and select `Options > Show in Finder`
- Create an alias of `MacVim.app` and drop it in the `/Applications/` directory (this will allow it to be found by Spotlight)
- Optionally choose to keep the icon in your dock `Options > Keep in Dock`


### Alias MacVim's install of Vim For Terminal

Fire up your `.bashrc`, `.zshrc` or wherever your aliases are and add the following:

    alias vim='/usr/local/Cellar/macvim/v<version-number>/MacVim.app/Contents/MacOS/Vim'

Your path may be different depending on the latest version from [homebrew][homebrew].

Once you point the alias to [MacVim's][macvim] Vim executable, you should be able to run plug-ins and crap that depend on ruby, python and so on. While you won't get all the niceties of the gui app, you'll at least have a similar install for your Terminal as what's in [MacVim][macvim].


### Mouse Support For Terminal

To get full mouse support (scrolling, clicking, etc...) within Terminal Vim, install the SIMBL [MouseTerm](http://bitheap.org/mouseterm/) plug-in. It brings the goodness.


### Working With Your Own Submodules

In order to keep your personal submodules available to forks but allow commits back to the upstream master repository from within the submodule:

1. Create the repository for your bundle within git
-  Then from the `vimfiles` directory add the submodule as you would any other submodule
-  Within your newly created submodule, create a remote reference to the upstream master repository
-  Make changes to the submodule and push updates back to the remote upstream master
-  Then whenever you pull updates to all of your submodules, you as well as everyone else should get the changes

Here is an example:

    cd ~/.homesick/repos/vimfiles/
    git submodule add git://github.com/username/submodule-name.vim.git home/.vim/bundle_storage/submodule-name.vim
    cd home/.vim/bundle_storage/submodule-name.vim/
    git remote add push git@github.com:username/submodule-name.vim.git
    git submodule init
    git submodule update
    make add_bundle name=<bundle-name>

Then whenever you make changes to the submodule:

    cd ~/.homesick/repos/vimfiles/home/.vim/bundle_storage/submodule-name.vim/
    git push push master

This allows you to make changes directly in your submodule, see the effects and push the changes back without maintaining multiple repositories and linking them back and forth. [Defunkt][defunkt] has a good article about [working with submodules][defunkt-subs].


## License and Contributions

All licensing for the Bundles/Plug-ins should be found in their respective repositories. Anything written by Mode Set is of course open source through MIT. While contributions are welcome, you're probably better off forking and tuning it to your own machine.

Copyright (c) 2012 by Mode Set

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


<!-- link ids -->
[macvim]: http://code.google.com/p/macvim/
[homebrew]: http://github.com/mxcl/homebrew
[homesick]: http://github.com/technicalpickles/homesick
[node]: http://nodejs.org/
[ctags]: http://ctags.sourceforge.net/
[discount]: http://www.pell.portland.or.us/~orc/Code/discount/
[vim-scripts]: https://github.com/vim-scripts
[install]: https://github.com/bit-theory/vimfiles/blob/master/install
[syntastic]: https://github.com/scrooloose/syntastic
[snipmate]: https://github.com/msanders/snipmate.vim
[pathogen]: https://github.com/tpope/vim-pathogen
[MesloGM]: https://github.com/andreberg/Meslo-Font
[defunkt]: http://github.com/defunkt
[defunkt-subs]: http://github.com/guides/developing-with-submodules
[node]: http://nodejs.org/
[npm]: http://npmjs.org/
[jshint]: http://jshint.com/
[jshintrc]: https://github.com/bit-theory/jshintrc
[solarized]: http://ethanschoonover.com/solarized
