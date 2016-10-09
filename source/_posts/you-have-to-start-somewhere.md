---
title: You have to start somewhere
date: 2016-10-09 13:29:47
tags:
    - c++
    - games
    - critterbits
---
As with all things, I have to start somewhere. I decided to make this blog so that, among other things, I could chronicle my development of a custom game engine (and a game to go along with it) that I call _Critterbits_. I might also talk about some other things from time to time as the mood strikes me.

I first started the Critterbits project in earnest back in August, though to be fair the idea for it goes back a couple years. Over that time, I've learned a few different engines and even some raw OpenGL programming to prepare for this. I even used Unity3D professionally for a while. One thing I learned through that process is that while all the available free engines I looked at were certainly handy for jumping right in and getting started, they were way overkill for the kind of game I wanted to make. I wanted to do something simple, and I felt like all the tools and bells and whistles just kept getting in the way.
<!-- more --> 
So I started a few engines from scratch to see what I liked. I have the most experience programming in C#, so I tried C# with SFML bindings for a bit. I also have a long history in web development, so I tried out some packages like Phaser.js. In the end, to my own surprise, I found I had the most ease working with C++ and SDL2. C++ by far is not my strongest programming language, so that part is a bit of a learning curve for me, but I accept it since it could be useful in the future. SDL2 does just enough of the low-level stuff I don't want to deal with (like input and setting up graphics contexts) without providing _too_ much help.

And so, after a couple of months of programming in my spare time, I have something that's starting to look like a real game. The screenshot isn't terribly interesting. Right now I can do several useful things though:

<a href="{% asset_path critterbits-screen-grab.jpg %}" class="fancybox alignright">{% asset_img critterbits-screen-grab-t.jpg %}</a>

* I can create and load custom maps using Tiled.
* I have custom, sheet-based sprites that can animate.
* I have basic support for both keyboard and controller.
* I have basic collision support.
* There is the beginnings of the GUI in there, but it's static for now.
* Objects are scriptable in JavaScript.

So essentially I can walk around a map right now. The most useful part to me, however, is that last bullet point. I've put a lot of effort into binding all the useful events in the engine to custom JavaScript files. My goal is at some point to spend most of my time creating the game in simpler tools like Tiled and JavaScript, simply reloading assets at runtime as I work rather than having to completely re-compile the engine and build in custom logic. This I realize is probably the most ambitious part of the whole thing, but doing things the easy way wouldn't be nearly as much fun.

As for the game itself, I have a few ideas floating around in my head, and I'm still settling on the specifics while I stall for time working on the engine. If you look at the screenshot, there is a particular aesthetic I'm going for (though the assets pictured are from a stock set), which is the GameBoy Advance era of games. I'm even using the GBA's resolution as a reference (240 × 160, though I'm upscaling by 4×). I love JRPGs, so my first thought was to do a classic turn-based RPG, but then I realized that would be more complex than I was willing to invest in at this junction, so now I'm looking at a simpler action-adventure concept.

<a href="{% asset_path vscode-screen-grab.jpg %}" class="fancybox alignleft">{% asset_img vscode-screen-grab-t.jpg %}</a>

Another reason I chose C++ and SDL2 was the vast amount of knowledge and support built up around this combination. Additionally, I've been able to leverage some pretty good third-party libraries. In particular, I've loved working with [duktape](http://duktape.org/). One of my big concerns early on was that the desire to hook runtime-evaluated JavaScript into the engine would slow everything down to an unacceptable level. While duktape doesn't have a lot of the ease of use that comes with some other script-binding libraries, the performance has more than proven it was the right choice. I have to do a bit of verbose coding to wire up my engine objects, and occasionally I will do something dumb and corrupt the JavaScript stack, but overall it has allowed me to move forward with the flexibility I wanted.

In the future, I plan to open source the engine (under an MIT license), though right now it's in such flux that I'm going to keep the repository private. I'm a big fan of open platforms, and I'm developing the engine itself in a Linux/GNU environment. (I'm also doing checkpoints in a Windows 7 VM to make sure it continues to work on Windows as well, though.) If I get access to some hardware at some point, I might give a try at porting it to macOS as well, though it's not a priority.