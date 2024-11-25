# Host Utilities

This article describes how KeyboardKit Pro can identify the host application.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

👑 [KeyboardKit Pro][Pro] KeyboardKit lets you get the bundle ID of the host application, which may be of interest for many reasons, e.g. to vary the style or functionality of a keyboard based on the currently active app.

KeyboardKit Pro also unlocks an additional ``KeyboardHostApplication`` that defines many common apps and makes it easier to identify and navigate to specific apps.


## Host Application Bundle Identifier

``KeyboardInputViewController`` has a ``KeyboardInputViewController/hostApplicationBundleId`` property that resolves the bundle identifier for the app that is currently using the keyboard.

The controller automatically syncs the ``KeyboardInputViewController/hostApplicationBundleId`` to the ``KeyboardContext``. Since you shouldn't pass around the controller, you can instead use the main ``Keyboard/State/keyboardContext``'s ``KeyboardContext/hostApplicationBundleId``.


## Host Application

KeyboardKit Pro unlocks ways to identify specific apps, using a ``KeyboardHostApplication`` type that defines many popular apps.


The ``KeyboardContext`` implements the ``KeyboardHostApplicationProvider`` protocol, which automatically tries to map the ``KeyboardContext/hostApplicationBundleId`` to a ``KeyboardHostApplicationProvider/hostApplication``. If this property returns an app, the bundle ID is known.

Once you have a ``KeyboardHostApplication``, you can get additional information about the app, and open it with  ``KeyboardHostApplication/open(with:)``. Note that opening the app uses app-specific information that may change at any time.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
