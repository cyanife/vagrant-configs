# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOME=`/home/vagrant`
pacman -Syu --noconfirm

# Installs
pacman -S --noconfirm base-devel libutil-linux 

pacman -S --noconfirm tmux git vim
pacman -S --noconfirm lua subversion unzip
pacman -S --noconfirm python-pip

pacman -S --noconfirm zsh 

# my dotfile setup
if [ ! -d ~/dotfiles ]; then
  git clone https://github.com/cyanife/dotfiles.git ~/dotfiles
  chown -R vagrant:vagrant ~/dotfiles

  zsh ~/dotfiles/zsh/bootstrap.sh

  ln -s ~/dotfiles/zsh/.zshrc.local ~/.zshrc.local
  touch ~/.zshrc
  touch ~/.zlogout
  echo "[ -f ~/.zshrc.local ] && source ~/.zshrc.local" >> ~/.zshrc
  echo 'print -P "%F{33}▓▒░ %F{160}Exiting...%f"' >> ~/.zlogout
  echo 'print -P "%F{33}▓▒░ %F{220}type %F{82}'h' %F{220}for vagrant command help%f"' >> ~/.zlogout
  mkdir ~/share
  chown vagrant:vagrant share/
fi
