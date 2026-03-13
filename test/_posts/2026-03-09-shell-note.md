---
title: "Note On Shell Script Syntax "
excerpt: "learn Shell Script Syntax" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - Bash
  - Note

---

# 命令行待学

> https://linuxhandbook.com/ssh-broken-pipe-error/

 ssh 建立的反向隧道过久没被操作会出现以下错误而断开连接：

```bash
client_loop: send disconnect: Broken pipe
```

解决方案：这样设置或者把 `-o` 这三行在ssh的config里面设置好

```bash
ssh -N -R 1080:127.0.0.1:7897 \ 
    -o ServerAliveInterval=60 \
    -o ServerAliveCountMax=3 \
    -o TCPKeepAlive=yes \
    server11
```

检查：看输出结果是否包含`ServerAliveInterval=60` 等

```bash
ps aux | grep "server11"
```





