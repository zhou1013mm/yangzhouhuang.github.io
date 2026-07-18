---
title: "Photoshowcase"
layout: splash 
permalink: /photoshowcase/
date: 2026-07-15
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/photoshowcase/display/nanjing/2-6.webp
  actions:
    - label: "Learn More"
      url: "/terms/"
  caption: "DanFeng Street, Nanjing"
excerpt: "introduce the picture."
intro: 
  - excerpt: 'Display my photographys'
---

{% for i in (1..1) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/nanjing/5-' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

{% for i in (1..1) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/nanjing/4-' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

{% for i in (1..1) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/nanjing/3-' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

{% for i in (1..3) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/nanjing/2-' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

{% for i in (1..2) %}
  {% assign start_idx = i | times: 3 | minus: 2 %}
  {% assign end_idx = i | times: 3 %}
  <div style="display:flex;gap:5px;align-items:center;">
    {% for j in (start_idx..end_idx) %}
      <img src="{{ '/assets/images/photoshowcase/display/nanjing/1-' | append: j | append: '.webp' | relative_url }}" style="width:32%;height:auto;">
    {% endfor %}
  </div>
{% endfor %}

