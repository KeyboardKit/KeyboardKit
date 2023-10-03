# Understanding Colors

This article describes the KeyboardKit color engine.

While you can use any native `Color` you like in your custom keyboards, having access to keyboard-specific colors simplifies creating custom keyboards that look more native.

KeyboardKit provides a bunch of keyboard-specific `Color` extensions, such as standard colors for buttons, backgrounds, etc. Some of these colors come with some built-in logic to help work around system limitations, so make sure to read this article carefully.



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

The colors without **ForDarkAppearance** suffix support both light and dark mode, while the ones with the prefix are meant to be used for dark appearance keyboards in light mode.



## Contextual colors

The contextual colors take a ``KeyboardContext`` instance and will vary the result based on the context:

```swift
Color.standardButtonBackground(for: context)
Color.standardButtonForeground(for: context)
Color.standardButtonShadow(for: context)
Color.standardDarkButtonBackground(for: context)
Color.standardDarkButtonForeground(for: context)
```

Using these contextual colors mean that you don't have to check if the keyboard is in dark or light mode, which device that is currently used, etc. It's recommended to use these instead of the raw values. 



## Important about keyboards and colors

If you take a closer look at some of these keyboard colors, you will notice that some of them are semi-transparent. The reason for this is to work around a system limitation (bug) in iOS.

Keyboard extensions get invalid color scheme information from iOS when they are used with a dark appearance text field. iOS will then tell the keyboard extension that is uses a dark color *scheme*, even if the system color scheme is light. 

Since dark appearance keyboards in light mode look different from keyboards in dark mode, being unable to detect the real appearance and color scheme makes it difficult to style the custom keyboard correctly. 

To work around this, some colors use an internal color set that has semi-transparent white colors with an opacity that aims to look good in both light and dark mode.

This has been reported to Apple in the [Feedback Assistant][Bug].



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Bug]: https://github.com/danielsaidi/KeyboardKit/issues/305
