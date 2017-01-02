---
title: Trade offs in the scripting implementation
date: 2016-11-20 10:16:56
tags:
    - c++
    - critterbits
    - javascript
    - scripting
---
After about a month off, it was time that I got back into working on Critterbits. Honestly, after my [previous post](/2016/11/09/thoughts-on-the-next-four-years/), I was having a bit of trouble getting back into the headspace of creating. It also doesn't help that _Pokemon Sun & Moon_ were just released. But I still have a lot of work to do, so let's get started!
<!-- more -->
Luckily I already had a couple of small improvements in mind for this morning, related to the scripting engine. First, when I implemented callbacks and intervals, I made a bit of a goof where the callbacks weren't bound to the entity that created them. Thus, any entity that shared the same script _source_ would happily start calling callbacks that didn't belong to them. That was an easy fix. All I had to do was add a simple owner check on the discrete callback objects to make sure only the owning entity executed them. There's still a use case there, I think... at some point I may want an unbound callback to happen (i.e., an entity creates a callback and then destroys itself, still expecting the code to execute later). But I'll think more about how to implement that later specifically rather than just having it be a side effect of bad code.

The next part was a bit trickier. Up until now, I decided the easiest thing to do was to have each script created in its own context (via duktape's [`duk_push_thread_new_globalenv()`](http://duktape.org/api.html#duk_push_thread_new_globalenv) function). This ensured that a scripter wouldn't have to worry about polluting the global JavaScript context, and it was easy to define new scripts and not bother with naming collisions and the like. An entity's script looked pretty simple:

{% codeblock lang:js %}
function start() {
    // do initialization stuff ...
}

function update(delta) {
    // do per-frame updates ...
}
{% endcodeblock %}

This also makes memory-managing the scripts pretty easy. Every time a script goes out of scope, I just tear down the duktape context that went with it.

However, while I was trying to think about how best to handle global scripts and user-defined libraries of re-usable functions, I realized that this created a huge problem. There isn't a straightforward way of bridging the global duktape context to the sub-contexts, and at this point it also revealed a bit of a weakness in that the user would still have to worry about naming collisions with global variables anyways.

I finally gave in and re-wrote a few parts of the scripting engine to no longer create new global environments when loading scripts. This has the disadvantage I mentioned of having one global context to worry about, and it also means I can't easily clean up unused scripts. The latter is a minor problem, however; individual scripts aren't that memory intensive, and you'd have to load literally tens of thousands of them to create a problem.

This unfortunately pushes some complexity back on to the scripter, but there wasn't a good way around that. I'm still sticking to standard conventions however, and now scripts use a [JavaScript module pattern](http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html):

{% codeblock lang:js %}
// declare module
var player = (function() {
var player_module = {};

player_module.start = function() {
    // do initialization stuff ...
}

player_module.update = function(delta) {
    // do per-frame updates ...
}

// end module
return player_module;
}());
{% endcodeblock %}

There's a lot more boilerplate code now, but hopefully it's reasonable to most people that would want to write scripts. It still affords the same freedoms as the old method. Inside the module function, you have your own variable scope so you can do what you want without polluting the global environment. The only real requirement is that the script returns a JavaScript variable **named the same as the script file** that exposes the familiar recognized function names like `start` and `update`.

I've debated whether or not to have the engine add the module boilerplate automatically, but in the end I sided on allowing the freedom to make the declarations as the scripter sees fit. For example, you could also define the script module above like this:

{% codeblock lang:js %}
// declare module
var player = {};
player.start = function() {
    // do initialization stuff ...
}

player.update = function(delta) {
    // do per-frame updates ...
}
{% endcodeblock %}

Or even this:

{% codeblock lang:js %}
// declare module
var player = {
    "start": function() {
        // do initialization stuff ...
    },
    "update": function(delta) {
        // do per-frame updates ...
    }
};
{% endcodeblock %}

This is a bit simpler and could be useful if you have no intention of creating variables outside of function scope. One thing I did want to avoid was any sort of notion of inheritance or true objects ([not that JavaScript really supports them anyways](http://www.engfers.com/2008/08/29/javascript-is-not-truly-object-oriented/)). These are basically just bags of functions.

A small boon from all of this is that now you can cross-call from different scripts. If for some reason you had some functionality declared on the `player` object above, it's as simple as calling `player.my_function()` or whatever from a completely different script. You can even share behavior for the standard engine functions by calling things like `start` and `update` directly, but you'll have to remember to set `this` to the appropriate entity (see the [`call()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call) function).

The only big limitation compared to the previous system is that now scripts must all have a unique file name (which is mapped to the JavaScript module name). This seems like an okay tradeoff though.

Next time, I'm hoping to get back into working on the gameplay elements which should be a bit more interesting.