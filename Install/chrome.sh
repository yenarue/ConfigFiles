# Install
# via http://askubuntu.com/questions/510056/how-to-install-google-chrome
if [ $1 = "install" ]; then
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
	sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update 
	sudo apt-get install google-chrome-stable


# Update
elif [ $1 = 'update' ]; then
	sudo apt-get --only-upgrade install google-chrome-stable

else
	echo 'options list:'
	echo 'install : install stable version'
	echo 'update : update to stable version'
fi
