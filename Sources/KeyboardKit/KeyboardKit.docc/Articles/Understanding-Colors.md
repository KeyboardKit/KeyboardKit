# Understanding Colors

This article describes the KeyboardKit color engine.

KeyboardKit provides a bunch of keyboard-specific colors. 

Some of these colors come with some caveats to help work around system limitations, so make sure to read this article carefully.


## Raw colors

KeyboardKit has a ``KeyboardColor`` enum with raw keyboard colors, such as:

```swift
KeyboardColor.standardButtonBackground
KeyboardColor.standardButtonForeground
KeyboardColor.standardKeyboardBackground
```

These colors aim to match the iOS system design as closely as possibly.


## Contextual colors

KeyboardKit has a ``KeyboardColorReader`` protocol that provides contextual colors based on the raw colors. It's implemented by `Color`, and can be implemented by any type. 

You can then get colors from a color reader like this:

```swift
let color = Color.standardButtonBackground(for: keyboardContext)
```

These contextual colors will return different colors based on the system color scheme, and sometimes even device type. This means that you don't have to pick which raw color to use.

The reason for having the reader protocol is basically just to expose this extended `Color` functionality to the documentation.


## Why having contextual colors?

The ``KeyboardColorReader`` protocol has many colors that may look strange, but the reason for having them is to work around an iOS bug that causes keyboards to get invalid color scheme information when used with a dark keyboard appearance. 

When editing a dark appearance text field in light mode, iOS will incorrectly tell the keyboard that the system color scheme is dark. Since dark appearance keyboards in light mode look different from dark mode keyboards, this gives us some problems. 

Since iOS makes it impossible for us to detect if the system uses dark or light mode, some colors will resolve to colors that are semi-transparent white, with an opacity that aims to look good in both light and dark mode.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
