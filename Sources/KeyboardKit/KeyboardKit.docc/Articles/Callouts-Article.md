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



## Callouts Namespace

KeyboardKit has a ``Callouts`` namespace that contains callout-related types and views. For instance, an ``Callouts/InputCallout`` can present the currently pressed character while an ``Callouts/ActionCallout`` can present secondary actions when long pressing a key.



## Callout Context

KeyboardKit has an observable ``CalloutContext`` class that provides observable input and action callout state, such as the currently pressed key or the callout actions to present.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Callout Services

In KeyboardKit, a ``CalloutService`` can return secondary callout actions when a key is long pressed.

KeyboardKit automatically creates an instance of ``Callouts/StandardService`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or inject localized services into it with ``CalloutService/tryRegisterLocalizedService(_:)``.



## Callout Service Shorthands

You can easily resolve various service types with these shorthands:

* ``CalloutService/standard(keyboardContext:baseService:localizedServices:feedbackService:)``
* ``CalloutService/localized(_:)``, e.g. `.localized(.German(...))` (👑 Pro)
* ``CalloutService/localized(for:)``, e.g. `.localized(for: .swedish)` (👑 Pro)
* ``CalloutService/disabled``
* ``CalloutService/preview``



## How to show input and action callouts

The ``KeyboardView`` and ``Keyboard/Button`` will automatically apply the proper view extensions to make input and action callouts work, so you don't have to do anything to make action and input callouts work.

For other views, you can apply the ``SwiftUICore/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` view extension to make any view act as the container of input and action callouts:

```swift
MyKeyboard()
    .keyboardCalloutContainer(...)
```

This will bind a ``CalloutContext`` to the view and apply ``Callouts/ActionCallout`` and ``Callouts/InputCallout`` views that will show as it changes. 



## How to create a custom callout service

You can create a custom ``CalloutService`` to customize which secondary callout actions to show for different ``KeyboardAction``s.

You can implement the ``CalloutService`` protocol from scratch, or inherit and customize ``Callouts/BaseService`` or ``Callouts/StandardService`` to get a lot of functionality for free, for instance:

```swift
class CustomCalloutService: Callouts.StandardService {
    
    override func calloutActions(for action: KeyboardAction) -> [KeyboardAction] {
        var actions = super.calloutActions(for: action)
        // Perform any modifications here
        return actions
    }
}
```

The ``Callouts/StandardService`` and ``Callouts/ProService`` base classes have different functions that you can override, and the ``KeyboardAction`` model also provodes ways to define actions.

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



## How to customize the callouts for a specific locale

If a service inherits ``Callouts/StandardService``, you can use ``CalloutService/tryRegisterLocalizedService(_:)`` or the ``Keyboard/Services`` convenient ``Keyboard/Services/tryRegisterLocalizedCalloutService(_:)`` to register a custom service for a certain ``KeyboardLocale``.

For instance, this is how you could make KeyboardKit Pro use  a custom service for ``KeyboardLocale/german``:

```swift
class MyCustomGermanService: KeyboardLayout.ProService.German { ... } 

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.tryRegisterLocalizedCalloutService(
            try! MyCustomGermanService() 
        )
    }
}
```

This makes it easy to replace the default service for a certain locale in KeyboardKit Pro, where you can subclass ``Callouts/ProService`` or any localized Pro service, and make customizations to it.



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
        
        The view can be styled with a ``Callouts/ActionCalloutStyle``, which is applied with the ``SwiftUICore/View/actionCalloutStyle(_:)`` view modifier.
    }
    
    @Tab("Callouts.InputCallout") {
        
        The ``Callouts/InputCallout`` view mimics a native input callout, which can be used to show the currently pressed key as the user types:
        
        @Row {
            @Column { }
            @Column(size: 3) { ![InputCallout](inputcallout) }
            @Column { }
        }  
        
        The view can be styled with a ``Callouts/InputCalloutStyle``, which can be applied with the ``SwiftUICore/View/inputCalloutStyle(_:)`` view modifier.
    }
}

The ``KeyboardView`` automatically registers everything needed to automatically show these callouts.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``CalloutService`` for every locale in your license, which will be injected as localized services into the main ``Keyboard/Services/calloutService`` when a valid license is registered.


### Pro Callout Services

KeyboardKit Pro unlocks a localized ``Callouts/ProService`` for every locale in your license. They are injected into the main ``Keyboard/Services/calloutService`` when a valid license is registered.

You can access any localized service in your license like this, after successfully registering your license key:

```swift
let service = try Callouts.ProService.Swedish()
```

> Important: These services will throw a license error if their locales are not included in the license.


### How to customize a Pro service

You can inherit and customize any ``Callouts/ProService`` in your license, then manually register your service after setting up KeyboardKit Pro for your ``KeyboardApp``, or with a license key:

```swift
class CustomService: Callouts.ProService.Swedish {

    // Override any functions you want here...
}

class KeyboardController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPro(for: .myApp) { license in
            setupCustomService()
        } 
    }

    func setupCustomService() {
        do {
            let service = try CustomService()
            try services.calloutService.tryRegisterLocalizedService(service)
        } catch {
            print(error)
        }
    }
}
```

This is useful for when you want to make modifications to a single locale's callout actions, but keep all other locales the same.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
