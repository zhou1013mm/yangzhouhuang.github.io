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



## Claude 常用命令

https://code.claude.com/docs/en/cli-reference

