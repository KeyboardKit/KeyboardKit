# Layouts

This article describes the KeyboardKit keyboard layout engine and how to use it. 

In KeyboardKit, ``InputSet``s and ``KeyboardLayout``s are central concepts when creating a ``SystemKeyboard``. You can also use them to create custom keyboards, although you don't have to.

An ``InputSet`` defines the input keys on a keyboard, while a ``KeyboardLayout`` defines the full set of actions on a keyboard, as well as their heights, sizes etc. This means that you can use many different input sets with a single keyboard layout. 

A typical system keyboard layout has several rows, where center input buttons are surrounded by action buttons on one or both sides.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Keyboard layout providers

KeyboardKit provides you with a foundation for generating flexible and dynamic keyboard layouts. The most flexible way to generate a keyboard layout is with a ``KeyboardLayoutProvider``. 

KeyboardKit will by default create a ``StandardKeyboardLayoutProvider`` and apply it to the input controller's ``KeyboardInputViewController/keyboardLayoutProvider``. You can replace it with a custom provider to customize the standard layout.

KeyboardKit also has an ``EnglishKeyboardLayoutProvider`` that defines the layout of a U.S. English keyboard. This provider is used by the standard provider, which supports injecting multiple locale-specific providers.



## How to customize the standard provider

If you want to make minor customizations to the ``StandardKeyboardLayoutProvider``, there are a couple of options:

* Add more localized providers to the ``StandardKeyboardLayoutProvider`` instance. 
* Subclass ``StandardKeyboardLayoutProvider`` and override ``StandardKeyboardLayoutProvider/keyboardLayout(for:)``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPadProvider``.
* Create a new ``StandardKeyboardLayoutProvider`` instance and inject a custom ``StandardKeyboardLayoutProvider/iPhoneProvider``.

You can also create a completely custom keyboard layout provider, see below.



## How to create a custom layout provider

You can create a custom keyboard layout provider by either inheriting and customizing the ``StandardKeyboardLayoutProvider`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardLayoutProvider`` from scratch.

For instance, here's a custom provider that extends ``StandardKeyboardLayoutProvider`` and injects a tab key to the top-leading part of the keyboard:

```swift
class MyKeyboardLayoutProvider: StandardKeyboardLayoutProvider {
    
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
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardLayoutProvider = MyKeyboardLayoutProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional keyboard layouts and keyboard layout providers for all keyboard locales.

This lets you create a fully localized ``SystemKeyboard`` for all available locales with a single line of code.

You can also access the underlying, locale-specific providers like this:

```swift
let provider = ProKeyboardLayoutProvider.Swedish()
```

You can access all providers that your license unlocks like this:

```swift
let providers = license.localizedKeyboardLayoutProviders
```

If you want to use a custom provider with KeyboardKit Pro, make sure to register your custom instance *after* registering your license key, otherwise it will be overwritten by the license registration process.

You can still inherit `StandardKeyboardLayoutProvider` with KeyboardKit Pro to get the standard behavior, combined with the additional functionality that your Pro license unlocks:

```swift
class CustomKeyboardLayoutProvider: StandardKeyboardLayoutProvider {

    override func keyboardLayout(for context: KeyboardContext) -> KeyboardLayout {
        let baseLayout = super.keyboardLayout(for: context)
        let customLayout = // Your custom logic here
        return customLayout
    }
}
```

You can then create a custom provider instance with your license, like this:

```swift
open func setupKeyboardKit() {
    try? setupPro(withLicenseKey: key, view: keyboardView) { license in
        self.setupCustomServices(with: license)
    }
}

func setupCustomServices(with license: License) {
    keyboardLayoutProvider = CustomKeyboardLayoutProvider(
        keyboardContext: keyboardContext,
        inputSetProvider: inputSetProvider,
        localizedProviders: license.localizedKeyboardLayoutProviders
    )
}
```

You can of course add a custom initializer to your custom provider if you need additional things in it, then just call `super.init` to setup the rest.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
