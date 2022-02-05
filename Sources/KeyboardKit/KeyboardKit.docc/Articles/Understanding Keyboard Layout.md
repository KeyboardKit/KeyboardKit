# Understanding Keyboard Layouts

This article describes the KeyboardKit keyboard layout concept and how to use it. 


## Keyboard layout

In KeyboardKit, a ``KeyboardLayout`` defines all available keyboard actions on a keyboard, as well as their size.

A keyboard layout most often consists of several input rows where the input buttons are surrounded by system buttons on either or both sides, as well as a bottom row with a space button and several system buttons.

Input sets and keyboard layouts are central components when creating a ``SystemKeyboard``, where flexibility and configurability is important features. If you want to create a custom keyboard, you don't have to use these concepts.

The most flexible way to generate a keyboard layout is with a ``KeyboardLayoutProvider``.


## Keyboard layout provider

KeyboardKit will create a ``StandardKeyboardLayoutProvider`` when the keyboard extension is started and then apply it to ``KeyboardInputViewController/keyboardLayoutProvider`` then use this instance by default to generate keyboard layouts.

KeyboardKit comes with a ``StandardKeyboardLayoutProvider``, which can be initialized with an ``InputSetProvider``, then uses separate layout providers for iPhone and iPad.

KeyboardKit also has an ``SystemKeyboardLayoutProvider``, which can be used as a general base class for creating layouts. It provides a bunch of utilities that makes this task easier.

KeyboardKit Pro can be used to unlock an input set provider for each ``KeyboardLocale``. This means that you can create a completely localized ``SystemKeyboard`` for all available locales with just a single line of code.


## Device specific layout providers

When creating system keyboards, the keyboard layout can vary depending on the device type.

KeyboardKit has ``iPhoneKeyboardLayoutProvider`` and ``iPadKeyboardLayoutProvider`` base classes that you can base your custom, device-specific layouts on.  


## How to create a custom input set provider

If you don't have a KeyboardKit Pro license, you can create a custom layout provider.

You can create a custom implementation of this protocol, by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

For instance, here is a custom provider that extends ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

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
