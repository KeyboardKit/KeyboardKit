# Callouts

This article describes the KeyboardKit callout engine and how to use it.

In KeyboardKit, input callouts and action callouts are important parts of the typing experience. Input callouts highlight the key that is being pressed, while action callouts show secondary actions when a key is long pressed.

[KeyboardKit Pro][Pro] specific features are described at the end of this document.



## Action callouts

An ``ActionCallout`` shows alternate actions in a callout bubble for a long pressed key. It can be presented by providing an ``ActionCalloutContext`` with the actions to display. This is automatically enabled if you use a ``SystemKeyboard``.

You can specify which actions to show for a certain ``KeyboardAction`` by using a ``CalloutActionProvider``. 

KeyboardKit will by default create a ``StandardCalloutActionProvider`` and apply it to the input controller's ``KeyboardInputViewController/calloutActionProvider``. You can replace it with a custom provide to customize the callouts.



## Input callouts

An ``InputCallout`` shows the currently pressed key in a large callout bubble. It can be presented by providing an ``InputCalloutContext`` with the actions to display. This is automatically enabled if you use a ``SystemKeyboard``.



## Callout action providers

KeyboardKit will by default create a ``StandardCalloutActionProvider`` and apply it to the input controller's ``KeyboardInputViewController/calloutActionProvider``. You can replace this provider with a custom one, or inject locale-specific providers to customize the layout for a certain locale.

KeyboardKit will by default inject an ``EnglishCalloutActionProvider`` into the standard provider. This provider defines the standard callout actions of a U.S. English keyboard.


### How to customize the standard action provider

If you want to make minor customizations to the ``StandardCalloutActionProvider``, there are a couple of options:

* Add more localized providers to the ``StandardCalloutActionProvider`` instance. 
* Subclass ``StandardCalloutActionProvider`` and override its various functions.

You can also create a completely custom callout action provider, see below.


### How to create a custom action provider

You can create a custom ``CalloutActionProvider`` by either inheriting the ``StandardCalloutActionProvider`` base class and customize the parts you want, or implement the ``CalloutActionProvider`` protocol from scratch.

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



## How to bind callouts to views

The ``SystemKeyboard`` view automatically sets up input and action callouts, but custom views require you to manually apply these callouts.  

To bind an input callout to a custom view, do this:

* Add `.inputCallout(context:keyboardContext:style:)` to the keyboard view.
* Update the ``InputCalloutContext`` with the character you want to show. 

To bind an action callout to a custom view, do this:

* Add `.actionCallout(context:style:)` to the keyboard view.
* Update the ``ActionCalloutContext`` with the actions you want to show.

Have a look at ``SystemKeyboard`` and the demo apps for examples on how this can be done.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks additional callout actions for all keyboard locales.

You can access the underlying, locale-specific callout action providers like this:

```swift
let provider = ProCalloutActionProvider.Swedish()
```

You can access all providers that your license unlocks like this:

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
