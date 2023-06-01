# Appearance

This article describes the KeyboardKit appearance engine and how to use it. 

In KeyboardKit, a ``KeyboardAppearance`` defines the styles, texts, icons etc. for different parts of the keyboard. It can adapt styles depending on ``KeyboardContext``, ``KeyboardAction`` etc., which gives you a lot of flexibility.

KeyboardKit will by default create a ``StandardKeyboardAppearance`` and apply it to the input controller ``KeyboardInputViewController/keyboardAppearance``. You can replace it with a custom appearance to customize how your keyboard looks.

[KeyboardKit Pro][Pro] specific features, such as the very convenient theme engine, are described at the end of this document.



## Appearance vs. styles vs. themes

You may find yourself confused by the appearance terminology. Let's clarify what appearances, styles and themes are, and how they are meant to be used. 

A ``KeyboardAppearance`` is a *dynamic* style provider that returns various styles (and more) for various parts of the keyboard. It can return different styles for different actions, if dark mode is enabled etc. so you have full control over every part of your keyboard.

A ``KeyboardTheme`` is a *static* style provider that can be used to define, reuse and share styles. It can be used with a ``KeyboardThemeAppearance`` to add a dynamic capabilities on top of the static theme. These utilities are only available in KeyboardKit Pro.

A `Style` provides properties that can be used to style various parts of the keyboard. One such example is ``KeyboardButtonStyle``. Styles can be customized and used as templates to create other styles.   

You can mix and match appearances, themes and styles as you see fit.



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

The `Appearance` namespace defines a bunch of general styles, such as ``KeyboardButtonStyle``, while other namespaces define more contextual styles, such as how the `Emojis` namespace defines an ``EmojiKeyboardStyle``.

Any style can be modified, as long as it's a `var`. For instance, here we adjust the standard ``CalloutStyle`` to use a red background:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Most styles have a `.standard` style that you can use as a template. The standard styles can also be overwritten with a custom style to change the global style of that component. 



## How to create a custom appearance

You can create a custom ``KeyboardAppearance`` to customize the style of various buttons or callouts, as well as texts, images etc. You can either inherit ``StandardKeyboardAppearance`` to get a lot of functionality for free and customize the parts you want, or implement the ``KeyboardAppearance`` protocol from scratch.

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

### Themes

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a lot easier to define styles for a keyboard. The theme engine comes with several predefined themes and also lets you easily define your own, custom themes.

A ``KeyboardTheme`` can be used to define a bunch of styles, such as button and background styles. KeyboardKit comes with many pre-defined themes, like `.standard`, `.minimal`, `.swifty` and more playful ones like `.candyShop`, `.neon` and `.tron`:

```swift
KeyboardTheme.standard
KeyboardTheme.swifty
KeyboardTheme.minimal
KeyboardTheme.candyShop
KeyboardTheme.neon
KeyboardTheme.tron
```

All pre-defined themes come with style variations that allow you to tweak the overall style of a theme:

```swift
KeyboardTheme.standard(.pink)
KeyboardTheme.swifty(.blue)
KeyboardTheme.minimal(.midnight)
KeyboardTheme.candyShop(.cottonCandy)
KeyboardTheme.neon(.night)
KeyboardTheme.tron(.sark)
```

You can also define a custom style variation directly in the theme initializer:

```swift
KeyboardTheme.standard(.init(tint: .black))
```

Style variations make it easy to play within the overall style of a theme, and only modify the parts that are allowed to change by the theme.


### Custom themes

You can create completely custom themes, like this one that just changes the color of the primary button:

```swift
extension KeyboardTheme {
    static var myCustomTheme: KeyboardTheme {
        get throws {
            var theme = try? KeyboardTheme(
                primaryBackgroundColor: .green
            )
        }
    }
}
```

You can also use another theme as a template and tweak any parts of it:

```swift
extension KeyboardTheme {
    static var anotherTheme: KeyboardTheme {
        get throws {
            var theme = try? KeyboardTheme.standard
            theme.buttonStyles[.primary]?.backgroundColor = .green
            return theme
        }
    }
}
```

You can then access your themese with `KeyboardTheme.myCustomTheme` or just `.myCustomTheme` when a theme is expected.


### Theme-based appearance

Once you have a theme that you want to use, you can use a ``KeyboardThemeAppearance`` to apply any theme to KeyboardKit:

```swift
override func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()

    // Setup KeyboardKit Pro with a license
    try? setupPro(withLicenseKey: "LICENSE_KEY_HERE") { _ in
        keyboardAppearance = KeyboardThemeAppearance(
            theme: .cottonCandy,
            keyboardContext: keyboardContext
        )
    }
}
```

This will make any view that uses the appearance (like the `SystemKeyboard`) use the theme. You can change the theme at any time. 

Since this requires KeyboardKit Pro, you must register it *after* setting up your license. 

You can inherit ``KeyboardThemeAppearance`` to customize the appearance even further, which lets you mix the benefits of themes and appearances in any way that fits your needs.


### Pre-defined themes

You can access all pre-defined themes with `KeyboardTheme.{ID}`, for instance `KeyboardKit.standard` or `KeyboardKit.minimal(.pink)`. Here are all pre-defined themes with some style variations:

| Theme        |                               |                                        |                                |                                 |
| ------------ | ----------------------------- | -------------------------------------- | ------------------------------ | ------------------------------- | 
| `.standard`  | ![Standard](standard.jpg)     | ![Standard](standard-blue.jpg)         | ![Standard](standard-pink.jpg) | ![Standard](standard-green.jpg) | 
| `.swifty`    | ![Swifty](swifty.jpg)         | ![Swifty](swifty-blue.jpg)             | ![Swifty](swifty-pink.jpg)     | ![Swifty](swifty-green.jpg)     | 
| `.minimal`   | ![Minimal](minimal.jpg)       | ![Midnight](minimal-blue.jpg)          | ![Sunset](minimal-sunset.jpg)  | ![Sunset](minimal-midnight.jpg) | 
| `.candyShop` | ![Candy Shop](candyshop.jpg)  | ![Cuppy Cake](candyshop-cuppycake.jpg) |                                |                                 |
| `.neon`      | ![Neon](neon.jpg)             |                                        |                                |                                 | 
| `.tron`      | ![Tron](tron.jpg)             | ![fCon](tron-fcon.jpg)                 | ![virus](tron-virus.jpg)       | ![virus](tron-sark.jpg)         |

You can get all pre-defined themes with `KeyboardTheme.allPredefined`. Theme-specific styles also have an `allPredefined` with all style variations for a certain theme, e.g. `KeyboardTheme.SwiftyStyle.allPredefined`.


### Views

KeyboardKit Pro has a ``KeyboardThemeLivePreview`` that you can use to preview themes in Xcode or display themes to the user. It will render a system keyboard with full interation, which means that it's quite heavy to render. You can use the more lightweight ``KeyboardThemeButtonPreview`` to preview many themes at the same time.


### License Requirements

The KeyboardKit Pro theme engine requires a `Gold` license.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
