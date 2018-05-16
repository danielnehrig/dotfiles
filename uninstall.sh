brew cask cleanup
brew cleanup
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
chsh -s /bin/sh $(whoami)
rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.vim
rm ~/.vimrc
mv ~/.dot-backup/.vimrc ~/.vimrc
mv ~/.dot-backup/.vim ~/.vim
mv ~/.dot-backup/.zshrc ~/.zshrc
mv ~/.dot-backup/.tmux.conf ~/.tmux.conf
