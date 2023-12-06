# Understanding Callouts

This article describes the KeyboardKit callout engine.

Callouts are an important part of the typing experience, where input callouts show the currently pressed key and action callouts present secondary keyboard actions.

In KeyboardKit, a ``CalloutActionProvider`` can be used to provide secondary actions to a ``CalloutContext``, which in turn will update views like ``Callouts/ActionCallout``.

KeyboardKit will bind a ``StandardCalloutActionProvider`` instance to ``KeyboardInputViewController/services`` when the keyboard is loaded. You can modify or replace this provider at any time.

[KeyboardKit Pro][Pro] unlocks and registers localized action providers. Information about Pro features can be found at the end of this article.



## Callout namespace

KeyboardKit has a ``Callouts`` namespace that contains callout-related types.

For instance, ``Callouts/InputCallout`` shows the currently pressed key while ``Callouts/ActionCallout`` shows secondary actions when long pressing a key. These callouts are automatically used if you use a ``SystemKeyboard``.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level.



## Callout context

KeyboardKit has an observable ``CalloutContext`` class that provides state for input and action callouts, such as the pressed key or the currently presented secondary actions.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then updates it when keys are pressed.



## How to show input and action callouts

You can apply callout-specific view extensions in KeyboardKit, to make any view act as the container of input and action callouts. 

For instance, this will make your custom keyboard view show both input and action callouts:

```swift
MyKeyboard()
    .keyboardCalloutContainer(...)
```

This will bind a ``CalloutContext`` to the view, then apply ``Callouts/ActionCallout`` and ``Callouts/InputCallout`` views that will show as these contexts change. 

The ``SystemKeyboard`` and ``KeyboardButton/Button`` will automatically apply this extension and update the callout contexts as you interact with the keyboard.



## How to customize callout actions

In KeyboardKit, a ``CalloutActionProvider`` can be used to provide dynamic callout actions.

You can customize the callout actions by adding localized providers to the default ``StandardCalloutActionProvider``, or by replacing the ``KeyboardInputViewController/services`` provider with a custom ``CalloutActionProvider``.



## How to create a custom callout action provider

You can create a custom ``CalloutActionProvider`` by inheriting ``StandardCalloutActionProvider`` and customize what you want, or implement the ``CalloutActionProvider`` protocol from scratch.

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

To use this provider instead of the standard one, just set the ``KeyboardInputViewController/services`` provider to this custom provider:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.calloutActionProvider = CustomCalloutActionProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a ``CalloutActionProvider`` for each locale in your license.

KeyboardKit Pro automaticallys inject all providers from your license into the ``StandardCalloutActionProvider``, to make it support all locales.


### How to access your localized providers

You can access all localized providers in your license like this:

```swift
let providers = License.current.localizedCalloutActionProviders
```

or any locale-specific provider like this:

```swift
let provider = try ProCalloutActionProvider.Swedish()
```

Note that your license must include the locale, otherwise the provider will throw a license error.


### How to customize a localized provider

You can inherit and customize any localized provider, to customize that specific locale:

```swift
class CustomProvider: ProCalloutActionProvider.Swedish {

    override func calloutActionString(for char: String) -> String {
        switch char {
        case "s": return "sweden"
        default: return ""
        }
    }
}
```

You can register this provider *after* registering your license key, to customize that specific locale:

```swift
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
            standard.localizedProviders[.swedish] = provider
            services.keyboardLayoutProvider = standard
        } catch {
            print(error)
        }
    }
}
```

Note that the standard provider cast will fail if you replace it.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
