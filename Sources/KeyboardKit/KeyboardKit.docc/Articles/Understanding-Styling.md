# Understanding Styling

This article describes the KeyboardKit styling engine.

While native iOS keyboards provide very little ways of customizing the look and feel of the keyboard, KeyboardKit-based keyboards can be styled and customized to great extent.

KeyboardKit uses ``KeyboardStyle`` types to style its views. For instance, a ``KeyboardStyle/InputCallout`` style can be used to style a ``Callouts/InputCallout`` view. 

[KeyboardKit Pro][Pro] unlocks a powerful theme engine when you register a valid license key. More information about this Pro feature can be found at the end of this article.



## Terminology

KeyboardKit uses different names for different ways to style keyboards. 

* A ``KeyboardStyle`` style is *static* and can be applied to certain views.
* A ``KeyboardStyleProvider`` is a *dynamic* style provider that provides context-based styles.
* A **KeyboardTheme** (Pro) is a *static* style provider that can define, reuse and share styles.

You can mix and match these different concepts as you see fit.



## Resources & Assets

KeyboardKit comes with colors and assets that can be used to create native-looking keyboards.

* **Image** has a bunch of keyboard-specific images, e.g. `.keyboardBackspace`.
* **Color** has a bunch of keyboard-specific colors, e.g. `.standardButtonBackground`.
* ``KeyboardAction`` and other types have standard images, texts and colors.

For instance, to get the standard button image and text for an action, you can do this:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // Localized "space"
```

Have a look at <doc:Understanding-Colors> and <doc:Understanding-Images> for more information about colors and images.



## Styling namespace

KeyboardKit has a ``Styling`` namespace that contains styling-related types.

The namespace doesn't contain protocols or open classes, or types that are meant to be top-level ones. It's meant to be a container for types used by top-level types, to make the library easier to overview.

For now, it only has a ``Styling/KeyboardAppearanceViewModifier`` that can be applied with **.keyboardAppearance(...)**.



## Keyboard styles

The ``KeyboardStyle`` namespace defines many static keyboard styles, like ``KeyboardStyle/Button``.

All these styles can be modified. For instance, here we add a red background to a ``KeyboardStyle/Callout`` value, then set the style to the global default:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Most styles have a `.standard` style that you can use as a template. The standard styles can also be overwritten with a custom style to change the global default style of that component.



## Style providers

A ``KeyboardStyleProvider`` can return dynamic styles for different parts of the keyboard. 

Unlike static styles, style providers can vary styles depending on the ``KeyboardContext``, ``KeyboardAction`` etc. This makes them very flexible.

KeyboardKit will bind a ``StandardKeyboardStyleProvider`` to ``KeyboardInputViewController/keyboardStyleProvider`` when the keyboard is loaded. You can replace it with a custom implementation at any time.



## How to create a custom style provider

You can create a custom style provider by either inheriting the ``StandardKeyboardStyleProvider`` and customize the parts you want, or implement the ``KeyboardStyleProvider`` protocol from scratch.

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

To use this provider instead of the standard one, just set ``KeyboardInputViewController/keyboardStyleProvider`` to this custom provider:

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

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a lot easier to define styles for a keyboard.

### Themes

A **KeyboardTheme** can be used to define a bunch of styles, such as button and background styles. You can also use other themes as templates to create your own custom themes. 

KeyboardKit comes with many pre-defined themes:

```swift
KeyboardTheme.standard
KeyboardTheme.swifty
KeyboardTheme.minimal
KeyboardTheme.candyShop
KeyboardTheme.colorful
KeyboardTheme.neon
KeyboardTheme.tron
```

All pre-defined themes come with style variations that allow you to tweak parts of a theme:

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

Style variations make it easy to play within the style of a theme, and only modify the parts that are meant to be changed by the theme.


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

You can then access your theme with **KeyboardTheme.myCustomTheme** or just **.myCustomTheme** when passing in the theme as a function parameter.


### Theme-based styling

Once you have a theme that you want to use, you can use the **ThemeBasedKeyboardStyleProvider**:

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

This will make any view that uses the style provider (like ``SystemKeyboard``) use this theme. You can change this theme at any time.

You can inherit **ThemeBasedKeyboardStyleProvider** to customize this theme-based provider even further, which lets you mix the benefits of themes and styles in even more ways.

> Important: Since the theme engine requires KeyboardKit Pro, you must register this provider *after* registering your KeyboardKit Pro license key. 


### Pre-defined themes

You can access all pre-defined themes with **KeyboardTheme.{ID}**, for instance **KeyboardKit.standard** or **KeyboardKit.minimal(.pink)**. 

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

You can access all pre-defined themes with **KeyboardTheme.allPredefined**. All pre-defined style variations also have an **allPredefined** property, e.g. **KeyboardTheme.SwiftyStyle.allPredefined**.


### Previews

KeyboardKit Pro unlocks powerful tools to preview themes:

```swift
SystemKeyboardThemePreview(...)         // A live theme preview.
SystemKeyboardThemePreviewHeader(...)   // A live theme preview header.
```

Since these views render system keyboards with full interation, they are quite performance demanding. 

To preview many themes at once, you can use this more lightweight preview:

```swift
SystemKeyboardButtonThemePreview(...)   // A system button preview for a theme.
```

This preview only renders lightweight buttons. See <doc:Understanding-System-Keyboards> for more information.


### License Requirements

The KeyboardKit Pro theme engine requires a `Gold` license.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
