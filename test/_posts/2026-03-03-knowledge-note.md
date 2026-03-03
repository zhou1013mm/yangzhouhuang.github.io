---
title: "Knowledge Note Around Generative Models"
excerpt: "Knowledge understanding and explanation on generative AI" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - CS
tags: 
  - AI
  - Note

---

# Diffusion-based denoise 

## 1. diffusion process : add noise & denoise & probablistic explanation



## 2. CFG (classifier free guidance)

> https://zhuanlan.zhihu.com/p/660518657

the formula of the method is 
\[
\hat\epsilon_{\theta} = \epsilon_{\theta,c} + \omega(\epsilon_{\theta,c}-\epsilon_{\theta})
\]
the common seen code of the formula :

```python
noise_pred = noise_pred_uncond + guidance_scale * (noise_pred_text - noise_pred_uncond)
```



## 3. UNet : for noise prediction



## 4. KL loss (Kullback–Leibler divergence / relative entropy)

\[
D_{\text{KL}}(P||Q) =\sum_{x\in\mathcal{X}}P(x)(\log P(x) - \log Q(x)) 
\]

so this definition is under the assumption that $Q(x)$ is the estimated distribution of $P(x)$, and $x$ is discrete.

## 5. VAE(variational auto-encoder) with KL loss 



# Flow-Matching-based denoise



# Python package usage 

## 1. einops

this package is usually exercised in tensor manipulation of Deep Learning, the advantages visible in the official tutorials

> https://www.bilibili.com/?spm_id_from=333.788.0.0

and the basic usage effects is shown :

> https://github.com/arogozhnikov/einops/blob/main/docs/1-einops-basics.ipynb

the basic usage is to `rearrange` the tensor's dimension sequence and to combine 2 dimensions , example:

```python
import einops
import torch

x = torch.tensor([[[1, 2], [3, 4]], [[5, 6], [7, 8]]]) # shape (2, 2, 2)
print(f"Original x: {x}")
print(f"Dimension-re-sequenced x: {einops.rearrange(x, 'b c d -> c b d')}") # shape (2, 2, 2)
print(f"Rearranged x: {einops.rearrange(x, 'b c d -> b (c d)')}") # shape (2, 4)
```

```bash
(DiT) huangyangzhou@huangyangzhou-MRGFG-XX:~/github/unified-world-model$ python ./../dreamzero/einopstest.py 
Original x: tensor([[[1, 2],
         [3, 4]],

        [[5, 6],
         [7, 8]]])
Dimension-re-sequenced x: tensor([[[1, 2],
         [5, 6]],

        [[3, 4],
         [7, 8]]])
Dimension-combined x: tensor([[1, 2, 3, 4],
        [5, 6, 7, 8]])
```

## 2. tqdm







