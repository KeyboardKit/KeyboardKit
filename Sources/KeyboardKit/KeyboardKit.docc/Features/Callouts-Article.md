# Callouts

This article describes the KeyboardKit callout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Callouts are an important part of the typing experience, where input callouts can show the currently pressed key and action callouts can show secondary actions when certain keys are long pressed.

KeyboardKit can show an ``KeyboardCallout/InputCallout`` for the currently pressed input key, and an ``KeyboardCallout/ActionCallout`` with secondary actions when a key with secondary actions is long pressed.

👑 [KeyboardKit Pro][Pro] unlocks localized callouts for all ``Foundation/Locale/keyboardKitSupported`` locales in your license. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has a ``KeyboardCallout`` namespace that contains callout-related types and views. For instance, an ``KeyboardCallout/InputCallout`` can show the currently pressed character, and an ``KeyboardCallout/ActionCallout`` can show secondary actions.



## Context

KeyboardKit has an observable ``KeyboardCalloutContext`` class that provides observable input and action callout state, such as the currently pressed ``KeyboardCalloutContext/inputAction`` or the ``KeyboardCalloutContext/secondaryActions`` to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Services

In KeyboardKit, a ``KeyboardCalloutService`` can return secondary callout actions when a key is long pressed and trigger feedback when the selected secondary action changes. 

KeyboardKit injects a ``KeyboardCallout/StandardCalloutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add localized services to it with ``KeyboardCalloutService/tryRegisterLocalizedService(_:)`` or ``Keyboard/Services/tryRegisterLocalizedCalloutService(_:)``.

> Info: KeyboardKit 9.5 introduced a new action builder-based  ``SwiftUICore/View/keyboardCalloutActions(_:)`` view modifier that will replace the entire service concept in the next major version, if it proves to be easier to use than services.



## View-based Action Customization (BETA)

You can use ``SwiftUICore/View/keyboardCalloutActions(_:)`` view modifier to customize callout actions for any action, instead of using a service:


```swift
// See the demo app for a better, interactive example.
struct MyKeyboardView: View {

    let state: Keyboard.State
    let services: Keyboard.Services
    let context: KeyboardContext { state.keyboardContext }
    
    var body: some View {
        ... // Insert the view to use here, for instance a KeyboardView
            .keyboardCalloutActions { params in
                switch params.action {
                case .backspace: [...]  // Return custom actions here
                default: params.standardActions(for: context) 
                }
            }
    }
}
```

You can customize callouts for any actions, then use ``KeyboardCallout/ActionsBuilderParams/standardActions(for:)`` to return the standard actions for all other actions.

> Important: KeyboardKit will use the callout service if this modifier returns nil value and view modifier-based model proves better, since using values removes many complexities that are involved with services.



## Styling

You can use the ``SwiftUICore/View/keyboardCalloutStyle(_:)`` view modifier to apply a custom callout style, or implement and register a custom ``KeyboardStyleService``. This style will be used by both the action callout and the input callout. 



## Views

The ``KeyboardCallout`` namespace has callout-specific views, that can be used to mimic the native iOS input and action callouts.

@TabNavigator {
    
    @Tab("ActionCallout") {
        
        @Row {
            @Column { ![ActionCallout](callouts-actioncallout) }
            @Column { 
                The ``KeyboardCallout/ActionCallout`` view can present secondary actions when a keyboard key with secondary actions is long-pressed.        
            }
        }
    }
    
    @Tab("InputCallout") {
        
        @Row {
            @Column { ![InputCallout](callouts-inputcallout) }
            @Column { 
                The ``KeyboardCallout/InputCallout`` view can be used to zoom in the currently pressed input key as the user types.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardCallout/ProCalloutService`` for every locale in your license, and injects them as localized services into the main ``Keyboard/Services/calloutService``. You can access any localized service in your license like this:

```swift
let service = try KeyboardCallout.ProCalloutService.Swedish()
```

KeyboardKit Pro also unlocks localized callout ``KeyboardCallout/Actions`` for all supported locales that are included in your license.

```swift
let actions = KeyboardCallout.Actions.swedish  // or...
let actions = try KeyboardCallout.Actions.swedishBuilder()
let standardActions = KeyboardCallout.Actions.standard(for: keyboardContext) 
```

The services and value builders will throw a license error if you try to access them without a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. 

> Important: The localized callout action values are static values that will be lazily computed when you first access them. They will fail silently if you try to access them before registering a valid license, which will cause them to always have a `nil` value.

---


## How to... 


### ...show callouts

The ``KeyboardView`` will automatically make both input and action callouts work. For a custom view, just apply a ``SwiftUICore/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` view modifier to it to make it present callouts.


### ...create a custom callout service

You can create a custom ``KeyboardCalloutService`` to customize which secondary actions to show for any ``KeyboardAction``. 

You can implement the ``KeyboardCalloutService`` protocol from scratch or inherit and customize ``KeyboardCallout/StandardCalloutService``:

```swift
class CustomCalloutService: KeyboardCallout.StandardCalloutService {
    
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        var actions = super.calloutActions(for: action)
        // Perform any modifications here
        return actions
    }
}
```

To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/calloutService`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.calloutService = CustomCalloutService()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.


### ...customize a localized Pro service

Service that inherit ``KeyboardCallout/StandardCalloutService`` can use ``KeyboardCalloutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` convenient ``Keyboard/Services/tryRegisterLocalizedCalloutService(_:)`` function to register a custom service for a certain locale.

For instance, this is how you could make KeyboardKit Pro use a custom callout service for ``Foundation/Locale/german``:

```swift
class MyCustomGermanService: KeyboardCallout.ProCalloutService.German { ... } 

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(for: ...) { result in
            // Check result to see that setup was successful
            self.services.tryRegisterLocalizedLayoutService(
                try! MyCustomGermanService() 
            )
        }
    }
}
```

This makes it easy to replace the service for a certain locale, since you can inherit and customize the related ``KeyboardCallout/ProCalloutService``.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
