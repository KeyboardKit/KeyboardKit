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

👑 [KeyboardKit Pro][Pro] unlocks localized services for all ``Foundation/Locale/keyboardKitSupported`` locales in your license. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has a ``KeyboardCallout`` namespace that contains callout-related types and views. For instance, an ``KeyboardCallout/InputCallout`` to show the currently pressed character and an ``KeyboardCallout/ActionCallout`` to present secondary actions.



## Context

KeyboardKit has an observable ``KeyboardCalloutContext`` class that provides observable input and action callout state, such as the currently pressed ``KeyboardCalloutContext/inputAction`` or the ``KeyboardCalloutContext/secondaryActions`` to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Services

In KeyboardKit, a ``KeyboardCalloutService`` can return secondary callout actions when a key is long pressed and trigger feedback when the selected secondary action changes. 

KeyboardKit injects a ``KeyboardCallout/StandardCalloutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add localized services to it with ``KeyboardCalloutService/tryRegisterLocalizedService(_:)``.



## Styling

In KeyboardKit, a ``KeyboardCallout/CalloutStyle`` can be used to style both input & action callouts. You can apply a custom style with the ``SwiftUICore/View/keyboardCalloutStyle(_:)`` view modifier, or by returning a custom style with a custom ``KeyboardStyleService``.



## Views

The ``KeyboardCallout`` namespace has callout-specific views, that can be used to mimic the native iOS input and action callouts.

@TabNavigator {
    
    @Tab("ActionCallout") {
        
        @Row {
            @Column { ![ActionCallout](actioncallout) }
            @Column { 
                The ``KeyboardCallout/ActionCallout`` view mimics presents secondary actions when a keyboard key with secondary actions is long-pressed.        
            }
        }
    }
    
    @Tab("InputCallout") {
        
        @Row {
            @Column { ![InputCallout](inputcallout) }
            @Column { 
                The ``KeyboardCallout/InputCallout`` view mimics a native input callout, which can be used to show the currently pressed key as the user types.
            }
        }
    }
}

Both views can be styled with a ``KeyboardCallout/CalloutStyle``, which can be applied with the ``SwiftUICore/View/keyboardCalloutStyle(_:)`` view modifier or provided with a custom ``KeyboardStyleService``.


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``KeyboardCallout/ProCalloutService`` for every locale in your license, and injects them as localized services into the main ``Keyboard/Services/calloutService`` when a valid license is registered. You can access any localized service in your license like this:

```swift
let service = try KeyboardCallout.ProCalloutService.Swedish()
```

These services will all throw an error if you try to access them without a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. See <doc:Getting-Started> for more info.

---


## How to... 


### ...show input and action callouts

The ``KeyboardView`` will automatically apply the proper view extensions to make input and action callouts work. For a custom view, just apply a ``SwiftUICore/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` modifier to it to make it present callouts.

This binds a ``KeyboardCalloutContext`` to the view and applies a ``KeyboardCallout/ActionCallout`` and a ``KeyboardCallout/InputCallout`` view to the container. 



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
    setupPro(for: ...) { result in
        // KeyboardKit Pro is available first after this
        self.services.tryRegisterLocalizedLayoutService(
            try! MyCustomGermanService() 
        )
    }
}
}
```

This makes it easy to replace the service for a certain locale, since you can inherit and customize the related ``KeyboardCallout/ProCalloutService``.

> Important: Note that you must wait for **setupPro** to finish successfully when you use KeyboardKit Pro and want to customize a Pro service class, otherwise you won't be able to resolve the pro-specific services, since your license will not yet be registered.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
