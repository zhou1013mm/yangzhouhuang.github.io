---
title: "Gmae PhotoShowcase"
excerpt: "photoshowcase for games in case I want to put some screenshoots together" # This line is the brief content of the post
header:
  teaser: "/assets/images/game/photoshowcase/kentucky-route-zero/5.webp"
  overlay_image: "/assets/images/game/photoshowcase/kentucky-route-zero/2.webp"
  og_image: "/assets/images/game/photoshowcase/kentucky-route-zero/2.webp"
categories:
  - Game
tags: 
  - showcase
---

This page should be structured differently because there are lots of games ---> need new method to put together, not just all display at once

## Some Games that Impressed me (I played them in 2024-2025)

I used to play digital games on web page and mobile phones. Most of my early time in games were occupied by [Roco Kingdom](https://baike.baidu.com/item/%E6%B4%9B%E5%85%8B%E7%8E%8B%E5%9B%BD/67258), [Honor of Kings](https://en.wikipedia.org/wiki/Honor_of_Kings), and [Minecraft](https://en.wikipedia.org/wiki/Minecraft). From 2012 to 2024, I did't play any games on STEAM or consoles like SWITCH. However in 2024.8 when I met my new roomate in my sophemore, I was attracted by the 3A game worlds he was playing on STEAM. So I started my first single-player game since then. My first play was [Horizon Zero Dawn](https://en.wikipedia.org/wiki/Horizon_Zero_Dawn). Till today , I've played about 80 games, spanning across different platforms and methods: I play STEAM, SWITCH, 3DS, and PS1, PS2, GBA etc. through emulators. 

So here are some games that impressed me a lot. This means maybe they're not the most highly rated I would give in terms of comprehensive rating, but unique for me in some way. For example, [Legend of Zelda: Breath of the Wild](https://en.wikipedia.org/wiki/The_Legend_of_Zelda:_Breath_of_the_Wild), [Grand Theft Auto IV](https://en.wikipedia.org/wiki/Grand_Theft_Auto_IV), and [Portal](https://en.wikipedia.org/wiki/Portal_(video_game)) are fascinating games as well but they're not that impressive, maybe for the themes or not strong in story (but fun to play still). 

### Disco Elysium

{% for i in (1..2) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/disco-elysium/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Kentucky Route Zero

{% for i in (1..2) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/kentucky-route-zero/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Witcher III: Wild Hunt

{% for i in (1..5) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/witcher-3/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Sekiro: Shadow Die Twice

{% for i in (1..1) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/sekiro/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Dark Souls

{% for i in (1..3) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/dark-souls/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Sable

{% for i in (1..5) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/sable/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

### Machinarium

{% for i in (1..3) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;margin-bottom:5px;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/game/photoshowcase/machinarium/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}
