---
title: "COMSOL Room Acoustics Basics"
excerpt: "Basic Comsol Usage on Room Acoustics" # This line is the brief content of the post
header:
  teaser: ""
  overlay_image: 
  og_image: 
categories:
  - Game
tags: 
  - Game
  - Interactivity
---

Today I'm working on my Architecture-Acoustics coursework: computes a 1.9m x 1.5m x 1.1m  room's first 6 eigenfrequencies with COMSOL. The walls should be set to all rigid with absorption coefficient $\alpha_n = 0.2$ . 

This is actually the first time I used COMSOL to support Physics work. I met bugs and found way through (how to see bug logs with more details). I also summarized on the logic behind how a COMSOL model is constructed with physics concepts linking to fundamental code.

## Basic logic to construct a correct COMSOL model tree

## See bug logs in details

## Parametric Scan







Room EigenFrequency & SPL with corner point source



computes the SPL of a room with 1.9m \times 1.5m \times 1.1m size and a point source at (0.1m, 0.1m, 0.1m) near a node point of the room.

The absorption coefficient is \apha_n = 0.2 for all walls.



Yangzhou Huang, 231840287