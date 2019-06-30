#!/bin/bash

set -ex
# TODO: First startup
# Configure snapshots in Timeshift - RSYNC
# remove "Show Desktop" from toolbar
# configure bash to 0 transparency
# set up wifi pw
# log in to firefox and show bookmarks toolbar, remove pocket, set default search to duckduckgo.
# deal with passwording: https://stackoverflow.com/a/11955369

# TODO: Install
# fonts for getGit
# both printers (attached, move into /etc/cups/ppd, set root as owner)
# clone common QIIME repos, add relevant git remotes
# Install R and relevant packages (ggplot2, dplyr, etc)
# Install firefox fb-blocker plugin

# save point
timeshift --create --comments "raw install"

sudo -s -- <<EOF
# enter password
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove
apt-get autoclean -y
# save point
timeshift --create --comments "updates/ugrades packages"

sudo apt-get install chromium-browser
sudo apt-get install clementine -y
sudo apt-get install build-essential -y
sudo apt-get install git -y
apt install idle-python3.6 -y
apt install python-pip -y
pip install flake8
apt install crawl-tiles -y
apt install kpat -y
apt install kmines -y
cd ~/Downloads
wget https://atom.io/download/deb
dpkg -i deb
rm deb
apm install hey-pane emmet linter linter-flake8 open-recent todo-show minimap highlight-selected apm install minimap-highlight-selected pigments auto-close-html auto-detect-indentation
apm install vivid one-dark-vivid-syntax monokai monokai-dark monokai-slate
# TODO: Choose a theme and load that theme
apt install emacs -y
apt install texlive-latex-recommended texlive-latex-base texlive-latex-extra texmaker -y
timeshift --create --comments "bulk software install"
EOF

#Install Miniconda, QIIME2, qiime2 repos, personal repos.
sudo -s -- <<EOF
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
# hit enter, scroll through license w/enter, type "yes", hit enter, hit enter to confirm
# default location, yes and enter to configure in .bashrc

#Install q2 environment
conda update conda -y
wget https://data.qiime2.org/distro/core/qiime2-2018.11-py35-linux-conda.yml
conda env create -n q2-18.11 --file qiime2-2018.11-py35-linux-conda.yml
rm qiime2-2018.11-py35-linux-conda.yml

#Install dev environment
wget https://raw.githubusercontent.com/qiime2/environment-files/master/latest/staging/qiime2-latest-py36-linux-conda.yml
conda env create -n q2-dev --file qiime2-latest-py36-linux-conda.yml
rm qiime2-latest-py36-linux-conda.yml
timeshift --create --comments "Installs miniconda and QIIME 2"
EOF

#Install Oracle 11 JDK - may require user input
sudo -s -- <<EOF
#enter password
echo oracle-java11-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections
# if this fails, an alternative method for auto-accepting licenses at:
#<<<https://www.linuxuprising.com/2018/10/how-to-install-oracle-java-11-in-ubuntu.html>>>
add-apt-repository ppa:linuxuprising/java
apt update
apt install oracle-java11-installer
apt install oracle-java11-set-default
timeshift --create --comments "adds oracle jdk"
EOF

# Install eclipse - requires user input:
# direct browser to <<<https://www.eclipse.org/downloads/>>>
# Download current version
#
# navigate to ~/Downloads
# sudo tar -xvzf eclipse-inst-linux64.tar.gz
# cd eclipse-installer
# ./eclipse-inst
#complete with GUI, then

#add panel icon:
sudo printf '%s\n' '[Desktop Entry]' 'Encoding=UTF-8' 'Exec=/home/chris/eclipse/java-2018-12/eclipse/eclipse' 'Icon=/home/chris/eclipse/java-2018-12/eclipse/icon.xpm' 'Type=Application' 'Terminal=false' 'Comment=Eclipse Integrated Development Environment' 'Name=Eclipse' 'GenericName=eclipse' 'StartupNotify=false' 'Categories=Development;IDE;Java;' >/home/chris/.local/share/applications/eclipse.desktop
sudo rm -r eclipse*
# save point
timeshift --create --comments "adds eclipse and panel icon"

# Generate SSH Key, clone all gitHub repos

# download all qiime and personal repos
# conda create --name gitRepoDump --clone base
# conda activate gitRepoDump
# conda install nodejs -y
# npm install -g git-friends
# cd ~
# mkdir src
# cd src