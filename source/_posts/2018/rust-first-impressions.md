---
title: 'Rust: first impressions'
date: 2018-09-05 21:52:49
tags:
    - c++
    - programming
    - rust
---
I've wanted to learn more about the [Rust programming language](https://www.rust-lang.org/) for a while. While somewhat C-like and familiar at first glance, there are several concepts and constructs that were opaque at first glance when I looked at examples of Rust code in the wild. I decided a more structured learning session would help, so I picked up a book that came out earlier this year called, aptly, [The Rust Programming Language](https://www.amazon.com/gp/product/1593278284/).

<p style="text-align:center">{% asset_img rust-book.jpg %}</p>

Since this is the official book written by members of the Rust core team, I figured this would be a good guide, and I was not disappointed. It's a great place to start for someone like me who already has a background in programming and just wants to learn the specifics of Rust. (Though thankfully it does not assume prior knowledge of any _specific_ programming language, so it's still useful regardless of your exact experience.) I'm only a few chapters in, but I'm already encouraged by what this language has to offer, and I've had a lot of fun trying out the examples in the book and poking around at the code.

<!--more-->
Nothing here is going to be revelatory and has probably been written about dozens of times elsewhere, but I personally wanted to jot down a few things that excited me (and a couple that didn't) before I got deeper into the book.

## Like: immutability by default
This is probably the single biggest thing I like so far. If you've used lanauges like Java or C++ you're probably familiar with the concept of marking variables as immutable with keywords like ``const`` or ``final``. If you actually do it by practice and don't forget, these can be great for stopping small mistakes and making it clear that a particular piece of code won't modify marked variables. (Barring insanity I've seen with things like [``const_cast``](https://en.cppreference.com/w/cpp/language/const_cast).)

Rust solves this elegantly by making immutability the default state. Only variables that are explicitly marked as mutable can be changed, so it is very clear when there is a possibility that the ground might shift underneath you.

## Like: RAII, but a little better
... albeit admittedly also at a cost. C++ implements the concept of [RAII](https://en.cppreference.com/w/cpp/language/raii) in a way that makes most run of the mill code fairly straightforward with regards to when a particular variable is initialized and then destroyed. Things could get a little weird though when you had to explicitly acknowledge when you wanted to do things like a copy or a move, and while the various [smart pointers](https://msdn.microsoft.com/en-us/library/hh279674.aspx?f=255&MSPPError=-2147217396) were good in intention, it required that you knew exactly which one was right for the given scenario, used it appropriately, and weren't also interfacing with APIs that expected raw pointers (which happens a lot). And God help you if you needed [a shared pointer to yourself](https://en.cppreference.com/w/cpp/memory/enable_shared_from_this).

Rust follows the same principle of binding heap allocations to a scope, but again it tries to help you out more at compile time by making ownership an intrinsic part of the language. It is more on rails than C++ and at first glance I think it will take a very different mindset to work around it, but I also believe overall that they're good restrictions. For instance, you can't pass around a mutable reference to an object while other parts of your code are using immutable references—something that C++ certainly won't save you from on its own—which at first blush takes a bit more thinking and maybe some more lines of code to work around, but ultimately it can save you from some fairly gnarly bugs at runtime.

Overall the philosophy of trying to catch as many "gotchas" at the compiler level is something I wholeheartedly agree with.

## Like: a few things borrowed from elsewhere
The ``match`` statement is really cool, not something novel (I've seen similar constructs in places like Prolog and F#), but very useful for writing concise case-matching code that's a little more flexible than the C-style ``switch``.

Slices for things like arrays and strings (basically a reference-style window into a portion of a larger data structure). I was just playing with something similar the other day in [C# with ``Span`` and ``Memory``](https://msdn.microsoft.com/en-us/magazine/mt814808.aspx).

You're encouraged to use ``for`` loops with iterators rather than explicit bounds based on an index, which just _feels_ better to me. Again, not new, but glad to see it used here as an intrinsic feature of the language.

## Like: bit-width in numeric type names
There's something comforting knowing that ``i32`` will always be exactly 32-bit, when ``int`` feels a little ambiguous in other languages. For architecture-dependent widths you still have access to ``isize`` and ``usize``.

Also the literal syntax for those types is much more sane, you just use the same type name, for example: ``1_000_000i64``. In C++ you'd have to remember that the 64-bit signed is ``1'000'000LL``, because ``long long`` made sense to someone at some point.

## Like: the cargo ecosystem
A first-class citizen package/dependency manager and build system for the language, something I've wanted for C++ for a while. (There are few solutions out there, but I haven't seen any clear winners in the space, especially with package management.) Hopefully it won't turn out to be {% post_link the-difficulty-with-node-js the crazy morass that npm is %}.

## Dislike: standardized code formatting
The language itself has [an opinionated style guide](https://doc.rust-lang.org/1.0.0/style/) for writing code that is expected to be followed for things like published crates. (Though probably not enforced?) Not a huge deal, but I've always been a fan of letting projects follow their own style guide. I'm particularly not fond of the [snake-case](https://en.wikipedia.org/wiki/Snake_case) naming used by the standard library, but that's a minor gripe.

## Dislike: functions returning expressions
This is just a weird one. The following is a valid function:

```rust
fn five() -> i32 {
    5
}
```

You can actually still write the more typical ```return 5;``` if that's what you want, but the above would be the preferred methodology. Note the lack of trailing semicolon (the only place where I've seen this occur in the language so far), which just makes it look syntactically _wrong_ at first glance. I'll get used to it at some point, I suppose.

## Don't worry, I still like C++
Some of the above might seem like I'm hating on C++ a bit, but the language is still quite useful and will be for the next few decades, I'm sure. C++ suffers from some similar burdens to most other legacy systems, namely backwards compatibility with earlier language architecture decisions and C APIs. For a language written from the ground up with different goals in mind, I like where Rust is going though, and I will definitely consider it for some future projects, so long as I don't run into some weird dealbreakers further in my studies!