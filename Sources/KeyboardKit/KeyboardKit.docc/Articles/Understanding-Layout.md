# Understanding Layout

This article describes the KeyboardKit layout engine.

A flexible keyboard layout is an important part of a software keyboard engine, where many factors like device, screen orientation, locale, etc. can all affect the layout.

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are important concepts to create a flexible keyboard layout, where the input set specifies the input keys of the keyboard and the keyboard layout specifies the full set of keys.

KeyboardKit will bind a ``StandardKeyboardLayoutProvider`` to ``KeyboardInputViewController/keyboardLayoutProvider`` when the keyboard is loaded. It has a QWERTY layout by default, but you can add localized providers to it or replace it with a custom implementation at any time.

[KeyboardKit Pro][Pro] unlocks additional input sets, and registers localized input sets and layout providers for all keyboard locales when you register a valid license key. Information about Pro features can be found at the end of this article.



## Input Sets

An ``InputSet`` set specifies the input keys of a keyboard.

KeyboardKit has some input sets, like ``InputSet/qwerty``, ``InputSet/standardNumeric(currency:)`` and ``InputSet/standardSymbolic(currencies:)``. You can also create your own custom input sets.



## Keyboard layouts

A ``KeyboardLayout`` specifies the full set of keys of a keyboard. 

Keyboard layouts can vary greatly for different device types, screen orientations, locales, etc. For instance, iOS keyboards often have 3 input rows, where the input keys are surrounded by actions on either side, as well as a bottom row with a space key and action buttons. 

This is however not true for all locales. For instance, Armenian has 4 input rows, Greek removes many side-buttons, Arabic removes the shift key, etc. These differences can be significat, so the layout engine has to be flexible. 



## Hot to custome the keyboard layout

In KeyboardKit, a ``KeyboardLayoutProvider`` can be used to create a dynamic layout based on many different factors, such as the current device type, orientation, locale, etc. 

You can customize the keyboard layout by adding localized providers to the default ``StandardKeyboardLayoutProvider``, or by replacing ``KeyboardInputViewController/keyboardLayoutProvider`` with a custom ``KeyboardLayoutProvider``.



## How to create a custom callout action provider

You can create a custom ``KeyboardLayoutProvider`` by either inheriting the ``StandardKeyboardLayoutProvider`` base class and customize the parts you want, or implement the ``KeyboardLayoutProvider`` protocol from scratch.

There are also several base classes make it easy to implement custom layouts. 

For instance ``BaseKeyboardLayoutProvider`` provides base functionality, ``InputSetBasedKeyboardLayoutProvider`` lets you use input sets, and ``iPadKeyboardLayoutProvider`` & ``iPhoneKeyboardLayoutProvider`` provides platform baselines. 

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

To use this provider instead of the standard one, just set ``KeyboardInputViewController/keyboardLayoutProvider`` to this custom provider:

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

[KeyboardKit Pro][Pro] unlocks additional ``InputSet``s and localized ``InputSet``s and ``KeyboardLayoutProvider``s for all ``KeyboardLocale``s in your license when you register a valid license key, then injects all providers into ``StandardCalloutActionProvider``.

You can access all locale-specific input sets that your license unlocks like this:

```swift
let swedish = try InputSet.swedish
let numeric = try InputSet.spanishNumeric
let symbolic = try InputSet.germanSymbolic
```

You can access all providers that your license unlocks like this:

```swift
let providers = License.current.localizedKeyboardLayoutProviders
```

and locale-specific providers like this:

```swift
let provider = try ProKeyboardLayoutProvider.Swedish()
```

You can inherit `ProKeyboardLayoutProvider`, or any of the available localized versions, to customize the base behavior:

```swift
class CustomKeyboardLayoutProvider: ProKeyboardLayoutProvider.Swedish {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        var layout = keyboardLayoutProvider(for: context)
            .keyboardLayout(for: context)
        layout.tryInsertFlag(for: context)
        return layout
    }
}

private extension KeyboardLayout {

    func tryInsertFlag() {
        guard let button = tryCreateBottomRowItem(for:  .character("🇸🇪")) else { return }
        itemRows.insert(button, after: .space, atRow: bottomRowIndex)
    }
}
```

To use a custom provider with KeyboardKit Pro, make sure to register it *after* registering your license key, otherwise it will be overwritten by the license registration process.

For instance, this is how you would register the custom provider that we created earlier, using the localized providers that the license unlocks:

```swift
open func setupKeyboardKit() {
    try? setupPro(withLicenseKey: key, view: keyboardView) { license in
        self.setupCustomServices(with: license)
    }
}

func setupCustomServices(with license: License) {
    keyboardLayoutProvider = CustomKeyboardLayoutProvider()
}
```

You can add a custom initializer to your custom provider if you need additional setup, then just call `super.init` to setup the rest.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
