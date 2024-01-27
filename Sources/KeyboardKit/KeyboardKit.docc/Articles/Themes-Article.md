# Themes

This article describes the KeyboardKit theme engine.

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a lot easier to style your keyboard. It comes with many predefined themes and style variations.


## What is a theme?

A **KeyboardTheme** can be used to define keyboard styles in a way that can be easily used and modified. Themes can define style variations, to provide even more variations.

KeyboardKit Pro unlocks a **ThemeBasedKeyboardStyleProvider** that can be used to apply any theme in a convenient way.


## Predefined themes

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

You can also define custom style variations directly in a theme initializer:

```swift
KeyboardTheme.standard(
    .init(tint: .black)
)
```

Style variations make it easy to define what parts of a theme that should be customizable.


### Custom themes

You can create completely custom themes, like this one that changes the primary button color:

```swift
extension KeyboardTheme {

    static var customTheme: KeyboardTheme {
        get throws {
            var theme = try? KeyboardTheme(
                primaryBackgroundColor: .green
            )
        }
    }
}
```

You can also use other themes as templates when creating custom themes, for instance:

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

You can then access your theme with **KeyboardTheme.customTheme** or just **.customTheme** when passing it as a parameter.


### Theme-based styling

Once you have a theme, you can apply it with a **ThemeBasedKeyboardStyleProvider**:

```swift
override func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()

    // Setup KeyboardKit Pro with a license
    setupPro(withLicenseKey: "...") { license in
        keyboardStyleProvider = ThemeBasedKeyboardStyleProvider(
            theme: .cottonCandy,
            keyboardContext: keyboardContext
        )
    } view: { controller in
        // Return your keyboard view here
    }
}
```

This will make any view that uses the style provider (like ``SystemKeyboard``) use this theme.

You can inherit **ThemeBasedKeyboardStyleProvider** to customize this theme-based provider even further, which lets you mix the benefits of themes and styles in even more ways.

> Important: The theme engine requires KeyboardKit Pro, so you must register the provider after registering your license key. 


### Pre-defined themes

You can access all pre-defined themes with **KeyboardTheme.{ID}**, e.g. **KeyboardKit.standard** or **KeyboardKit.minimal(.pink)**. 

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

You can access all pre-defined themes with **KeyboardTheme.allPredefined**. Pre-defined style variations also have an **allPredefined** property, e.g. **KeyboardTheme.SwiftyStyle.allPredefined**.


### Previews

KeyboardKit Pro unlocks powerful tools to preview themes. See <doc:Previews-Article> for more information.


### License Requirements

The KeyboardKit Pro theme engine requires a `Gold` license.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
