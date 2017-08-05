---
title: Open-sourcing Critterbits
date: 2017-08-05 14:05:23
card_image: /2017/08/05/open-sourcing-critterbits/rabbit.png
tags:
    - art
    - c++
    - critterbits
    - games
    - programming
---
It's been a few months since I last wrote about Critterbits. I guess it should be obvious by now that I'm not actively working on it at the moment. Work and real life got in the way a bit, and I also kind of hit a wall on where to go next with the project. To that end, the TL;DR of this post is I'm publicly opening the repository so you can get the code if you want to play with it and build upon it. The rest of this post goes into things I learned in getting this far and what I want to do in the future.

Critterbits on GitHub: https://github.com/taxes-dev/critterbits

<p style="text-align:center">{% asset_img bring-out-your-dead.jpg %}<br><small>_©1975 Python(Monty) Pictures_</small></p>

## Why I wrote Critterbits
Originally, I wrote Critterbits as an educational exercise. I wanted to learn more about internals of game engines, some ruidmentary graphics programming, and C++. I've written software for a variety of systems over the year, from payment services to gameplay code. But I'd never dug into the internals of a game engine except on a theoretical level. It's a subject that fascinates me and I wanted to learn more. I once heard a colleague say something along the lines of "Show me a man who is writing his own game engine, and I'll show you a man who has never finished a game." I can appreciate that... there's a reason solutions like Unreal Engine and Unity3D are so popular. You can pull them off the shelf and start writing your game rather than worrying about just getting an OpenGL context started and figuring out basic frame timing. Luckily for me, the end goal was to write an engine. I really wasn't setting out to write a real game. Yet.

<!--more-->
For the sake of simplicity and just because I like retro games, I settled on doing only 2D for now. In addition to that, I wanted to make something that was flexible rather than purpose-built to a specific game, so I wanted to include easy-to-write configuration files and scripting. My hope was that in the end it was something that hackers of all skill levels could get into.

## What I learned
I was surprised at the amount of takeaways from going through this multi-month exercise. Here's some of the most important ones (in my opinion).

### Learning C++
While I was well-versed in plain C and had maintained a few existing projects over the years written in C++, I'd never really written a huge amount of code in C++. I imagine most people who've mastered C++ will look through my repository and laugh at the naïveté of my code. That's fine, I have no doubt it could be improved, and as I said it's my first time writing C++ at this scale. Having come from a background mostly in C# and Java, I had to unlearn a lot of things (like trying not to force [templates](http://www.geeksforgeeks.org/templates-cpp/) to be [generics](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/)). Having started even earlier with C, though, the shift to an [unmanaged memory](https://stackoverflow.com/questions/1345377/unmanaged-memory-and-managed-memory) environment wasn't as harsh as I thought it would be. But [Valgrind](http://valgrind.org/) was a life-saver in finding some of my mistakes. I can't recommend that tool enough.

<p style="text-align:center">{% asset_img what-were-you-thinking.gif %}</p>

That said, learning a language in the midst of trying to program complex systems was probably not the smartest thing I could have done. Were I to do this over, I might try to use a more familiar language like C#, Java, or Javascript. But, that would probably lead to me falling into another habit...

### Unlearning Object-Oriented Programming
Until I started writing Critterbits, I didn't realize how much [OOP](http://www.webopedia.com/TERM/O/object_oriented_programming_OOP.html) had warped my sense of good software design. OOP is a useful tool, especially in the world of business software. Unfortunately it adds a lot of unnecessary overhead in the case of writing efficient, specialized code for a game engine. Probably where this is most apparent in Critterbits is the root engine code itself. I encapsulated everything in a reusable "Engine" class from the beginning and went from there. Over time, I realized that having multiple engines running simultaneously was simply not a use case, so I switched it and a few other classes to a [Singleton pattern](http://gameprogrammingpatterns.com/singleton.html) to simplify some things. To be honest, it should have just been procedural code from the beginning. This is why I would probably avoid C#/Java in future endeavors... they don't do anything *but* OOP, and I'd rather have the flexibility to only create objects where needed.

### You aren't gonna need it... or will you?
Originally I set out with the idea that this iteration would be very, very simple. I had planned to do just basic tile sprites with box collisions, so instead of an [entity system](https://github.com/junkdog/artemis-odb/wiki/Introduction-to-Entity-Systems), everything was built into the "Sprite" class. As the engine grew in size and complexity, though, I realized this was foolish, as it made it extremely hard to hook in new features to an already weighty object. Next time I'll build more flexibility in from the start.

### Scripting is the way to go
I knew from the beginning that scripting was going to be the core of the engine. I wanted others to be able to take the compiled executable and modify to do whatever they could imagine, so I needed a full-featured scripting language to make that possible. At first I was concerned that run-time interpreted scripting would be unacceptably slow to execute inside the frame times (I was targeting 60 fps minimum), and I looked at solutions like embedding Python that would have added a huge amount of weight to the project.

Then I found [duktape](http://duktape.org/). This little single-file library was easy enough to embed in my project, and it's lightning fast. I was super happy that I could have complex Javascript code that executed within my engine's tolerances. There was a fairly steep learning curve at first, which you can see in [the scripting classes](https://github.com/taxes-dev/critterbits/blob/master/src/scriptsupport.cpp). But, once I got into the groove of integrating it, it reminded me of working with [ASM](https://en.wikipedia.org/wiki/X86_assembly_language) and [MSIL](https://en.wikipedia.org/wiki/Common_Intermediate_Language). Duktape is a pretty cool little library, and I'd definitely use it again.

<p style="text-align:center">{% asset_img magic.gif %}</p>

### Don't go too simple with the graphics
When I first learned games programming, I actually did a few rudimentary graphics programming tutorials using [bit-blitting](https://en.wikipedia.org/wiki/Bit_blit) directly to video RAM (back in the days when that was actually a thing). Early on I decided to use SDL2 as my main API, as it afforded a lot of flexibility and capability without being a full game engine on its own. I started with the [SDL_RenderCopy](http://wiki.libsdl.org/SDL_RenderCopy) method since it was the easiest way to model layers of 2D sprites. I realized much later, however, that I should have stuck with traditional OpenGL textures. I realized if I wanted to do any sort of advanced effects processing (or at least do them efficiently), I would need to write things like custom shaders, and that isn't possible using the blit methods.

### Building is hard
I'll admit, years of working in the .NET ecosystem spoiled me on how easy it is to manage dependencies and get a build pipeline going. I was most familiar with [CMake](https://cmake.org/) for building C/C++ projects, so that was what I used for Critterbits, and it solved the initial problem of mapping out makefiles and Visual Studio projects. But, I wasn't prepared for how difficult it would be to bring in third party libraries and support cross-platform compiling and whatnot. I ended up making things simpler by checking in pre-built static libraries rather than downloading entire repositories for external projects and feeding them into the build process, but I'm aware (especially on Linux) that sometimes these fail to work right when moved to different computers. So if you're building the project you may need to re-compile those yourself (I've included references to specific commits and any patches I made in the 3pp folder).

Of course, I could have spent hours and hours figuring this out and making it better, but in the end I decided it wasn't worth it. In the future I would just choose a different environment that makes this simpler. (I'm in total control of this project, so I have that luxury!)

## So what's next?
I think at this point Critterbits went down a rabbit hole that's too deep to fix in its current state. While the basis is strong, there's a lot of architectural decisions that I would want to do completely different the next time around (not the least of which is choosing a different programming language). I'm still very interested in engine programming, so there *will* be a next time, but it may be a little while.

In the meantime, I've decided to work on my drawing skills. Not really related to engine development, but somewhere down the line I would like to make a game with my engine. The one piece I'm not really very good at is art. Also I've really wanted to learn how to draw in general for a long time. So I've started practicing every night, even if it's only for 30 minutes.

Below are the first pieces I'm willing to share. They're deeply flawed of course, but I have to start somewhere! I was actually surprised I could draw this well, considering I hadn't drawn much at all since I was in elementary school.

<table align="center"><tr><td>{% asset_img rabbit.png %}</td><td>{% asset_img pikachu.png %}</td></tr><tr><td colspan="2"><small>_Art by Havi_</small></td></tr></table>