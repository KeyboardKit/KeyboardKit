# Styling

This article describes the KeyboardKit styling engine.

KeyboardKit uses ``KeyboardStyle`` types to style various views. For instance, a ``KeyboardStyle/InputCallout`` style can be used to style ``InputCallout`` views. 

[KeyboardKit Pro][Pro] specific features, such as the convenient theme engine, are described at the end of this document.



## Terminology

KeyboardKit uses different names for different parts of the styling engine. Let's clarify what they are and how they are meant to be used. 

* A ``KeyboardStyle`` type is a *static* style that can be applied to certain views.
* A ``KeyboardStyleProvider`` is a *dynamic* style provider for condition-based styles.
* A `KeyboardTheme` (Pro) is a *static* style provider that can define, reuse and share styles.

You can mix and match these different concepts as you see fit.



## Resources & Assets

KeyboardKit comes with colors and assets that can be used to create native-looking keyboards.

* `Image` has a bunch of keyboard-specific images, e.g. `.keyboardBackspace`.
* `Color` has a bunch of keyboard-specific colors, e.g. `.standardButtonBackground`.
* ``KeyboardAction`` and other types have standard images, texts and colors, for instance:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // Localized "space"
```

Have a look at the `Sources/Resources` and `Sources/Styling` folders for more info.



## Styles

The ``KeyboardStyle`` namespace defines many styles, like ``KeyboardStyle/Button``, while other namespaces define contextual styles, like ``EmojiKeyboardStyle``.

All styles can be modified. For instance, here we add a red background to a ``KeyboardStyle/Callout`` value:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Most styles have a `.standard` style that you can use as a template. The standard styles can also be overwritten with a custom style to change the global style of that component.



## Style providers

A ``KeyboardStyleProvider`` can return dynamic styles for different parts of the keyboard. 

Unlike static styles, style providers can vary styles depending on the ``KeyboardContext``, ``KeyboardAction`` etc. This makes them very flexible.

KeyboardKit will by default create a ``StandardKeyboardStyleProvider`` and bind it to the input controller's ``KeyboardInputViewController/keyboardStyleProvider``. 

You can replace this style provider with a custom one, to change how the keyboard is styled.


### How to create a custom style provider

You can create a custom style provider by inheriting the ``StandardKeyboardStyleProvider`` and customize the parts you want, or implement the ``KeyboardStyleProvider`` protocol from scratch.

For instance, here's a custom provider that inherits ``StandardKeyboardStyleProvider`` and makes all input buttons red:

```swift
class CustomKeyboardStyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        if !action.isInputAction { return style }
        style.backgroundColor = .red
        return style
    }
}
```

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardStyleProvider`` to your custom provider, like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardStyleProvider = CustomKeyboardStyleProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

### Themes

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a lot easier to define styles for a keyboard, using themes to define a bunch of styles, such as button and background styles. 

KeyboardKit comes with many pre-defined themes, like `.standard`, `.minimal`, `.swifty` and more playful ones like `.candyShop`, `.neon` and `.tron`:

```swift
KeyboardTheme.standard
KeyboardTheme.swifty
KeyboardTheme.minimal
KeyboardTheme.candyShop
KeyboardTheme.colorful
KeyboardTheme.neon
KeyboardTheme.tron
```

All pre-defined themes come with style variations that allow you to tweak the style of a theme:

```swift
KeyboardTheme.standard(.pink)
KeyboardTheme.swifty(.blue)
KeyboardTheme.minimal(.midnight)
KeyboardTheme.candyShop(.cottonCandy)
KeyboardTheme.colorful(.purple)
KeyboardTheme.neon(.night)
KeyboardTheme.tron(.sark)
```

You can also define a custom style variation directly in the theme initializer:

```swift
KeyboardTheme.standard(
    .init(tint: .black)
)
```

Style variations make it easy to play within the overall style of a theme, and only modify the parts that are meant to be changed by the theme.


### Custom themes

You can create completely custom themes, like this one that changes the primary button color:

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


### Theme-based styling

Once you have a theme that you want to use, you can use the `ThemeBasedKeyboardStyleProvider` with any theme:

```swift
override func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()

    // Setup KeyboardKit Pro with a license
    try? setupPro(withLicenseKey: "LICENSE_KEY_HERE") { _ in
        keyboardStyleProvider = ThemeBasedKeyboardStyleProvider(
            theme: .cottonCandy,
            keyboardContext: keyboardContext
        )
    }
}
```

This will make any view that uses the style provider (like ``SystemKeyboard``) use this theme. You can change the theme at any time. 

Since this requires KeyboardKit Pro, you must register it *after* setting up your license. 

You can inherit `ThemeBasedKeyboardStyleProvider` to customize this theme-based provider even further, which lets you mix the benefits of themes and styles in even more ways.


### Pre-defined themes

You can access all pre-defined themes with `KeyboardTheme.{ID}`, for instance `KeyboardKit.standard` or `KeyboardKit.minimal(.pink)`. 

Here is a list of all pre-defined themes with some style variations:

| Theme        |                                     |                                        |                                       |                                         |
| ------------ | ----------------------------------- | -------------------------------------- | ------------------------------------- | --------------------------------------- | 
| `.standard`  | ![Standard](standard.jpg)           | ![Standard Blue](standard-blue.jpg)    | ![Standard Pink](standard-pink.jpg)   | ![Standard Green](standard-green.jpg)   | 
| `.swifty`    | ![Swifty](swifty.jpg)               | ![Swifty Blue](swifty-blue.jpg)        | ![Swifty Pink](swifty-pink.jpg)       | ![Swifty Green](swifty-green.jpg)       | 
| `.minimal`   | ![Minimal](minimal.jpg)             | ![Minimal Blue](minimal-blue.jpg)      | ![Minimal Sunset](minimal-sunset.jpg) | ![Sunset Green](minimal-midnight.jpg)   | 
| `.candyShop` | ![Candy Shop](candyshop.jpg)        | ![Cuppy Cake](candyshop-cuppycake.jpg) |                                       |                                         | 
| `.colorful`  | ![Colorful Blue](colorful-blue.jpg) | ![Colorful Green](colorful-green.jpg)  | ![Colorful Red](colorful-red.jpg)     | ![Colorful Purple](colorful-purple.jpg) |
| `.neon`      | ![Neon](neon.jpg)                   |                                        |                                       |                                         | 
| `.tron`      | ![Tron](tron.jpg)                   | ![fCon](tron-fcon.jpg)                 | ![virus](tron-virus.jpg)              | ![virus](tron-sark.jpg)                 |

You can access all pre-defined themes with `KeyboardTheme.allPredefined`. 

Theme-specific styles also have an `allPredefined` with all style variations for a certain theme, e.g. `KeyboardTheme.SwiftyStyle.allPredefined`.


### Views

KeyboardKit Pro has a `KeyboardThemeLivePreview` that you can use to preview themes in Xcode or display a theme to the user.  It will render a system keyboard with full interation. 

The live preview is quite heavy to render, so you should probably only have at most a single one displayed at any given time.

You can also use the more lightweight `KeyboardThemeButtonPreview` to preview many themes at the same time. This preview will only render one or several buttons for the theme.


### License Requirements

The KeyboardKit Pro theme engine requires a `Gold` license.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
