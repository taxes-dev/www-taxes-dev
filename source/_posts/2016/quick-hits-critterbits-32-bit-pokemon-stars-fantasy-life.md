---
title: 'Quick hits: Critterbits 32-bit, Pokémon Stars, Fantasy Life'
date: 2016-12-16 09:50:07
card_image: /2016/12/16/quick-hits-critterbits-32-bit-pokemon-stars-fantasy-life/fantasy-life.jpg
tags:
    - critterbits
    - fantasy life
    - games
    - pokémon
---
I'm a ball of useless, sickly foxgirl right now, so I don't have many meaty updates today. I'm mostly just sitting here watching YouTube and playing games. But I had a few things I wanted to talk about.

## Critterbits 32-bit versus 64-bit

So far I've maintained both 32-bit and 64-bit builds of my game engine up to this point. I'm not really even sure why I felt that it was necessary. I think it's just been tradition to support both for so many years that I didn't even think about it. Apparently the [most recent Steam update for Linux dropped 32-bit support](https://www.gamingonlinux.com/articles/32-bit-linux-distributions-are-no-longer-supported-by-steam-steam-web-browser-disabled.8745), so it made me stop and think about it for a minute.
<!-- more -->
I think especially amongst Linux gamers (as proven out by the surveys linked from above article) are bleeding edge types who will always be running the latest and greatest hardware/software combos, so 32-bit Linux is obviously not a huge necessity. Part of me wanted to maintain a 32-bit build anyways, specifically in case I wanted to port to some SoCs like the Raspberry Pi. But I would still need to do some porting working for the ARM vs x86 processors, so maintaining 32-bit x86 still doesn't help a whole lot. I think at this point dropping 32-bit x86 on Linux for Critterbits makes sense.

But what about 32-bit Windows? I need to do some more research on this one. I know in my lovely day job we still support 32-bit Windows builds of certain games just because there's a huge audience of Windows users that refuse to upgrade from 32-bit Windows XP, especially outside of the U.S. and Europe. I need to look into the specific numbers and see if it's worth my time to support those systems.

Obviously wider support is always better, and I would love to compile my software for as many systems as possible, but that also means testing and making sure they work well. As an indie developer, I have to pick and choose my battles. Since I'm primarily working on Linux, it's already a huge time investment to keep the builds working on Windows as well. Supporting 32-bit on both platforms is starting to look less and less like a good investment of my time.

## Pokémon Stars

Apparently rumors are swirling of [a possible _Pokémon Stars_ to follow up on _Sun & Moon_](http://www.eurogamer.net/articles/2016-11-18-nintendo-switch-will-get-pokemon-sun-and-moon-version) in traditional third-game style for the Pokémon series. Of particular note with this one is that the rumors also say that it will be coming to the new home console, the Nintendo Switch. Some people have blown this off as speculative nonsense, but I think there's some truth to this rumor. Here's just a few things I've been thinking about that lend credence to the rumor of Pokémon coming to Nintendo Switch:

* _Pokémon Sun & Moon_ seem to be pushing at the upper limits of the 3DS' capabilities, even the New Nintendo 3DS. It seems more like a backport of an engine that was built for a more powerful system. This is especially notable in the new Battle Royal mode, which is curious for something that was touted as a central new feature of the game.
* The second screen in _Sun & Moon_ isn't nearly as well utilized as in previous editions of the game. For the most part it just shows you a minimap during game play and acts as a place for the menu to display. This could be in preparation for a system that doesn't feature a second screen.
* Street Pass functionality is notably absent from _Sun & Moon_ despite featuring in _X & Y_ and _Omega Ruby & Alpha Sapphire_. (Was it used in earlier games? I don't recall.)
* What _is_ featured, however is the awesome new [Quick Link](http://www.serebii.net/sunmoon/communication.shtml) mode. This ability to create ad hoc quick communications with nearby players seems much more in line with how multiplayer is shown to work on the Nintendo Switch in the reveal trailers.
* The article linked above notes that one of the 3D models being worked on in a trailer released back in February for _Sun & Moon_ seems to be an HD version of Pikipek. I'm not sure how they make that determination just from the video, but it sounds interesting.
* There seems to be a lot missing that they may or may not have planned for. Post-game in _Sun & Moon_ is especially anemic compared to previous editions. Additionally, there have been discoveries of [walk animations for all the Pokémon](http://www.gamespot.com/articles/pokemon-sun-and-moon-unused-walking-animations-unc/1100-6446041/), which seems to hint at a feature fans have been demanding be brought back for years. It could just be a cut feature, but will it make a re-appearance soon?

Of course, this could all just be pointers to a follow-up on the 3DS itself, but especially with regards to the first bullet point, I feel like Game Freak is gearing up for something bigger and better. Or maybe that's just wishful thinking on my part. I was already going to buy a Nitendo Switch (unabashed Nintendo fangirl here), but if a new Pokémon game comes out for the system, that buy becomes a 100% no-brainer for me.

## Fantasy Life

So why am I mentioning a random two-year-old game here (four if you live in Japan)? My wife and I were looking for some good co-op games to play together, lamenting the fact that _Pokémon Sun & Moon_ still doesn't have any good co-op options outside of multi-battles. We did some research (which mostly involved watching of Let's Play videos) and settled on this little gem.

<p>{% asset_img fantasy-life.jpg %}<br><small>_©2012 Level5 Inc._</small></p>

I think it probably says something about the game that it still fetches near-retail price for a pre-owned copy at GameStop (typically something I only see with venerable series such as Pokémon). This is not a difficult game by any stretch of the imagination, in fact it falls squarely in the "casual" realm, playing like a weird mashup of _Animal Crossing_ and _Final Fantasy_. But it's deep... you can really lose yourself in the systems of crafting, gathering, and combat. This is the perfect chill game for me and my wife to play together.

My only criticism is that the only way to play co-op is to essentially pause the narrative and play in a stasis room that just allows for adventuring together. But, there's still a lot of stuff to do since you generally need to work on challenges and quests or gather resources for crafting, so it's still a compelling game mode. I just wish we could play through the story together as well.

It's a good enough game that I'm looking forward to the [forthcoming Fantasy Life 2](http://www.siliconera.com/2016/07/27/fantasy-life-2s-closed-beta-to-start-on-smartphone-in-japan-on-july-29/), though sadly it appears it will be an iOS/Android game only. The only reason I'm not excited about that is that I'm pretty sure that means it will be free-to-play with tons of microtransactions. I'd much rather just pay an up-front price and have all the content open to me from the beginning.

<p>{% asset_img fantasy-life-2.png %}<br><small>_©2016 Level5 Inc._</small></p>