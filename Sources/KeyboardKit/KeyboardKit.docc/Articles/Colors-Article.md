# Colors

This article describes the KeyboardKit color engine.

While you can use any native SwiftUI **Color** you like in your custom keyboards, having access to keyboard-specific colors simplifies creating custom keyboards that look native.

KeyboardKit therefore provides a bunch of additional, keyboard-specific colors, such as button and background colors. 

Some of these colors come with some built-in logic to help work around iOS system limitations, so make sure to read this article carefully.



## Color Extensions

KeyboardKit has static colors that aim to match native iOS system colors, like:

```swift
Color.keyboardBackground
Color.keyboardButtonBackground
Color.keyboardButtonBackgroundForDarkAppearance
Color.keyboardButtonForeground
Color.keyboardButtonShadow
```

Colors without a **ForDarkAppearance** suffix support both light and dark mode, while the ones with the suffix are meant to be used for dark appearance keyboards in light mode.

KeyboardKit also has contextual colors take a ``KeyboardContext`` and base the color on it:

```swift
Color.keyboardBackground(for: context)
Color.keyboardButtonBackground(for: context)
Color.keyboardButtonForeground(for: context)
Color.keyboardButtonShadow(for: context)
Color.keyboardDarkButtonBackground(for: context)
Color.keyboardDarkButtonForeground(for: context)
```

Using the contextual colors means that you don't have to check for light or dark mode, which device that is currently used, etc. It's recommended to use these instead of the raw values.



## Important about keyboards and colors

If you take a closer look at some of these colors, you will notice that some are semi-transparent. The reason for this is to work around a system limitation (bug?) in iOS.

Keyboard extensions get invalid color scheme information when used with a dark appearance text field. iOS will say that is uses a dark color scheme, even if the system color scheme is light. 

Since dark appearance keyboards in light mode look different from keyboards in dark mode, this incorrect information makes it difficult to style keyboards correctly. 

To work around this, some colors use a semi-transparent color with an opacity that aims to look good in both light and dark mode. This has been [reported to Apple][Bug].



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305
