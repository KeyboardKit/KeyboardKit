# Understanding Extensions

This article describes KeyboardKit native type extensions.

Since native type extensions don't show up in DocC, this article will list some extensions you get by just adding KeyboardKit to your app or keyboard extension.



## String extensions

KeyboardKit extends **String** with a few extensions:

```swift
"a".isLowercasedWithUppercaseVariant    // True
"A".isLowercasedWithUppercaseVariant    // False
"1".isLowercasedWithUppercaseVariant    // False
"a".isUppercasedWithLowercaseVariant    // False
"A".isUppercasedWithLowercaseVariant    // True
"1".isUppercasedWithLowercaseVariant    // False

"abc".chars     // ["a", "b", "c"]
```

These extensions are used in the library, to determine button styles.



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
