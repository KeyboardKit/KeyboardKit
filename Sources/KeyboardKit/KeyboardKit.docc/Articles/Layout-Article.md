# Layout

This article describes the KeyboardKit layout engine.

A flexible keyboard layout is at the heart of a software keyboard, with many considerations like device models, screen orientation, locale, keyboard-specific considerations, etc.

In KeyboardKit, an ``InputSet`` is important parts of a ``KeyboardLayout``, where the input set specifies the input keys and the layout specifies the full layout configuration.

KeyboardKit has a ``KeyboardLayoutProvider`` protocol that describes how to provide the keyboard with dynamic layouts, as well as a base classes that provide standard layouts.   

👑 [KeyboardKit Pro][Pro] unlocks localized providers for all locales, and more input sets, like `qwertz` and `azerty`. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard. It makes it possible to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``.



## Keyboard layouts

A ``KeyboardLayout`` specifies the full set of keys of a keyboard. Layouts can vary greatly for different device types, screen orientations, locales, etc.

For instance, iOS keyboards often have 3 input rows, where the input keys are surrounded by actions, as well as a bottom row with a space key and action buttons on both sides.

![System Keyboard - English](systemkeyboard-english-350.jpg)

This is however not always true. Most layouts are very different on iPhone and iPad. Some, like Armenian, have 4 input rows, some remove some side-buttons, etc. 

For instance, here's an iPad Pro layout, where many buttons look and behave very different:

![System Keyboard - iPad Pro](systemkeyboard-ipadpro.jpg)

Since the layout differences can be significant, the layout engine has to be flexible. KeyboardKit therefore has a ``KeyboardLayoutProvider`` concept to generate layouts at runtime. 



## Keyboard layout providers

In KeyboardKit, a ``KeyboardLayoutProvider`` can create a layout based on many different factors, such as locale, device, screen orientation, etc.

KeyboardKit will inject a ``StandardKeyboardLayoutProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time, and inject localized providers into it.



## How to create a custom provider

You can create a custom layout provider to customize the layout for certain locales or devices, or to provide a completely custom layout.

You can implement ``KeyboardLayoutProvider`` from scratch, or inherit and customize ``StandardKeyboardLayoutProvider``, ``BaseKeyboardLayoutProvider``, ``iPadKeyboardLayoutProvider``, or ``iPhoneKeyboardLayoutProvider``, depending on the baseline you want to customize. 

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
        services.layoutProvider = CustomKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardLayoutProvider`` for every locale in your license, and automatically injects them into the ``StandardKeyboardLayoutProvider``.

KeyboardKit Pro also unlocks more input sets, like **qwertz** and **azerty**, which are used by some locales, as well as an **iPadProKeyboardLayoutProvider** that provides iPad Pro-specific layouts.

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

This is useful for the cases when you want to make modifications to a single locale, but keep all other locales unaffected.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
