# Layout

This article describes the KeyboardKit layout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

A flexible keyboard layout is an important part of a software keyboard, with many considerations like device models, screen orientation, locale, keyboard-specific considerations, etc.

In KeyboardKit, an ``InputSet`` is used to create a ``KeyboardLayout``, where the input set specifies input keys and the layout specifies the full keyboard layout.

KeyboardKit has a ``KeyboardLayoutProvider`` protocol that is implemented by classes that can provide the keyboard with dynamic layouts, as well as a base classes that provide standard layouts.   

👑 [KeyboardKit Pro][Pro] unlocks localized input sets and layout providers for all locales. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard. It makes it easy to define different input keys for the same keyboard layout.

KeyboardKit comes with some pre-defined input sets, like ``InputSet/qwerty``, ``InputSet/numeric(currency:)`` and ``InputSet/symbolic(currencies:)``.



## Keyboard layouts

A ``KeyboardLayout`` specifies the full set of keys om a keyboard. Layouts vary greatly for different device types, screen orientations, locales, keyboard configurations, etc.

For instance, most iOS keyboards have 3 input key rows, where the input keys are surrounded by actions, as well as a bottom row with a space key and contextual action and input keys.

This is however not always true. Most layouts are different on iPhone and iPad, and many locales make changes to the entire layout, not just inputs. For instance, Armenian keyboards use 4 rows, Arabic keyboards remove some action buttons, etc.



## Keyboard layout providers

Given all this, the layout engine has to be flexible. KeyboardKit has a ``KeyboardLayoutProvider`` that generates layouts at runtime, based on many different factors. Layout providers can use any information to tweak any part of a layout at any time.

KeyboardKit injects a ``StandardKeyboardLayoutProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time, and inject localized providers into it.



## How to create a custom provider

You can create a custom layout provider to customize the layout for certain locales or devices, or to provide a completely custom layout.

You can implement ``KeyboardLayoutProvider`` from scratch, or inherit and customize ``StandardKeyboardLayoutProvider``, ``KeyboardLayout/BaseProvider``, ``iPadKeyboardLayoutProvider``, or ``iPhoneKeyboardLayoutProvider``. 

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



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks more input sets, as well as a localized ``KeyboardLayoutProvider`` for every locale in your license, that it automatically injects into the ``StandardKeyboardLayoutProvider``.


### Input Sets

KeyboardKit Pro unlocks more input sets, like ``InputSet/qwertz`` and ``InputSet/azerty``. These are used by some of the localized layouts, but you can use them separately as well.


### iPad Pro layout support

KeyboardKit Pro unlocks an ``iPadProKeyboardLayoutProvider`` that can be used to generate iPad Pro-specific layouts. It is used by some locales, and will be added to more locales over time. 


### Localized layout providers

KeyboardKit Pro unlocks a localized ``KeyboardLayoutProvider`` for every locale in your license. You can access all providers in your license, or any specific one, like this:

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
