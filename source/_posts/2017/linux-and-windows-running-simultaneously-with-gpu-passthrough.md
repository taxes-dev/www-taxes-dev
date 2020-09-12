---
title: Linux and Windows running simultaneously with GPU passthrough
date: 2017-07-08 05:30:32
card_image: /2017/07/08/linux-and-windows-running-simultaneously-with-gpu-passthrough/windowspluslinux.png
tags:
    - games
    - hardware
    - hypervisor
    - linux
    - vm
    - windows
---
<div class="updated">

**Updated September 2020:** I still get quite a few hits on this old guide, so welcome! If you're looking for some more recently created alternatives to complement what I've written below, I also recommend you check out these two:

* [GPU passthrough tutorial](https://github.com/bryansteiner/gpu-passthrough-tutorial) by bryansteiner
* [VFIO Single GPU Passthrough Configuration](https://gitlab.com/Karuri/vfio) by Maagu Karuri
</div>

Wherein I describe the process where I was able to get the "perfect" setup (for my purposes anyways) with Linux and Windows coexisting peacefully on one machine.

a.k.a. "Oh yeah, I have a blog, I should use this thing."

<p>{% asset_img mass-hysteria.gif %}<br><small>Human sacrifice! Dogs and cats living together! Mass hysteria! ©1984 Columbia Pictures.</small></p>

## First, some background
As you could tell from {% post_link oryx-pro-by-system76-first-impressions "my previous post" %}, I've been on the path of replacing all my machines with Linux boxen recently. This journey started about a year or so ago when I reconfigured a Chromebook with Linux as well as my Alienware desktop (X51 R3). Interestingly, this wasn't driven by some desire to support open source or be a digital revolutionary. I hadn't actually used Linux with any seriousness since the late 90s. Instead, it was Microsoft forcing my hand on something that's bothered me for a while with regards to computing devices and operating systems.
<!--more-->
I started out my career in graphic design and desktop publishing, so I naturally gravitated towards Apple Macintosh computers since the days of System 7.6. I used primarily Macs well up until about 2012 when I finally got fed up with Apple locking down their ecosystem. I had quietly accepted the "walled garden" approach with the iPhone, but once that philosophy started to creep into OS X (macOS now?), I couldn't stand losing control over my own computer. I was still pretty familiar with Windows as well, since I used it for gaming and at work sometimes, so naturally I just slid over to Windows 7 and started using that.

Not long after making that switch, however, Windows 10 became the new hotness. I was already irked by this _virus_ one day taking over my media PC and upgrading it from Windows 7 to 10 without my permission. Literally I just turned it on one day and it was like, "Here you are, kthxbai." Other than that incident, I tolerated it for the most part. The more I used it though, the more I hated it. I eventually bought a new gaming rig (the aforementioned Alienware), and didn't really think about the fact that it _only_ supported Windows 10. Part of me really wanted to go back to Windows 7, but I was stuck. Forced updates. Not being able to opt-out of various "features." The ones I could opt-out of silently turned themselves back on without me noticing. It was infuriating that Microsoft owned my computer instead of me.

So I switched to Linux. It wasn't an easy transition... some things are certainly more difficult to get setup than they were under Windows (and especially OS X... despite what you may think, the "it just works" mantra is very much alive and well there). But it was totally worth it. I now feel like I own my computers again. So this year it was really a no-brainer to start buying computers that primarily support Linux.

I have been dual-booting Windows and Linux on my desktop for about a year now, but one of the dumber things I had to deal with is the fact that the Alienware BIOS literally will not boot anything other than Windows. It's actually hard-coded to look for the Windows OS loader in the UEFI partition. The only way to get around it was to rename the GRUB boot loader to the same filename/path as the Windows one... which Windows helpfully overwrote whenever it installed its many updates. It finally annoyed me for the last time a couple weeks ago, so I ordered a new computer.

## Goals for this project
The main things I wanted were:

* The ability to run Linux without hassle (pretty much the same thing I needed from my new laptop).
* The ability to run Windows 7 without hassle (_not_ Windows 10).
* The ability to run _both_ through virtualization while retaining top performance in both operating systems.
* The ability to run Windows games without rebooting (this is where the GPU passthrough comes in).

The last two points is where everything got tricky. I knew theoretically that it was possible with all the nice virtualization technology built into modern CPUs and Linux. For the most part I prefer to game under Linux when I can, but obviously that's not going to work in every case. Only a portion of games support Linux natively; some others run well under [WINE](https://www.winehq.org/), but not all. So I needed Windows 7 around primarily for some games and few other things that just don't run under Linux. But I didn't want to deal with the previous hassle of constantly rebooting back and forth between Windows and Linux.

<p style="text-align:center">{% asset_img just-do-it.gif %}</p>

## The hardware and the software
First I needed to figure out what hardware I was going to use. My first thought was to go with System76 again, but with their current lineup that was a non-starter. They're only selling 7th gen Intel systems, which Micrsosoft & Intel have colluded on to specifically exclude Windows 7 support. (I assume because Microsoft really, _really_ wants to avoid a repeat of Windows XP and the decade-plus OS cycle... but they should have made a better OS upgrade in that case. I digress.) It's possible it would have still worked under virtualization, but I wanted to make sure as a fallback (if this crazy scheme didn't work) that I could still do a dual-boot setup.

After a bit more research, I actually ended up buying another Dell. Not an Alienware this time, but a proper Precision workstation (which Dell explicitly supports Linux on). Now, a Precision is not a gaming computer by a longshot... but my needs aren't exactly intense in that area. I don't play the latest AAA titles at ultra quality. If you're looking for a more high-end rig to focus on the gaming part, I would definitely look into one of those System76 computers but you'll have to deal with Windows 10. At any rate the Precision T3620 I picked up suits my needs. I was able to get a refurbished one for a decent price (sub-1000$) that came with 16 gigs of RAM, a Core i7 processor, and a SSD/HDD combo. As an added bonus, I realized the memory chips in it were the exact same type/brand I pulled out of the Alienware during an upgrade, so I was able to pop those in for a total of 24 gigs.

While I was working out the hardware, I had to simultaneously research the software I needed. At first I was looking at the [Xen hypervisor](https://www.xenproject.org/) since I was already passingly familiar with it, but after digging into it some more I found out that the [KVM built into the Linux kernel](https://www.linux-kvm.org/page/Main_Page) has come a long way in recent years. I decided on the latter since it made things a bit simpler; I only had to have the host (my main OS) running the single guest VM instead of both running as guests under Xen. So with that in mind I double-checked the specs of the computers I was considering to make sure they supported the necessary virtualization options (VT-d and IOMMU in the case of Intel), I would have sufficient RAM, etc.

## The struggle
It took nearly two days of fiddling with things, but I'm happy to report I _did_ make it work. I hit some low points of despair when I thought I wasn't going to get it to work, but I'm resourceful. The main guide I used was this one:

* [GPU passthrough: gaming on Windows on Linux](https://davidyat.es/2016/09/08/gpu-passthrough/)

That blog post covers pretty much the same use case I have, so it was easy to follow it step-by-step to get KVM/QEMU up and running with a Windows guest. The PCI passthrough part was, of course, the difficulty. There were a few minor things the author missed though that gave me some headaches:

1. I'm not sure if it's just easier with an AMD card, but blacklisting the Nvidia drivers required a few more lines (example `/etc/modprobe.d/blacklist.conf`):
```    
    blacklist nouveau
    blacklist lbm-nouveau
    options nouveau modeset=0
    alias nouveau off
    alias lbm-nouveau off
```
1. After doing the above (and also when adding `pci-stub` as noted in the blog post), make sure to run `update-initramfs -u`. It wasn't explicitly called out during those steps, and I ran into some interesting system freezes while nouveau and KVM fought over the graphics card because I thought the driver was blacklisted when it wasn't. (In hindsight I should have checked to make sure it was _really_ blacklisted in the first place.)
1. When configuring the VM in `virt-manager`, on the Overview tab make sure to choose "UEFI" for the boot type. I accidentally left it on "BIOS" because the article didn't call out that particular setting, but any modern video card will need UEFI in order to get setup properly. Windows 7 was happy to load in a legacy BIOS environment, but the video card wouldn't do a damn thing. That minor oversight probably wasted the most time before I figured out what was going on.

Lastly, if I had to do this over, I would probably suggest going with an AMD card instead of Nvidia. Normally I love Nvidia cards, their Linux drivers are usually better than AMD's, but in this particular case I got hung up on something I didn't anticipate. Even after working through all of the above, I was getting a mysterious "Code 43" error in Windows when it tried to initialize the graphics card. I could tell the card was functional though, since it was sending a signal to the monitor. After digging around some more on the Internet, it seems the Nvidia driver will disable the card if it detects it's running under virtualization. _Thanks Nvidia._

Luckily I could fix that. From [this page](https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF#.22Error_43:_Driver_failed_to_load.22_on_Nvidia_GPUs_passed_to_Windows_VMs), you just add some additional configuration to hide virtualization from the Windows guest:

```xml-doc
...

<features>
	<hyperv>
		...
		<vendor_id state='on' value='whatever'/>
		...
	</hyperv>
	...
	<kvm>
	<hidden state='on'/>
	</kvm>
</features>
...
```

That was the final hurdle. Once I had corrected that issue, I had the Windows desktop appearing on my second monitor!

## So how does it run?
<p>{% asset_img smooth.gif %}</p>

I haven't done extensive testing yet, but I've heard claims that you should be able to get 95% of native performance in this setup. I did some testing with a few games and got a steady 60 fps (this is using a GTX 950). Again, I don't play the latest games on the highest quality, so I imagine some games will not be up to the core gamer's expectations in this setup, _but_ that's a limitation of the hardware I chose and not the software setup. So again if you go with a high-end rig, you'll get commensurate results.

One thing I liked about the particular tutorial I chose is that the author pointed out a feature called "hugepages" which I didn't see mentioned anywhere else. You don't actually _need_ this feature, and in fact if you only plan to run the guest VM some of the time, I would avoid it. It will actually reserve the allocated RAM even when the VM isn't running. But it does provide a nice little boost for my case where I want to just leave Windows running (I have 8 gigs dedicated to it and 16 gigs still leftover for my host OS, so it works out fine).

## The last pieces of the puzzle
The one thing I haven't completely worked out yet is controlling the Windows guest. Since it's running off its own graphics card, I have it on a second monitor right now, and obviously that doesn't work with the SPICE viewer so sharing keyboard/mouse is a little tricky. One possibility is to just use a second keyboard/mouse as well and treat them like two separate machines, but that takes up a lot of desk real estate.

The author of the post pointed out a tool called [Synergy](https://symless.com/synergy). I decided to give this a try, and it actually works pretty well (it's not free though). This allows me to treat the Windows guest kind of like an extended virtual desktop, so when I move the mouse off screen in the direction of the second monitor, the keyboard and mouse smoothly transition over. You also get some nice add-ons like being able to share the clipboard. It wreaks havoc on games though, unless you tweak a couple things.

First, turn on a setting called "Use relative mouse movement." I don't know what exactly it does or why it's turned off by default, but mouse panning just _does not work at all_ with it turned off. Second, while gaming I suggest locking the mouse to the guest's screen (tap Scroll Lock key by default). For some reason mouse sensitivity was crazy high until I did that. This is also just handy since it makes sure you don't accidentally move the mouse back on to the host's screen while you're trying to control the game.

Also I'd like to get rid of the second monitor I think, but having both video outputs in one monitor presents its own challenges. Some people online I've seen use a script to cut the video signal from the host OS just before starting their VM so that the monitor auto-detects the new input, but for a system where I want both running constantly that doesn't really work. I suppose I can just switch manually using the menu on the monitor, but that's a bit cumbersome. I'll have to play with it some more.

The other tricky part I haven't 100% figured out is sound. Again, the article I linked talks about some different options. I'll probably eventually go with hooking something up to the HDMI audio since that seems the easiest. I share his sentiment that pulseaudio is a PITA.

Overall, I'm pretty happy with the solution. I'll continue to tweak it, but I think this will work for my purposes. And now that I've done it once, it's not so daunting a task to do it again.

<p style="text-align:center">{% asset_img thank-you.gif %}<br><small>Thank you for reading!</small></p>
