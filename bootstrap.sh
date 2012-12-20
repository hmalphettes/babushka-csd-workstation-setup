#!/bin/sh
echo "Looking for babushka:"
which babushka
if [ "$?" != "0" ]; then
	echo "Looking for git:"
	which git
	gitHere=$?
	if [ "$gitHere" != "0" ]; then
		if [ ! -f "downloads/git-1.8.0.2-3-intel-universal-snow-leopard.dmg" ]; then
			echo "Downloading Git"
			mkdir -p downloads || true
			cd downloads
			curl -O https://git-osx-installer.googlecode.com/files/git-1.8.0.2-3-intel-universal-snow-leopard.dmg
			cd ..
		fi
		open downloads/git-1.8.0.2-3-intel-universal-snow-leopard.dmg
		echo "Please install it"
	else
		echo "  ... already installed."
	fi

	echo "Looking for XCode Command Line Tools:"
	which make
	makeHere=$?
	if [ "$makeHere" != "0" ]; then
		if [ ! -f "downloads/xcode452cltools10_86938211a.dmg" ]; then
			echo "Downloading XCode Command Line Tools. Please login, download and install it."
			open https://developer.apple.com/downloads/
		else
			echo "Please Install The XCode Command-Line Tools"
			open downloads/xcode452cltools10_86938211a.dmg
		fi
	else
		echo "  ... already installed."
	fi

	which git
	gitHere=$?
	which make
	makeHere=$?
	if [ "$gitHere" -a "$makeHere" ]; then
echo "Installing babushka"
echo 
echo "During this installation, you will be prompted for your password a few times."
echo
echo "Waiting 10 seconds. Then going."
sleep 10

echo "We need to make sure you can write to some directories in /usr/local"
echo "We may need your user account password to invoke sudo to chgrp and chmod /usr/local to 'user:staff 775'"
echo "If prompted for your password, please enter it."
echo
sleep 2
echo "Checking to make sure you have a /usr/local directory"
if [ -d /usr/local ]
then
  echo "/usr/local exists. Awesome."
else
  sleep 1
  echo "Creating /usr/local."
  sudo mkdir -p /usr/local
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

echo "Checking permissions in /usr/local/..."
# Make sure the current user can write to /usr/local/babushka
if [ -w /usr/local ]
then
  echo "/usr/local is writable. Awesome."
else
  sleep 1
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

if [ -w /usr/local/bin ]
then
  echo "/usr/local/bin is writable. Also Awesome."
else
  sleep 1
  sudo chmod g+w /usr/local
  sudo chgrp staff /usr/local
fi

if [ -w /usr/local/babushka ]
then
  echo "/usr/local/babushka is writable."
elif [ -e /usr/local/babushka ]
then
  echo "/usr/local/babushka exists, but is not writable by you. Fixing that."
  sleep 1
  sudo chgrp staff /usr/local/babushka
  sudo chmod g+w /usr/local/babushka
else
  echo "/usr/local/babushka does not exist. That's OK. We'll create it later."
fi

sleep 2

echo
echo "OK. Permissions are good to go. Next we will install Babushka."
echo

sleep 2


	fi
else
	echo " .. already installed"
fi

babushka babushka
babushka 'CSD Workstation Setup'
