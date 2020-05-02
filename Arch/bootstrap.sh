# during provisioning ~ or $HOME seems to be /root so we need to fix that
export HOMEPATH='/home/vagrant'
pacman -Syu --noconfirm

# Installs
pacman -S --noconfirm base-devel libutil-linux 
pacman -S --noconfirm tmux vim
pacman -S --noconfirm git lua subversion unzip
# pacman -S --noconfirm python-pip

pacman -S --noconfirm zsh 
chsh -s /bin/zsh vagrant

# my dotfile setup
if [ ! -d $HOMEPATH/dotfiles ]; then
  su -c "git clone https://github.com/cyanife/dotfiles.git $HOMEPATH/dotfiles" vagrant
  su -s "/bin/zsh" -c "$HOMEPATH/dotfiles/zsh/bootstrap.sh" vagrant

  ln -s $HOMEPATH/dotfiles/zsh/.zshrc.local $HOMEPATH/.zshrc.local
  su -c "touch $HOMEPATH/.zshrc" vagrant
  su -c "touch $HOMEPATH/.zlogout" vagrant
  echo "[ -f ~/.zshrc.local ] && source ~/.zshrc.local" >> $HOMEPATH/.zshrc
  echo 'print -P "%F{33}▓▒░ %F{160}Exiting...%f"' >> $HOMEPATH/.zlogout
  echo 'print -P "%F{33}▓▒░ %F{220}type %F{82}'h' %F{220}for vagrant command help%f"' >> $HOMEPATH/.zlogout
fi
