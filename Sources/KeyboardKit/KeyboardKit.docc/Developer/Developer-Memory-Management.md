# Memory Management

This guide describes how to manage memory in a keyboard extensions.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Native iOS keyboards are severely limited when it comes to how much memory they can allocate. Based on the device and iOS version, a keyboard extension is not allowed to allocate more than **~60-70 MB**.

> Important: If your keyboard extension allocate more memory than what is allowed by iOS, your keyboard extension will be instantly terminated. 

You may avoid some crashes by deferring some allocation until after the keyboard has been loaded, but this is not guaranteed to work.


## Why is this problematic?

These memory limitations have been in effect for many years, and don't seem to be extended much, even as our devices become more powerful. Despite several discussions with Apple, these limitations remain more or less unchanged.

This makes it hard for keyboards to provide more powerful features. AI & ML could be used to provide amazing keyboard features, but since such models generally require a lot of memory, keyboard extensions are in general unable to use them directly.

Many keyboards work around these limitations by opening the main app or by requesting external, web-based APIs. This will however result in a bas user experience, since users will have to enable Full Access, cross app navigation works bad, and web requests are slow.


## What can we do?

Not much, since Apple are very strict about these limitations. At the very least, make sure to carefully monitor your keyboard extension's memory consumption, and try to defer memory intense tasks until the keyboard has first been rendered.

You should reach out to Apple if you struggle with these limitations. If many do, perhaps they will consider increasing the memory limit.


## Memory Leaks
    
It's imperative that you inspect your keyboard extension's memory consumption, to ensure that it doesn't have any memory leaks. This can easily happen due to how central the keyboard input view controller is to the keyboard extension. It can however be easily handled.

First, try to find other ways to rely on the keyboard input controller than passing it around, which will cause a memory leak if an instance isn't marked as weak or unowned. KeyboardKit makes it easy to avoid having to rely on the controller, and instead use state & services.

If you have a leak, you will see the memory consumption increase when you switch keyboards back and forth. You will also see multiple instances of the same type in the memory graph (see below). This will nto happen when you don't have a leak.

> Tip: Use KeyboardKit's state and services to avoid having to rely on the controller. This will drastically reduce the risk of memory leaks.   



## How to...


### ...monitor memory consumption

It's *very* important that you carefully monitor your keyboard's memory consumption, if you suspect that it's close to the **60-70 MB** limit. 

@Row {
    @Column {
        ![A screenshot of how to attach to the debugger](developer-attach-debugger)
    }
    @Column {
        You can monitor a keyboard's memory consumption by attaching the Xcode debugger to the keyboard process *after* launching the keyboard, by using "Debug > Attach to Process by PID or Name..." and entering the name of your extension in the modal.
        
        The reason why you should wait with attaching the debugger until the keyboard has launched, is that attaching takes time. This may cause Xcode to terminate the launch, but keep zombie allocations that will show you an inaccurate allocation result.
    }
}

@Row {
    @Column {
        Once the debugger is attached, you can inspect your keyboard's memory consumption by tapping the Debug Navigator button (the tiny spray bottle) button in the Xcode Project Navigator.
        
        This will show you how much memory your keyboard extension is currently using, which is great to quickly inspect the consumption at a specific time. The "Memory" value is the number that should stay below 60-70 MB.
    }
    @Column {
        ![A screenshot of how to monitor the memory consumption](developer-memory-consumption)
    }
}
    
@Row {
    @Column {
        ![A screenshot of how to inspect the memory graph](developer-memory-graph)
    }
    @Column {
        You can also check the full allocation graph by tapping the Debug Memory Graph button in the Xcode Debug Area. This will pause the runner and show you all allocated instances in the Debug Navigator. It will also show an interactive graph in the main area.
        
        ⚠️ The Debug Area should only show a "KeyboardController (1)"! If you see a "KeyboardController (2)" and haven't created an extra instance, you either attached the debugger before launching the keyboard, as described above, or have a memory leak!
    }
}
    
    
> Important: Always monitor your keyboard extension's memory consumption on a physical device! The iOS Simulator doesn't apply the same memory limitations, and may allocate a very different amount of memory than what will be allocated on-device.
