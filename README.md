## ADB: input
参考: <https://blog.bihe0832.com/adb-shell-input.html>
```
adb shell input tap <x> <y> (Default: touchscreen)
adb shell input swipe <x1> <y1> <x2> <y2> [duration(ms)] (Default: touchscreen)
adb shell input press (Default: trackball)
adb shell input roll <dx> <dy> (Default: trackball)

```


## ADB: net

方法1: 数据线连接后电脑端: 
```
adb devices
adb tcpip 5555
```
方法2: 安卓端: 
```
su
setprop service.adb.tcp.port 5555 && stop adbd && start adbd
```
: 
```
adb connect ...:5555
```


## ADB: screencap

参考: <https://www.jianshu.com/p/9a6d77ff50a8?tdsourcetag=s_pctim_aiomsg>

高版本安卓支持直接保存: 
```
adb exec-out screencap -p > 1.png
```
如果是windows系统，执行上述命令出来的图片，由于换行符的问题，会导致打不开文件，需要把\r\n换成\n
```
def convert_img():
 with open("./1.png", "rb") as f:
 bys = f.read()
 bys_ = bys.replace(b"\r\n",b"\n") # 二进制流中的"\r\n" 替换为"\n"
 with open("./2.png", "wb") as f:
 f.write(bys_)
 f.close()
```
简明: 
```
os.system("adb exec-out screencap -p > 1.read.png")
open('2.write.png', 'wb').write(open('1.read.png', 'rb').read().replace(b'\r\n',b'\n'))
```
低版本安卓: 
```
adb devices
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png 0.png
rem adb shell rm /sdcard/screenshot.png
```


## ADB: uiautomator2: initialze

	pip3 install --pre --upgrade uiautomator2 weditor
	python -m uiautomator2 init
	python -m weditor


## Android Studio: "Plugin with id 'kotlin-android' not found"

当你的使用Kotlin编写的android项目中出现Plugin with id 'kotlin-android' not found.

你可以查看下你的项目Gradle文件，加上如图两行代码: 

```
ext.kotlin_version="1.3.30"

classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
```


## Android Studio: ConstraintLayout: initialze

参考: 
<https://developer.android.com/training/constraint-layout/index.html>
<https://developer.android.com/studio/write/layout-editor>
```
repositories {
 google()
 }
将该库作为依赖项添加到同一个 build.gradle 文件中，如以下示例所示。请注意，最新版本可能与示例中显示的不同: 
 dependencies {
 implementation 'com.android.support.constraint:constraint-layout:1.1.2'
 } 
在工具栏或同步通知中，点击 Sync Project with Gradle Files。
现在，您可以使用 ConstraintLayout 构建布局。
```


## Android Studio: jcenter: faster

参考: <https://maven.aliyun.com/mvn/view>

	repositories {
		maven { url 'https://maven.aliyun.com/repository/gradle-plugin' }
		maven { url 'https://maven.aliyun.com/repository/google' }
		maven { url 'https://maven.aliyun.com/repository/jcenter' }
		google()
		jcenter()
	}


## Android: Adb

<https://developer.android.google.cn/studio/releases/platform-tools#downloads>


## Android: Adb server

<https://github.com/Nethesh/Termux-ADB/blob/master/README.md>

连接vpn后继续
安装: 

    apt update && apt install wget && wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh && bash InstallTools.sh

卸载: 

    apt update && apt install wget && wget https://github.com/MasterDevX/Termux-ADB/raw/master/RemoveTools.sh && bash RemoveTools.sh


## Android: Google Play: Certificated

termux::

	pkg install tsu sqlite
	sudo sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"

<https://www.google.com/android/uncertified/>

注册之后，谷歌同步数据需要一点时间，稍等5分钟
清除谷歌play应用市场的数据和缓存
谷歌账户给注销退出，等待5分钟，重新登录
继续重新打开谷歌Play


## Android: Termux: CodeServer

	pkg install -y python nodejs yarn vim
	exit

	pkg uninstall -y git
	pkg install -y git
	yarn global add code-server
	
	cd ~/.config/yarn/global/node_modules/code-server/lib/vscode/node_modules/spdlog/
	vim binding.gyp

	"targets": [{
			"target_name": "spdlog",
	+       "libraries": [ "-latomic" ], 
			"sources": [
					"src/main.cc",
					"src/logger.cc"
			],

	npm install
	pkg install ripgrep -y
	cd ~/.config/yarn/global/node_modules/code-server/lib/vscode/node_modules/vscode-ripgrep/bin
	ln -s $(which rg) .
	pkg install openssl-tool
	code-server --bind-addr 0.0.0.0:8080 --disable-telemetry --auth none


## Android: Termux: Minio

	pkg install wget && wget https://dl.minio.io/server/minio/release/linux-arm/minio -c && chmod +x minio && su -c 'iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to- port 8080' && (MINIO_ACCESS_KEY=shine MINIO_SECRET_KEY=sunshine /data/data/com.termux/files/home/minio server /sdcard --address ":1080"&)
	


## Android: Termux: Numpy

	curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
	bash setup-pointless-repo.sh
	pkg install numpy


## Android: Termux: bashrc

	vim .bashrc

	alias p='python'
	alias v='vim'
	alias l='ls'
	alias i='pkg install'
	alias ii='pkg uninstall'
	alias pi='pip install'
	alias pii='pip uninstall'
	alias r='rm -rf'
	alias rm='rm -rf'
	alias rmm='rm .bash_history > /dev/null 2>&1 && rm -rf /data/data/com.termux/cache/apt/*'
	alias pmd='sudo pm disable'
	alias pme='sudo pm enable'

	alias c='python /data/data/com.termux/files/home/git.py/1.tools/8.cast-clipboard.py'
	alias g='python /data/data/com.termux/files/home/git.py/1.tools/8.get-clipboard.py'
	alias ft='python /data/data/com.termux/files/home/git.py/1.tools/5.file-transmission.py'
	alias ftt='cd /storage/emulated/0/Download && python /data/data/com.termux/files/home/git.py/1.tools/5.file-transmission.py'
	alias co='code-server --bind-addr 0.0.0.0:8080 --disable-telemetry --auth none'
	alias cc='python ~/git.h5/3/1.py'
	alias h='htop'
	alias gp='git pull'
	alias gpp="git add . && git commit -m 'AutoCommit' && git push"
	alias gc='git clone'
	alias n='su -c "iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080"'
	alias ww='su -c "cmd wifi force-low-latency-mode enabled"'
	alias www='su -c "cmd wifi force-low-latency-mode disabled"'
	alias vv='vim ~/.bashrc'

	# alias aa="su -c 'setprop service.adb.tcp.port 55051' &&su -c 'stop adbd' &&su -c 'start adbd'"
	# alias aaa='adb connect 127.0.0.1:55051 && adb devices'
	# alias hh='sudo swapoff /dev/block/zram0'
	# alias mm='MINIO_ACCESS_KEY=shine MINIO_SECRET_KEY=sunshine /data/data/com.termux/files/home/minio server /storage/emulated/0 --address ":8080"'

	export API_KEY_3gy6=
	export SECRET_KEY_3gy6=


## Android: Termux: button
	
	mkdir .termux
	vim .termux/termux.properties

	extra-keys = [ \
	['ESC','HOME','UP','END','ENTER'], \
	['CTRL','LEFT','DOWN','RIGHT','TAB'] \
	]


## Android: Termux: pkg: initialze

	sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
	sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
	sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
	apt update && apt upgrade
	pkg install vim python git


## Android: Wifi: low latency

	sudo cmd wifi force-low-latency-mode enabled


## Android: Xiaomi: update

<http://www.miui.com/shuaji-393.html>  
<https://xiaomirom.com/rom/redmi-note-9-4g-9t-lime-china-fastboot-recovery-rom/>  

	fastboot.exe flash recovery twrp.img
	fastboot.exe boot twrp.img


## ArchLinux: zip multipart

~~~
zip -r -s 1g output.zip ...
~~~


## Archlinx: Chinese input method

	sudo pacman -Sy fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-qt4 fcitx-qt5 fcitx-sogoupinyin
	sudo vim /etc/environment

	export XMODIFIERS="@im=fcitx"
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx

	sudo vim /etc/profile
	... // 同上


## BaiduAPI: translate 百度翻译API

<https://fanyi-api.baidu.com/manage/developer>

~~~
import requests
import random
import json
from hashlib import md5

appid = 'INPUT_YOUR_APPID'
appkey = 'INPUT_YOUR_APPKEY'

# For list of language codes, please refer to `https://api.fanyi.baidu.com/doc/21`
from_lang = 'en'
to_lang =  'zh'

endpoint = 'http://api.fanyi.baidu.com'
path = '/api/trans/vip/translate'
url = endpoint + path

query = 'Hello World! This is 1st paragraph.\nThis is 2nd paragraph.'

# Generate salt and sign
def make_md5(s, encoding='utf-8'):
    return md5(s.encode(encoding)).hexdigest()

salt = random.randint(32768, 65536)
sign = make_md5(appid + query + str(salt) + appkey)

headers = {'Content-Type': 'application/x-www-form-urlencoded'}
payload = {'appid': appid, 'q': query, 'from': from_lang, 'to': to_lang, 'salt': salt, 'sign': sign}

r = requests.post(url, params=payload, headers=headers)
result = r.json()

# Show response
print(json.dumps(result, indent=4, ensure_ascii=False))

~~~


## Chrome: 扩展

<https://crxdl.com/>

将下载来的文件后缀名 *.crx 改成 *.rar，解压这个压缩文件得到一个文件夹。
如果解压出的文件夹中有"\_metadata"，将前面的"\_"去掉，否则无法加载。
打开扩展程序页面，选中右上方开发人员模式复选框，点击载入正在开发的扩展程序，选中刚刚解压出来的文件夹。


## Ffmpeg: cut

	ffmpeg -ss 00:01:00 -i ...mp4 -o 00:02:00 -c copy o.mp4


## Ffmpeg: m3u8

	ffmpeg -i https...m3u8 -c copy -bsf:a aac_adtstoasc o.mp4


## Git

	git clone ...
	
	git config --global user.email "...
	git config --global user.name "...
	git config --global credential.helper store

	git config --global core.editor "vim"
	
	git add .
	git commit -a
	git push

	git pull

	git push origin master --force


## Git: GitHub

<https://d.serctl.com/?dl_start>


## Git: GitHub: hosts

	192.30.253.112 github.com
	151.101.185.194 github.global.ssl.fastly.net
	192.30.253.120 codeload.github.com


## Git: erase

	git checkout --orphan latest_branch
	git add -A
	git commit -am "commit message"
	git branch -D master
	git branch -m master
	git push -f origin master
	git push --set-upstream origin master


## Git: exact ditectory

```
// 初始化空库
$ mkdir devops
$ cd devops
$ git init

// 拉取remote的all objects信息
$ git remote add -f origin https://github.com/....git

// 开启sparse clone
$ git config core.sparsecheckout true

// 设置需要pull的目录，*表示所有，!表示匹配相反的
$ echo "devops" >> .git/info/sparse-checkout
$ more .git/info/sparse-checkout

// 将origin端需要pull的目录下的文件pull到本地
$ git pull origin master
```


## Git: roll back

	// 回到上个版本: 

	git reset --hard HEAD^

	// 回到前几个版本: 

	git reset --hard HEAD~3
	git reset --hard commit_id

	git push origin HEAD --force


## Golang

```
export GO111MODULE=on
export GOPROXY=https://mirrors.aliyun.com/goproxy/

```


## Html: Inject: NeteaseMusic: title

在控制台中键入

	var importJs=document.createElement('script')
	importJs.setAttribute("type","text/javascript")
	importJs.setAttribute("src", 'http://ajax.microsoft.com/ajax/jquery/jquery-1.4.min.js')
	document.getElementsByTagName("head")[0].appendChild(importJs)
	console.log("如果遇到错误，可能是jQuery尚未加载完成；如果复制的结果为空，请先在检查元素中点击一下歌曲名（刷新页面后点击一次即可）。请重新执行该脚本");
	var v=[];
	var name="";
	var author="";
	$("b").each(function(i, i2){
		name= $(this).attr("title")
		author= $(this).parents("td").next().next().children("div").attr("title")
		v.push(name+" "+author);
		});
	var v2 = v.join("\n");
	console.log(v2)
	console.log("以上内容将被复制到剪贴板")
	$('<textarea>').val(v2).appendTo('body').select();
	document.execCommand('copy');


## Html: Inject: Yuketang: call when exercise

	var script = document.createElement('script');
	script.src = "https://smtpjs.com/v3/smtp.js";
	document.getElementsByTagName('head')[0].appendChild(script);
	script = document.createElement('script');
	script.src = "https://code.jquery.com/jquery-3.4.1.min.js";
	document.getElementsByTagName('head')[0].appendChild(script);
	sendAvailable= true

	setTimeout(function(){
	$("body").bind("DOMNodeInserted", function(e){
	if ($(e.target).is('.page-exercise')){
		if (sendAvailable){
		sendAvailable= false
		Email.send({
			Host: "smtp.qq.com",
			Username: "...",
			Password: "...",
			To: '...',
			From: "...",
			Subject: "Exercise from Yu Ke Tang",
			Body: ""
			})
			.then(function (message) {
				console.log("Mail has been sent successfully")
				setTimeout(function(){
				sendAvailable= true;
				}, 3000);
			});
		}
	}
	});
	}, 1000);


- 油猴插件
	
	~~~
	// ==UserScript==
	// @name         雨课堂提醒
	// @namespace    http://tampermonkey.net/
	// @version      1
	// @description  try to take over the world!
	// @author       You
	// @match        https://changjiang.yuketang.cn/lesson/fullscreen/*
	// @icon         https://www.google.com/s2/favicons?domain=tampermonkey.net
	// @grant        none
	// @require      https://smtpjs.com/v3/smtp.js
	// @require      https://code.jquery.com/jquery-3.4.1.min.js
	// ==/UserScript==

	(function(){

	var sendAvailable= true

	setTimeout(function(){
	$("body").bind("DOMNodeInserted", function(e){
		console.log(e.target)
	if ($(e.target).is('.page-exercise')){
		if (sendAvailable){
		sendAvailable= false
		Email.send({
			Host: "smtp.qq.com",
			Username: "...",
			Password: "...",
			To: '...',
			From: "...",
			Subject: "Exercise from Yu Ke Tang",
			Body: ""
			})
			.then(function (message) {
				console.log("Mail has been sent successfully")
				setTimeout(function(){
				sendAvailable= true;
				}, 3000);
			});
		}
	}
	});
	}, 1000);
	})();
	~~~


## IOS: PUBG: better

关闭查找iPhone

运行iMazing

点击【管理应用程序】，选择【设备】

右键点击，选择【备份应用程序数据】

点击“下一步”保存数据，然后又弹出一个界面就选“好”

6.找到刚刚保存的数据文件【和平精英】，右键选择【用好压打开】，打开Container\Documents\ShadowTrackerExtra\Saved\Config\IOS，找到配置文件【UserCustom.ini】

右键点击【UserCustom.ini】，选择【内部查看器打开】

在UserCustom.ini文件的【UserCustom DeviceProfile】下一行添加下面四行代码，添加完毕之后记得保存

	+CVars=r.PUBGDeviceFPSLow=60
	+CVars=r.PUBGDeviceFPSMid=60
	+CVars=r.PUBGDeviceFPSHigh=60
	+CVars=r.PUBGDeviceFPSHDR=60

打开iMazing点击【管理应用程序】，选择【设备】，下拉列表找到游戏“和平精英”右键点击“和平精英”，选择【恢复应用程序数据】

手机运行“和平精英”，点击设置，帧率选择【极限】然后保存，不能进训练场和开始游戏！不能进训练场和开始游戏！不能进训练场和开始游戏！

手机游戏不要关闭，再次用iMazing备份“和平精英”数据

添加代码

还原数据

之后游戏不能选择其他画质了，不然又自动还原


## Jupyterlab

    pip install jupyterlab
    echo > /data/data/com.termux/files/home/.jupyter/jupyter_notebook_config.py
    vim /data/data/com.termux/files/home/.jupyter/jupyter_notebook_config.py
    
    c.NotebookApp.allow_remote_access = True
    c.NotebookApp.open_browser = False
    c.NotebookApp.ip='*'
    
    jupyter notebook --generate-config
    jupyter-lab
    
    // 中文
    pip install https://jfds-1252952517.cos.ap-chengdu.myqcloud.com/jupyterhub/jupyterlab_language_pack_zh_CN-0.0.1.dev0-py2.py3-none-any.whl


## Linux: Arch

下载位置: <https://mirrors.tuna.tsinghua.edu.cn/ArchLinux/iso/latest/>

	// # ls /sys/firmware/efi/efivars

	# ping -c 3 www.baidu.com
	# timedatectl set-ntp true
	# fdisk -l
	# fdisk -l /dev/sda
	# fdisk /dev/sda

	// 1 输出 n 创建分区
	// 2 Partition type是分区类型，p是主分区，e是扩展分区，直接按回车键选择默认
	// 3 Partition number是分区编号，直接按回车键选择默认
	// 4 First sector是开始的部分，直接按回车键选择默认
	// 5 Last sector是结尾的部分，输入 +50G，按回车键
	// 6 输入p查看分区列表
	// 7 输入w保存分区操作并继续安装系统。

	# mkfs.ext4 /dev/sda1
	# mount /dev/sda1 /mnt
	# vim /etc/pacman.d/mirrorlist

	// Server = http://mirrors.aliyun.com/ArchLinux/$repo/os/$arch
	// Server = https://mirrors.tuna.tsinghua.edu.cn/ArchLinux/$repo/os/$arch

	# pacman -Syy
	// # pacman -S arch-install-scripts
	# pacstrap /mnt base linux linux-firmware

	# genfstab -U /mnt >> /mnt/etc/fstab
	# arch-chroot /mnt
	# ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	# hwclock --systohc
	# pacman -S vim dhcpcd
	# systemctl enable dhcpcd

	// # vim /etc/locale.gen
	// zh_CN.UTF-8 UTF-8
	
	# vim /etc/hosts

	// 127.0.0.1 localhost
	// ::1 localhost
	// 127.0.1.1 hellokitty.localdomain hellokitty

	# echo "rm ~/.bash_history"> ~/.bash_logout

	# passwd

	# pacman -S grub
	# grub-install /dev/sda
	# grub-mkconfig -o /boot/grub/grub.cfg
	
	# exit
	# reboot

	// 安装运行 xfce4
	# pacman -S xorg-server xorg-xinit xfce4 fcitx-im network-manager-applet xfce4-notifyd
	# startxfce4

	// 安装运行 gnome（未成功）
	# pacman -S xorg xorg-server gnome gnome-extra && systemctl enable gdm.service && reboot


## Linux: Arch: Chinese display
	
	sudo vim /etc/locale.gen
		zh_CN.UTF-8 UTF-8

	sudo pacman -Ss font chinese


## Linux: Arch: Grub: time

	sudo vim /etc/default/grub

	// GRUB_TIMEOUT = 0

	sudo grub-mkconfig -o /boot/grub/grub.cfg


## Linux: Arch: Pacman: "error: failed to update core (unable to lock database)"

	rm -f /var/lib/pacman/db.lck


## Linux: Arch: Pacman: initialze

	echo [multilib]>> /etc/pacman.conf
	echo Include = /etc/pacman.d/mirrorlist>> /etc/pacman.conf
	echo [archlinuxcn]>> /etc/pacman.conf
	echo SigLevel = Optional TrustAll>> /etc/pacman.conf
	echo Server = http://mirrors.163.com/archlinux-cn/\$arch>> /etc/pacman.conf
	echo # Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch>> /etc/pacman.conf
	pacman -Syy
	pacman -S yay --noconfirm
	su arch
	yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save

- 安装code server
	
	~~~
	yay -S code-server
	~~~

- 手动更改源排名: 

	~~~
	sudo pacman-mirrors -i -c China -m rank
	~~~


## Linux: Arch: Pacman: install zst file

	su
	cd /var/ca*/pac*/*/
	cp ... /home
	cd /home
	tar -I zstd -xvf ..zst 
	cp ... / -r


## Linux: Arch: Pacman: overwrite

	sudo pacman -S --overwrite '*' ...


## Linux: Arch: Swap

<https://wiki.archlinux.org/index.php/Swap>

	su
	dd if=/dev/zero of=/swapfile bs=2M count=1024 status=progress
	chmod 600 /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo /swapfile none swap defaults 0 0 >> /etc/fstab


## Linux: Arch: TTY: Mouse

gpm必须使用多个参数启动，参数在/etc/conf.d/gpm文件中指定。

	su
	pacman -S gpm
	mkdir /etc/conf.d
	vim /etc/conf.d/gpm

	// 对于 USB 鼠标应该使用: 
	// GPM_ARGS="-m /dev/input/mice -t imps2"
	// 对于 PS/2 鼠标，用下面这行替代已有的一行: 
	// GPM_ARGS="-m /dev/psaux -t ps2"
	// 对于 IBM Trackpoints 使用: 
	// GPM_ARGS="-m /dev/input/mice -t ps2"

	systemctl enable gpm
	systemctl restart gpm


## Linux: Arch: TTY: auto login as root

	sudo vim /usr/lib/systemd/system/getty@.service

	// ExecStart=-/sbin/agetty --noclear %I 38400 linux 
	// 修改为: 
	// ExecStart=-/sbin/agetty --noclear -a root %I 38400 linux 


## Linux: Arch: TTY: font size

参考: 
<https://wiki.ArchLinux.org/index.php/Linux_console#Fonts>

	su
	pacman -S terminus-font
	ls /usr/share/kbd/consolefonts/ter-*
	echo "setfont ter-c22b.psf"> ~/.bash_profile


## Linux: Arch: TencentCloud

	su
	mv arch* /arch.iso
	mount /arch.iso /mnt
	tree|grep vmlinuz
	tree|grep .img
	vim /boot/grub/grub.cfg

		set timeout=600
		menuentry "Archlinux Live (x86_64)" {
			insmod iso9660
			set isofile=/arch.iso
			loopback lo0 ${isofile}
			linux (lo0)/arch/boot/x86_64/vmlinuz-linux archisolabel=ARCH_202002 img_dev=/dev/vda1 img_loop=${isofile} earlymodules=loop
			initrd (lo0)/arch/boot/x86_64/initramfs-linux.img
		}

	reboot

	mount -o rw,remount /dev/vda1
	cd /run/archiso/img_dev
	rm -rf [b-z]*
	mount /dev/vda1 /mnt
	echo Server = http://mirrors.aliyun.com/ArchLinux/\$repo/os/\$arch > /etc/pacman.d/mirrorlist
	echo Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch >> /etc/pacman.d/mirrorlist
	cat /etc/pacman.d/mirrorlist
	pacstrap /mnt base linux-lts linux-firmware base-devel grub openssh intel-ucode vim man dhcpcd tree htop git python python-pip tigervnc screen adobe-source-han-sans-cn-fonts

	genfstab -U /mnt >> /mnt/etc/fstab
	arch-chroot /mnt
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	hwclock --systohc
	echo en_US.UTF-8 UTF-8 > /etc/locale.gen
	echo ch_CN.UTF-8 UTF-8 >> /etc/locale.gen
	locale-gen
	echo LANG=en_US.UTF-8 > /etc/locale.conf
	echo myhostname > /etc/hostname
	echo 127.0.0.1	tencent > /etc/hosts
	echo ::1        tencent >> /etc/hosts
	echo 127.0.1.1	tencent.localdomain	myhostname >> /etc/hosts
	echo PermitRootLogin no >> /etc/ssh/sshd_config
	vim /etc/ssh/sshd_config

		ClientAliveInterval 3600 
		ClientAliveCountMax 6

	useradd -m -g wheel arch
	passwd arch
	passwd

	echo root ALL=\(ALL\) ALL >> /etc/sudoers
	echo %wheel ALL=\(ALL\) NOPASSWD: ALL >> /etc/sudoers
	grub-install --target=i386-pc /dev/vda
	grub-mkconfig > /boot/grub/grub.cfg
	systemctl enable dhcpcd
	systemctl enable sshd
	echo [multilib]>> /etc/pacman.conf
	echo Include = /etc/pacman.d/mirrorlist>> /etc/pacman.conf
	echo [archlinuxcn]>> /etc/pacman.conf
	echo SigLevel = Optional TrustAll>> /etc/pacman.conf
	echo Server = http://mirrors.163.com/archlinux-cn/\$arch>> /etc/pacman.conf
	echo # Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch>> /etc/pacman.conf
	pacman -Syy
	pacman -S yay --noconfirm
	su arch
	yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
	yay -S code-server
	yay -S google-chrome

	exit
	reboot

	su

	pacman -S xorg-server xorg-xinit xfce4 network-manager-applet
	reboot
	
	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
	vim ~/.bashrc

		alias gg='reset && cargo build && cargo run'
		alias p='python'
		alias v='vim'
		alias l='ls'
		alias r='rm -rf'
		alias rm='rm -rf'
		alias gc='git clone'
		alias gp='git pull'
		alias sl='screen -ls'
		alias ss='screen -S'
		alias s='screen -x'
		alias vv='vim ~/.bashrc'
		alias i='sudo pacman -S'
		alias ir='sudo pacman -R'
		alias is='sudo pacman -Ss'
		alias iyu='sudo pacman -Syu'

	vncpasswd

	vncserver :1


## Linux: Arch: User: add 

	su
	useradd -m -g users -s /bin/bash arch
	passwd arch


## Linux: Arch: User: switch

	# su arch


## Linux: Arch: clean pkg cache

	sudo rm /var/cache/pacman/pkg/*


## Linux: Arch: ignore GPG key

	vim /etc/pacman.conf
	// SigLevel=Never

	rm -rf /etc/pacman.d/gunpg


## Linux: Arch: package history
 
	vim /var/log/pacman.log

或者: 

	pacman -Qe


## Linux: Arch: set autorun

	su
	cd /etc/systemd/system
	vim <NAME>.service

	[Unit]
	Description=MongoDB Service
	[Service]
	ExecStart=/home/shine/0/mongodb-linux-x86_64-4.1.6/bin/mongod
	[Install]
	WantedBy=default.target

	systemctl start mongod.service
	systemctl enable mongod.service


## Linux: Arch: set proxy

	export http_proxy=http://10.203.0.1:5187/
	export https_proxy=$http_proxy
	export ftp_proxy=$http_proxy
	export rsync_proxy=$http_proxy
	export no_proxy=\"localhost,127.0.0.1,localaddress,.localdomain.com\"


## Linux: CodeServer

	PASSWORD=... code-server --bind-addr 0.0.0.0:8081


## Linux: Debian: Desktop

安装桌面

	tasksel


## Linux: Debian: screen

新建

	screen -S 1

隐藏
	
	<ctrl>-<a>-<d>



	screen -r ...

列表

	screen -ls

关闭

	screen -XS ... quit
	screen -XS ... kill


## Linux: Debian: sshd: disable root login

禁止 Root 用户通过 SSH 登陆

	sudo vim /etc/ssh/sshd_config
	
		PermitRootLogin no

	sudo systemctl restart sshd


## Linux: Download

	axel -a -n 20 ...


## Linux: Kernel
 
<http://hurlex.0xffffff.org/> 
<http://wiki.0xffffff.org/> 
<http://www.osdever.net/bkerndev/Docs/gettingstarted.htm> 
<http://www.jamesmolloy.co.uk/tutorial_html/> 
<https://wiki.osdev.org/Main_Page> 


## Luckypatchers

<https://www.luckypatchers.com>


## MacOS: Brew

<https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/>


## MacOS: dont sleep

	su

	pmset -a sleep 0; pmset -a hibernatemode 0; pmset -a disablesleep 1; pmset -a displaysleep 0; pmset -a autopoweroffdelay 0; pmset -a autopoweroff 0
	
	pmset -g


## MacOS: 删除开机界面上的其他用户登陆选项

执行如下命令后重启：

~~~
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool FALSE
~~~


## Magisk

<https://topjohnwu.github.io/Magisk/guides.html>


## Magisk: better

	sudo vim /data/adb/modules/hosts/system/build.prop

	ro.ril.hsdpa.category=8
	dalvik.vm.startheapsize=16m
	dalvik.vm.heapsize=48m
	#dalvik.vm.execution-mode=int:jit
	dalvik.vm.dexopt-flags=v=n,o=v
	dalvik.vm.checkjni=false
	ro.opengles.version=65536
	ro.media.dec.jpeg.memcap=20000000
	dalvik.vm.execution-mode=int:fast
	windowsmgr.max_events_per_sec=150
	ro.min_pointer_dur=1
	debug.sf.hw=1
	video.accelerate.hw=1
	wifi.supplicant_scan_interval=180
	#pm.sleep_mode=1
	ro.media.enc.jpeg.quality=100


## Markdown: Pandoc

下载地址: <https://github.com/jgm/pandoc/releases>
arm可在Arch仓库找到。

pandoc 默认生成三级目录。

	pandoc -s --toc FAQ.md -o FAQ.md
	
	// pandoc -s --toc --toc-depth=4 FAQ.md -o FAQ.md


## NAS

<https://cloud.tencent.com/developer/article/1563182>

	pacman -S samba
	vim /etc/samba/smb.conf

	[global]
        workgroup = MYGROUP
        server string = Samba Server
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        strict allocate = Yes
		allocation roundup size = 4096
		read raw = Yes
		server signing = No
		write raw = Yes
		strict locking = No
		socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
		min receivefile size = 16384
		use sendfile = Yes
		aio read size = 16384
		aio write size = 16384
	[readonly]
        comment = Directories
        path = /run/media/shine/Disk/Bandicam/
        browseable = yes   
        writable = no
        public = no
	[writable]
        comment = Writable
        path = /home/shine/0/
        browseable = yes
        public = no
        writable = yes


## Netron

<https://github.com/lutzroeder/netron/blob/master/README.md>


## Nodejs: npm: initialze

	<https://nodejs.org/en/download/>
	tar xvf *xz
	sudo cp -r node*x64/{bin,include,lib,share} /usr/
	npm config set registry https://registry.npm.taobao.org/


## Nodejs: npm: vite: initialze

	npm init @vitejs/app
	npm install --save @vitejs/create-app
	npm install --save vue-router@4
	npm install
	npm run dev


## Office365

<https://www.ruanfun.com/>
<https://www.luymm.com/archives/420/>


## Pacman: Remove

	sudo pacman -Rcns ...

删除孤包

	sudo pacman -R $(pacman -Qdtq)


## Path

	export PATH="$PATH:/...


## Python: MongoDB
 
	from pymongo import MongoClient
	MongoClient()[...][...].insert_one({"...":"...", ...})
	MongoClient()[...][...].find({'...':{'$regex': '^%s' %context }}).count()
	MongoClient()[...][...].find_one({'...':{'$regex': '^%s' %context }})['...']


## Python: PIL

	$ pip install Pillow


	from PIL import Image

	# 读取一张图片: 
	im=Image.open('/home/Picture/test.jpg')	
	# 显示一张图片: 
	im.show()
	# 保存图片: 
	im.save("save.gif","GIF") 
	# 创建新图片: 
	Image.new(mode,size)
	Image.new(mode,size,color)
	newImg = Image.new("RGBA",(640,480),(0,255,0))
	newImg.save("newImg.png","PNG")
	# 查看图像信息: 
	im.format, im.size, im.mode
	# 图片裁剪: 
	box=(100,100,500,500)
	# 设置要裁剪的区域
	region=im.crop(box) #此时，region是一个新的图像对象。
	# 改变图像的大小: 
	out=img.resize((128,128))#resize成128*128像素大小


## Python: Pysqlcipher3

pacman -S sqlcipher
pip3 install pysqlcipher3


## Python: VSCode: support cv2

	ctrl+shift+p

    "python.linting.pylintArgs": ["--generate-members"]


## Python: pip

	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple


## Python: pip: fix

	sudo python3 -m pip install --upgrade pip


## Python: set proxy

	import os

	proxy = 'http://<user>:<pass>@<proxy>:<port>'

	os.environ['http_proxy'] = proxy 
	os.environ['HTTP_PROXY'] = proxy
	os.environ['https_proxy'] = proxy
	os.environ['HTTPS_PROXY'] = proxy

	#your code goes here


## RPI: Manjaro: RPi.GPIO

	(sudo pacman -S python-pip)
	(pacman -S python python-pip base-devel)
	
	yay --aur python-raspberry-gpio


## RPI: Manjaro: vnc
	
	sudo pacman -S tigervnc
	vncpasswd

	//configure XDMCP - Modify /etc/lightdm/lightdm.conf
	sudo nano /etc/lightdm/lightdm.conf

	#in [LightDM] section
	#uncomment and set start-default-seat=false

	#in [XDMCPServer] section
	#uncomment and set enabled=true
	#uncomment port=177

	//restart lightdm
	sudo systemctl restart lightdm

	//create /etc/systemd/system/tigervnc.socket
	sudo nano /etc/systemd/system/tigervnc.socket

	#paste in
	[Unit]
	Description=TigerVNC Server

	[Socket]
	ListenStream=5900
	Accept=yes

	[Install]
	WantedBy=sockets.target

	//create /etc/systemd/system/tigervnc@.service
	sudo nano /etc/systemd/system/tigervnc@.service

	#paste in
	[Unit]
	Description=TigerVNC Per-Connection Daemon

	[Service]
	ExecStart=-/usr/bin/Xvnc -inetd -query localhost -geometry 1440x900 -once -SecurityTypes=None
	User=nobody
	StandardInput=socket
	StandardError=syslog

	//use systemctl to start and enable
	sudo systemctl start tigervnc.socket
	sudo systemctl enable tigervnc.socket

	//reboot
	sudo reboot

以 ...:5900 登陆


## Re

	\n 	匹配一个换行符。
	\r 	匹配一个回车符。
	\s 	匹配任何空白字符
	\S 	匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。
	\t 	匹配一个制表符。
	\v 	匹配一个垂直制表符。

	$ 	匹配输入字符串的结尾位置。
	* 	匹配前面的子表达式零次或多次。
	+ 	匹配前面的子表达式一次或多次。
	. 	匹配除换行符 \n 之外的任何单字符。
	? 	匹配前面的子表达式零次或一次
	^ 	匹配输入字符串的开始位置
	:  	指明两项之间的一个选择。
	\b 	匹配一个单词边界，即字与空格间的位置。
	\B 	非单词边界匹配。

	eg: \b\S+


## Rust: Cargo

```
vim ~/.cargo/config

[source.crates-io]
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```


## Rust: Cargo: Error

```
[35] SSL connect error (schannel: next InitializeSecurityContext failed: Unknown error (0x80092013) - The revocation function was unable to check revocation because the revocation server was offline.)
```
Windows:
```
set CARGO_HTTP_CHECK_REVOKE=false
```


## Rust: Cargo: cargo-edit

```
cargo install cargo-edit

cargo add 
cargo rm 
cargo upgrade 
```


## Rust: Rustup

```
// Windows
set RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
// Bash
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
```


## Steam: VAC

- 关闭Steam

	C:\Program Files (x86)\Steam\bin\SteamService.exe /repair
	bcdedit /deletevalue nointegritychecks
	bcdedit /deletevalue loadoptions
	bcdedit /debug off
	bcdedit /deletevalue nx
	bcdedit.exe /set {current} nx OptIn

- 重启电脑


## TensorFlow: Could not find a version that satisfies the requirement tensorflow

参考: <https://pypi.org/project/tensorflow/#files>

TensorFlow版本目前还不支持Python新版本。

```
pip install tensorflow-cpu

```


## Tesserract

<https://github.com/UB-Mannheim/tesseract/wiki>
<https://github.com/tesseract-ocr/tessdata>

```
tesseract 01.png 02 -l chi_sim
```


## VMware: MacOS

Unlocker: 

<https://github.com/paolo-projects/unlocker/releases>

VMware Workstation Pro 16 许可证密钥，批量永久激活: 

	ZF3R0-FHED2-M80TY-8QYGC-NPKYF
	YF390-0HF8P-M81RQ-2DXQE-M2UT6
	ZF71R-DMX85-08DQY-8YMNC-PPHV8


## VSCode: 关闭侧边栏

	"editor.folding":false,
	"editor.glyphMargin": false,


## Visual CPP

在bing上搜索visual c++可得: 
<https://support.microsoft.com/zh-cn/help/2977003/the-latest-supported-visual-c-downloads>


## Waifu2x: 图像放大

<https://github.com/AaronFeng753/Waifu2x-Extension-GUI>


## Wget

	screen wget -r https://mirrors.sirung.com/source/fuchsia/ -c -np -T 5 -t 0


## Windows: Microsoft Visual C++ Build Tools下载

解决Visual C++ 14.0 is required问题  
下载:   
<http://go.microsoft.com/fwlink/?LinkId=691126>
参考:   
<https://blog.csdn.net/bbhdeal/article/details/81144783>
<https://devblogs.microsoft.com/python/unable-to-find-vcvarsall-bat/>


## Windows: host

<https://www.ipaddress.com/>

	ipconfig /flushdns


## Windows: powercfg

卓越性能

	powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61


## Windows: pppoe reconnect

- 1.bat :

~~~
:start
ping -n 2 114.114.114.114 | find "TTL=" >nul
if errorlevel 1 (
    rasdial rasdial 2021120326@cmu Cong@1998
)
timeout 5
goto:start
~~~

- 1.vbs :

~~~
set v=wscript.createobject("wscript.shell")
v.run "C:\Users\Shine\runtime\1.bat /start", 0
~~~

- regedit :

计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run


## Windows: 自动同步时间

管理员状态在CMD: 

	w32tm /register

在“服务”中找到“Windows Time”项，设置为自动启动，并启动服务。

在“计划任务”中新建计划任务，以最高权限运行: 

	w32tm /resync


## ssh: without password

- client

~~~
ssh-keygen -t rsa
scp id_rsa.pub ...@...:~/
~~~

- host

~~~
cd
mkdir ~/.ssh
mv id_rsa.pub ~/.ssh/
~~~


## 在线工具: 解压

<https://extract.me/>