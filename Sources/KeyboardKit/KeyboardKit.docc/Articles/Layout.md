# Layout

This article describes the KeyboardKit layout engine. 

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are important concepts, where input sets describe the input keys of a keyboard and layouts describe the full set of keys. 

[KeyboardKit Pro][Pro] features are described at the end of this document.



## Input Sets

An ``InputSet`` set describes the input keys of a keyboard.

KeyboardKit has some standard input sets, like ``InputSet/qwerty`` and a few localized input sets, such as ``InputSet/english``, ``InputSet/englishNumeric(currency:)`` and ``InputSet/englishSymbolic(currency:)``. You can also create your own custom input sets.

> Note: These types will be merged into a single `InputSet` struct in KeyboardKit 8.0. 



## Keyboard layouts

A ``KeyboardLayout`` describes the full set of keys of a keyboard. Layouts can vary greatly for different device types, locales, screen orientations, etc. 

For instance, iOS keyboards often have 3 input rows, where the input keys are surrounded by actions on either side, as well as a bottom row with a space key and action buttons. 

This is however not true for all locales. For instance, Armenian has 4 input rows, Arabic removes the shift key, etc. The difference between different locales can be very large. 



## Keyboard layout providers

In KeyboardKit, a ``KeyboardLayoutProvider`` can be used to create a dynamic layout based on many different factors, such as the current device type, orientation, locale, etc. 

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and bind it to the input controller's ``KeyboardInputViewController/keyboardLayoutProvider``. 

You can replace this provider with a custom one, or inject locale-specific providers to customize the layout for a certain locale.


### How to customize the standard provider

To customize the ``StandardKeyboardLayoutProvider``, you can:

* Add more localized providers to a ``StandardKeyboardLayoutProvider`` instance. 
* Inherit ``StandardKeyboardLayoutProvider`` and override its various functions.

You can also create a completely custom ``KeyboardLayoutProvider`` implementation.


### How to create a custom provider

You can create a custom ``KeyboardLayoutProvider`` by inheriting ``StandardKeyboardLayoutProvider`` and customize the parts you want, or implement the ``KeyboardLayoutProvider`` protocol from scratch.

For instance, here's a custom provider that inherits ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

```swift
class CustomKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let layout = super.keyboardLayout(for: context)
        var rows = layout.itemRows
        var row = layout.itemRows[0]
        let next = row[0]
        let size = KeyboardLayout.ItemSize(width: .available, height: next.size.height)
        let tab = KeyboardLayout.Item(action: .tab, size: size, insets: next.insets)
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

[KeyboardKit Pro][Pro] unlocks additional input sets like `.azerty` and `.qwertz`. It also unlocks localized input sets and keyboard layout providers for all ``KeyboardLocale``s  in your license and automatically injects them into the ``StandardKeyboardLayoutProvider``.

You can access the locale-specific input sets and layout providers like this:

```swift
let swedish = try InputSet.swedish
let numeric = try InputSet.swedishNumeric
let symbolic = try InputSet.swedishSymbolic
let provider = try ProKeyboardLayoutProvider.Swedish()
```

You can access all providers that your license unlocks like this:

```swift
let providers = license.localizedKeyboardLayoutProviders
```

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
