---
title: The difficulty with Node.js
date: 2018-04-01 19:30:47
card_image: /2018/04/01/the-difficulty-with-node-js/node-modules-heavy.jpg
tags:
    - javascript
    - nodejs
    - programming
---
I originally wanted to call this post "I hate Node.js," but that seemed a little too provocative. Also it's not quite accurate–Node.js is a very useful product. As a fast, efficient JavaScript runtime, it does exactly what's on the tin and fulfills a dream of being able to use the same programming language on both clients and servers of web applications. The real problem I have with Node.js is the package ecosystem. [Npm](https://www.npmjs.com/) is a complete mess.

To illustrate the problem, let me start with a seemingly straightforward example:

```
npm init
npm install gulp
```

It's not unusual for me to install [gulp](https://gulpjs.com/) first thing with a new project, as it's a common tool that I like to use for the initial build pipeline for a JavaScript-based web application. This was fresh on my mind since I use gulp for building my professional web site, [havisullivan.com](http://havisullivan.com), which I was working on the past few days. After installing just that one explicit dependency, here's what my `node_modules` directory looks like:

<!-- more -->

```
ansi-gray/             graceful-fs/              object.map/
ansi-regex/            gulp/                     object.pick/
ansi-styles/           gulplog/                  object-visit/
ansi-wrap/             gulp-util/                once/
archy/                 has-ansi/                 orchestrator/
array-differ/          has-gulplog/              ordered-read-streams/
array-each/            has-value/                os-homedir/
array-slice/           has-values/               parse-filepath/
array-uniq/            homedir-polyfill/         parse-passwd/
array-unique/          inflight/                 pascalcase/
arr-diff/              inherits/                 path-parse/
arr-flatten/           ini/                      path-root/
arr-union/             interpret/                path-root-regex/
assign-symbols/        is-absolute/              posix-character-classes/
atob/                  is-accessor-descriptor/   pretty-hrtime/
balanced-match/        isarray/                  process-nextick-args/
base/                  is-buffer/                readable-stream/
beeper/                is-data-descriptor/       rechoir/
brace-expansion/       is-descriptor/            regex-not/
braces/                isexe/                    repeat-element/
cache-base/            is-extendable/            repeat-string/
chalk/                 is-extglob/               replace-ext/
class-utils/           is-glob/                  resolve/
clone/                 is-number/                resolve-dir/
clone-stats/           isobject/                 resolve-url/
collection-visit/      is-odd/                   ret/
color-support/         is-plain-object/          safe-buffer/
component-emitter/     is-relative/              safe-regex/
concat-map/            is-unc-path/              semver/
copy-descriptor/       is-utf8/                  sequencify/
core-util-is/          is-windows/               set-value/
dateformat/            kind-of/                  sigmund/
debug/                 liftoff/                  snapdragon/
decode-uri-component/  lodash/                   snapdragon-node/
defaults/              lodash._basecopy/         snapdragon-util/
define-property/       lodash._basetostring/     source-map/
deprecated/            lodash._basevalues/       source-map-resolve/
detect-file/           lodash.escape/            source-map-url/
duplexer2/             lodash._getnative/        sparkles/
end-of-stream/         lodash.isarguments/       split-string/
escape-string-regexp/  lodash.isarray/           static-extend/
expand-brackets/       lodash._isiterateecall/   stream-consume/
expand-tilde/          lodash.keys/              string_decoder/
extend/                lodash._reescape/         strip-ansi/
extend-shallow/        lodash._reevaluate/       strip-bom/
extglob/               lodash._reinterpolate/    supports-color/
fancy-log/             lodash.restparam/         through2/
fill-range/            lodash._root/             tildify/
find-index/            lodash.template/          time-stamp/
findup-sync/           lodash.templatesettings/  to-object-path/
fined/                 lru-cache/                to-regex/
first-chunk-stream/    make-iterator/            to-regex-range/
flagged-respawn/       map-cache/                unc-path-regex/
for-in/                map-visit/                union-value/
for-own/               micromatch/               unique-stream/
fragment-cache/        minimatch/                unset-value/
gaze/                  minimist/                 urix/
get-value/             mixin-deep/               use/
glob/                  mkdirp/                   user-home/
glob2base/             ms/                       util-deprecate/
global-modules/        multipipe/                v8flags/
global-prefix/         nanomatch/                vinyl/
glob-stream/           natives/                  vinyl-fs/
globule/               object-assign/            which/
glob-watcher/          object-copy/              wrappy/
glogg/                 object.defaults/          xtend/
```

Let that listing sink in for a moment. __That's 198 dependencies installed__ (a total of 5.5 MB of code assets), and so far all I have is my task runner. I haven't even started to write actual application code that will need real dependencies.

<p style="text-align:center">{% asset_img node-modules-heavy.jpg 480 345 %}<br><small>Yeah, I've just been waiting to use this meme one day...</small></p>

This is just a tiny bit insane to me, not just because of the size of the dependencies, but also because of how ridiculously niche a lot of them are. Let's pick one at random: `path-root`. (With apologies to the author, Jon Schlinkert: I'm not doing this to call him out. His code was just a convenient example.) What does this do? According to its README: "Get the root of a posix or windows filepath." Okay, seems straightforward. Then I look at the code:

```javascript
/*!
 * path-root <https://github.com/jonschlinkert/path-root>
 *
 * Copyright (c) 2016, Jon Schlinkert.
 * Licensed under the MIT License.
 */

'use strict';

var pathRootRegex = require('path-root-regex');

module.exports = function(filepath) {
  if (typeof filepath !== 'string') {
    throw new TypeError('expected a string');
  }

  var match = pathRootRegex().exec(filepath);
  if (match) {
    return match[0];
  }
};
```

That's literally the whole "library." A single function that matches a string to a regular expression. Even more crazy, the regular expression itself does not exist in this module; it's in a nested dependency, `path-root-regex`. What. The. Heck.

This raises several questions in my mind:
 * Why is there an entire module dependency dedicated to what could be boiled down to one line of code?
 * Why is that module in turn dependent on a completely different module that basically acts as a data source for the first module?
 * Why did the developers of other modules resort to importing these dependencies? (Point of order: it's not gulp, it's actually like four dependencies deep.)

I bring up this particular example because it's very indicative of how Node.js modules are built and distributed: as tiny pieces with an arcane and unfathomable dependency chain. You want A, and you end up getting B, C, D, etc. whether you wanted them or not, and the value/provenance of those dependencies is suspect. In my own searches of looking for tools in the npm repository, I've stumbled upon dozens of these types of micro-modules that someone wrote, single-function and seemingly pointless. Did I really make myself more productive by importing two modules into my project instead of writing a single-line regular expression match?

I'm not steeped in the culture of Node.js/npm by any stretch of the imagination, but we use Node.js for quite a few web applications at my workplace, and I also have taken to using them on my personal web sites as a means of learning more about them. This way of writing code seems insane to me, but I also came from a background in monolithic application software written using the .NET Framework. I think this is where I get lost. Instead of the Node.js environment providing a standard library of common features that developers can build on, we're instead left to our own devices, writing whatever we think might be useful and posting it onto a central repository for everyone to pull into their software, probably with varying degrees of review. [The flaws in a completely democratic system can be self-evident.](https://qz.com/646467/how-one-programmer-broke-the-internet-by-deleting-a-tiny-piece-of-code/)

It's also not uncommon when trying to find something that does what you want, you'll find at least a half-dozen implementations from various sources (often with confusingly similar names), in various states of maintenance. There is a lot of abandonware in npm, and also it's not always obvious if there are tons of hidden bugs you're inheriting that the author never found and/or never intends to fix. It's very much a "buyer beware" scenario.

Of course, I'm not novel in recognizing this. While I was researching for this post, I found [a nice post by Mateusz Morszczyzna](https://hackernoon.com/whats-really-wrong-with-node-modules-and-why-this-is-your-fault-8ac9fa893823) that reaches pretty much the same conclusions I did. He even used the same joke image I picked out. Oh well.

At this point, I'd almost be willing to go back to PHP–while the language has its flaws, at least it had a well-maintained, well-documented set of standard extensions to cover all the common scenarios where you'd want to take on dependencies. I feel like npm's design actively encourages dependency hell and obfuscation, and it results in people pulling in first-level dependencies unnecessarily and second-level dependencies unwittingly.