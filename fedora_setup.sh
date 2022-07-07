
sudo dnf update -y
sudo dnf upgrade --refresh -y

sudo dnf groupinstall 'Development Tools' -y
sudo dnf install gcc-c++ -y


# installing nvidia drivers
sudo dnf install kernel-devel -y
sudo dnf install akmod-nvidia -y
sudo dnf install xorg-x11-drv-nvidia-cuda -y
sudo systemctl enable nvidia-hibernate.service nvidia-suspend.service nvidia-resume.service

# setting blacklist novou and other setting mentioned in asus-linux
sudo gedit /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2.cfg


# zsh install
sudo dnf install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # "" --skip-chsh

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
sed -i 's#plugins=(git)#plugins=( \n git \n colored-man-pages \n zsh-autosuggestions \n zsh-history-substring-search \n zsh-syntax-highlighting \n )#g' $HOME/.zshrc

# set zsh as the default shell
chsh -s $(which zsh)


### Installing Miniconda for python development
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -bfu  # b is batch mode, f is no error if already installed, u is update existing installation
PREFIX=$HOME/miniconda3
$PREFIX/bin/conda init

