#!/bin/bash

set -e
declare -A fun

fun+=(
    ["install-tools"]="Install necessary tools"
    ["decrypt-ssh"]="Decrypt ssh private key"
    ["configure-git"]="Configure git"
    ["clone-projects"]="Clone projects from git"
    ["prepare-symlinks"]="Create symlinks for configuration files"
    ["configure-acpi"]="Configure acpi handlers"
    ["configure-locale"]="Configure locale and keyboard templates"
    ["configure-docker"]="Configure docker service"
    ["launch-jetbrains"]="Launch jetbrains toolbox"
    ["configure-environment"]="Configure /etc/environment"
)

function wrap {
    local command
    local name
    command=$1
    name=${fun["$command"]}
    [[ -z $name ]] && echo "No such function description for $1"  && exit 1
    cprint "$name"
    eval "$*"
    cprint "DONE: $name"
}

function cprint {
    printf "=== \033[0;37m$1\033[0m === \n"
}

function install-tools() { 
  sudo pacman -S --noconfirm vim htop git jdk8-openjdk openjdk8-src openjdk8-doc visualvm xf86-input-synaptics yaourt telegram-desktop docker docker-compose transmission-cli npm gradle ansible noto-fonts-emoji tree sshfs
  yaourt -S --noconfirm jetbrains-toolbox zoom
  yaourt -Syua --noconfirm
} 

function decrypt-ssh() {
  tmp=`mktemp -d`
  wget https://github.com/pTykvin/scripts/blob/master/ssh-crypt?raw=true $tmp/ssh-crypt
  openssl aes-256-cbc -d -in $tmp/ssh-crypt -out - -pbkdf2 | tar -xzvf - -C ~/.ssh
  sudo cp -rf /home/happyfat/.ssh /root/.
}

function configure-git() {
  git config --global user.email happyfat25@gmail.com
  git config --global user.name happyfat
  git config --global core.editor vim
}

function clone-projects() {
  mkdir -p ~/Work/projects
  git clone git@github.com:pTykvin/scripts.git ~/Work/projects/scripts
  git clone git@bitbucket.org:Happy-Fat/arch-settings.git ~/Work/arch-settings
  git clone git@github.com:pTykvin/docker.git ~/Work/projects/docker
}

function prepare-symlinks() {
  cp -rf ~/.config ~/config-backup
  rm -rf ~/.config
  ln -s ~/Work/arch-settings/happyfat-config ~/.config
  for f in `ls -1 ~/.config/bash/.bash*`; do ln -sf $f ~/`basename $f`; done && ls -la ~/.bash*
  ln -s .config/.vimrc ~/.vimrc
  ln -s ~/.config/.screenlayout ~/.screenlayout
  ln -sf ~/Work/projects/scripts/recovery.sh ~/recovery.sh
  mv ~/config-backup/chromium ~/.config/. || true
  
  sudo cp -rf /root/.config /root/config-backup
  sudo rm -rf /root/.config
  sudo ln -s /home/happyfat/Work/arch-settings/root-config /root/.config
  sudo sh -c 'for f in `ls -1 /root/.config/bash/.bash*`; do sudo ln -sf $f /root/`basename $f`; done && sudo ls -la ~/.bash*'
  sudo ln -s /root/.config/.vimrc ~/.vimrc
  sudo mv /root/config-backup/chromium /root/.config/. || true
}

function configure-acpi() {
  sudo systemctl start acpid.service
  sudo systemctl enable acpid.service
  sudo cp /etc/acpi/handler.sh /etc/acpi/handler.sh.bck
  sudo rm -rf /etc/acpi/handler.sh
  sudo ln -s ~/Work/arch-settings/happyfat-config/acpi/handler.sh /etc/acpi/handler.sh
}

function configure-locale() {
  setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
  localectl --no-convert set-x11-keymap us,ru pc105, grp:alt_shift_toggle
}

function configure-docker() {
  systemctl start docker
  systemctl enable docker
  sudo usermod -a -G docker happyfat
}

function configure-environment() {
  sudo s -c "cat <<-EOF > /etc/environment
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano
  EOF
  "
}

function launch-jetbrains() {
  jetbrains-toolbox
}

function main() {
  [[ -z $1 ]] && funs=${!fun[@]} || funs=$@
  for f in ${funs[@]}; do wrap $f; done;
}

main $1
