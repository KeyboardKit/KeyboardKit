# Appearance

This article describes the KeyboardKit appearance engine and how to use it. 

In KeyboardKit, a ``KeyboardAppearance`` defines the styles, texts, icons etc. for different parts of the keyboard. It can adapt styles depending on ``KeyboardContext``, ``KeyboardAction`` etc., which gives you a lot of flexibility.

KeyboardKit will by default create a ``StandardKeyboardAppearance`` and apply it to the input controller ``KeyboardInputViewController/keyboardAppearance``. You can replace it with a custom appearance to customize how your keyboard looks.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Appearance vs. styles vs. themes

You may find yourself confused by the appearance terminology, as we talk about appearances, styles and themes, so let's clarity what they are and how they are used. 

A ``KeyboardAppearance`` is a dynamic style provider, that returns various styles (and more) for various parts of the keyboard, such as a ``KeyboardButtonStyle``. With dynamic, means that it can return different styles for different actions, if dark mode is enabled etc. so you have full control over every little button.

KeyboardKit Pro adds the concept of a ``KeyboardTheme``, which is a way to define static styles. Themes make it a lot easier to define, reuse and share styles, but are not dynamic like a ``KeyboardAppearance`` can be.

KeyboardKit Pro adds a theme-based ``KeyboardThemeAppearance`` that uses a theme to define styles. You can override this class to customize things further and make use of the dynamic capabilites of the appearance, while also making use of the power of themes.

You can mix and match appearances, styles and themes as you see fit.



## Resources & Assets

KeyboardKit comes with colors and images that make it easy to create native-looking keyboards.

* `Image` has a bunch of static, keyboard-specific images, e.g. `.keyboardBackspace`.
* `Color` has a bunch of static, keyboard-specific colors, e.g. `.standardButtonBackgroundColor(for:)`.
* ``KeyboardAction`` and other types have standard images, texts and colors, for instance:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // Localized "space"
```

Have a look at the `Sources/Resources` and `Sources/Appearance` folders for more information.



## Styles

The `Appearance` namespace defines general styles, such as ``KeyboardButtonStyle``, while other namespaces define more contextual styles, such as how the `Emojis` namespace defines an ``EmojiKeyboardStyle``.

Any style can be modified as long as it's a `var`. For instance, here we adjust the standard ``CalloutStyle`` to use a red background:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Almost all styles have a `.standard` style that you can replace with a custom style to change the global style of that component. 



## How to create a custom appearance

You can create a custom ``KeyboardAppearance`` to customize the style of various buttons or callouts, as well as texts, images etc. 

You can either inherit ``StandardKeyboardAppearance`` to get a lot of functionality for free and customize the parts you want, or implement the ``KeyboardAppearance`` protocol from scratch.

For instance, here's a custom appearance that inherits ``StandardKeyboardAppearance`` and makes all input buttons red:

```swift
class MyKeyboardAppearance: StandardKeyboardAppearance {
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardButtonStyle {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        if !action.isInputAction { return style }
        style.backgroundColor = .red
        return style
    }
}
```

To use this appearance instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardAppearance`` to the new appearance:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardAppearance = MyKeyboardAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom appearance instead of ``StandardKeyboardAppearance``.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a LOT easier to define styles for a keyboard. It comes with several predefined themes and lets you define your own themes.


### How to use themes

The ``KeyboardTheme`` struct defines a bunch of styles, such as button and background styles.

For instance, this theme just changes the tint color of the primary button:

```swift
var myCustomTheme: KeyboardTheme {
    get throws {
        var theme = try? KeyboardTheme(
            primaryBackgroundColor: .green
        )
    }
}
```

You can use another theme as a template and tweak any parts of it:

```swift
var anotherTheme: KeyboardTheme {
    get throws {
        var theme = try KeyboardTheme.cottonCandy
        theme.buttonStyles[.primary]?.backgroundColor = .green
        return theme
    }
}
```

Once you have a theme that you want to use, you can use a ``KeyboardThemeAppearance`` to apply it:

```swift
override func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()

    // Setup KeyboardKit Pro with a license
    try? setupPro(withLicenseKey: "LICENSE_KEY_HERE") { _ in
        keyboardAppearance = KeyboardThemeAppearance(
            theme: .cottonCandy,
            keyboardContext: keyboardContext)
    }
}
```

Since the theme engine requires KeyboardKit Pro, you must register it *after* setting up your license. You can inherit this appearance to customize a base theme even further.


### Pre-defined themes

KeyboardKit Pro comes with a set of pre-defined themes, which you can access with `KeyboardTheme.{ID}`:

| ID               | Preview                                  |
| ---------------- | ---------------------------------------- | 
| `.cottonCandy`   | ![Cotton Candy](cotton-candy-500.png)    | 
| `.neonNights`    | ![Neon Nights](neon-nights-500.png)      | 
| `.tron`          | ![Tron](tron-500.png)                    |


### License Requirements

The KeyboardKit Pro theme engine requires a `Gold` license.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
