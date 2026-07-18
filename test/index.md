---
title: Blog
layout: archive
entries_layout: grid
classes: wide
author_profile: true
---

## LEGO Design
<div class="feature__wrapper">
  {% assign lego_home_items = site.lego | sort: "date" | reverse %}
  {% for item in lego_home_items limit:3 %}
    {% assign teaser = item.header.teaser | default: item.image_path | default: site.teaser %}
    <div class="feature__item">
      <div class="archive__item">
        {% if teaser %}
          <div class="archive__item-teaser">
            <img src="{{ teaser | relative_url }}" alt="{{ item.title | default: 'teaser image' }}">
          </div>
        {% endif %}
        <div class="archive__item-body">
          <h2 class="archive__item-title">
            {% if item.url %}
              <a href="{{ item.url | relative_url }}" rel="permalink">{{ item.title }}</a>
            {% else %}
              {{ item.title }}
            {% endif %}
          </h2>
          {% if item.excerpt %}
            <div class="archive__item-excerpt">
              {{ item.excerpt | markdownify }}
            </div>
          {% endif %}
          {% if forloop.index == 2 %}
            <p><a href="{{ '/lego-collection/' | relative_url }}" class="btn btn--primary">Read More</a></p>
          {% endif %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>

## Game Comment
<div class="feature__wrapper">
  {% assign game_played = site.game | where: "slug", "played" | first %}
  {% assign game_photoshowcase = site.game | where: "slug", "photoshowcase" | first %}

  {% assign game_pinned_items = "" | split: "" %}
  {% if game_played %}
    {% assign game_pinned_items = game_pinned_items | push: game_played %}
  {% endif %}
  {% if game_photoshowcase %}
    {% assign game_pinned_items = game_pinned_items | push: game_photoshowcase %}
  {% endif %}

  {% for item in game_pinned_items %}
    {% assign teaser = item.header.teaser | default: item.image_path | default: site.teaser %}
    <div class="feature__item">
      <div class="archive__item">
        {% if teaser %}
          <div class="archive__item-teaser">
            <img src="{{ teaser | relative_url }}" alt="{{ item.title | default: 'teaser image' }}">
          </div>
        {% endif %}
        <div class="archive__item-body">
          <h2 class="archive__item-title">
            {% if item.url %}
              <a href="{{ item.url | relative_url }}" rel="permalink">{{ item.title }}</a>
            {% else %}
              {{ item.title }}
            {% endif %}
          </h2>
          {% if item.excerpt %}
            <div class="archive__item-excerpt">
              {{ item.excerpt | markdownify }}
            </div>
          {% endif %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>

<div class="feature__wrapper">
  {% assign game_comments = site.game | where_exp: "item", "item.path contains '_game/comment/'" | sort: "date" | reverse %}
  {% for item in game_comments limit:3 %}
    {% assign teaser = item.header.teaser | default: item.image_path | default: site.teaser %}
    <div class="feature__item">
      <div class="archive__item">
        {% if teaser %}
          <div class="archive__item-teaser">
            <img src="{{ teaser | relative_url }}" alt="{{ item.title | default: 'teaser image' }}">
          </div>
        {% endif %}
        <div class="archive__item-body">
          <h2 class="archive__item-title">
            {% if item.url %}
              <a href="{{ item.url | relative_url }}" rel="permalink">{{ item.title }}</a>
            {% else %}
              {{ item.title }}
            {% endif %}
          </h2>
          {% if item.excerpt %}
            <div class="archive__item-excerpt">
              {{ item.excerpt | markdownify }}
            </div>
          {% endif %}
          {% if forloop.index == 2 %}
            <p><a href="{{ '/game-collection/' | relative_url }}" class="btn btn--primary">Read More</a></p>
          {% endif %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>

## Blog
<div class="feature__wrapper">
  {% assign blog_home_items = site.blog | sort: "date" | reverse %}
  {% for item in blog_home_items limit:3 %}
    {% assign teaser = item.header.teaser | default: item.image_path | default: site.teaser %}
    <div class="feature__item">
      <div class="archive__item">
        {% if teaser %}
          <div class="archive__item-teaser">
            <img src="{{ teaser | relative_url }}" alt="{{ item.title | default: 'teaser image' }}">
          </div>
        {% endif %}
        <div class="archive__item-body">
          <h2 class="archive__item-title">
            {% if item.url %}
              <a href="{{ item.url | relative_url }}" rel="permalink">{{ item.title }}</a>
            {% else %}
              {{ item.title }}
            {% endif %}
          </h2>
          {% if item.excerpt %}
            <div class="archive__item-excerpt">
              {{ item.excerpt | markdownify }}
            </div>
          {% endif %}
          {% if forloop.index == 2 %}
            <p><a href="{{ '/blog-collection/' | relative_url }}" class="btn btn--primary">Read More</a></p>
          {% endif %}
        </div>
      </div>
    </div>
  {% endfor %}
</div>