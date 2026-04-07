---
title: "Unified World Model Code Learning"
excerpt: "Learn the architecture of UWM from code" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - Model Architecture
  - Python
  - Note
---

# Torch

> https://www.codegenes.net/blog/netmodule-pytorch/
>
> https://www.machinelearningexpedition.com/how-to-train-multilayer-perceptron-in-pytorch/
>
> https://timm.fast.ai/schedulers
>
> https://www.geeksforgeeks.org/deep-learning/adam-optimizer/

## Basic Usage of Torch : `nn.Module` and `nn.Sequential` etc.

1. initialize, load, save the checkpoint:

   ```python
   # initialize
   torch.manual_seed(0)
   mlp = SimpleModule(...)
   
   # load 
   state = torch.load(ckpt_path, map_location="cpu")
   mlp.load_state_dict(state)
   
   # save
   torch.save(mlp.state_dict(),ckpt_path)
   ```

2. Model architecture writing for save and reuse the weights & bias

   ```python
   class SimpleModule(nn.Module):
       """Simple MLP with persistent layers."""
   
       def __init__(
           self,
           layer_number: int = 1,
           input_dim: int = 10,
           output_dim: int = 1,
       ):
           super().__init__()
           layers = []
           for i in range(layer_number):
               in_dim = input_dim
               out_dim = output_dim if i == layer_number - 1 else input_dim
               layers.append(nn.Linear(in_dim, out_dim))
               if i < layer_number - 1:
                   layers.append(nn.ReLU())
           self.net = nn.Sequential(*layers)
   
       def forward(self, x):
           return self.net(x)
   ```

   The writing below cannot keep the weights because each time the `mlp` object is  created, the layers in it are re-initialized in the `__init__(...)`  method, but if use `torch.manual_seed(0)` in the `main()` would make the output the same each time calling the script (same seed).

   ```python
   class SimpleModule(nn.Module):
       def __init__(self, input_dim=4, hidden_dim=4, output_dim=2):
           super().__init__()
           self.linear1 = nn.Linear(input_dim, hidden_dim)
           self.relu = nn.ReLU()
           self.linear2 = nn.Linear(hidden_dim, output_dim)
   
       def forward(self, x):
           x = self.linear1(x)
           x = self.relu(x)
           x = self.linear2(x)
           return x
   ```

3. code explained

   ```python
   # this two equals
   output = mlp(x)
   
   output = mlp.forward(x)
   ```

   `try...except` writing to cover different situations

   ```python
   if os.path.exists(ckpt_path):
           try:
               state = torch.load(ckpt_path, map_location="cpu")
               mlp.load_state_dict(state)
               print(f"loaded checkpoint from {ckpt_path}")
           except RuntimeError as exc:
               # Likely from an old checkpoint with different layer names; start fresh.
               print(f"failed to load old checkpoint ({exc}); reinitializing weights")
       else:
           print("no checkpoint found, using fresh weights")
   ```

   1st & 2nd ouputs:

   ```bash
   (deepcode) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/unified-world-model/self-scripts$ python self-MLP.py 
   failed to load old checkpoint (Error(s) in loading state_dict for SimpleModule:
           Missing key(s) in state_dict: "net.0.weight", "net.0.bias", "net.2.weight", "net.2.bias". ); reinitializing weights
   model input: tensor([[1., 2., 3., 4.]])
   model output: tensor([[ 0.4872, -0.0244]], grad_fn=<AddmmBackward0>)
   saved checkpoint to MLP.pth
   
   
   (deepcode) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/unified-world-model/self-scripts$ python self-MLP.py 
   loaded checkpoint from MLP.pth
   model input: tensor([[1., 2., 3., 4.]])
   model output: tensor([[ 0.4872, -0.0244]], grad_fn=<AddmmBackward0>)
   saved checkpoint to MLP.pth
   ```
   
## Train and evaluate model



# Diffusion

## CFG (classifier free guidance)

> from `models.py` in DiT github repo

```python
    def forward_with_cfg(self, x, t, y, cfg_scale):
        """
        Forward pass of DiT, but also batches the unconditional forward pass for classifier-free guidance.
        """
        # https://github.com/openai/glide-text2im/blob/main/notebooks/text2im.ipynb
        half = x[: len(x) // 2]
        combined = torch.cat([half, half], dim=0)
        model_out = self.forward(combined, t, y)
        # For exact reproducibility reasons, we apply classifier-free guidance on only
        # three channels by default. The standard approach to cfg applies it to all channels.
        # This can be done by uncommenting the following line and commenting-out the line following that.
        # eps, rest = model_out[:, :self.in_channels], model_out[:, self.in_channels:]
        eps, rest = model_out[:, :3], model_out[:, 3:]
        cond_eps, uncond_eps = torch.split(eps, len(eps) // 2, dim=0)
        half_eps = uncond_eps + cfg_scale * (cond_eps - uncond_eps)
        eps = torch.cat([half_eps, half_eps], dim=0)
        return torch.cat([eps, rest], dim=1)
```

解释：

> if i give a 3 x 256 x 256 image , what would the latent shape be? and how would the latent be computed by cfg (just a example for my understanding , no need to run really)
>
> - GitHub Copilot
>
>   - A 3×256×256 RGB image would be encoded by the SD-style VAE to a latent of shape **4×32×32** (downsample by 8× in H and W, with 4 latent channels).
>
>   - With `learn_sigma=True`, the DiT output per step is 8×32×32 (4 noise + 4 variance); if `learn_sigma=False`, it’s 4×32×32 (noise only).
>
>   - CFG example (batch size 2 for simplicity):
>     - Stack cond and uncond latents: `combined = [x0, x0]` → shape 2×4×32×32.
>     - Run model → `model_out`.
>     - Split: `eps = model_out[:, :3]` (RGB-ish latent channels), `rest = model_out[:, 3:]` (4th latent channel + any sigma channels).
>     - Split `eps` into cond/uncond: `cond_eps, uncond_eps`.
>     - Guided noise: `guided = uncond_eps + cfg_scale * (cond_eps - uncond_eps)`.
>     - Duplicate guided to match batch, then `torch.cat([guided, guided], dim=0)`; finally reattach `rest` → output batch of shape matching `model_out` (either 2×4×32×32 or 2×8×32×32).
>

## DDPM & DDIM (denoising diffusion probablistic / implicit model)

根据预测目标分为两类：

|                | ε-prediction      | x0-prediction            |
| -------------- | ----------------- | ------------------------ |
| **模型输出**   | 噪声图 $\epsilon$ | 干净图像 $x_0$           |
| **去噪方式**   | 减噪声            | 用x0重构中间步骤         |
| **CFG适用性**  | 直接适用          | 需要调整公式             |
| **数值稳定性** | 标准              | 有时更好（尤其高分辨率） |

工作流程：

```
Step 50: 纯噪声 [██████████] 模型预测:"这是猫+噪声"
                ↓ 减去预测噪声
Step 40: 模糊轮廓 [░░▓▓░░▓▓░░] 模型预测:"还有这些噪声"
                ↓
Step 20: 大致形状 [░▓▓▓▓▓▓░░] 模型预测:"细节处还有噪声"
                ↓
Step 0:  清晰图像 [▓▓▓▓▓▓▓▓▓▓] "生成完成"
```

## FID score (Fréchet Inception Distance) 

FID 衡量生成图像与真实图像在"特征空间"中的分布距离，越低越好（理想值0，优秀<10，较差>50）。

### 为什么需要FID？

- 人眼看图主观、慢、无法量化
- 需要自动评估生成质量+多样性

# Bash   

## Basic Usage of `du` command to check the directory information

```bash
du -sh /home/huangyangzhou/miniconda3/envs/deepcode/lib/python3.13/site-packages/torch/lib/*.so* 2>/dev/null | sort -hr | head -15
```

| 部分          | 作用                                                         |
| ------------- | ------------------------------------------------------------ |
| `du -sh ...`  | 显示每个 `.so` 文件的总大小（human-readable）                |
| `*.so*`       | 匹配所有共享库文件（`.so`, `.so.1`, `.so.2` 等）             |
| `2>/dev/null` | 把错误信息（如权限不足）丢进黑洞，不显示                     |
| `| sort -hr`  | 按人类可读的大小格式**降序**排列（`-h` 支持 K/M/G，`-r` 逆序） |
| `| head -15`  | 只显示前 15 行（最大的 15 个文件）                           |

simple usage forked myself: 

```bash
(base) huangyangzhou@huangyangzhou-MRGFG-XX:~$ du -ah --max-depth=1 2>/dev/null | sort -hr | head -5
190G    .
54G     ./.docker
33G     ./.cache
29G     ./.local
22G     ./Downloads
```

pay attention  `-sh` `-ah`

```bash
du -sh file_or_dir      # 看这个文件/文件夹总共多大（最常用）
du -sh */               # 当前目录下每个子文件夹多大
du -ah --max-depth=1    # 当前目录下所有文件+文件夹多大，--max-depth 不能和 -s 同用
ls */        # 列出所有子目录的内容
```

## Basic Usage of `tail` command

```bash
tail -n 100 environment.yml  # show last 100 rows :
tail -f test.txt  # the display content would change dynamically as the test.txt changes
```

## Basic Usage of `rg` (ripgrep) command

| 选项                    | 简写 | 功能                         |
| ----------------------- | ---- | ---------------------------- |
| `--line-number`         | `-n` | 显示行号                     |
| `--ignore-case`         | `-i` | 忽略大小写                   |
| `--word-regexp`         | `-w` | 整词匹配(如error不会匹配出errors)                     |
| `--fixed-strings`       | `-F` | 按字面意思搜索（不解析正则符号`|`） |
| `--glob`                | `-g` | 按文件名模式过滤             |
| `--after-context`/`--before-context`/`--context`             | `-A/-B/-C` | 显示匹配行前/后/上下都有 N 行          |
| `--count`               | `-c` | 只显示匹配次数               |
| `--hidden`              | `-.` | 搜索隐藏文件                 |

| 示例                     | 含义                          |
| ------------------------ | ----------------------------- |
| `rg "TODO" -g "*.py"`    | 只在 `.py` 文件中搜索         |
| `rg "TODO" -g "*.md"`    | 只在 Markdown 文件中搜索      |
| `rg "class" -g "model*"` | 只在 `model` 开头的文件中搜索 |

示例：

```bash
(DiT) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/DiT$ rg -n "AutoencoderKL" -g "*.py"
train.py
32:from diffusers.models import AutoencoderKL
151:    vae = AutoencoderKL.from_pretrained(f"stabilityai/sd-vae-ft-{args.vae}").to(device)

sample_ddp.py
19:from diffusers.models import AutoencoderKL
79:    vae = AutoencoderKL.from_pretrained(f"stabilityai/sd-vae-ft-{args.vae}").to(device)
```

更高级应用： 在当前路径下的子路径中搜索

```bash
rg -t 'txt' "avg_success_rate" ./sub/path
```



## Basic Usage of `ffmpeg` command

video & image : `.jpg / .png / .mp3 / .webm`

```bash
```

sound file : `.wav / .avif / .mp4`



## Basic Usage of Environment management by `Conda` 

environment transmit and copy

```bash
conda env create -f environment.yml  # create environment from config file
conda env export > environment.yml  # create config file and save environment infor inside 
```

Conda configuration in the `~/.bashrc` to mangae bash behavior of Conda  

## Basic Usage of `git` command & python code

稀疏检出 & 只拉最新版本

```bash
# 1. 克隆仓库骨架（不下载文件内容）
# git clone --depth 1 --filter=blob:none --sparse https://github.com/madebyollin/taesd.git
git clone --depth 1 --filter=blob:none --no-checkout https://github.com/madebyollin/taesd.git

# 2. 进入目录
cd taesd

# 3. 初始化非 cone 模式（支持文件级过滤）
git sparse-checkout init --no-cone

# 4. 设置规则：包含所有，排除权重文件
git sparse-checkout set "/*" "!*.pt" "!*.safetensors"

# 5. 检出文件
git checkout

# 6. 查看结果
ls -lh
```

通过`ssh` 登陆 github：

```bash
# 看有没有公钥，名字如 xxx.pub ，若没有则去生成 
ls -al ~/.ssh 

# 把公钥内容打印出来，复制粘贴到 github 上自己新创建的 ssh key（authentication类型）里
cat ~/.ssh/hyz_rsa.pub

# 最后用 ssh 命令登录 bash 到 github
(base) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/yangzhouhuang.github.io$ ssh -T git@github.com
Hi zhou1013mm! You've successfully authenticated, but GitHub does not provide shell access.

```



## Basic Usage of `wandb` command & python code



