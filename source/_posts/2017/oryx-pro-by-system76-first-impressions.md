---
title: Oryx Pro by System76 first impressions
date: 2017-03-11 08:44:47
card_image: /2017/03/11/oryx-pro-by-system76-first-impressions/my-oryx-pro-thumbnail.jpg
tags:
    - hardware
    - linux
    - pillars of eternity
    - system76
---
I've needed a new laptop for quite a while. Last year, my Dell XPS 13 went kaputt unexpectedly, and I needed a quick replacement. I ended up modding a Toshiba Chromebook 2 and installing [GalliumOS](https://galliumos.org/) on it as a stop-gap solution. Surprisingly, that solution turned out not to be a bad one. I could still run all my development applications on it, albeit a bit slower. GalliumOS is a solid distribution (based on Xubuntu, which is already my preferred), and I actually didn't mind working on the Chromebook for a year.

But this is also my main computing device at home, so I really needed more power and features. After much deliberation, I settled on an [Oryx Pro by System76](https://system76.com/laptops/oryx). Serendipitously, right before I was about to make my purchase, System76 came out with their new 7th gen Intel versions of the laptop. Win-win. I've had my machine for about a week now, so I figured it would be a good time to share some of my initial thoughts. This isn't a review in any sense of the word, but I wanted to talk about a few things that I like and a few problems I've run into.

<p><a href="{% asset_path my-oryx-pro.jpg %}" class="fancybox">{% asset_img my-oryx-pro-thumbnail.jpg %}</a><br><small>_My Oryx Pro, basking in the light of my filthy kitchen_</small></p>

<!--more-->

## Why did I choose an Oryx Pro?
I can't say that there was a hugely scientific process to it. I've been using Linux full-time for a few years now. I used to use mostly Apple laptops with OS X, but that ecosystem feels more and more closed to me over the past five or six years. I didn't mind using Windows 7 that much, but Windows 10 is an absolute train wreck that completely wrests control of your computer away from you. So now I work mostly in Linux, and I was pleasantly surprised. I hadn't used Linux much since the early 2000s, and it's come quite a ways since then, especially for someone like me who just wants to use it and not be constantly tinkering and patching.

The selection of Linux-specific hardware is pretty limited, though, so there weren't a lot of contenders. I considered getting another Dell XPS 13. It's a great little machine with good build quality, but I feel like its "Linux compatibility" is a bit disingenuous. I had a lot of problems getting mine to work with anything other than the Dell-installed version of Ubuntu that's on them. Also, mine had a Broadcom wireless chip in it which was just annoying.

So that didn't leave me a whole lot of choices. System76 was easily a top contender, and I liked the looks and specs of the Oryx Pro. The only upgrade over the base model I opted for was 16 GB of RAM, bringing the price as built to right around USD 1,500.

## Build quality and general impressions
This laptop just feels nice. The aluminum casing is a nice touch. I was surprised by how light it is for a laptop that straddles the line between laptop and desktop power. I was a bit concerned that I'd be annoyed by the extra weight having come from the XPS 13 and the Chromebook, but I've gotten used to it quickly. The keyboard was the most pleasant surprise. It has great tactility for a laptop keyboard. Not anywhere near a mechanical desktop keyboard, of course, but great for a laptop.

Overall, it feels sturdy, and I'm not afraid I'm going to break anything on it. The hinge is quite solid. I like that the screen is matte rather than glossy in a world where it seems glossy dominates these days. Also, I'm _super_ happy about the placement of the fans. Most laptops blow heat out the backside of the unit, and I like to actually set my latop, you know, _in my lap_. This creates a problem where the heat ends up blowing right on my knees. The Oryx Pro, on the other hand, blows heat out the left side. I love this! Heat goes completely away from me and isn't a bother, even when the fans are running at full blast.

I haven't tried completely draining the battery yet, but it estimates that I would get about 3 hours from a full charge during normal use. Obviously nowhere near what I got from the XPS 13 or Chromebook, but it seems reasonable for a laptop of this kind. Speaking of power, I'm not a huge fan of the location of the power cable (back left). It seems to get in my way a lot, but that may just be a personal thing. Most of the laptops I've had, the power cord comes out one of the sides, which I've gotten used to.

Ports! So many ports on this machine, including a couple of USB C and a real Ethernet port. Love it.

Probably the single thing about the Oryx Pro I _don't_ like is the touchpad. The surface of it feels rough to my fingers, and it doesn't seem to have the precision of previous laptops I've used. I also prefer being able to click the touchpad itself rather than having discrete buttons (tap-to-click just isn't the same). I'll get used to it, though.

## Linux support
This was the biggest point for me, so the first thing I did was wipe the machine and try to install stock Linux (Xubuntu 16.04 in this case) to see how it went. Installation went smoothly at first, but then I was concerned because I couldn't use the wifi at all. After some quick research, I found that the Intel wireless (8265 I think?) in the latest model isn't supported by the 4.4 kernel. I needed at least Linux 4.8, so for easy-mode I just switched to Xubuntu 16.10, now everything works great. System76 has their own PPA with driver support, but everything seemed to work just fine even before I installed their drivers.

This part was simply wonderful and just what I wanted: a laptop that doesn't require any special drivers or fiddling to work with Linux.

## Graphics and gaming
To be honest, I didn't strictly need as much power for graphics as the Oryx Pro provides (I have an Alienware desktop for intensive games and such). It comes with an Nvidia GTX 1060, which ended up being a pretty nice bonus. I haven't put it through its full paces yet, but I played _Pillars of Eternity_ for a bit and it was quite pretty and held a steady 60 fps.

<p><a href="{% asset_path pillars-of-eternity-linux.jpg %}" class="fancybox">{% asset_img pillars-of-eternity-linux-thumbnail.jpg %}</a></p>

One issue I've run into is that quite frequently the mouse cursor will disappear at random. Switching to a virtual terminal and back to the X desktop will fix it, but it's definitely an annoyance. This seems to be an Nvidia driver issue (not fixed yet as of 375.26). I found someone with the exact same problem [over here](https://devtalk.nvidia.com/default/topic/979687/linux/arch-linux-on-nvidia-375-20-3-driver-mouse-disappears-virtual-consoles-blank-/), and the discussion was still ongoing as of late February. Not really System76's fault though. I'm hoping the next driver release will fix it.

There's also an issue where when waking from sleep, the display will go haywire for a brief moment before coming up. It doesn't seem to hurt anything, but it's a little disconcerting and makes me think the display has crashed before righting itself. I haven't done any research on this issue yet, so maybe there's an easy fix somewhere.

I was also surprised to find the system doesn't run that hot while gaming. The fans kicked in higher than normal, of course, but they were not anywhere near as noisy as some gaming laptops I've used, and the system remained comfortably cool. It's possible by ramping up the graphics settings in a game it could maybe run hotter, but at this stage it appears to be quite reasonable.

The speakers on the Oryx Pro sound really nice, a little bit tinny but perfectly usable such that I don't feel immediately compelled to grab headphones. My biggest issue is just getting sound to route through them... it seems Linux tries to play sound through every single device but the speakers unless I go in and manually change things. This is a gripe with pulseaudo though and not the laptop itself. I've always had issues with pulseaudio making something that should be simple into a real chore.

## Overall power
It's got an Intel Core i7 and 16 GB of RAM. No complaints. My code compiles a lot faster on this machine than it did on the Toshiba Chromebook, that's for sure. Also I've been wanting that extra RAM for a while now so that I can actually run some VMs without slowing my system to a crawl.

## Conclusion
Despite a couple hitches I'm really happy with my purchase. This is a solid machine that I'm hoping will last me for a couple years. Or at least longer than the XPS 13 did, which decided to crap out right after the warranty period (grr). The Oryx Pro gives me a lot of the power and versatility I'd expect from a desktop workstation, but it's in a relatively light and small package so I can still call it a laptop.