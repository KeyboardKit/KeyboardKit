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

The observable ``KeyboardStatusContext`` can be used to observe the state of any keyboard:

```swift
struct MyView: View {

    @StateObject
    var status = KeyboardStatusContext(bundleId: "com.myapp.keyboard")

    var body: some View {
        VStack {
            Text("Enabled: \(status.isKeyboardEnabled.description)")
            Text("Active: \(status.isKeyboardActive.description)")
            Text("Full Access: \(status.isFullAccessEnabled.description)")
        }
    }
} 
```

The context is observable, so any status changes will immediately cause the view to refresh. It supports bundle ID wildcards, which let you can inspect multiple keyboards with a single instance:

```
@StateObject
var status = KeyboardStatusContext(bundleId: "com.myapp.*")
```

The ``KeyboardStatusInspector`` protocol that powers the context can be implemented by any type, to make it able to inspect the status of any keyboard at any time.


## Views

@TabNavigator {
    
    @Tab("KeyboardStatus.Label") {
        A keyboard status ``KeyboardStatus/Label`` can display various keyboard statuses, e.g. if a keyboard has been enabled, if Full Access is enabled, etc.
        
        ![KeyboardStatus.Label](keyboardstatelabel.jpg)
        
        This view can be used together with a ``KeyboardStatusContext``, to automatically update the label whenever the status changes:

        ```swift
        struct MyView: View {

            @StateObject
            var status = KeyboardStatusContext(bundleId: "com.myapp.keyboard")

            var body: some View {
                KeyboardStatus.Label(
                    isEnabled: status.isKeyboardEnabled,
                    enabledText: "Keyboard is enabled",
                    disabledText: "Keyboard is disabled",
                )
            }
        } 
        ```
        
        The view can be wrapped in a `Link` or ``KeyboardSettingsLink`` to link to System Settings. It supports custom texts, icons, etc.
        and can be styled with a ``KeyboardStatus/LabelStyle`` or by applying a ``SwiftUI/View/keyboardStatusLabelStyle(_:)`` view modifier.
    }
}

See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.
