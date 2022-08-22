#!/bin/bash

function check() {
	local param=$1

	echo "============================================="

	if ! [ -x "$(command -v ${param})" ]; then
		echo "${param}을 설치합니다..."
		return 0
	else 
		echo "${param}가 이미 설치되어 있습니다."
		return 1
	fi
}

function check_cask() {
	local param=$1
	echo "============================================="
	local cmd=`brew list --cask | grep ${param}`

	if [ -z $cmd ]; then
		echo "${param}을 설치합니다..."
		return 0
	else
		echo "${param}가 이미 설치되어 있습니다."
		return 1
	fi
}

# ohmyzsh 설치
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "" >> ~/.alias
echo "source ~/.alias" >> ~/.zshrc

# homebrew 설치
if check brew ; then	
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.zshrc

if check mas ; then 
	brew install mas
fi

# 자바 설치
if check java ; then
	brew install java
fi

# 스칼라 설치
if check scala ; then
	brew install scala@2.12
fi

if check sbt ; then
	brew install sbt
fi

# 그외 개발 환경 세팅
if check git ; then
	brew install git
fi

if check python3 ; then
	brew install python3
fi

if check pip3 ; then
	brew install pip3
fi

if check gradle ; then
	brew install gradle
fi

if check fzf ; then
	brew install fzf
fi

if check jenv ; then
	brew install jenv
fi

if check wget ; then
	brew install wget
fi

if check node ; then
	brew install node
fi

if check poetry ; then
	brew install poetry
fi

if check conda ; then
	brew install anaconda
fi

if check gpg ; then
	brew install gpg
fi

if check lima ; then
	brew install lima
fi
echo 'alias docker="lima nerdctl"' >> ~/.alias

# 맥 프로그램 설치
if check_cask iterm2 ; then
	brew install --cask iTerm2
fi

if check_cask sublime-text ; then
	brew install --cask sublime-text
fi

if check_cask intellij-idea ; then
	brew install --cask intellij-idea
fi

if check_cask pycharm ; then
	brew install --cask pycharm
fi

if check_cask slack ; then
	brew install --cask slack
fi

if check_cask datagrip ; then
	brew install --cask datagrip
fi

if check_cask datagrip ; then
	brew install --cask datagrip
fi

if check_cask lens ; then
	brew install --cask lens
fi

# 상태창
if check_cask eul ; then
	brew install --cask eul
fi

if check_cask alfred ; then
	brew install --cask alfred
fi

# 클립보드
if check_cask maccy ; then
	brew install --cask maccy
fi

if check_cask postman ; then
	brew install --cask postman
fi

if check_cask visual-studio-code ; then
	brew install --cask visual-studio-code
fi

# bear
mas install 1091189122

# feedly
mas install 865500966

# zoom
mas install 1514260034

# magnet
mas install 441258766

# owly
mas install 882812218

# git 설정
read -p "이름을 입력하세요 : " name
read -p "이메일을 입력하세요 : " email
git config --global user.name $name
git config --global user.email $email
ssh-keygen -t rsa -C $email
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa
pbcopy < $HOME/.ssh/id_rsa.pub
echo "클립보드에 키가 복사되었습니다. SSH key를 붙여넣기 하세요."
open "https://github.com/settings/ssh/new"
read -p "enter를 누르면 다음 과정으로 진행합니다." next

source ~/.zshrc

ehco "완료되었습니다."
