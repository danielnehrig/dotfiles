brew cleanup
chsh -s /bin/sh $(whoami)
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
rm -rf ~/.zshrc
rm -rf ~/.tmux.conf
rm -rf ~/.vim
rm -rf ~/.vimrc
mv ~/.dot-backup/.vimrc ~/.vimrc
mv ~/.dot-backup/.vim ~/.vim
mv ~/.dot-backup/.zshrc ~/.zshrc
mv ~/.dot-backup/.tmux.conf ~/.tmux.conf
