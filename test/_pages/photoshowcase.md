---
title: "Photoshowcase"
layout: splash 
permalink: /photoshowcase/
date: 2026-07-15
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/unsplash-image-1.webp
  actions:
    - label: "Learn More"
      url: "/terms/"
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "introduce the picture."
intro: 
  - excerpt: 'Display my photographys'
---

<div style="display:flex;gap:5px;align-items:center;">
  {% for i in (1..3) %}
    <img src="{{ '/assets/images/photoshowcase/display/tall/' | append: i | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
  {% endfor %}
</div>
<div style="display:flex;gap:5px;align-items:center;">
  {% for i in (4..6) %}
    <img src="{{ '/assets/images/photoshowcase/display/tall/' | append: i | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
  {% endfor %}
</div>

{% for i in (1..7) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/wide/' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}
