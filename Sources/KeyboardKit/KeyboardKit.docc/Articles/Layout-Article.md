# Layout

This article describes the KeyboardKit layout engine.

A flexible keyboard layout is an important part of a software keyboard, with many considerations like device models, screen orientation, locale, keyboard-specific considerations, etc.

In KeyboardKit, an ``InputSet`` is used to create a ``KeyboardLayout``, where the input set specifies input keys and the layout specifies the full keyboard layout.

KeyboardKit has a ``KeyboardLayoutProvider`` protocol that is implemented by classes that can provide the keyboard with dynamic layouts, as well as a base classes that provide standard layouts.   

👑 [KeyboardKit Pro][Pro] unlocks localized providers for all locales, and more input sets. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard. It makes it easy to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``.



## Keyboard layouts

A ``KeyboardLayout`` specifies the full set of keys om a keyboard. Layouts vary greatly for different device types, screen orientations, locales, keyboard configurations, etc.

For instance, iOS keyboards often have 3 input rows, where input keys are surrounded by actions, as well as a bottom row with a space key and action buttons on both sides.

![System Keyboard - English](systemkeyboard-english-350.jpg)

This is however not always true. Most layouts are different on iPhone and iPad, and many locales make changes to the entire layout, not only the input set. For instance, Armenian keyboards use 4 rows, Arabic keyboards remove some action buttons, etc. 

For instance, here's an iPad Pro layout, where many buttons look and behave very different:

![System Keyboard - iPad Pro](systemkeyboard-ipadpro.jpg)

Given all this, the layout engine has to be flexible. KeyboardKit has a ``KeyboardLayoutProvider`` that generates layouts at runtime. Layout providers can use any information to tweak any part of a layout at any time. 



## Keyboard layout providers

In KeyboardKit, a ``KeyboardLayoutProvider`` can create dynamic layouts, based on many different factors, as described above. It allows you to modify any part of the layout, at any time.

KeyboardKit injects a ``StandardKeyboardLayoutProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time, and inject localized providers into it.



## How to create a custom provider

You can create a custom layout provider to customize the layout for certain locales or devices, or to provide a completely custom layout.

You can implement ``KeyboardLayoutProvider`` from scratch, or inherit and customize ``StandardKeyboardLayoutProvider``, ``BaseKeyboardLayoutProvider``, ``iPadKeyboardLayoutProvider``, or ``iPhoneKeyboardLayoutProvider``, based on the baseline you want to customize. 

For instance, here's a custom provider that inherits ``StandardKeyboardLayoutProvider``, then injects a ``KeyboardAction/tab`` key into the layout:

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

KeyboardKit Pro also unlocks more input sets, like **qwertz** and **azerty**, as well as an **iPadProKeyboardLayoutProvider** that can be used to generate iPad Pro-specific layouts.

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
