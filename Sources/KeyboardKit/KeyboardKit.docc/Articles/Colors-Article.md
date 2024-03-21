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

KeyboardKit provides additional, keyboard-specific colors that make it easy to apply a keyboard style that mimics the native style.



## Color Extensions

KeyboardKit has additional colors that aim to match native iOS system colors, for instance ``SwiftUI/Color/keyboardBackground``. See ``SwiftUI/Color`` for a full list of additional colors that are provided by the library.

Colors without the **ForDarkAppearance** name suffix support both light & dark mode, while colors with the suffix are meant to be used for dark appearance keyboards in light mode.

KeyboardKit also has contextual color functions that take a ``KeyboardContext``, for instance ``SwiftUI/Color/keyboardBackground(for:)`` and base the color on the context. It's recommended to use these functions instead of the raw color values. 



## Important about keyboards and colors

If you take a closer look at some of these keyboard-specific colors, you will notice that some are semi-transparent. The reason for this is to work around a system bug in iOS.

iOS namely provide keyboard extensions with an invalid color scheme when it's used with a dark appearance text field. iOS will say that the color scheme is `.dark`, even if the system color scheme is light. 

Since dark appearance keyboards in light mode look quite different from keyboards in dark mode, this bug makes it impossible to apply the correct style, since it's impossible to determine if the system uses light or dark mode.

To work around this bug, some colors use a semi-transparent color with an opacity that aims to look good in both light and dark mode.

This has been [reported to Apple][Bug].



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305
