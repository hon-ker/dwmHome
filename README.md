# 样式展示

<img src="https://github.com/xclay-net/dwm/screenshot/all.png">
<img src="https://github.com/xclay-net/dwm/screenshot/statusbar.png">

# 目录结构
```bash
.dwm
├── alacritty               # alacritty 配置文件
│   ├── alacritty.yml
│   └── themes
│       └── snazzy.yaml
├── autostart.sh            # dwm启动脚本
├── dwm                     # dwm核心文件
│   ├── config.def.h
│   ├── config.h
│   ├── config.mk
│   ├── drw.c
│   ├── drw.h
│   ├── drw.o
│   ├── dwm
│   ├── dwm.1
│   ├── dwm.c
│   ├── dwm.o
│   ├── dwm.png
│   ├── Makefile
│   ├── patches             # 本dwm安装过的所有依赖，不想要可以删除
│   │   ├── dwm-autostart-20210120-cb3f58a.diff
│   │   ├── dwm-barpadding-20211020-a786211.diff
│   │   ├── dwm-cool-autostart-6.2.diff
│   │   ├── dwm-doublepressquit-6.3.diff
│   │   ├── dwm-fullgaps-6.4.diff
│   │   ├── dwm-fullgaps-toggle-20200830.diff
│   │   ├── dwm-fullscreen-6.2.diff
│   │   ├── dwm-hide_vacant_tags-6.3.diff
│   │   ├── dwm-moveresize-20221210-7ac106c.diff
│   │   ├── dwm-noborder-6.2.diff
│   │   ├── dwm-pertag-20200914-61bb8b2.diff
│   │   ├── dwm-rainbowtags-6.2.diff
│   │   ├── dwm-rotatestack-20161021-ab9571b.diff
│   │   ├── dwm-scratchpad-20221102-ba56fe9.diff
│   │   ├── dwm-status2d-6.3.diff
│   │   ├── dwm-statuspadding-6.3.diff
│   │   ├── dwm-tapresize-20200819-f04cac6.diff
│   │   ├── dwm-titlecolor-20210815-ed3ab6b4.diff
│   │   ├── dwm-underlinetags-6.2.diff
│   │   └── dwm-winicon-6.3-v2.1.diff
│   ├── transient.c
│   ├── util.c
│   ├── util.h
│   └── util.o
├── picom.conf              # picom的配置文件及美化
├── README.md
├── .zshrc                  # zsh主题配置
├── rofi                    # rofi的配置文件及美化
│   ├── config.rasi
│   └── themes
│       ├── dracula.rasi
│       ├── everblush.rasi
│       ├── forest.rasi
│       ├── gruv.rasi
│       ├── nord.rasi
│       └── onedark.rasi
├── screenshot
├── script                  # 自使用脚本
│   ├── net.sh              # 状态栏的网速显示的脚本
│   ├── setBacklight.sh     # dwm绑定快捷键，设置屏幕亮度
│   └── setVol.sh           # dwm绑定快捷键，设置音量
└── statusbar.sh            # 状态栏启动脚本
```

# 安装
|alacritty|替代默认的st终端，alacritty开箱即用，拥有非常好看的主题配色，具有很高的定制性|
|rofi|替代dwm默认的dmenu启动器，相当于是一款菜单栏|
|imlib2|状态栏每个程序的icon图标库，需要这个库的支持才能显示|
|picom|背景透明和窗口切换动画用的|
|feh|linux设置壁纸|
|acpi|获取电池状态信息（用于状态栏）|

## 安装依赖(arch为例)

1. 从官方源安装部分依赖
```bash
sudo pacman -S imlib2 alacritty rofi feh acpi
```

```bash
sudo pacman -S rofi
```

2. 从AUR下载 picom
比较特殊，咱们不用官方包里的，从AUR库下载（paru 或yay），官方包里的动画设置很一般

```bash
paru picom
```

找到 aur/picom-jonaburg-git 的对应的数字进行下载


## 安装主体dwm


```bash
git clone https://github.com/xclay-net/dwm.git  ~/.dwm
cd ~/.dwm/dwm
sudo make clean install
```

或者自己下载好后重命名成`.dwm` 文件，放在自己的home目录下（是个隐藏文件）


## 配置
把相关依赖的配置移动到相应文件夹下，只有picom比较特殊，其他全部移动到`~/.conifg/`文件夹下就可以

1. alacritty rofi
```bash
mv alacritty rofi ~/.config/
```

2. picom

```bash
mv picom.conf /etc/xdg/
```

如果没有上面讲到的几个文件夹，自行先创建一下，相信玩dwm的不是linux萌新。

## 最终效果
```bash
1. home 目录下的.dwm文件结构：

.dwm
├── autostart.sh
├── dwm
│   ├── config.def.h
│   ├── config.h
│   ├── config.mk
│   ├── drw.c
│   ├── drw.h
│   ├── drw.o
│   ├── dwm
│   ├── dwm.1
│   ├── dwm.c
│   ├── dwm.o
│   ├── dwm.png
│   ├── Makefile
│   ├── patches
│   ├── transient.c
│   ├── util.c
│   ├── util.h
│   └── util.o
├── README.md
├── screenshot
├── script
│   ├── net.sh
│   ├── setBacklight.sh
│   └── setVol.sh
└── statusbar.sh

2. home目录下的.config 文件结构:

.config
    ├── rofi
    |   ├── config.rasi
    |   └── themes
    |       ├── dracula.rasi     
    |       ├── everblush.rasi
    |       ├── forest.rasi
    |       ├── gruv.rasi
    |       ├── nord.rasi
    |       ├── onedark.rasi
    |       └── squared-nord.rasi
    ├── alacritty.yml
        ├── alacritty.yml
        └── themes
            └── snazzy.yaml

3. /etc/xdg 目录:

/etc/xdg
    └── picom.conf

```

个人在alacritty中使用了ohmyzsh,配置文件也已经放到该项目中`.zshrc`

安装配置结束，下一步运行。

# Run

## startx
```bash
startx ~/.dwm/autostart.sh 
```

## sddm 窗口启动器

创建启动文件

```shell
sudo vim /usr/share/xsessions/dwm.desktop  
```

把下面内容复制进去
```
[Desktop Entry]
Name=dwm
Comment=dwm 
Exec=dwm
Type=Application 
```

# 参考

## 主题参考

## Script 来源

## Patches列表


# TODO


