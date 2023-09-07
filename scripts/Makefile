install-desktop: upgrade desktop clean
install-container: container

desktop:
	# dotfile manager
	sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:JaydenElliott/dotfiles.git
	
	# install
	wget.sh	
	apt-packages.sh
	cargo-crates.sh
	desktop.sh

container:
	wget.sh
	apt-packages.sh
	cargo-crates
	

upgrade:
	sudo apt update
	sudo apt install --fix-missing -y
	sudo apt upgrade --allow-downgrades -y
	sudo apt full-upgrade --allow-downgrades -y

clean:
	sudo apt install -f
	sudo apt autoremove -y
	sudo apt autoclean
	sudo apt clean

