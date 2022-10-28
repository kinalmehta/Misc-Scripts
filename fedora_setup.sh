
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

### Install latex for LaTeX-Workshop extension of VSCode
sudo dnf install texlive-scheme-full
sudo dnf install latexmk # use this only if above doesn't install it

# Docker and nvidia-docker
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER

distribution=centos8 
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo dnf clean expire-cache --refresh
sudo dnf install -y nvidia-docker2
sudo systemctl restart docker
sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi


