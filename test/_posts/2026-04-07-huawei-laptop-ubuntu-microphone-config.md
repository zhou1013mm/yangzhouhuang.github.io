---
title: "How I Fixed My Huawei Laptop's Ubuntu Microphone Unavailability"
excerpt: "Ubuntu Microphone Setup on Huawei Laptop" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - CS
  - Audio
---

During my recent work, I need to communicate with my colleagues on our lab's project. But I found my Huawei laptop's mic wasn't usable which makes the online communication inconvenient. Actually, there even showed NO Input device available in the Setting panel.

Here is a walkthrough of how I solved this problem.

## Concise fix 
edit the `GRUB` config file by 
```bash
nano /etc/default/grub
```
and substitute this 
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash snd_intel_dspcfg.dsp_driver=1"
```
with
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```
save the file and update `GRUB` with 
```bash
sudo update-grub
```
reboot the computer
```bash
sudo reboot
```
now you should be able to find the input device in the seting panel and it's working correctly.
## Explanation
Concisely present the WHY: the Codec of my Huawei Laptop is Conexant CX11970. However, the laptop also contains an inner digital microphone array (DMIC) which requires Intel SST (Smart Sound Technology) to drive.

The SST was avoided by GRUB config setting `snd_intel_dspcfg.dsp_driver=1`. This parameter forces the system to use only the traditional HDA driver (snd-hda-intel), bypassing SST completely. As a result, the DMIC array became invisible to the system.

Valid values for `dsp_driver`: 0=auto-detect, 1=disable SST (our problematic setting), 2=force SST, 3=use SOF firmware.

The Bluetooth headphone's mic wasn't working right before this fix is bacause : my laptop uses Pipewire to support the Bluetooth , but Pipewire needs at least a properly routed backend for processing (which needs at least a normally workable set of input & output). In my case, that is say the inner digital mic must be workable as well to meet this requirement.

So by unsetting `snd_intel_dspcfg.dsp_driver=1`, the Intel SST was activated ---> supports a basic workable input & output set (inner digital mic & speaker) ---> Pipewire found that input list wasn't void still, so it routes normally ---> Bluetooth mic workable as well.

**Before Fix:**

```
┌─────────────────────────────────────────┐
│  华为笔记本音频硬件                       │
│                                         │
│  ┌─────────────┐    ┌─────────────┐      │
│  │ 内置数字麦克风 │    │  CX11970    │      │
│  │  (DMIC阵列)  │    │ (模拟Codec)  │      │
│  │             │    │             │      │
│  │ 需要Intel SST │    │ 管理:耳机孔/扬声器│     │
│  │   驱动       │    │             │      │
│  └──────┬──────┘    └──────┬──────┘      │
│         │                  │              │
│         │ 被GRUB参数禁用    │  ← 唯一可用路径   │
│         ▼                  │              │
│      [未加载]              ▼              │
│                      ┌──────────┐         │
│                      │  snd-hda │         │
│                      │  -intel  │         │
│                      └────┬─────┘         │
│                           │              │
│                           ▼              │
│                      ┌──────────┐         │
│                      │ PipeWire │         │
│                      │  无输入设备 │ ← 问题！ │
│                      └──────────┘         │
└─────────────────────────────────────────┘
```
**After Fix:**
```
┌─────────────────────────────────────────┐
│  华为笔记本音频硬件（双路径并行）          │
│                                         │
│  ┌─────────────┐    ┌─────────────┐      │
│  │ 内置数字麦克风 │    │  CX11970    │      │
│  │  (4ch DMIC)  │    │ (模拟Codec)  │      │
│  │             │    │             │      │
│  │ 走Intel SST │    │ 走HDA总线    │      │
│  │  48kHz/32bit │    │ 48kHz/24bit  │      │
│  └──────┬──────┘    └──────┬──────┘      │
│         │                  │              │
│         ▼                  ▼              │
│    ┌─────────┐        ┌─────────┐       │
│    │snd_sof  │        │snd-hda  │       │
│    │_intel   │        │_intel   │       │
│    └────┬────┘        └────┬────┘       │
│         │                  │            │
│         └────────┬────────┘            │
│                  ▼                      │
│            ┌──────────┐                 │
│            │ PipeWire │                 │
│            │ 多输入设备 │ ← 内置麦+蓝牙麦  │
│            │ 可选      │                 │
│            └──────────┘                 │
└─────────────────────────────────────────┘
```
#### GRUB
GRUB (short for GNU GRand Unified Bootloader, commonly referred to as GRUB) is a boot loader package from the GNU Project. So the `/etc/default/grub` config file contains the configuration information of how the Ubuntu system would be initialized when booting, including how the firmwares like microphone and speaker is selected during boot.
#### Codec & Intel SST
Codec means differently in CS. Different encoding technologies of sound data is called codec, `.mp4`, `.aac` ,`.wav` for example, as we see them in our music files. However, Codec can mean codec chip which recieves original PCM (Pulse Code Modulation) signal flow from CPU and transform them into analog signal flow.

Intel SST is a driver system for Intel-Chip based sound signal processing chips. In my Huawei Laptop (2024 Matebook X Pro), the Codec chip is Conexant CX11970, and the it contains a digital microphone which requires Intel SST to drive.

However, the Intel SST was muted by `GRUB` setting `snd_intel_dspcfg.dsp_driver=1`. That's the core cause of the unseen input device list.

The Bluetooth headphones also needs Intel SST to do drive (?) so the Bluetooth Mic wasn't available. By setting the config correctly, both the Bluetooth and the inner mic came alive.
#### alsa & PulseAudio & Pipewire
alsa : advanced linux sound architeture
PulseAudio : the contemporary commonly used middle layer of between the software app and the computer's firmwares. It's concretely referred to as a sound routing service (?). 
#### A2DP & HSP/HFP
When using the Bluetooth headphones, there always contains 2 different output mode you can choose: headphone & handsfree . In my  case, i can choose my computer sound output from : 
```
1. Speaker
2. Headphone - Bose QC Headphone
3. Handsfree - Bose QC Headphone
```
You can choose the Headphone and Handsfree mode to test the difference. There difference comes from different sound signal route based on different signal collecting circuites based on A2DP & HSP/HFP protocols. 

Both A2DP and HSP/HFP are Bluetooth sound protocols.

A2DP is advanced audio distribution profile which is designed for high definition, quality sound. it collects signal with 48kHz , 16bit depth, for a set of two-ears headphone, the raw digital flow bandwith is 48k x 16bit x 2 = 1.536Mbps ---> after compression: 576kbps. 

HSP is headset profile while HFP refers to hands-free profile. HSP/HFP are older than A2DP but requires less bandwidth. They each collects signal at 16kHz, 16bit depth, and after compression bandwidth comes to 64kbps each. 

You may found the listensing sound quality changed during phoneing with other people. That's because the now-in-use Bluetooth 2.0 protocol limits the max bandwidth of data flow to 1Mbps , while a double-tunnel A2DP would requires 2 x 576kbps > 1Mbps. Also, A2DP doesn't contain upper stream collecting path (can only used for sound playing) because it was just designed for high quality listening. Besides, they share different circuites. HSP/HFP shares a set and A2DP consumes a set separately. 

For the reasons above, during phone call , your phone or computer would change the data flow path from A2DP to HSP/HFP (HFP is the upgraded version of HSP, based on vechicle scenes).
## Note of Other Learned 

#### alsa & PulseAudio command
> pactl means pulseaudio control

```bash
# 查看所有录音设备（麦克风）
pactl list sources short

# 查看所有播放设备（扬声器/耳机）
pactl list sinks short

# 设置默认输入/输出
pactl set-default-source [设备名]
pactl set-default-sink [设备名]

# 查看当前默认设备
pactl info | grep -E "Default Sink|Default Source"

# 查看声卡详细配置（包括活跃Profile）
pactl list cards | grep -A 20 "你的设备名"

# 蓝牙设备切换Profile（A2DP ↔ HFP）
pactl set-card-profile bluez_card.XX:XX:XX a2dp-sink
pactl set-card-profile bluez_card.XX:XX:XX headset-head-unit-msbc

# 内核日志查看音频驱动
sudo dmesg | grep -i "snd\|sof\|hda"

# 查看已加载的音频模块
lsmod | grep snd
```

#### ubuntu system command
> dmesg means diagnostic message

```bash
# 内核日志（查看驱动加载/硬件检测）
sudo dmesg | grep -i "snd\|sof\|hda\|audio"

# 查看内核模块参数（如SST驱动配置）
systool -v -m snd_intel_dspcfg 2>/dev/null | grep dsp_driver
# 或
cat /sys/module/snd_intel_dspcfg/parameters/dsp_driver

# 查看已加载的音频模块
lsmod | grep snd

# 查看PCI音频设备
lspci -nnk | grep -A3 Audio

# 查看ALSA硬件信息
cat /proc/asound/cards
cat /proc/asound/card0/codec#0  # 编解码器详情

# 查看USB音频设备（如有外接声卡）
lsusb | grep -i audio
```



 # Related Problem solve: Line-in 3.5mm headphone no response 

#### solution : change the pin configuration of the corresponding pin @ the 3.5mm hole

use HDAJackRetask , select codec : mine is Conexant CX11970. edit the pin with title like 'Black Headphone, Left side' , select its usage as 'headphone' in 'advanced override' mode, apply it and reboot your computer (may be stuck, then shut down and boot again)

#### side-effect : online video bad playing

the clock of video & audio parsing dismatch, leading to the consequence of online video playing stuck ,(can play , but ususally buffering / choppy).
