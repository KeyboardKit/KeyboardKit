# Essentials - Memory Management

This guide describes how to manage memory in a keyboard extensions.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Native iOS keyboards are severely limited when it comes to how much memory they can allocate. Based on the device and iOS version, a keyboard extension is not allowed to allocate more than **~60-70 MB**.

Keyboard extensions that allocate more than this will be instantly terminated by the operating system. You may avoid some crashes by deferring some allocation until after the keyboard has been loaded, but this is not guaranteed to work.


## Why is this problematic?

The strict memory limitations have been in effect for many years, and don't seem to be loosened up much even as our devices become more powerful. Despite several discussions with Apple, the memory limitations remain more or less unchanged.

The reason for these limitations is to protect the device from memory intense extensions affecting the device. Still, a **~60-70 MB** limit is *very* strict, and makes it hard to provide more powerful functionality.

With the rise of AI and ML, 3rd party keyboards could provide amazing AI/ML-based functionality. However, since such models require a considerable amount of memory, these limitations make it hard to use such features in keyboard extensions.


## What can we do?

Not much. Make sure to carefully monitor your keyboard extension's memory consumption, and try to defer memory intense tasks until the keyboard has first been rendered.

If possible, try to extract features that requires a lot of memory to external services, such as remote APIs. You could also try to open the main app to perform some operations, then return to the keyboard using KeyboardKit Pro's <doc:Host-Article>.

You can also reach out to Apple if you struggle with these limitations. If many do, perhaps they will consider increasing the memory limit.


## How to monitor memory consumption

It's *very* important that you carefully monitor your keyboard's memory consumption, if you suspect that it's close to the **60-70 MB** limit.

> Important: Make sure to always monitor your keyboard extension's memory consumption on a physical device. The iOS simulator doesn't apply the same memory limit, which means that it lets keyboard extensions allocate huge amounts of memory without crashing. 

You can monitor your keyboard's memory consumption by attaching the Xcode debugger to the keyboard process *after* launching the keyboard, using the "Debug > Attach to Process by PID or Name..." menu alternative.

The reason why you should wait with attaching the debugger until the keyboard has launched, is that attaching may take time. This may cause Xcode to terminate the launch, but keep zombie allocations around, which will show you an inaccurate allocation result.

Once the debugger is attached, you can check the memory consumption by tapping the top-leading spray bottle in the Xcode Project Navigator. You can also check the full allocation graph by tapping the graph button in Xcode's process runner toolbar.
