mkdir ~/tmp
wget https://bitbucket.org/gward/vcprompt/downloads/vcprompt-1.2.1.tar.gz -P ~/tmp
tar xzf ~/tmp/vcprompt-1.2.1.tar.gz -C ~/tmp
~/tmp/vcprompt-1.2.1/configure --prefix=~/tmp/vcprompt-1.2.1
make -C ~/tmp/vcprompt-1.2.1 clean
make -C ~/tmp/vcprompt-1.2.1
make -C ~/tmp/vcprompt-1.2.1 install PREFIX=$HOME/bin
