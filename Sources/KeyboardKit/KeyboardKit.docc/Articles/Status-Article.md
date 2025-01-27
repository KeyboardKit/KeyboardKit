# Status

This article describes the KeyboardKit status engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit has ways to check various keyboard statuses, e.g. if a keyboard is enabled in System Settings, if Full Access is enabled, if a keyboard is actively being used, etc. This can be used to help users set up their keyboard. 

👑 [KeyboardKit Pro][Pro] unlocks more keyboard status-related views & utilities. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has a ``KeyboardStatus`` namespace that contains status-related types and views, like the ``KeyboardStatus/Label`` that can be used to visualize a certain status value, as well as the ``KeyboardStatus/Section`` which is unlocked by KeyboardKit Pro.



## Context

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

The context is observable, so any status changes will immediately cause the view to refresh. It supports bundle ID wildcards, which lets you inspect multiple keyboards with a single instance:

```
@StateObject
var status = KeyboardStatusContext(bundleId: "com.myapp.*")
```


## Views

The ``KeyboardStatus`` namespace has status-specific views, that can be used to display various keyboard status-related values:

@TabNavigator {
    
    @Tab("Label") {
        @Row {
            @Column { ![KeyboardStatus.Label](keyboardstatuslabel) }
            @Column {
                A keyboard status ``KeyboardStatus/Label`` can display various keyboard statuses, e.g. if a keyboard has been enabled, if Full Access is enabled, etc.
                
                The view supports custom texts, icons, etc. and can be styled with the ``SwiftUICore/View/keyboardStatusLabelStyle(_:)`` view modifier.        
            }
        }

    }
}


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional keyboard status views and utilities, like a keyboard status section that can be added to the home or settings screen in an app that has a custom keyboard.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("Section") {
        @Row {
            @Column { ![KeyboardStatus.Label](keyboardstatussection) }
            @Column {
                A keyboard status ``KeyboardStatus/Section`` can display all relevant status labels for a keyboard extension, with a link to System Settings if needed.
                
                The view is used by the ``KeyboardApp/HomeScreen`` component, and can be added as a standalone section, in e.g. an app's settings screen. 
                
                The view can be styled with the ``SwiftUICore/View/keyboardStatusSectionStyle(_:)`` view modifier.
            }
        }
    }
}
