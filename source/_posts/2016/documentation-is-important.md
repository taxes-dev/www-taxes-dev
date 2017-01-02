---
title: Documentation is important
date: 2016-10-16 13:07:59
tags:
    - critterbits
    - documentation
    - testing
---
I haven't been able to do as much coding as I would like on Critterbits this week (busy with real life stuff). All I added was a little feature for creating timers and callbacks in the scripting engine. So instead I spent some time this weekend on some much-needed documentation. Even with just a few small features in the engine, I realized I kept having to refer back to my code to remember what I called certain configuration keys and scripting conventions, so I decided it was about time to write some documentation that I was going to need anyways.

This is probably one of my number one peeves with lots of projects (both open source and not). Documentation is usually an afterthought to the point that once someone decides its important, the project is so far along that catching up becomes a hopeless task. For something like a highly configurable/scriptable game engine like Critterbits, documentation is especially important, otherwise the whole project is kind of useless for other people to get into.
<!--more-->
I started with some user documentation describing the initial configuration of the engine and scenes. You can see some examples below:

* [Configuration and Conventions](/documentation-is-important/config.html)
* [Scenes](/documentation-is-important/scenes.html)

These two pages detail some of the basic setup using the engine's [TOML](https://github.com/toml-lang/toml) configuration files and also conventions for file/folder layout and usage of [Tiled](http://www.mapeditor.org/) maps. It's not exhaustive at the moment, but at least it contains enough information for my own usage and also acts as a starting point for when I need more comprehensive documentation in the future.

The other meta-feature I wish I had for Critterbits would be some comprehensive [unit testing](https://en.wikipedia.org/wiki/Unit_testing). Right now I have some asserts sprinkled through the project to help catch some programming and configuration errors, but I don't have a library of unit tests yet. Unfortunately since the "logic" of the game is mostly handled in script, the actual engine itself is mostly concerned with rendering, input, and other hardware functionality that doesn't lend itself to meaningful unit testing. Probably the most readily testable code would be in the math modules, so I may start there.