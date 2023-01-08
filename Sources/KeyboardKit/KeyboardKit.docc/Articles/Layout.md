# Layouts

This article describes the KeyboardKit keyboard layout engine and how to use it. 

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating a ``SystemKeyboard``. You can also use them to create custom keyboards, but you don't have to.

An ``InputSet`` defines the input keys on a keyboard, while a ``KeyboardLayout`` defines the full set of actions on a keyboard, as well as their heights, sizes etc. This means that you can use many different input sets with a single keyboard layout.  

A typical system keyboard layout has several rows, where center input buttons are surrounded by action buttons on one or both sides.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Keyboard layout providers

KeyboardKit provides you with a foundation for generating flexible and dynamic keyboard layouts. The most flexible way to generate a keyboard layout is with a ``KeyboardLayoutProvider``. 

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to the input controller's ``KeyboardInputViewController/keyboardLayoutProvider``. You can replace it with a custom provider to customize the standard layout.

KeyboardKit also has an ``EnglishKeyboardLayoutProvider`` that defines the layout of a U.S. English keyboard. This provider is used by the standard provider, which supports injecting multiple locale-specific providers.



## How to customize the standard layout provider

If you want to make minor customizations to the standard layout provider, there are a couple of options:

* Subclass ``StandardKeyboardLayoutProvider`` and override ``StandardKeyboardLayoutProvider/keyboardLayout(for:)``.
* Add more localized providers to the ``StandardKeyboardLayoutProvider`` instance. 
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPadProvider``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPhoneProvider``.

You can also create a completely custom keyboard layout provider, see below.


## How to create a custom keyboard layout provider

You can create a custom keyboard layout provider by either inheriting and customizing the ``StandardKeyboardLayoutProvider`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardLayoutProvider`` from scratch.

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


## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional keyboard layouts and keyboard layout providers for the 60 locales it supports. 

This lets you create a fully localized ``SystemKeyboard`` for all available locales with a single line of code.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
