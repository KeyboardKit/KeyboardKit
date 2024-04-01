# Callouts

This article describes the KeyboardKit callout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

Callouts are an important part of the typing experience, where input callouts show the currently pressed character and action callouts show secondary actions when certain keys are long pressed.

KeyboardKit has ways to automatically show an ``Callouts/InputCallout`` when the user types, and has a ``CalloutActionProvider`` that can provide actions that can be presented in an ``Callouts/ActionCallout`` when long pressing certain keys.

👑 [KeyboardKit Pro][Pro] unlocks localized providers for all locales. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Callout namespace

KeyboardKit has a ``Callouts`` namespace that has callout-related types and views. For instance, an ``Callouts/InputCallout`` can present the currently pressed character while an ``Callouts/ActionCallout`` can present secondary actions while long pressing a key.



## Callout context

KeyboardKit has an observable ``CalloutContext`` class that provides observable input and action callout state, such as the currently pressed key or the callout actions to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Callout action providers

In KeyboardKit, a ``CalloutActionProvider`` can be used to provide dynamic callout actions, which are then presented when a key that has actions defined in the provider is long pressed.

KeyboardKit automatically creates an instance of ``Callouts/StandardActionProvider`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject localized providers into it.



## How to show input and action callouts

You can apply a ``SwiftUI/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` view extension to make any view act as the container of input and action callouts:

```swift
MyKeyboard()
    .keyboardCalloutContainer(...)
```

This will bind a ``CalloutContext`` to the view, then apply ``Callouts/ActionCallout`` and ``Callouts/InputCallout`` views that show as this context changes. There are also separate input and action-specific container extensions.

There are also individual extensions for ``SwiftUI/View/keyboardActionCalloutContainer(calloutContext:keyboardContext:)`` and ``SwiftUI/View/keyboardInputCalloutContainer(calloutContext:keyboardContext:)``. 

The ``SystemKeyboard`` and ``Keyboard/Button`` will automatically apply the proper extensions and update the context as you interact with them.



## How to create a custom callout action provider

You can create a custom ``CalloutActionProvider`` to customize which callout actions to present for certain ``KeyboardAction``s.

You can implement ``CalloutActionProvider`` from scratch, or inherit and customize the ``Callouts/StandardActionProvider``. For instance, here's a custom callout action provider that inherits ``Callouts/StandardActionProvider`` and customizes the actions for the $ key:

```swift
class CustomCalloutActionProvider: Callout.StandardActionProvider {
    
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

@TabNavigator {
    
    @Tab("Callouts.ActionCallout") {
        
        KeyboardKit has an ``Callouts/ActionCallout`` that mimics a native action callout and can be used to present secondary actions for any key:
        
        ![ActionCallout](actioncallout-350.jpg)
        
        The view can be styled with a ``Callouts/ActionCalloutStyle``, which is applied with the ``SwiftUI/View/actionCalloutStyle(_:)`` view modifier.
    }
    
    @Tab("Callouts.InputCallout") {
        
        KeyboardKit has an ``Callouts/InputCallout`` that mimics a native input callout and can be used to show the currently pressed key:
        
        ![InputCallout](inputcallout-350.jpg)  
        
        The view can be styled with a ``Callouts/InputCalloutStyle``, which can be applied with the ``SwiftUI/View/inputCalloutStyle(_:)`` view modifier.
    }
}

See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.




## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``CalloutActionProvider`` for every locale in your license, and automatically injects them into the ``Callouts/StandardActionProvider``. You can access all localized providers in your license like this:

```swift
let providers = License.current.localizedCalloutActionProviders
let provider = try Callouts.ProActionProvider.Swedish()
```

> Important: These providers will throw a license error if their locale is not included in the license.


### How to customize a Pro callout action provider

You can inherit and customize any localized provider, then manually register your provider *after* registering your license key:

```swift
class CustomProvider: Callouts.ProActionProvider.Swedish {

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
            let standard = services.calloutActionProvider as? Callouts.StandardActionProvider
            standard?.registerLocalizedProvider(provider)
        } catch {
            print(error)
        }
    }
}
```

This is useful for the cases when you want to make modifications to a single locale, but keep all other locales unaffected.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
