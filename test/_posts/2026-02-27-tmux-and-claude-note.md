---
title: "Tmux and Claude Note"
excerpt: "Easy Usage on Tmux & Claude" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - Tmux
  - Bash
  - Note
---

## tmux常用命令

> 在bash内

```bash
tmux new -s test 

tmux a -t test -d  # 加一个 -d 使如果有attach在test上的窗口，那么把他attach然后当前窗口进入

tmux list-windows -t test

tmux list-windows -a

tmux kill-session -t test

tmux kill-session -a

tmux send-keys -t test 'conda activate env && python train.py' C-m  # C-m 是 ctrl+m = enter

tmux ls

exit
```

> 进入tmux会话界面后

```bash
# ctrl+b,d
# ctrl+b,w

# ctrl+b,c
# ctrl+b,n
# ctrl+b,p

# ctrl+b,%  # split horizontally
# ctrl+b,"  # split vertically
# ctrl+b,←/→/↑/↓  # change the input sub-window

# ctrl+b,[	# Enter Copy Mode -> enable scroll in the window
# q  # Exit Copy Mode
# ctrl+b,]	# Paste buffer

# Ctrl+b Ctrl+←	# Resize left
# Ctrl+b Ctrl+→	# Resize right
# Ctrl+b Ctrl+↑	# Resize up
# Ctrl+b Ctrl+↓	# Resize down
```
在 tmux 内用命令行跑 jupyter notebook ：

```bash
jupyter nbconvert --to notebook --execute your_script.ipynb
```

或者转换成 `.py` 文件后再运行：

```bash
# 先转换
jupyter nbconvert --to python your_script.ipynb

# 再运行
python your_script.py
```

## rsync 常用命令

```bash
# -a: archive ; -v: verbose ; -z: transport in compressed mode(quicker) ; 
#./: transportation target
rsync -avz usr@x.x.x.x:/path/dir/file.xxx ./

# --include='xxx/***': means recursively includeing ; 
# --exclude="*": exclude all others 
rsync -avz usr@x.x.x.x:/path/dir --include='xxx/***' --exclude='*' ./
```

## scp 常用命令

copy file: remote 2 local

```bash
scp -P xxxx user@x.x.x.x:/remote/file.txt /local/path/
```

copy file: local 2 remote

```bash
scp file.txt user@x.x.x.x:/remote/path/
```

## ssh 常用命令---

#### 建立反向隧道

on local: （这里 server 填写 usr@x.x.x.x 或 ssh config 文件里的 Host 栏名字）

```bash
(base) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/unified-world-model/outputs$ ssh -N -R 1080:127.0.0.1:7897 server
```

on gpu server:

```bash
export ALL_PROXY=socks5h://127.0.0.1:1080
export HTTP_PROXY=$ALL_PROXY
export HTTPS_PROXY=$ALL_PROXY
```

#### 登陆 remote device （要在同一LAN内）

登陆（port 可以去ssh的config文件看）

```bash 
ssh guojia@210.28.135.71 -p 15022
```

登出

```bash
exit
```

## ffmpeg 常用命令

看视频色深，fps ，width ，height 等

```bash
ffprobe -v quiet -print_format json -show_streams input.mp4 | grep -E "(width|height|pix_fmt|bits_per|color)"
```

## 检查磁盘余量

```bash
df -h /path/
```

## Claude 常用命令

https://code.claude.com/docs/en/cli-reference

