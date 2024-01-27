# Colors

This article describes the KeyboardKit color engine.

While you can use any native SwiftUI **Color** you like in your custom keyboards, having access to keyboard-specific colors simplifies creating custom keyboards that look native.

KeyboardKit therefore provides a bunch of additional, keyboard-specific colors, such as button and background colors. 

Some of these colors come with some built-in logic to help work around iOS system limitations, so make sure to read this article carefully.



## Raw colors

The raw colors aim to match the iOS system design as closely as possible:

```swift
Color.standardButtonBackground
Color.standardButtonBackgroundForDarkAppearance
Color.standardButtonForeground
Color.standardButtonForegroundForDarkAppearance
Color.standardButtonShadow
Color.standardDarkButtonBackground
Color.standardDarkButtonBackgroundForDarkAppearance
Color.standardDarkButtonForeground
Color.standardDarkButtonForegroundForDarkAppearance
Color.standardKeyboardBackground
Color.standardKeyboardBackgroundForDarkAppearance
```

The colors without **ForDarkAppearance** support both light and dark mode, while the ones with that suffix are meant to be used for dark appearance keyboards in light mode.



## Contextual colors

Contextual colors take a ``KeyboardContext`` value and vary the result based on the context:

```swift
Color.standardButtonBackground(for: context)
Color.standardButtonForeground(for: context)
Color.standardButtonShadow(for: context)
Color.standardDarkButtonBackground(for: context)
Color.standardDarkButtonForeground(for: context)
```

When you use these colors, you don't have to check if the keyboard is in dark or light mode, which device that is currently used, etc.



## Important about keyboards and colors

If you take a closer look at some of these colors, you will notice that some are semi-transparent. The reason for this is to work around a system limitation (bug?) in iOS.

Keyboard extensions get invalid color scheme information when used with a dark appearance text field. iOS will say that is uses a dark color scheme, even if the system color scheme is light. 

Since dark appearance keyboards in light mode look different from keyboards in dark mode, this incorrect information makes it difficult to style keyboards correctly. 

To work around this, some colors use a semi-transparent color with an opacity that aims to look good in both light and dark mode. This has been [reported to Apple][Bug].



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305
