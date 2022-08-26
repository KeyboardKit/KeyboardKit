# Understanding Layouts

This article describes the KeyboardKit keyboard layout model and how to use it. 


## Keyboard layout

In KeyboardKit, input sets and keyboard layouts are central components when creating a ``SystemKeyboard``, where flexibility and configurability is important features. If you want to create a custom keyboard, you don't have to use these concepts.

While an ``InputSet`` defines the input characters of a keyboard, a ``KeyboardLayout`` defines all available keyboard actions, as well as their sizes.

A keyboard layout most often has several input rows, where the input buttons are surrounded by system buttons on either or both sides, as well as a bottom row with a space button and several system buttons.


## Keyboard layout provider

The most flexible way to generate a keyboard layout is with a ``KeyboardLayoutProvider``.

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to ``KeyboardInputViewController/keyboardLayoutProvider``, which is then used by default. You can replace this standard instance with a custom one.

The standard keyboard layout provider can be initialized with an ``InputSetProvider``, which makes it possible to vary the input set while keeping the surrounding keys intact. This standard provider then uses iPhone and iPad-specific providers to generate device-specific layouts. 

KeyboardKit Pro contains additional input set providers for the 50+ locales it supports. This means KeyboardKit Pro lets you create a completely localized ``SystemKeyboard`` for all available locales with just a single line of code.


## How to create a custom input set provider

You can create a custom keyboard layout provider by either inheriting and customizing the ``StandardKeyboardLayoutProvider`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardLayoutProvider`` protocol from scratch.

If you don't have a KeyboardKit Pro license, you can create a custom layout provider.

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
