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

👑 [KeyboardKit Pro][Pro] unlocks more status-related views & utilities. Information about Pro features can be found at the end of this article.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Keyboard Status Namespace

KeyboardKit has a ``KeyboardStatus`` namespace that contains status-related types and views, like the ``KeyboardStatus/Label`` that can be used to visualize a certain status value, as well as the ``KeyboardStatus/Section`` which is unlocked by KeyboardKit Pro.



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
        
        @Row {
            @Column {}
            @Column(size:2) { ![KeyboardStatus.Label](keyboardstatuslabel) }
            @Column {}
        }
        
        The view can be wrapped in a SwiftUI or ``KeyboardSettings`` ``KeyboardSettings/Link`` to link to System Settings. It supports custom texts, icons, etc.
        and can be styled with a ``KeyboardStatus/LabelStyle`` or by applying a ``SwiftUICore/View/keyboardStatusLabelStyle(_:)`` view modifier.
    }
}


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional keyboard status views and utilities, like a keyboard status section that can be added to the home or settings screen in an app that has a custom keyboard.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("Section ") {
        A keyboard status ``KeyboardStatus/Section`` can display all relevant status labels for a keyboard extension, with a link to System Settings if needed:
        
        @Row {
            @Column {}
            @Column(size:2) { ![KeyboardStatus.Label](keyboardstatussection) }
            @Column {}
        }
        
        The view is used by the ``KeyboardApp/HomeScreen`` component, and can be added as a standalone section, in e.g. an app's settings screen. It can be styled by applying a ``SwiftUICore/View/keyboardStatusSectionStyle(_:)`` view modifier.
    }
}
