# Callouts

This article describes the KeyboardKit callout engine and how to use it.

In KeyboardKit, input callouts and action callouts are important parts of the typing experience. While input callouts highlight the key that is being pressed, action callouts can be used to show secondary actions when a key is long pressed.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Action callouts

An ``ActionCallout`` shows alternate actions in a callout bubble for a long pressed key. It can be presented by providing an ``ActionCalloutContext`` with the actions to display. This is automatically enabled if you use a ``SystemKeyboard``.

You can specify which actions to show for a certain ``KeyboardAction`` by using a ``CalloutActionProvider``. 

KeyboardKit will by default create a ``StandardCalloutActionProvider`` and apply it to the input controller's ``KeyboardInputViewController/calloutActionProvider``. You can replace it with a custom provide to customize the callouts.



## Input callouts

An ``InputCallout`` shows the currently pressed key in a large callout bubble. It can be presented by providing an ``InputCalloutContext`` with the actions to display. This is automatically enabled if you use a ``SystemKeyboard``.



## How to customize the standard callout action provider

If you want to make minor customizations to the ``StandardCalloutActionProvider``, there are a couple of options:

* Add more localized providers to the ``StandardCalloutActionProvider`` instance. 
* Subclass ``StandardCalloutActionProvider`` and override its various functions.

You can also create a completely custom callout action provider, see below.



## How to create a custom callout action provider

You can create a custom callout action provider by either inheriting and customizing the ``StandardCalloutActionProvider`` base class, which gives you a lot of functionality for free, or by implementing ``CalloutActionProvider`` from scratch.

For instance, here's a custom provider that inherits ``StandardCalloutActionProvider`` and customizes the $ key callout actions:

```swift
class MyCalloutActionProvider: StandardCalloutActionProvider {
    
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "$": return "$₽¥€¢£₩"
        default: return super.calloutActionString(for: char)
        }
    }
}
```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        calloutActionProvider = MyCalloutActionProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.



## How to bind callouts to views

To bind an input callout to a custom view, follow these steps:

* Add `.inputCallout(context:keyboardContext:style:)` to the keyboard view (see ``SystemKeyboard``).
* Update the ``InputCalloutContext`` with the character you want to show (see the internal `KeyboardGestures`). 

To bind an action callout to a custom view, follow these steps:

* Add `.actionCallout(context:style:)` to the keyboard view (see ``SystemKeyboard``).
* Update the ``ActionCalloutContext`` with the actions you want to show (see the internal `KeyboardGestures`).

Have a look at ``SystemKeyboard`` and the demo apps for examples on how this can be done.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional callout actions for all keyboard locales it supports. 

This lets you create a fully localized ``SystemKeyboard`` for all available locales with a single line of code.

You can also access the underlying, locale-specific providers like this:

```swift
let provider = ProCalloutActionProvider.Swedish()
```

You can access all providers that your license unlocks like this:

```swift
let providers = license.localizedCalloutActionProviders
```

If you want to use a custom provider with KeyboardKit Pro, make sure to register your custom instance *after* registering your license key, otherwise it will be overwritten by the license registration process.

You can still inherit `StandardCalloutActionProvider` with KeyboardKit Pro to get the standard behavior, combined with the additional functionality that your Pro license unlocks:

```swift
class CustomCalloutActionProvider: StandardCalloutActionProvider {

    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        let baseActions = super.calloutActions(for: action)
        let customActions = // Your custom logic here
        return customActions
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
    calloutActionProvider = CustomCalloutActionProvider(
        keyboardContext: keyboardContext,
        inputSetProvider: inputSetProvider,
        localizedProviders: license.localizedCalloutActionProviders
    )
}
```

You can of course add a custom initializer to your custom provider if you need additional things in it, then just call `super.init` to setup the rest. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
