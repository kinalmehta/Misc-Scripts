
sudo apt-get install -y git apt-transport-https wget software-properties-common curl gnupg-agent ca-certificates libappindicator3-1 build-essential


# install sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text


# install vscode
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code
# NOTE: after the installation is complete, check the list of PPA repositories, Microsoft add a duplicate entry.
#       open Software Sources and disable/remove the duplicate entry


# install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb


### Installing Miniconda for python development
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -bfu  # b is batch mode, f is no error if already installed, u is update existing installation
PREFIX=$HOME/miniconda3
$PREFIX/bin/conda init


# upgrade packages
sudo apt upgrade -y


# install zsh shell
sudo apt install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # "" --skip-chsh
# sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended  # WARNING: This will not setup ohmyzsh in .zshrc file

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
sed -i 's#plugins=(git)#plugins=( \n git \n colored-man-pages \n zsh-autosuggestions \n zsh-history-substring-search \n zsh-syntax-highlighting \n )#g' $HOME/.zshrc

# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel10k/powerlevel10k"#g' $HOME/.zshrc

# set zsh as the default shell
chsh -s $(which zsh)
# IMPORTANT: REBOOT after this


# install tmux
sudo apt install -y tmux
[[ -a $HOME/.bashrc ]] && echo "alias tmux='tmux -u'" >> $HOME/.bashrc && echo "Successfully added \"alias tmux='tmux -u'\" to $HOME/.bashrc"
[[ -a $HOME/.zshrc ]] && echo "alias tmux='tmux -u'" >> $HOME/.zshrc && echo "Successfully added \"alias tmux='tmux -u'\" to $HOME/.zshrc"


# -------------------------------------


# installing nvidia drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo ubuntu-drivers autoinstall

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# NOTE: replace ```  $(lsb_release -cs) ---> focal  ```, if using mint 20 instead of ubuntu 20 derivation
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker ENTER_USERNAME  # IMPORTANT to change this
# REBOOT

# nvidia docker extention
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) # replace this line as => distribution="ubuntu20.04" if on mint 20
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker


# VMWare Workstation
# Download the .bundle file from https://www.vmware.com/in/products/workstation-pro/workstation-pro-evaluation.html
# IMPORTANT: replace this👇 with the downloaded bundle file name
sudo bash "VMware-Workstation-Full-15.5.6-16341506.x86_64.bundle"

