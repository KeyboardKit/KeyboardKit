# Understanding Layouts

This article describes the KeyboardKit keyboard layout engine and how to use it. 


## Input sets vs keyboard layouts

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating ``SystemKeyboard``s. You can also use them when you create custom keyboards, but you don't have to.

An ``InputSet`` defines the input keys on a keyboard, which can be combined with other actions to create a ``KeyboardLayout``, which defines the full set of actions on a keyboard as well as insets, sizes etc. This means that you can use many different input sets with a single keyboard layout. 

A typical system keyboard layout has several rows, where center input buttons are surrounded by action buttons on one or both sides.



## Keyboard layout providers

The most flexible way to generate a keyboard layout is with a ``KeyboardLayoutProvider``. KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to ``KeyboardInputViewController/keyboardLayoutProvider`` when it's initialized. You can replace this provider with a custom one if you want to.

The ``StandardKeyboardLayoutProvider`` is initialized with an ``InputSetProvider``, which makes it possible to vary the input set while keeping the surrounding keys intact. It uses an ``iPhoneKeyboardLayoutProvider`` and an ``iPadKeyboardLayoutProvider`` to generate device-specific layouts.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional input set providers for the 50+ locales it supports, e.g. `PolishInputSetProvider`, localized input sets like `AlphabeticInputSet.filipino` and input set variations like `AlphabeticInputSet.azerty`, `AlphabeticInputSet.qwertz`. 

This means that [KeyboardKit Pro][Pro] lets you create fully localized ``SystemKeyboard``s for all available locales with a single line of code.



## How to customize the standard layout provider

If you want to make minor customizations to the standard layout provider, there are a couple of options:

* Subclass ``StandardKeyboardLayoutProvider`` and override ``StandardKeyboardLayoutProvider/keyboardLayout(for:)``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPadProvider``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPhoneProvider``.

You can also create a completely custom keyboard layout provider, see below.


## How to create a custom keyboard layout provider

You can create a custom keyboard layout provider by either inheriting and customizing the ``StandardKeyboardLayoutProvider`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardLayoutProvider`` protocol from scratch.

For instance, here's a custom provider that extends ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

```swift
class MyKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.itemRows
        var row = layout.itemRows[0]
        let next = row[0]
        let size = KeyboardLayoutItemSize(width: .available, height: next.size.height)
        let tab = KeyboardLayoutItem(action: .tab, size: size, insets: next.insets)
        row.insert(tab, at: 0)
        rows[0] = row
        layout.itemRows = rows
        return layout
    }
}
```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardLayoutProvider = MyKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
