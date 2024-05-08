# Host Utilities

This article describes how KeyboardKit can identify the host application.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit provides additional utilities that it easy to identify the host application.

👑 [KeyboardKit Pro][Pro] unlocks a list of host applications, to make this even easier.



## Host Application Bundle Identifier

``KeyboardInputViewController`` has a ``KeyboardInputViewController/hostApplicationBundleId`` property that tries to resolve the bundle identifier for the application that is currently using the keyboard.

``KeyboardContext`` also has a ``KeyboardContext/hostApplicationBundleId`` property that is kept in sync with the controller. Since you should not pass around the controller instance, this property may be more convenient to use.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more ways to identify the current host application.

KeyboardKit Pro unlocks a ``KeyboardHostApplication`` enum that defines a bunch of commonly used applications. This enum will be expanded over time, so please reach out if you're missing a certain app.

KeyboardKit Pro also extends ``KeyboardInputViewController`` and ``KeyboardContext`` with a `hostApplication` property, that tries to map the raw bundle identifier to a ``KeyboardHostApplication`` value.

Any failure to map the identifier will return an unknown case with the raw identifier.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro