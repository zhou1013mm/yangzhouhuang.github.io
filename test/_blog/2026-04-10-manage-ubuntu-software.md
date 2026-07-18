---
title: "Ubuntu Software & This Site Note"
date: 2026-04-10
excerpt: "Ubuntu Soft Management & This Site Note" # This line is the brief content of the post
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

## ubuntu software management

[ubuntu_tutorial](https://ubuntu.com/server/docs/tutorial/managing-software/#installing-deb-packages)

## jekyll static web building problem
### on adding the katex plugin for math support

```text
Great question. The simplest mental model is:

1. HTML is the structure
It says what exists on the page: title, paragraph, image, navigation, post content.

2. CSS is the appearance
It controls how things look: colors, spacing, fonts, layout, responsive behavior on phone vs desktop, animations.

3. JS (JavaScript) is behavior
It controls what changes after page load: click actions, search, toggles, dynamic rendering, fetching data, math auto-rendering, etc.

For a Jekyll site like yours, there are two phases:

1. Build time (on your machine)
Jekyll reads Markdown/posts/layouts/config and generates static HTML files.
Sass/SCSS is compiled into CSS.
No browser yet, this is just file generation.

2. Runtime (in the browser)
Browser loads the generated HTML.
Browser applies CSS to style it.
Browser runs JS for interactive/dynamic features.

How this maps to your KaTeX issue:

1. Jekyll plugin can transform some math at build time.
2. KaTeX CSS is needed so rendered math looks correct.
3. KaTeX JS auto-render is needed if you want browser-side conversion from delimiters like $...$ or $$...$$ into formatted math.

So in one line:
HTML = content skeleton, CSS = visual skin, JS = live behavior.

If you want, I can also give you a very small “before/after” example showing exactly what each one changes on a page.
```

the linking part was added in the header as 

```html
<!-- insert favicons. use https://realfavicongenerator.net/ -->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.css">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/katex.min.js"></script>
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.22/dist/contrib/auto-render.min.js" onload="document.addEventListener('DOMContentLoaded', function () { renderMathInElement(document.body, { delimiters: [ { left: '$$', right: '$$', display: true }, { left: '$', right: '$', display: false }, { left: '\\(', right: '\\)', display: false }, { left: '\\[', right: '\\]', display: true } ], ignoredTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code'] }); });"></script>

<!-- end custom head snippets -->
```
in `yangzhouhuang.github.io/_includes/head/custom.html`

### on making the post pages wide in display

Yes, there is a clean way, and your observation is correct.

The blank right area is mostly from the theme reserving right-sidebar space on large screens:
- _page.scss
- _page.scss

The easiest fix is to use wide layout mode.

For one post/page:
1. Add this in front matter:
```yaml
classes: wide
```

For all posts site-wide:
1. Add defaults in [ _config.yml ](test/_config.yml):
```yaml
defaults:
  - scope:
      path: ""
      type: posts
    values:
      classes: wide
```

If you also want globally wider content even in non-wide pages, adjust Sass variables in [ main.scss ](assets/css/main.scss) before imports, for example:
```scss
$max-width: 1600px;
$right-sidebar-width-narrow: 140px;
$right-sidebar-width: 200px;
```

Then rebuild preview.

If you want, I can apply the global posts-wide change in [ _config.yml ](test/_config.yml) for you now.

**Short learning summary for your note post:**

If a Minimal Mistakes page looks too narrow, first use wide class.
If still narrow, override width variables before importing theme Sass.
Prefer variable overrides in main.scss over many custom CSS selectors, because it is cleaner and easier to maintain.
If you want, I can also apply the same default wide setting to normal pages (not only posts) in _config.yml.


## themes and templates of static web , noted
> [UX & Bootstrap](https://themes.3rdwavemedia.com/)

