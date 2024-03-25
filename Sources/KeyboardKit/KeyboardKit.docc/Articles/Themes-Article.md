# Themes

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit theme engine.

👑 [KeyboardKit Pro][Pro] unlocks a theme engine and ``KeyboardTheme`` type, that makes it a lot easier to style your keyboard with themes. 

KeyboardKit Pro comes with many predefined themes, style variations and theme-based views. You can also create your own themes and style variations.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


## What is a theme?

A ``KeyboardTheme`` can be used to define keyboard styles in a way that can be easily used and modified. Themes can also define style variations, to provide even more variations within a constrained set of properties.

KeyboardKit Pro also unlocks a ``ThemeBasedKeyboardStyleProvider``, which can be used to apply themes with the same style provider concept that is already used by many views in the library.


## Predefined themes

KeyboardKit comes with many pre-defined themes, like ``KeyboardTheme/standard``, ``KeyboardTheme/swifty`` and ``KeyboardTheme/minimal``. See the table further down for a full list of pre-defined themes.

All themes come with individual style variations that lets you to tweak certain parts of the theme. This makes it easy for themes to define which parts that are customizable, to constrain variations.


### How to create a custom theme

You can create completely custom themes, like this one that only changes the color of the primary button:

```swift
extension KeyboardTheme {

    static var customTheme: Self {
        get throws {
            try? Self(primaryBackgroundColor: .green)
        }
    }
}
```

You use other themes as base when creating custom themes, for instance:

```swift
extension KeyboardTheme {

    static var anotherTheme: Self {
        get throws {
            var theme = try? KeyboardTheme.standard
            theme.buttonStyles[.primary]?.backgroundColor = .green
            return theme
        }
    }
}
```

You can also create custom themes that just tweak the style variation of another theme:

```swift
extension KeyboardTheme {

    static var standardBlack: Self {
        .standard(.init(tint: .black))
    }
}
```

All these combinations make the theme engine very flexible and powerful.



## How to apply themes

You can apply any theme by applying a ``ThemeBasedKeyboardStyleProvider`` or the ``KeyboardStyleProvider/themed(with:context:)`` shorthand:

```swift
override func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()

    // Setup KeyboardKit Pro with a license
    setupPro(withLicenseKey: "...") { license in
        keyboardStyleProvider = .themed(.cottonCandy, context: keyboardContext)
    } view: { controller in
        // Return your keyboard view here
    }
}
```

You can inherit ``ThemeBasedKeyboardStyleProvider`` to customize this theme-based provider even further, which lets you mix the benefits of themes and styles in even more ways. 


### Pre-defined themes

You can access all pre-defined themes with `KeyboardTheme.{ID}`, e.g. **KeyboardKit.standard** or **KeyboardKit.minimal(.pink)**. 

Here is a list of all pre-defined themes with some style variations:

@TabNavigator {
    @Tab(".standard"){
        @Row {
            @Column {
                ![standard](standard.jpg)
            }
            @Column {
                ![blue](standard-blue.jpg)
            }
            @Column {
                ![green](standard-green.jpg)
            }   
        }
    }
    @Tab(".swifty") {
        @Row {
            @Column {
                ![standard](swifty.jpg)
            }
            @Column {
                ![blue](swifty-blue.jpg)
            }
            @Column {
                ![green](swifty-green.jpg)
            }   
        }
    }
    @Tab(".minimal") {
        @Row {
            @Column {
                ![standard](minimal.jpg)
            }
            @Column {
                ![blue](minimal-blue.jpg)
            }
            @Column {
                ![subset](minimal-sunset.jpg)
            }   
        }
    }
    @Tab(".candyShop") {
        @Row {
            @Column {
                ![standard](candyshop.jpg)
            }
            @Column {
                ![cuppycake](candyshop-cuppycake.jpg)
            }
            @Column {
            }   
        }
    }
    @Tab(".colorful") {
        @Row {
            @Column {
                ![blue](colorful-blue.jpg)
            }
            @Column {
                ![green](colorful-green.jpg)
            }   
            @Column {
                ![standard](colorful-orange.jpg)
            }
        }
    }
    @Tab(".neon") {
        @Row {
            @Column {
                ![standard](neon.jpg)
            }
            @Column {
            }
            @Column {
            }   
        }
    }
    @Tab(".tron") {
        @Row {
            @Column {
                ![blue](tron.jpg)
            }
            @Column {
                ![fcon](tron-fcon.jpg)
            }   
            @Column {
                ![virus](tron-virus.jpg)
            }   
        }
    }
}

You can get a list of all pre-defined themes, as well as all pre-defined style variations, using the static ``KeyboardTheme/allPredefined`` properties.


### Views

KeyboardKit Pro provides some theme-based views:

@TabNavigator {
    @Tab("Theme.Shelf"){
        @Row {
            @Column {
                A theme ``KeyboardTheme/Shelf`` renders theme collections in horizontally scrolling shelves.
                
                You can use a ``KeyboardTheme/ShelfItem`` as item view to show how a ``Keyboard/Button`` will look, or use completely custom views for titles and items.
            }
            @Column {
                ![ThemeShelf](themeshelf.jpg)
            }   
        }
    }
}
