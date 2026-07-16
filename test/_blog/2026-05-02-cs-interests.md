---
title: "CS Course Interests Note"
excerpt: "Interests inspired during CS course" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - CS
---

# OS

## Different OS, Maybe would try
Some Widely Used OS:
1. Elementary OS ---> AI said this looks mostly like MacOS
2. Ubuntu ---> my daily use & the mostly used Linux distro
3. Fedora ---> even Linus himself uses
4. Kali Linux ---> for Cyber Securtiy specifically 
5. Win95
6. Windows XP ---> brought NT kernel to great use ?
7. Windows 7
8. Windows 11 ---> I use this too
9. DOS system ---> games like 三国志5 run on this OS
10. MacOS

Newly found OS :
1. OpenEuler
2. KaihongOS
3. HarmonyOS  

I would only try the 1 2 5 6 8 9 for now. I learned that different OS use different kernel , like NT kernel , linux kernel , hybrid kernel (HarmonyOS use hybrid kernel with linux liteOS RTOS mixed up ?)

## Check different Strategies of files management and Memory Schedulling in different OS 
Maybe I would need to use the resource monitor to help this.

## Write C code using the OS provided API to visit and edit files 
I want to use my Huawei Pad to use termux for writing python and basic C code in a cocise way 

## Misc
 1. Learn Vim ---> faster code editing | learn hotkeys for faster editing and code reading as well
 2. Different Architeture differs (arm & amd )
 3. Flutter
 4. Termux
 5. ipv4 & ipv6 addresss differs
 6. natural venv functions brought by python ---> manage python venv on termux
 7. commands just for cool : https://www.youtube.com/watch?v=54UiVeQ_p7k    
   >  sudo apt install btop cmatrix
   > btop
   > cmatrix
 8. hyperland ---> for windows management




# Computer Architecture

## RAM
```bash
sudo dmidecode -t memory | grep "Memory Device" | wc -l
```
this will show the RAM infor , learn the meaning of information in the `dmidecode` command's display like `DMI type`, `Total Width=64 bits`, `Bank Locator: BANK 3`, `Speed: 6400 MT/s` etc.





# Computer Network

## bash command

```bash
(base) huangyangzhou@huangyangzhou-MRGFG-XX:~$ # 查看当前连接详情
nmcli connection show --active

# 查看 DNS 配置
systemd-resolve --status 2>/dev/null || resolvectl status

# 查看是否有 VPN/代理残留
ip link show
```

```bash
ping -M do -s 1432 www.bilibili.com  # 测试连接 ，1432+28=1460 宽度是否 <= mtu
```

```bash
sudo ip link set dev wlp0s20f3 mtu 1450 # 手动设置 mtu （临时？）
```

```bash
sudo sysctl -w net.ipv4.tcp_congestion_control=bbr # 或者 cubic （好像bbr更好？）
```

```bash
# 状态确认
sysctl net.ipv4.tcp_congestion_control

ip addr show wlp0s20f3 | grep mtu
```

```bash
# 查看路由表
ip route
```











