---
title: SeriStruct reaches 1.0
date: 2020-10-13 18:28:46
card_image: /2020/10/13/seristruct-reaches-1-0/cpp.jpg
tags:
    - c++
    - programming
---
As I mentioned a couple weeks ago in my {% post_link highlights-from-cppcon-2020 'CppCon post' %}, I've been working on a little C++ project called [SeriStruct](https://git.taxes.dev/taxes/SeriStruct). Today I think it's feature-complete to the point I can call it a [1.0 release](https://git.taxes.dev/taxes/SeriStruct/releases/tag/1.0)!

What is SeriStruct? It's a super lightweight mechanism for streaming a complex structure of data to or from bytes (either an in-memory buffer or a stream). This allows for quick transport of data across whatever medium you desire without requiring complex serialization/deserialization functionality (i.e. contrastd with something like [Protobuf](https://developers.google.com/protocol-buffers)). Of course that comes with other limitations, mostly because this was a pet project and not meant for full productionized code. For the most part, it only supports basic data types, strings, and a couple extras like `std::array` and `std::optional` (essentially types that could have a known size at compile time).

I don't know if I'll actually use this for anything, but it was still fun to write, and it gave me some much-needed practice with [test driven development](https://www.agilealliance.org/glossary/tdd/). The code includes almost 40 unit tests, about 90% of which were written before the code they test.