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

KeyboardKit provides ways to easily identify the host application, which may be of interest for many reasons, e.g. to vary the style or functionality of a keyboard based on the currently active app.

👑 [KeyboardKit Pro][Pro] unlocks an additional keyboard host information, defines many common apps, and makes it easier to identify and navigate to specific apps.



## Host Application Bundle Identifier

``KeyboardInputViewController`` has a ``KeyboardInputViewController/hostApplicationBundleId`` property that tries to resolve the bundle identifier for the application that is currently using the keyboard.

``KeyboardContext`` also has a ``KeyboardContext/hostApplicationBundleId`` property that is kept in sync with the controller. Since you should not pass around the controller, this property may be more convenient to use within your code.

``DictationContext`` also has a ``DictationContext/hostApplicationBundleId``, but unlike the others, this is used to tell the main app which app to navigate back to after the main app has finished a dictation operation.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks ways to identify the current host application, using the ``KeyboardHostApplication`` enum that identifies many common, popular apps. It also tells you how to navigate to them, using app-specific URL schemes. 

Since it's impossible to define all apps that exist in the App Store, this enum just covers the most popular ones. Reach out if you want to add apps to this collection, or if an existing one stops working.

KeyboardKit Pro also extends ``KeyboardInputViewController``, ``KeyboardContext``, and ``DictationContext`` with a ``KeyboardHostApplicationProvider/hostApplication`` property, that tries to map the raw ``KeyboardHostApplicationProvider/hostApplicationBundleId`` to a ``KeyboardHostApplication``.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
