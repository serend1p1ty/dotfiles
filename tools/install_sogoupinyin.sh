sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx
sudo apt-get install fcitx-config-gtk
sudo apt-get install fcitx-table-all
sudo apt-get install im-switch
wget -O sogoupinyin.deb http://cdn2.ime.sogou.com/dl/index/1571302197/sogoupinyin_2.3.1.0112_amd64.deb?st=bhRZurql-yvquuOkispmBQ&e=1579235866&fn=sogoupinyin_2.3.1.0112_amd64.deb
sudo dpkg -i sogoupinyin.deb
sudo apt-get install -f
