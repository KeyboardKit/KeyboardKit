# State

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit state engine.

KeyboardKit has ways to check various keyboard state, such as if a keyboard is enabled in System Settings, if **Full Access** is enabled, if the keyboard is currently being used, etc.

This information can be used to make an app help users to set up their keyboard properly. 


## Keyboard state

The observable ``KeyboardStateContext`` can be used to observe the state of any keyboard:

```swift
struct MyView: View {

    @StateObject
    var state = KeyboardStateContext(bundleId: "com.myapp.keyboard")

    var body: some View {
        VStack {
            Text("Enabled: \(state.isKeyboardEnabled.description)")
            Text("Active: \(state.isKeyboardActive.description)")
            Text("Full Access: \(state.isFullAccessEnabled.description)")
        }
    }
} 
```

Since the context is observable, any state changes will immediately cause the view to refresh.

The context supports bundle ID wildcards, which means that you can inspect multiple keyboards with a single instance:

```
@StateObject
var state = KeyboardStateContext(bundleId: "com.myapp.*")
```

The ``KeyboardStateInspector`` protocol that powers the context can be implemented by any type, to make it able to inspect the state of a keyboard at any time.


## Views

@TabNavigator {
    
    @Tab("KeyboardState.Label") {
        A keyboard state ``KeyboardState/Label`` can be used to display any keyboard state, for instance if the keyboard has been enabled in System Settings, if Full Access is enabled, etc.

        ```swift
        struct MyView: View {

            @StateObject
            var state = KeyboardStateContext(bundleId: "com.myapp.keyboard")

            var body: some View {
                KeyboardState.Label(
                    isEnabled: state.isKeyboardEnabled,
                    enabledText: "Keyboard is enabled",
                    disabledText: "Keyboard is disabled",
                )
            }
        } 
        ```
        
        The view can be wrapped in a `Link` or ``KeyboardSettingsLink`` to link to System Settings. It supports custom texts, icons, etc.
        and can be styled with a ``KeyboardState/LabelStyle`` or by applying a ``SwiftUI/View/keyboardStateLabelStyle(_:)`` view modifier.
    }
}

See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.
