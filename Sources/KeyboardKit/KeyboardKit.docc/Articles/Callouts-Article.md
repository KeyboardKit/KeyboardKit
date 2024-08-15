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

Callouts are an important part of the typing experience, where input callouts can show the currently pressed key and action callouts can show secondary actions when certain keys are long pressed.

KeyboardKit has ways to automatically show an ``Callouts/InputCallout`` when the user types, and has a ``CalloutService`` protocol that can provide actions to present in an ``Callouts/ActionCallout`` when long pressing certain keys.

👑 [KeyboardKit Pro][Pro] unlocks localized services for all locales. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Callout Namespace

KeyboardKit has a ``Callouts`` namespace that has callout-related types and views. For instance, an ``Callouts/InputCallout`` can present the currently pressed character while an ``Callouts/ActionCallout`` can present secondary actions while long pressing a key.



## Callout Context

KeyboardKit has an observable ``CalloutContext`` class that provides observable input and action callout state, such as the currently pressed key or the callout actions to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Callout Services

In KeyboardKit, a ``CalloutService`` can be used to provide secondary callout actions for any key, which are then presented when a key with actions is long pressed.

KeyboardKit automatically creates an instance of ``Callouts/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject localized services into it.



## How to show input and action callouts

The ``KeyboardView`` and ``Keyboard/Button`` will automatically apply the proper view extensions to make input and action callouts work, so you don't have to do anything to make action and input callouts work.

For other views, you can apply the ``SwiftUI/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` view extension to make any view act as the container of input and action callouts:

```swift
MyKeyboard()
    .keyboardCalloutContainer(...)
```

This will bind a ``CalloutContext`` to the view and apply ``Callouts/ActionCallout`` and ``Callouts/InputCallout`` views that will show as it changes. 



## How to create a custom callout service

You can create a custom ``CalloutService`` to customize which secondary callout actions to show for different ``KeyboardAction``s.

You can implement the ``CalloutService`` protocol from scratch, or inherit and customize ``Callouts/BaseService`` or ``Callouts/StandardService`` to get a lot of stuff for free. 

For instance, here's a custom service that inherits ``Callouts/StandardService`` and customizes the actions for the `$` key:

```swift
class CustomCalloutService: Callout.StandardService {
    
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


To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/calloutService`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.calloutService = CustomCalloutService()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## Views

The ``Callouts`` namespace has callout-specific views, that can be used to mimic the native iOS & iPadOS input and action callouts.

@TabNavigator {
    
    @Tab("Callouts.ActionCallout") {
        
        The ``Callouts/ActionCallout`` view mimics a native action callout, and can present secondary actions when a keyboard key is long-pressed:
        
        @Row {
            @Column { }
            @Column(size: 3) { ![ActionCallout](actioncallout) }
            @Column { }
        }
        
        The view can be styled with a ``Callouts/ActionCalloutStyle``, which is applied with the ``SwiftUI/View/actionCalloutStyle(_:)`` view modifier.
    }
    
    @Tab("Callouts.InputCallout") {
        
        The ``Callouts/InputCallout`` view mimics a native input callout, which can be used to show the currently pressed key as the user types:
        
        @Row {
            @Column { }
            @Column(size: 3) { ![InputCallout](inputcallout) }
            @Column { }
        }  
        
        The view can be styled with a ``Callouts/InputCalloutStyle``, which can be applied with the ``SwiftUI/View/inputCalloutStyle(_:)`` view modifier.
    }
}




## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``CalloutService`` for every locale in your license, which will be injected as localized services into the main ``Keyboard/Services/calloutService`` when a valid license is registered.


### Pro Callout Services

KeyboardKit Pro unlocks a localized ``Callouts/ProService`` for every locale in your license.

You can access any service in your license like this:

```swift
let service = try Callouts.ProService.Swedish()
```

> Important: These services will throw a license error if their locales are not included in the license.


### How to customize a Pro service

You can inherit and customize any ``Callouts/ProService``, then manually register your service *after* registering your license key:

```swift
class CustomService: Callouts.ProService.Swedish {

    /// This string will be converted to a list of keyboard actions
    override func calloutActionString(for char: String) -> String {
        switch char {
        case "s": "sweden"
        default: ""
        }
    }
}

class KeyboardController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setupPro(withLicenseKey: "...") { license in
            setupCustomService()
        } view: { controller in
            // Return your keyboard view here
        }
    }

    func setupCustomService() {
        do {
            let service = try CustomService()
            let standard = services.calloutService as? Callouts.StandardService
            standard?.registerLocalizedService(service)
        } catch {
            print(error)
        }
    }
}
```

This is useful for when you want to make modifications to a single locale's callout actions, but keep all other locales the same.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
