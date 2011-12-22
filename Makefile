
CWD=`pwd`

help:
	@echo "USAGE:"
	@echo "make update                               Updates all of the submodules within the project"
	@echo "make clean                                Cleans out all of the generated code within a submodule (mainly docs/tags)"
	@echo "make pathogen                             Updates the pathogen bundle"
	@echo "make commandt                             Runs the rake make task on command-t to compile the module"
	@echo "make add_bundle name=<bundle-name>        Symlinks a bundle from bundle_storage to the bundle directory"
	@echo "make add_snippet name=<snippet-name>      Symlinks a snippet from snippet_storage to the snippet directory"
	@echo "make remove_bundle name=<bundle-name>     Removes a bundle symlink from the bundle directory"
	@echo "make remove_snippet name=<snippet-name>   Removes a snippet symlink from the snippet directory"
	@echo "make install                              Installs the default set up of Bit Theory's Vim configuration"
	@echo "make themes                               Copies the themes directory of Terminal themes to the User's Desktop"

update:
	@git submodule foreach git checkout master
	@git submodule foreach git clean -f
	@git submodule foreach git pull --rebase
	@git status

clean:
	@git submodule foreach git checkout master
	@git submodule foreach git clean -f
	@git status

pathogen:
	curl -so $(CWD)/home/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

commandt:
	cd $(CWD)/home/.vim/bundle_storage/command-t/ && rake make && cd -

add_bundle:
	@ln -sv $(CWD)/home/.vim/bundle_storage/$(name) $(CWD)/home/.vim/bundle/$(name)

add_snippet:
	@ln -sv $(CWD)/home/.vim/snippets_storage/$(name).snippets $(CWD)/home/.vim/snippets/$(name).snippets

remove_bundle:
	@echo "The remove_bundle task has not been setup"

remove_snippet:
	@rm -v $(CWD)/home/.vim/snippets/$(name).snippets

install: themes
	@./install

themes:
	@cp -rv themes $(HOME)/Desktop/

.PHONY: help update clean pathogen add_bundle add_snippet remove_bundle remove_snippet install themes

