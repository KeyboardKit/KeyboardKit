# Callouts

This article describes the KeyboardKit callout engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Callouts are an important part of the typing experience, where an ``Callouts/InputCallout`` can show the currently pressed key and an ``Callouts/ActionCallout`` can show secondary actions when certain keys are long pressed.

👑 [KeyboardKit Pro][Pro] unlocks localized callouts for all ``Foundation/Locale/keyboardKitSupported`` locales in your license. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has a ``Callouts`` namespace that contains callout-related types and views, like the callout ``Callouts/Actions`` model, the ``Callouts/InputCallout`` and ``Callouts/ActionCallout`` views, styles, etc.



## Context

KeyboardKit has an observable ``CalloutContext`` class that has observable callout state, such as the current ``CalloutContext/inputAction`` or the ``CalloutContext/secondaryActions`` that should be presented.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates this context when keys are pressed.



## Services (DEPRECATED)

In KeyboardKit, a ``CalloutService`` can return secondary callout actions when a key is long pressed and let the user swipe to change which action to apply. 

KeyboardKit injects a ``Callouts/StandardCalloutService`` into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down, or add localized services to it by signing up for [KeyboardKit Pro][Pro].

> Important: This service model is soft deprecated and will be removed in KeyboardKit 10. Please migrate to the new view-based customization approach described in the next section as soon as possible.



## Callout Action Customization

You can use the ``SwiftUICore/View/keyboardCalloutActions(_:)`` view modifier to customize the callout actions for any action:


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
                default: .standardCalloutActions(for: params.action, context: context) 
                }
            }
    }
}
```

You can customize callouts for any actions, then use ``Callouts/ActionsBuilderParams/standardActions(for:)`` to return the standard actions for all other actions.



## Styling

You can use the ``SwiftUICore/View/keyboardCalloutStyle(_:)`` view modifier to customize the style of the input and action callouts and their items. 



## Views

The ``KeyboardCallout`` namespace has callout-specific views, that can be used to mimic the native iOS input and action callouts.

@TabNavigator {
    
    @Tab("ActionCallout") {
        
        @Row {
            @Column { ![ActionCallout](callouts-actioncallout) }
            @Column { 
                The ``Callouts/ActionCallout`` view can present secondary actions when a keyboard key with secondary actions is long-pressed.        
            }
        }
    }
    
    @Tab("InputCallout") {
        
        @Row {
            @Column { ![InputCallout](callouts-inputcallout) }
            @Column { 
                The ``Callouts/InputCallout`` view can be used to zoom in the currently pressed input key as the user types.
            }
        }
    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a localized ``Callouts/ProCalloutService`` for every locale in your license, and injects them as localized services into the main ``Keyboard/Services/calloutService``. You can access any localized service in your license like this:

```swift
let service = try Callouts.ProCalloutService.Swedish()
```

KeyboardKit Pro also unlocks localized callout ``Callouts/Actions`` for all supported locales that are included in your license.

```swift
let actions = Callouts.Actions.swedish  // or...
let actions = try Callouts.Actions.swedishBuilder()
let standardActions = Callouts.Actions.standard(for: keyboardContext) 
```

The services and value builders will throw a license error if you try to access them without a valid KeyboardKit Pro license. If you are on the Basic or Silver plan, you must specify which locales to use in your ``KeyboardApp``. 

> Important: The localized callout action values are static values that will be lazily computed when you first access them. They will fail silently if you try to access them before registering a valid license, which will cause them to always have a `nil` value.

---


## How to... 


### ...show callouts

The ``KeyboardView`` will automatically make both input and action callouts work. For a custom view, just apply a ``SwiftUICore/View/keyboardCalloutContainer(calloutContext:keyboardContext:)`` view modifier to it to make it present callouts.

You can then use the ``CalloutContext``'s ``CalloutContext/inputAction`` and ``CalloutContext/secondaryActions`` to show input and action callouts.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
