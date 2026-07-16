---
title: "Tmux and Claude Note"
excerpt: "Easy Usage on Tmux & Claude" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
toc: ture
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
ffprobe -v quiet -print_format json -show_streams input.mp4 | grep -E "(width|height|pix_fmt|bits_per|color|frame)"
```

## 检查磁盘余量

```bash
df -h /path/
```

## grep 常用

```bash
ls /path/xxx | grep 'word' | wc -l
```

count the time a word occurs in the `ls` command

## Claude 常用命令

https://code.claude.com/docs/en/cli-reference

## 检查正在监听的端口

```bash
netstat -tulnp | grep LISTEN
```





download datasets 

```bash
cd /data0/guojia/work_huang/RoboTwin
python download_robotwin_franka_randomized_500.py \
  --output-dir /data0/guojia/datasets/RoboTwin-randomized500
```



 see this repo /data0/guojia/work_huang/RoboTwin and see if the ./script/eval_policy.py or the
  eval_policy_client.py can be diirectly utilized by my model to do evaluation, my model is /data0/guojia/robotics/code/VACE/logdir/uwm_new_offline_views224/uwm_new_offline_views224_5e-5_96_action_new_rep_benti/0/20260321_015843/models_step39999.pt , make the script(new or slightly forked from the RoboTwin directory) based on the evaluation config in the VACE directory /data0/guojia/robotics/code/VACE/uwm_new/configs or refer to the robocasa evaluation workflow in the uwm_new directory and fork them into robotwin-style, name it eval_robotwin.py under /data0/guojia/robotics/code/VACE/uwm_new/experiments and notate the bash command
  of using it , like setting the necessary args combination examples(tasks to evaluate etc. ). also , if added necessary config files like test_vace_joint_robotwin.yaml under /data0/guojia/robotics/code/VACE/uwm_new/configs/ 





check this file and see how the data is loaded, because i have a new dataset (robotwin) which needs to be trained , i want to re-use this script , but the script i give you is a 50-episodes-in-one-hdf5 kind stored (from the robocasa bench). the robotwin data is stored at /data0/guojia/datasets/RoboTwin-randomized500/dataset ,you can see the one-episode-one-hdf5 kind of storation in path like /data0/guojia/datasets/RoboTwin-randomized500/dataset/adjust_bottle/franka_randomized_500/data  , also the data size , different kinds of data(ee_pose , videos , etc.) storing sequence / structure may differ , and the 





Successfully built SAM-2 antlr4-python3-runtime iopath
Installing collected packages: nvidia-cusparselt-cu13, mpmath, cuda-toolkit, antlr4-python3-runtime, typing_extensions, triton, tqdm, sympy, PyYAML, portalocker, pillow, nvidia-nvtx, nvidia-nvshmem-cu13, nvidia-nvjitlink, nvidia-nccl-cu13, nvidia-curand, nvidia-cufile, nvidia-cuda-runtime, nvidia-cuda-nvrtc, nvidia-cuda-cupti, nvidia-cublas, numpy, networkx, MarkupSafe, fsspec, filelock, cuda-pathfinder, omegaconf, nvidia-cusparse, nvidia-cufft, nvidia-cudnn-cu13, jinja2, iopath, cuda-bindings, nvidia-cusolver, hydra-core, torch, torchvision, SAM-2



```
check this script (/data1/guojia/work_huang/sam2/notebooks/video_predictor_example.ipynb) and the frontend & backend repo in
  the sam2 repo , tell me if I can deploy a local site or app or something to allow a continuous flow processing, the
  processing flow is : the videos are stored at (can be chosen) /data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test
  (eg./data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test/CoffeeServeMug/demo_1/agentview_left.mp4) in the
  frontend ,i want to 1. specify the path to the videos/video 2.the frontend show me the video's first frame 3. i can click
  the first frame to add positive & negative points to prompt sam2 what to mask   4. i can choose the mask color 5. i can mask
  multiple (2/3 kinds of objects) ---> in my robot task , i want to mask the drawer's pulling bar and the robot arm with
  black , and all exceptions are white . And this machine has 8 gpus so is able, i want to launch the site/app by local
  command (like deploy a site locally) and click by mouse to give the drawer's bar and robot arm a positive point and some
  other negatives , every video i give a instruction like this and then i click a 'go' then the video is processed by the
  deployed sam2 checkpoint(can parallel if able, like simaltaneously processing 8 videos on 8 gpus)
```

```
• Yes, you can deploy it locally now for the basic click-and-process workflow, if you put the videos under the path the demo al
ready serves.                                                                                                                  
                                                                                                                               
  What works now:                                                                                                              
                                                                                                                               
  - Local web app: yes.                                                                                                        
  - Select a video from the demo dataset path: yes.                                                                            
  - See the video and click positive/negative points: yes.                                                                     
  - Track up to 3 objects, then press the existing Track objects button: yes.                                                  
  - Export a processed video: yes.                                                                                             
                                                                                                                               
  What you need to do:                                                                                                         
                                                                                                                               
  - Put or symlink your .mp4 files under demo/data/gallery, or point DATA_PATH at a folder whose gallery/ subfolder contains th
em.                                                                                                                            
  - The backend already scans gallery/**/*.mp4, so if your videos are there, they can be served by the app.                    
                                                                                                                               
  What does not work “now”:                                                                                                    
                                                                                                                               
  - Arbitrary filesystem path browsing from the frontend.                                                                      
  - 8-GPU parallel batch processing.                                                                                           
  - A dedicated job queue for many videos.                                                                                     
  - A purpose-built “black selected objects, white everything else” batch pipeline; the demo is more interactive/effects-orient
ed.                                                                                                                            
                                                                                                                               
  If your question is only “can I use it now locally to click prompts on videos and run SAM2 on them?”, the answer is yes.     
                                                                                                                               
  Typical local run:                                           

  - Backend:                                                   

  cd /data1/guojia/work_huang/sam2/demo/backend/server                                                                         
  APP_ROOT=/data1/guojia/work_huang/sam2 \                                                                                     
  API_URL=http://localhost:7263 \                              
  DATA_PATH=/data1/guojia/work_huang/sam2/demo/data \                                                                          
  MODEL_SIZE=base_plus \                                       
  gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 0.0.0.0:7263 --timeout 60

  - Frontend:                                                  

  cd /data1/guojia/work_huang/sam2/demo/frontend                                                                               
  yarn install                                                 
  yarn dev --port 7262        

  Then open http://localhost:7262.                             

  For your immediate use case, the simplest path is:                                                                           

  1. Copy/symlink videos into demo/data/gallery/...                                                                            
  2. Launch frontend/backend locally                           
  3. Open each video                                           
  4. Click positive/negative points                            
  5. Press Track objects                                       
  6. Export/download the processed result                      

  If you want, I can next turn this repo into a version tailored for your dataset workflow instead of the generic demo.
```



```
 The practical solution is:                                                                                                                                                                                                                                	   Run only the backend on the GPU server                                                                                                                                    
                                                                                                                                                                            
  cd /data1/guojia/work_huang/sam2/demo/backend/server                                                                                                                      
  APP_ROOT=/data1/guojia/work_huang/sam2 \                                                                                                                                  
  API_URL=http://localhost:7263 \                                                                                                                                           
  DATA_PATH=/data1/guojia/work_huang/sam2/demo/data \                                                                                                                       
  MODEL_SIZE=large \                                                                                                                                                    
  gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7263 --timeout 60                                                                        
                                                                                                                                                                            
  Run the frontend on your own laptop                                                                                                                                       
                                                                                                                                                                            
  - clone/copy this repo to your laptop                                                                                                                                     
  - in demo/frontend, install deps on the laptop                                                                                                                            
  - start:                                                                                                                                                                  
                                                                                                                                                                            
  npm install --legacy-peer-deps                                                                                                                                            
  npm run dev -- --host 127.0.0.1 --port 7262                                                                                                                               
                                                                                                                                                                            
  Tunnel backend from laptop to server                                                                                                                                      
                                                                                                                                                                            
  ssh -N -L 7263:127.0.0.1:7263 server14
                                                                                                                                                                            
  Then open on your laptop:                                                                                                                                                 
                                                                                                                                                                            
  http://localhost:7262                                                                                                                                                     
                                                                                                                                                                            
  Why this works:                                                                                                                                                           
                                                                                                                                                                            
  - the frontend is hardcoded to call http://localhost:7263                                                                                                                 
  - with the SSH tunnel, your laptop’s localhost:7263 points to the server backend                                                                                          
  - clicks happen in your local browser                                                                                                                                     
  - SAM2 inference still runs on the GPU server                                                                                                                             
                                                                                                                                                                            
  So yes, your workflow is still deployable now, but the frontend should run on your laptop, not on the server.   
```

设置`$DATA_PATH` 变量

```

  cd /data1/guojia/work_huang/sam2/demo/backend/server && \
  APP_ROOT=/data1/guojia/work_huang/sam2 \
  API_URL=http://localhost:7263 \
  DATA_PATH=/data1/guojia/work_huang/sam2/demo/data \
  MODEL_SIZE=large \
  gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7263 --timeout 60

  Quick check before launch:

  echo "$DATA_PATH"

  It must print:

  /data1/guojia/work_huang/sam2/demo/data

  If it still prints nothing, that is why it falls back to /data.
```

on server: 

```bash
cd /data1/guojia/work_huang/sam2/demo/backend/server && \
env \
APP_ROOT=/data1/guojia/work_huang/sam2 \
API_URL=http://localhost:7263 \
DATA_PATH=/data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test \ # or /data1/guojia/work_huang/sam2/demo/data 
MODEL_SIZE=large \
gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7263 --timeout 60 
```

to use gpu :

```
conda create -n sam2-gpu python=3.10 -y                                                                                                                                   
  conda activate sam2-gpu                                                                                                                                                   

  pip install torch==2.5.1 torchvision==0.20.1 --index-url https://download.pytorch.org/whl/cu121

  cd /data1/guojia/work_huang/sam2
  export SAM2_BUILD_CUDA=0
  pip install -e '.[interactive-demo]'

  I suggest python=3.10 because this repo was written for that range and it is less fragile than your current 3.12 env.

  Verify GPU works before starting backend

  CUDA_VISIBLE_DEVICES=7 python - <<'PY'
  import torch
  print('torch', torch.__version__)
  print('cuda build', torch.version.cuda)
  print('cuda available', torch.cuda.is_available())
  if torch.cuda.is_available():
      print('device', torch.cuda.get_device_name(0))
  PY

  If that prints cuda available True, then start backend on that GPU:

  conda activate sam2-gpu
  cd /data1/guojia/work_huang/sam2/demo/backend/server

  export CUDA_VISIBLE_DEVICES=7
  export APP_ROOT=/data1/guojia/work_huang/sam2
  export API_URL=http://localhost:7263
  export DATA_PATH=/data1/guojia/sam2_app_data
  export MODEL_SIZE=base_plus

  gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7263 --timeout 60 	
```



```bash
Verify GPU works before starting backend

CUDA_VISIBLE_DEVICES=7 python - <<'PY'
import torch
print('torch', torch.__version__)
print('cuda build', torch.version.cuda)
print('cuda available', torch.cuda.is_available())
if torch.cuda.is_available():
    print('device', torch.cuda.get_device_name(0))
PY

  If that prints cuda available True, then start backend on that GPU:

conda activate sam2-gpu
cd /data1/guojia/work_huang/sam2/demo/backend/server

export CUDA_VISIBLE_DEVICES=7 \
export APP_ROOT=/data1/guojia/work_huang/sam2 \
export API_URL=http://localhost:7263 \
export DATA_PATH=/data1/guojia/work_huang/sam2/demo/data \ 
export MODEL_SIZE=large \

gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7263 --timeout 60


###################################################
export DATA_PATH=/data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test \ # or /data1/guojia/work_huang/sam2/demo/data 
export MODEL_SIZE=large # or base_plus
```



```
› ok , now it runs well, i now have several questions/problems to solve:  1. i don't want to download the processed videos on local
  machine and in a compressed way (i want the original clarity shown on the web, now the downloaded ones are opaque periodically, maybe
  it's because i downloads them by the downloading button on the web frontend, this interface may automatically compress the video and
  make it bad), like: around every 2 seconds it become opaque across the whole frame   2. i don't want objects and background display
  effects choosing stage in the original frontend workflow(in the original frontend , first you choose a video, then you click the
  positive & negative points then the machine track the objects , then if you accep the results , you enter the second stage to choose the
  effects of the objects and background respectively , finally you can download the video on local machine), i want specific pattern of
  masking : one is white background & black objects , another is white background & original pixel objects  3. i don't want to download
  the videos on local machine so i just want to edit and specify the positive & negative points on the web-frontend and the server backend
  process it , i check if it's ok , if yes , click 'pass' and the original processed video (not automatically compressed or downsampled
  one)is saved at the origianl path as name: [original_video_name]_masked_original.mp4/_masked_black.mp4  4. i want to change the first
  stage of the using sam2 workflow on frontend : choose videos by pictures , the original choosing video pattern is : the web displays all
  the videos' cover picture and you choose, now i want the file-system choosing pattern, like you can direct through the DATA_PATH's
  subdirectories and choose mp4 files by name not cover pictures ------------------------if you can help to edit all these problems , help
  edit , if there are problems you have , tell me
```



```bash
What the new flow does

  - Browse videos by directory and .mp4 filename under VIDEO_ROOT
  - Click positive/negative points and track as before
  - No effects-selection stage
  - Pass & save on server writes both:
      - [original]_masked_black.mp4
      - [original]_masked_original.mp4
  - Files are written next to the source video path on the server
  - Export uses original video resolution and source fps, not the frontend downloader

  How to run
  Use a writable app-data dir and a separate browse root:

  export APP_ROOT=/data1/guojia/work_huang/sam2
  export API_URL=http://localhost:7263
  export DATA_PATH=/data1/guojia/sam2/
  export VIDEO_ROOT=/data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test
  export MODEL_SIZE=base_plus
  export OUTPUT_VIDEO_CRF=10

  DATA_PATH must be writable. VIDEO_ROOT is where the file browser looks for videos.

  Problems / caveats

  - Saving next to the original file requires write permission in that source directory. If the dataset tree is read-only, the new save
    button will fail.
  - I verified backend Python syntax with py_compile, but I could not run a frontend build in this server session because the server still
    lacks working Node package installation.
  - GPU use is still an environment issue, not a code issue. This patch does not solve the driver/PyTorch mismatch.

  If you want, next I can help you with the exact backend launch command for this new DATA_PATH + VIDEO_ROOT setup, or help patch the
  frontend further if you hit a specific UI/build error.
```



```bash
DATA_PATH                                                                                                                                
                                                                                                                                           
  - App-managed writable directory for the backend.                                                                                        
  - It is used for backend-owned subfolders like gallery/, uploads/, and posters/.                                                         
  - This path must be writable by your user.
  - In the new workflow, it is still required even if your real videos live elsewhere.

  Example:

  DATA_PATH=/data1/guojia/sam2_app_data

  VIDEO_ROOT

  - Root directory that the new frontend file browser exposes.
  - The browser will let you navigate subdirectories under this path and choose .mp4 files by name.
  - This can point directly at your dataset tree.
  - It does not need to be inside the repo.
  - It does not need to be writable for browsing, but it does need to be readable.
  - If you want saved outputs written next to the original video, then the chosen source directory also needs write permission.

  Example:

  VIDEO_ROOT=/data1/guojia/datasets/RoboCasa-Cosmos-Policy-all/video_test

  OUTPUT_VIDEO_CRF

  - FFmpeg/H.264 quality setting for the server-side saved videos.
  - Lower value means better quality and larger files.
  - Higher value means more compression and lower quality.
  - Typical values:
      - 10: high quality
      - 18: visually very good
      - 23: default-ish compressed
  - For your use case, lower is better because you want to avoid the bad-looking frontend export behavior.

  Example:

  OUTPUT_VIDEO_CRF=10

  Practical summary:

  - DATA_PATH: backend working/storage area
  - VIDEO_ROOT: where you browse original videos from
  - OUTPUT_VIDEO_CRF: quality/compression of the saved masked output videos
```





The main failure is very likely a port conflict on your local machine.

You are forwarding local 7265 with SSH and also trying to run Vite on local 7265 at the same time.

- SSH command opens a local listener on 7265.
- Vite then cannot reliably bind 7265, and may fail or switch ports.
- If Vite switches port, your auto-mapping logic may not match, so requests go wrong.

Use this exact setup for one frontend (local 7265) + one backend (remote 7264):

1. On server14 (backend)
cd /data1/guojia/work_huang/sam2/demo/backend/server && conda activate sam2-gpu && export CUDA_VISIBLE_DEVICES=7 && export APP_ROOT=/data1/guojia/work_huang/sam2 && export API_URL=http://localhost:7264 && export DATA_PATH=/data1/guojia/work_huang/sam2/demo/data && export VIDEO_ROOT=/data1/guojia/work_huang/sam2/demo/data && export MODEL_SIZE=large && export OUTPUT_VIDEO_RATE_CONTROL=source_bitrate && export OUTPUT_VIDEO_CODEC=libx264 && export OUTPUT_VIDEO_PRESET=medium && gunicorn --worker-class gthread app:app --workers 1 --threads 2 --bind 127.0.0.1:7264 --timeout 60

2. On local machine, only tunnel backend port (do NOT tunnel 7265)
ssh -N -L 7264:127.0.0.1:7264 server14

3. On local machine, run frontend on 7265 with strict port and explicit backend endpoint
cd ~/github/sam2/demo/frontend
VITE_VIDEO_API_ENDPOINT=http://127.0.0.1:7264 VITE_INFERENCE_API_ENDPOINT=http://127.0.0.1:7264 npm run dev -- --host 127.0.0.1 --port 7266 --strictPort

Quick checks:
1. Before starting Vite, verify tunnel works:
curl http://127.0.0.1:7264/healthy
You should get OK.

2. When Vite starts, confirm it says Local: http://127.0.0.1:7265 (exactly 7265).

3. In browser devtools Network, verify requests go to 127.0.0.1:7264.

If you want, I can give you a clean 4-user command matrix that avoids all frontend-port tunnels and only tunnels backend ports, which is the safest pattern.











Great question. The key is: your `ssh -L` setup is **local port forwarding**, not reverse forwarding.

Why one tunnel is enough now:
1. The frontend dev server (`npm run dev`) is running on your local machine, so browser -> frontend traffic is already local (`127.0.0.1:7262`, `7265`, etc.).
2. Only the backend is remote (on `server14`), so only frontend/browser -> backend traffic needs SSH forwarding.
3. Therefore you only need `-L` for backend ports (like `7263`, `7264`, ...), not frontend ports.

Why it seemed to work before with two `-L` ports (`7262` and `7263`):
1. `-L 7263:127.0.0.1:7263` was the useful one (backend API).
2. `-L 7262:127.0.0.1:7262` was redundant if Vite also ran locally on 7262.
3. It can still “appear fine” because:
- Either SSH failed to bind 7262 but kept running with 7263 forwarding.
- Or start order made one side win the port and you didn’t need the other anyway.
- Or frontend wasn’t actually using that forwarded 7262 path at all.

Simple rule:
1. Local frontend -> no tunnel needed for frontend port.
2. Remote backend -> tunnel backend port(s) only.
3. Use explicit env (`VITE_*_ENDPOINT`) to point each frontend to its intended local forwarded backend port.









› check the code of this porject,/data1/guojia/work_huang/sam2  i'm
  deploying the frontend and the backend , now it's working well , but
  i found during the second stage of the object selecting & tracking
  process , the if the first time tracking doesn't match my
  expectation, i want to re-track it by adding more positive &
  negative points , after i added , i can click 'track object' again ,
  but the model inferred mostly by old points (not newly added ones)
  or even just ignored them , what i want this button's workflow is :
  it ignore the last time inferernce output but keep the positive &
  negative points i added , after then, using the old & newly added
  points together to infer from scratch . if you can edit this , then
  edit
