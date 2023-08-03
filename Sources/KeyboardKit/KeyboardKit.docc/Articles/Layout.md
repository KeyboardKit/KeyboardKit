# Layouts

This article describes the KeyboardKit keyboard layout engine and how to use it. 

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating a ``SystemKeyboard`` and to work with custom layouts in general.

The difference between an input set and a layout, is that an input set defines the input keys on a keyboard, while a keyboard layout defines the full set of keys on a keyboard, as well as their size. This means that you can use many different input sets with a single keyboard layout. 

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Localized layouts

A typical ``SystemKeyboard`` layout has several rows, where the top 3 rows generally consists of input keys surrounded by action keys on one or both sides, and the bottom row has a space key that is surrounded by other action keys. 

This is however not true for all locales, where some (like Armenian) have 4 input rows, some (like Arabic) may remove the shift key, etc.

Regardless of the locale-specifics, a localized keyboard layout is typically implemented with locale-specific ``InputSet`` values for the alphabetic, numeric and symbolic keyboards, and a locale-specific ``KeyboardLayoutProvider`` that uses these input sets to provide iPhone and iPad-specific layouts. 

[KeyboardKit Pro][Pro] provides localized input sets and layouts for all supported keyboard locales.



## Layout providers

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to the input controller's ``KeyboardInputViewController/keyboardLayoutProvider``. You can replace this provider with a custom one, or inject locale-specific providers to customize the layout for a certain locale. 

KeyboardKit will by default inject an ``EnglishKeyboardLayoutProvider`` into the standard layout provider. This provider defines the layout of a U.S. English keyboard, for both iPad and iPhone.


### How to customize the standard layout provider

If you want to make minor customizations to the ``StandardKeyboardLayoutProvider``, there are a couple of options:

* Add more localized providers to the ``StandardKeyboardLayoutProvider`` instance. 
* Subclass ``StandardKeyboardLayoutProvider`` and override ``StandardKeyboardLayoutProvider/keyboardLayout(for:)``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPadProvider``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPhoneProvider``.

You can also create a completely custom keyboard layout provider, see below.


### How to create a custom layout provider

You can create a custom keyboard layout provider by either inheriting and customizing the ``StandardKeyboardLayoutProvider`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardLayoutProvider`` from scratch.

For instance, here's a custom provider that extends ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

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

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardLayoutProvider = CustomKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional keyboard layouts providers for all keyboard locales.

You can access the underlying, locale-specific keyboard layout providers like this:

```swift
let provider = ProKeyboardLayoutProvider.Swedish()
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
