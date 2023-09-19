# Callouts

This article describes the KeyboardKit callout engine.

In KeyboardKit, input and action callouts are important parts of the typing experience.

Input callouts highlight the currently pressed key while action callouts present secondary keyboard actions.

[KeyboardKit Pro][Pro] features are described at the end of this document.



## Input callouts

An ``InputCallout`` shows the currently pressed key in a large callout bubble. 

To bind an input callout to a custom view, apply an `.inputCallout(...)` modifier to the view, then update the callout context with the character you want to show.

This is automatically enabled if you use a ``SystemKeyboard``.



## Action callouts

An ``ActionCallout`` shows secondary actions in a callout bubble when long pressing a key.

To bind an action callout to a custom view, apply an `.actionCallout(...)` modifier to the view, then update the callout context with the actions you want to show.

This is automatically enabled if you use a ``SystemKeyboard``.



## Callout action providers

A ``CalloutActionProvider`` can be used to provide actions to an ``ActionCallout``.

KeyboardKit will by default create a ``StandardCalloutActionProvider`` and bind it to the input controller's ``KeyboardInputViewController/calloutActionProvider``. 

You can replace this provider with a custom one, or inject locale-specific providers to customize the layout for a certain locale.


### How to customize the standard provider

To customize the ``StandardCalloutActionProvider``, you can:

* Add more localized providers to a ``StandardCalloutActionProvider`` instance. 
* Inherit ``StandardCalloutActionProvider`` and override its various functions.

You can also create a completely custom ``CalloutActionProvider`` implementation.


### How to create a custom provider

You can create a custom ``CalloutActionProvider`` by inheriting ``StandardCalloutActionProvider`` and customize the parts you want, or implement the ``CalloutActionProvider`` protocol from scratch.

For instance, here's a custom provider that inherits ``StandardCalloutActionProvider`` and customizes the secondary actions for the `$` key:

```swift
class CustomCalloutActionProvider: StandardCalloutActionProvider {
    
    // This function is the most convenient to override
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "$": return "$₽¥€¢£₩"
        default: return super.calloutActionString(for: char)
        }
    }
}
```

To use this provider instead of the standard one, just set the input controller's ``KeyboardInputViewController/calloutActionProvider`` to your custom provider, like this:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        calloutActionProvider = CustomCalloutActionProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks localized callout action providers for all ``KeyboardLocale``s  in your license and automatically injects them into the ``StandardCalloutActionProvider``.

You can access the locale-specific callout action providers like this:

```swift
let provider = try ProCalloutActionProvider.Swedish()
```

and access all providers that your license unlocks like this:

```swift
let providers = license.localizedCalloutActionProviders
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
    calloutActionProvider = CustomCalloutActionProvider(
        keyboardContext: keyboardContext,
        localizedProviders: license.localizedCalloutActionProviders
    )
}
```

You can add a custom initializer to your custom provider if you need additional setup, then just call `super.init` to setup the rest. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
