# Debugging

This guide describes how to debug a keyboard extension.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Native iOS keyboard extensions are a bit tricky to debug, since launching the app will not trigger any breakpoints that you add to your keyboard extension. Even when the debugger is properly attached, you may also notice that printing doesn't work as expected.

To debug the keyboard extension, you must either launch the extension instead of the app, or manually attach the Xcode debugger to the keyboard process. This is fairly straightforward, but may feel awkward the first few times you do it.

By becoming comfortable with debugging your keyboard extension, you will find it a lot easier to find and handle problems and bugs. Follow the steps below to start getting familiar with how to properly debug your keyboard extension.


## Common Warnings

When debugging your keyboard extension, you may see the following warning being logged multiple times as you use the keyboard:

`-[UIInputViewController needsInputModeSwitchKey] was called before a connection was established to the host application. This will produce an inaccurate result. Please make sure to call this after your primary view controller has been initialized.`

This warning is logged because KeyboardKit checks the `needsInputModeSwitchKey` property to determine whether or not to add a ``KeyboardAction/nextKeyboard`` key to the keyboard. This warning is logged whenever that property is used, even after the keyboard is presented. It doesn't have any effect on the keyboard, at least in any way that has been detected or reported.  


## How to...

### ...run the keyboard instead of the app 

@Row {
    @Column {
        ![A screenshot of how to launch the keyboard extension](developer-launch-extension)
    }
    @Column {
        You can run the keyboard extension instead of the main app, by switching target in the Xcode top Target Switcher. This will make the Xcode debugger wait for the keyboard to start, after which it will automatically attach itself to the keyboard process.
        
        While this alternative is convenient, attaching the debugger before the keyboard extension is loaded may cause the launch to take too long, which may cause Xcode to terminate the initial launch. This can lead to inaccurate behavior and zombie instances.
        
        A more reliable, but slightly more cumbersome approach, is to attach the Xcode debugger *after* the keyboard has been loaded.
    }
}

### ...attach the debugger to a running keyboard

@Row {
    @Column {
        You can attach the Xcode debugger to the keyboard process *after* launching the keyboard, by using "Debug > Attach to Process by PID or Name..." and entering the name of the keyboard extension in the modal that appears.
        
        Attaching the Xcode debugger to your keyboard will make your keyboard show up in the Xcode Debug Navigator (the top leading spray bottle), and will make breakpoints trigger and printing work.
    }
    @Column {
        ![A screenshot of how to attach to the debugger](developer-attach-debugger)
    }
}
    
### ...properly print from a keyboard extension

You may notice that `print(...)` will not always work from a keyboard extension, even after properly attaching the debugger. This is a strange bug in Xcode, which is however easy to fix.

If you use `NSLog(...)` instead of `print(...)`, your keyboard extension should print more reliably. Since `NSLog` is not as versatile as `print`, you may however have to convert some types to string to be able to print them.
