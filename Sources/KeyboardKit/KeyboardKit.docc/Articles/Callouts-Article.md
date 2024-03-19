# Callouts

This article describes the KeyboardKit callout engine.

Callouts are an important part of the typing experience, where input callouts show the currently pressed character and action callouts can show secondary actions.

In KeyboardKit, a ``CalloutActionProvider`` can provide actions to a ``CalloutContext``, which in turn will update views like ``Callouts/ActionCallout``.

[KeyboardKit Pro][Pro] unlocks localized action providers for all ``KeyboardLocale``s. Information about Pro features can be found at the end of this article.



## Callout namespace

KeyboardKit has a ``Callouts`` namespace that contains callout-related types.

For instance, ``Callouts/InputCallout`` shows the currently pressed key while ``Callouts/ActionCallout`` shows secondary actions when long pressing a key.

This namespace doesn't contain protocols, open classes, or types that are meant to be top-level.



## Callout context

KeyboardKit has an observable ``CalloutContext`` class that handles input and action callout state, such as the currently pressed key or the callout actions to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates it when keys are pressed.



## Callout action providers

In KeyboardKit, a ``CalloutActionProvider`` can be used to fetch dynamic callout actions.

KeyboardKit injects a ``StandardCalloutActionProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time.

You can add and replace localized providers to the ``StandardCalloutActionProvider``, or replace the ``KeyboardInputViewController/services`` provider with a custom ``CalloutActionProvider``.



## How to show input and action callouts

You can apply callout-specific view extensions in KeyboardKit, to make any view act as the container of input and action callouts. 

For instance, this will make your custom keyboard view show both input and action callouts:

```swift
MyKeyboard()
    .keyboardCalloutContainer(...)
```

This will bind a ``CalloutContext`` to the view, then apply ``Callouts/ActionCallout`` and ``Callouts/InputCallout`` views that show as this context changes. 

The ``SystemKeyboard`` and ``KeyboardButton/Button`` will automatically apply the proper extensions and update the context as you interact with the keyboard.



## How to create a custom callout action provider

You can create a custom callout action provider to customize the callout actions to present for a certain ``KeyboardAction``.

You can implement ``CalloutActionProvider`` from scratch, or inherit and customize ``StandardCalloutActionProvider``.

For instance, here's a custom provider that inherits ``StandardCalloutActionProvider`` and customizes the actions for **$**:

```swift
class CustomCalloutActionProvider: StandardCalloutActionProvider {
    
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        switch action {
        case .character(let char):
            switch char {
            case "$": return "$₽¥€¢£₩".chars.map { KeyboardAction.character($0) }
            default: break
            }
        default: break
        }
        return super.calloutActions(for: action)
    }
}
```

To use this provider instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.calloutActionProvider = CustomCalloutActionProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

KeyboardKit has a ``Callouts/InputCallout`` that can be show the currently pressed key.

![InputCallout](inputcallout-350.jpg)

KeyboardKit also has a ``Callouts/ActionCallout`` that can present secondary actions.

![InputCallout](actioncallout-350.jpg)

``SystemKeyboard`` applies the proper view extensions to make these callouts appear, to both its keyboard and the **EmojiKeyboard**.




## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a ``CalloutActionProvider`` for every locale in your license, and automatically injects them into the ``StandardCalloutActionProvider``.


### How to access your localized providers

You can access all localized providers in your license, or any specific provider, like this:

```swift
let providers = License.current.localizedCalloutActionProviders
let provider = try ProCalloutActionProvider.Swedish()
```

> Important: These providers will throw a license error if their locale is not included in the license.


### How to customize a localized provider

You can inherit and customize any localized provider, then manually register your provider *after* registering your license key:

```swift
class CustomProvider: ProCalloutActionProvider.Swedish {

    override func calloutActionString(for char: String) -> String {
        switch char {
        case "s": return "sweden"
        default: return ""
        }
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
            let standard = services.calloutActionProvider as? StandardCalloutActionProvider
            standard?.registerLocalizedProvider(provider)
        } catch {
            print(error)
        }
    }
}
```

Note that the provider cast will fail if you replace the instance with your own type.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
