# Layout

This article describes the KeyboardKit layout engine.

A flexible keyboard layout is at the heart of a software keyboard, with many considerations like device models, screen orientation, locale, etc.

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are important parts of creating a layout, where the input set specifies the input keys and the layout specifies the full layout configuration.

[KeyboardKit Pro][Pro] unlocks input sets and localized layout providers for all ``KeyboardLocale``s. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard.

KeyboardKit has some input sets, like ``InputSet/qwerty``, ``InputSet/standardNumeric(currency:)`` and ``InputSet/standardSymbolic(currencies:)``. You can also create your own custom input sets.



## Keyboard layouts

A ``KeyboardLayout`` specifies the full set of keys of a keyboard. 

Keyboard layouts can vary greatly for different device types, screen orientations, locales, etc.

For instance, iOS keyboards often have 3 input rows, where the input keys are surrounded by actions, as well as a bottom row with a space key and action buttons on both sides.

This is however not always true. Most layouts are very different on iPhone and iPad. Some, like Armenian, have 4 input rows. Greek keyboards remove many side-buttons. And so on.

Since the layout differences can be significant, the layout engine has to be flexible. KeyboardKit therefore uses a dynamic ``KeyboardLayoutProvider`` to resolve layouts at runtime. 



## Keyboard layout providers

In KeyboardKit, a ``KeyboardLayoutProvider`` can create a dynamic layout based on many different factors, such as the current locale, device, screen orientation, etc.

KeyboardKit injects a ``StandardKeyboardLayoutProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time.

The standard layout uses a QWERTY layout by default, but you can inject localized providers into it, modify it, or even replace it, as you see fit.

You can add and replace localized providers to the default ``StandardKeyboardLayoutProvider``, or replace the ``KeyboardInputViewController/services`` provider with a custom ``KeyboardLayoutProvider``.



## How to create a custom provider

You can create a custom layout provider to customize the layout for certain locales, certain devices, or to provide a completely custom layout.

You can either inherit ``StandardKeyboardLayoutProvider`` and customize what you want, or implement the ``KeyboardLayoutProvider`` protocol from scratch.

For instance, here's a custom provider that inherits ``StandardKeyboardLayoutProvider`` and injects a tab key into the layout:

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

To use this provider instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
services.keyboardLayoutProvider = CustomKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.

There are also other base classes, such as ``BaseKeyboardLayoutProvider``, ``InputSetBasedKeyboardLayoutProvider``, ``iPadKeyboardLayoutProvider`` and ``iPhoneKeyboardLayoutProvider``.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a ``KeyboardLayoutProvider`` for every locale in your license, and automatically injects them into the ``StandardKeyboardLayoutProvider``.


### How to access your localized providers

You can access all localized providers in your license, or any specific provider, like this:

```swift
let providers = License.current.localizedKeyboardLayoutProviders
let provider = try ProKeyboardLayoutProvider.Swedish()
```

> Important: These providers will throw a license error if their locale is not included in the license.


### How to customize a localized provider

You can inherit and customize any localized provider, then manually register your provider *after* registering your license key:

```swift
class CustomProvider: ProKeyboardLayoutProvider.Swedish {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let provider = keyboardLayoutProvider(for: context)
        var layout = provider.keyboardLayout(for: context)
        guard let item = layout.tryCreateBottomRowItem(
            for: .character("🇸🇪")
        ) else { return layout }
        layout.itemRows.insert(item, after: .space, atRow: layout.bottomRowIndex)
        return layout
    }
}

class KeyboardController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        setupPro(withLicenseKey: "...") { license in
            setupCustomProvider()
        } view: { controller in
            // Return your keyboard view here
        }
    }

    func setupCustomProvider() {
        do {
            let provider = try CustomProvider()
            let standard = services.layoutProvider as? StandardKeyboardLayoutProvider
            standard?.registerLocalizedProvider(provider)
        } catch {
            print(error)
        }
    }
}
```

Note that the provider cast will fail if you replace the instance with your own type.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
