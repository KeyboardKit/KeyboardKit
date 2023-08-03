# Layout

This article describes the KeyboardKit layout engine. 

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating a ``SystemKeyboard``, where the ``InputSet`` defines the input keys of a keyboard, while a ``KeyboardLayout`` defines the full set of keys, as well as their sizes and properties. 

This means that you can use many different input sets with a single keyboard layout. 

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Input Sets

In KeyboardKit, there are three different ``InputSet`` implementations: ``AlphabeticInputSet``, ``NumericInputSet`` and ``SymbolicInputSet``.

> Note: These types will be merged into a single `InputSet` struct in KeyboardKit 8.0.

KeyboardKit provides you with a few localized input sets, such as ``AlphabeticInputSet/english``, ``NumericInputSet/englishNumeric(currency:)`` and ``SymbolicInputSet/englishSymbolic(currency:)``, which are used to create English keyboards. 



## Keyboard layouts

A typical ``SystemKeyboard`` layout has several rows, where the top 3 generally consist of input keys surrounded by action keys on one, both or no sides. Furthermore, the bottom row has a space key that is surrounded by other action keys. 

This is however not true for all locales, where some (like Armenian) have 4 input rows, some (like Arabic) may remove the shift key, etc. The difference between some languages are actually way larger than one may think at first.

A localized keyboard layout is typically implemented with locale-specific ``InputSet`` values for the alphabetic, numeric and symbolic keyboards, and a locale-specific ``KeyboardLayoutProvider`` that uses the input sets to provide iPhone and iPad-specific layouts. 



## Keyboard layout providers

In KeyboardKit, a ``KeyboardLayoutProvider`` can be used to create a dynamic layout based on many different factors, such as the current device type, orientation, locale, etc. 

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to the input controller's ``KeyboardInputViewController/keyboardLayoutProvider``. It will by default use an ``EnglishKeyboardLayoutProvider`` to return U.S. English keyboard layouts, for both iPad and iPhone.

You can replace this provider with a custom one, or inject locale-specific providers to customize the layout for a certain locale.


### How to customize the standard layout provider

If you want to make minor customizations to the ``StandardKeyboardLayoutProvider``, there are a couple of options:

* Add more localized providers to the ``StandardKeyboardLayoutProvider`` instance. 
* Subclass ``StandardKeyboardLayoutProvider`` and override ``StandardKeyboardLayoutProvider/keyboardLayout(for:)``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPadProvider``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPhoneProvider``.

You can also create a completely custom keyboard layout provider, see below.


### How to create a custom layout provider

You can create a custom ``KeyboardLayoutProvider`` by either inheriting the ``StandardKeyboardLayoutProvider`` base class and customize the parts you want, or implementing the ``KeyboardLayoutProvider`` protocol from scratch.

For instance, here's a custom provider that inherits ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

```swift
class CustomKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.itemRows
        var row = layout.itemRows[0]
        let next = row[0]
        let size = KeyboardLayoutItemSize(width: .available, height: next.size.height)
        let tab = KeyboardLayoutItem(action: .tab, size: size, insets: next.insets)
        row.insert(tab, at: 0)
        rows[0] = row
        layout.itemRows = rows
        return layout
    }
}
```

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardLayoutProvider`` to your custom provider, like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardLayoutProvider = CustomKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional input set variations like `.azerty` and `.qwertz`, as well as localized input sets and keyboard layout providers for all keyboard locales.

You can access the locale-specific input sets like this:

```swift
let swedish = try? InputSet.swedish
let numeric = try? InputSet.swedishNumeric
let symbolic = try? InputSet.swedishSymbolic
```

and the locale-specific layout providers like this:

```swift
let provider = try? ProKeyboardLayoutProvider.Swedish()
```

You can also access all providers that your license unlocks like this:

```swift
let providers = license.localizedKeyboardLayoutProviders
```

Note that the input sets and layout providers are throwing, and will only return a value if you have registered a license key.

If you want to use a custom provider with KeyboardKit Pro, make sure to register it *after* registering your license key, otherwise it will be overwritten by the license registration process.

For instance, this is how you would register the custom provider that we created earlier, using the localized providers that the license unlocks:

```swift
open func setupKeyboardKit() {
    try? setupPro(withLicenseKey: key, view: keyboardView) { license in
        self.setupCustomServices(with: license)
    }
}

func setupCustomServices(with license: License) {
    keyboardLayoutProvider = CustomKeyboardLayoutProvider(
        keyboardContext: keyboardContext,
        localizedProviders: license.localizedKeyboardLayoutProviders
    )
}
```

You can add a custom initializer to your custom provider if you need additional setup, then just call `super.init` to setup the rest.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
