# Status

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit status engine.

KeyboardKit has ways to check various keyboard statuses, e.g. if a keyboard is enabled in System Settings, if Full Access is enabled, if a keyboard is actively being used, etc.

This information can be used to make an app help users to set up their keyboard properly. 


## Keyboard Status Context

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


## Keyboard Status Inspector

The ``KeyboardStatusInspector`` protocol that powers the context can be implemented by any type, to make it able to inspect the status of any keyboard at any time.


## Views

The ``KeyboardStatus`` namespace has status-specific views, that can be used to display various keyboard status-related values:

@TabNavigator {
    
    @Tab("Label") {
        A keyboard status ``KeyboardStatus/Label`` can display various keyboard statuses, e.g. if a keyboard has been enabled, if Full Access is enabled, etc.
        
        ![KeyboardStatus.Label](keyboardstatuslabel.jpg)
        
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
        
        The view can be wrapped in a `Link` or ``KeyboardSettings/Link`` to link to System Settings. It supports custom texts, icons, etc.
        and can be styled with a ``KeyboardStatus/LabelStyle`` or by applying a ``SwiftUI/View/keyboardStatusLabelStyle(_:)`` view modifier.
    }
}

See the <doc:Styling-Article> article for more information about KeyboardKit view styling.
