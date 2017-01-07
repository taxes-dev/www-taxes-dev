---
title: Iterating on animations
date: 2017-01-07 13:57:25
card_image: /2016/12/11/adding-movement-algorithms-to-sprites/elk-still.png
tags:
    - critterbits
    - scripting
---
If you recall from {% post_link adding-movement-algorithms-to-sprites "one of last month's posts" %}, I was working on movement algorithms for sprites in Critterbits. I've been refining this particular feature, so the functionality has not changed much, but I've made it a lot easier to use from the scripting modules. As a refresher, here's what it looks like in the game using simple linear movement:

<p>{% asset_img lerp-example.gif %}</p>

Now let's examine what the elk's movement looks like in script.<!--more--> This is the original script from the example in December:

```js
// declare module
var elk = (function() {
var em = {};

var VELOCITY = 60;
var MOVE_LENGTH = 2;
var current_start;
var flipped = false;
var current_dest = { "x": 0, "y": 0 };
em.start = function() {
    current_start = this.pos;
    current_dest.x = this.pos.x + VELOCITY * MOVE_LENGTH;
    current_dest.y = this.pos.y;
}

var t = 0;
em.update = function(dt) {
    t += dt;
    if (t < MOVE_LENGTH) {
        this.pos = lerp(current_start, current_dest, t / MOVE_LENGTH);
    } else {
        t = 0;
        flipped = !flipped;
        this.animation.stop_all();
        current_dest = current_start;
        current_start = this.pos;
    }
    if (flipped) {
        this.animation.play("walk_left");
    } else {
        this.animation.play("walk_right");
    }
}

// end module
return em;
}());
```
It takes a lot of setup just to get it walking back and forth on a path. Basically we're manually lerping between two positions during the update cycle. Because this is a pretty common use case, I wanted to make it a lot easier to do, so I created a new `move_to` function which leverages the animation subsystem to encapsulate this behavior. Here's the new script:


```js
// declare module
var elk = (function() {
var em = {};

var VELOCITY = 60;
var MOVE_LENGTH = 2;
var flipped = false;

em.start = function() {
    var callback = function() {
        var dest = { "x": this.pos.x, "y": this.pos.y };
        flipped = !flipped;
        if (flipped) {
            this.animation.play("walk_left");
            dest.x -= VELOCITY * MOVE_LENGTH;
        } else {
            this.animation.play("walk_right");
            dest.x += VELOCITY * MOVE_LENGTH;
        }
        this.move_to(dest, MOVE_LENGTH * 1000, "lerp", callback);
    };
    callback.call(this);
}

//FIXME: callbacks don't get called if there's no update function
em.update = function(dt) {
}

// end module
return em;
}());
```

The new hotness is this line:

```this.move_to(dest, MOVE_LENGTH * 1000, "lerp", callback);```

This new function takes a destination and a duration and moves the sprite accordingly. Optional third and fourth arguments specify the algorithm to use (as with the previous post, I still only have lerp and quadratic ease-in defined) and a callback function. Now I can just use that callback to make the elk change direction when it reaches the end of the animation. From this perspective, it doesn't look like a huge change, but this did take quite a bit of work. I had to refactor the animation system (it was hard-wired to do key frame animations) and then extend my callback system to be called from an arbitrary point in the engine (namely the animations).

Lastly you might've noticed my little `FIX_ME` note. I realized as I was building this that some optimizations I'd done in the update loop broke expectations here. Because callbacks use the same context and timing as the update loop, it was easy to hook them into that part of the engine. But, because setting up the script calls is a non-zero-cost operation, I have an optimization which skips calling the script engine if the `update` function doesn't even exist. So thus I had to create an unneeded dummy `update` to make sure callbacks would be called. I need to go back and detangle those pieces a bit to make sure this works.