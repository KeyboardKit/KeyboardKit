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

A ``KeyboardTheme`` can provide various keyboard styles in a way that can be easily used and modified. A theme can also define a style variation that can be used to create variations of the theme with a constrained set of properties.

KeyboardKit Pro also unlocks a ``KeyboardStyle/ThemeBasedProvider``, which can be used to apply themes with the ``KeyboardStyleProvider`` concept that is used by some views in the library.


## Predefined themes

KeyboardKit comes with pre-defined themes, like ``KeyboardTheme/standard``, ``KeyboardTheme/swifty`` and ``KeyboardTheme/minimal``. See the grid further down for a full list themes.

All themes come with individual style variations that lets you to tweak certain parts of the theme. This makes it easy for themes to define which parts that are customizable, to constrain variations.


### How to create a custom theme

Since a ``KeyboardTheme`` is just a struct, you can easily create custom themes by just defining new static value types. For instance, this theme only changes the color of the primary button:

```swift
extension KeyboardTheme {

    static var greenPrimary: Self {
        get throws {
            try? Self(primaryBackgroundColor: .green)
        }
    }
}
```

You can also use other themes as a foundation when creating your own custom themes. For instance, this theme starts with the minimal theme and changes the color of the primary button to pink:

```swift
extension KeyboardTheme {

    static var pinkPrimary: Self {
        get throws {
            var theme = try? KeyboardTheme.minimal
            theme.buttonStyles[.primary]?.backgroundColor = .green
            return theme
        }
    }
}
```

You can also create custom themes that just tweak the style variation of another theme. For instance, this custom theme is a standard theme what applies a black tint color:

```swift
extension KeyboardTheme {

    static var standardBlack: Self {
        .standard(.init(tint: .black))
    }
}
```

All these combinations make the theme engine very flexible and powerful.



## How to apply themes

You can apply any theme by using the ``KeyboardStyle``'s ``KeyboardStyle/ThemeBasedProvider`` or the ``KeyboardStyleProvider/themed(with:context:)`` shorthand:

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

You can inherit the ``KeyboardStyle/ThemeBasedProvider`` to customize its styles even further, which lets you mix the benefits of themes and styles.


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

[KeyboardKit Pro][Pro] unlocks views in the ``KeyboardTheme`` namespace, that make it easy to preview and present keyboard themes:

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    @Tab("Theme.Shelf"){
        A keyboard theme ``KeyboardTheme/Shelf`` can be used to list theme collections in a vertical list of horizontally scrolling shelves, much like a Netflix list:
        
        @Row {
            @Column {}
            @Column(size:2) { ![ThemeShelf](themeshelf.jpg) }
            @Column {}
        }
        
        You can use the standard ``KeyboardTheme/ShelfItem`` view to show how a ``Keyboard/Button`` will look, or use completely custom views for the titles and items.
    }
}
