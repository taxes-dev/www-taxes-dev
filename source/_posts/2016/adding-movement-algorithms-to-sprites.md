---
title: Adding movement algorithms to sprites
date: 2016-12-11 13:34:46
card_image: /2016/12/11/adding-movement-algorithms-to-sprites/elk-still.png
tags:
    - algorithms
    - critterbits
---
I said I would get back to some more interesting gameplay-related enhancements to Critterbits, and this morning I deliver! For a while now I've had player-controlled movement in the engine, which was easy enough to implement as simple velocity changes in response to keyboard or controller input. However, it was about time to give some life to my non-player-controlled sprites, so I went ahead and implemented a couple of algorithms to help with that.

The simplest algorithm for this sort of animation [tweening](https://en.wikipedia.org/wiki/Inbetweening) is called [linear interpolation](https://en.wikipedia.org/wiki/Linear_interpolation). It looks like this:

`new_position = start_position + percent × (end_position - start_position)`

Essentially we're just dividing up the movement from the start to the end evenly over time, hence the "linear." It looks like this in the engine:

<p>{% asset_img lerp-example.gif %}</p>

Sorry for not perfectly looping it… I know it's a bit distracting. But the elk is moving from a start position to an end position and then back again, evenly divided over 1.5 seconds of travel. I also added another algorithm called _quadratic ease-in_.

<!--more-->
Quadratic ease-in is only slightly different from linear interpolation:

`new_position =  start_position + percent² × (end_position - start_position)`

Note that in this case, the percent of change is squared, which adds a subtle acceleration effect to the movement. It looks like this:

<p>{% asset_img ease-in-example.gif %}</p>

These are just the first of many different types of algorithms used for this sort of animation. They're also pretty generic and can be used for more than just tweening a sprite from one location to another. For example, if I wanted a sprite to flash in a special color tint when it takes damage, I could use one of these algorithms to gradually add the color and take it away over time.

While I was doing all this, I used that gigantic elk sprite you see for my example, and it forced my hand to fix something else. Up until now, the engine assumed the sprite tile size was the desired dimensions for the sprite's collision box. This created huge amounts of empty space around the elk that was colliding, so I created a separate definable collision box on sprites (though it defaults to the sprite's dimensions for ease of use). This is why the elk is able to walk "in front of" the player sprite with its antlers overlapping without actually colliding.
