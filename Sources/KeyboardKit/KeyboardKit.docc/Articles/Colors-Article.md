# Colors

This article describes the KeyboardKit color engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit provides a collection of additional, keyboard-specific colors, that makes it easy to apply a native looking keyboard style.



## Color Extensions

KeyboardKit has static colors that aim to match native iOS system colors, for instance:

```swift
Color.keyboardBackground
Color.keyboardButtonBackground
Color.keyboardButtonBackgroundForDarkAppearance
Color.keyboardButtonForeground
Color.keyboardButtonShadow
```

Colors without **ForDarkAppearance** support both light and dark mode, while the ones with that suffix are meant to be used for dark appearance keyboards in light mode.

KeyboardKit also has contextual colors take a ``KeyboardContext`` and base the color on it:

```swift
Color.keyboardBackground(for: context)
Color.keyboardButtonBackground(for: context)
Color.keyboardButtonForeground(for: context)
Color.keyboardButtonShadow(for: context)
Color.keyboardDarkButtonBackground(for: context)
Color.keyboardDarkButtonForeground(for: context)
```

It's recommended to use these functions instead of the raw color values, since they will adjust the color based on the provided context. 



## Important about keyboards and colors

If you take a closer look at some of these keyboard-specific colors, you will notice that some are semi-transparent. The reason for this is to work around a system bug in iOS.

iOS namely provide keyboard extensions with an invalid color scheme when it's used with a dark appearance text field. iOS will say that the color scheme is `.dark`, even if the system's color scheme is light. 

Since dark appearance keyboards in light mode look quite different from keyboards in dark mode, this bug makes it impossible to apply the correct style, since it's impossible to determine if the system uses light or dark mode.

To work around this bug, some colors use a semi-transparent color with an opacity that aims to look good in both light and dark mode.

This has been [reported to Apple][Bug].



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305
