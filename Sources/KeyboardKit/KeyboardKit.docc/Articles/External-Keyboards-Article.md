# External Keyboards

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

This article describes the KeyboardKit external keyboard engine.

Keyboard extensions start to behave strangely when you type on an external keyboard. For instance, the keyboard extension will stop receiving information about when text changes, and will only update the context when the text cursor moves.

👑 [KeyboardKit Pro][Pro] unlocks tools that help you easily detect if an external keyboard is connected to the device, for instance if a magic keyboard is connected to an iPad. Information about Pro features can be found further down.


## Workarounds

One way to force the proxy to update is to move the text cursor with a fixed interval, to make the keyboard read the current text. This may however interfere with the typing, so it's not encouraged.

Due to this limitation, it may be better to collapse the keyboard to a compact toolbar when an external keyboard is connected. You can always add a button that expands the keyboard again.


## How to collapse the keyboard

The ``KeyboardContext/isKeyboardCollapsed`` context property can be used to collapse the keyboard, e.g. when an external keyboard is connected. KeyboardKit Pro will automatically update this if the context setting's ``KeyboardContext/Settings-swift.struct/isKeyboardAutoCollapseEnabled`` is true. 

The ``KeyboardView`` lets you define which view to show when it's collapsed. It defaults to a ``Keyboard/CollapsedView``, which can be set to use any custom content. See the <doc:Essentials-Article> article for more information.


## How to manage external keyboard state 

KeyboardKit has an ``ExternalKeyboardContext`` that has state for if an external keyboard is connected, such as a Smart Keyboard Folio, a Magic Keyboard, any Bluetooth keyboards, etc.

KeyboardKit Pro will automatically keep this context up to date when an external keyboard is connected and disconnected. Without it, you must listen for connection changes yourself and update this context accordingly.  



---


## 👑 KeyboardKit Pro


KeyboardKit Pro will automatically keep the ``ExternalKeyboardContext`` up to date when an external keyboard is connected and disconnected. Without it, you must listen for connection changes yourself and update this context accordingly.

> Warning: KeyboardKit Pro will consider an Apple Smart Keyboard Folio to be connected even when it's just snapped on to the device and not being actively used. This should be improved.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
