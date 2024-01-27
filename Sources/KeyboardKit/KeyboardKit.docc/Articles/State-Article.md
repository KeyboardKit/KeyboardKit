# State

This article describes the KeyboardKit state engine.

KeyboardKit has ways to check various keyboard state, such as if a keyboard is enabled in System Settings, if **Full Access** is enabled, if the keyboard is currently being used, etc.

This information can be used to make the main app help users setup their keyboard properly. 


## Keyboard state

The observable ``KeyboardStateContext`` can be used to observe the state of any keyboard:

```swift
struct MyView: View {

    @StateObject
    var state = KeyboardStateContext(bundleId: "com.myapp.keyboard")

    var body: some View {
        VStack {
            Text("Enabled: \(stateContext.isKeyboardEnabled.description)")
            Text("Active: \(stateContext.isKeyboardActive.description)")
            Text("Full Access: \(stateContext.isFullAccessEnabled.description)")
        }
    }
} 
```

Since the context is observable, any state changes will immediately cause the view to refresh.

The context supports bundle ID wildcards, which means that a single instance can be used to inspect multiple keyboards:

```
@StateObject
var state = KeyboardStateContext(bundleId: "com.myapp.*")
```

The ``KeyboardStateInspector`` protocol that powers the context can be implemented by any type, to make it able to inspect the state of a keyboard.


## Views

The ``KeyboardStateLabel`` view can be used to display any keyboard state, for instance:

```swift
struct MyView: View {

    @StateObject
    var state = KeyboardStateContext(bundleId: "com.myapp.keyboard")

    var body: some View {
        KeyboardStateLabel(
            isEnabled: state.isKeyboardEnabled,
            enabledText: "Keyboard is enabled",
            disabledText: "Keyboard is disabled",
        )
    }
} 
```

The view can be wrapped in a `Link` or ``KeyboardSettingsLink`` to link to System Settings:

![KeyboardStateLabel](keyboardstatelabel-350.jpg)

It supports custom texts, icons, etc. and can be styled with a ``KeyboardStateLabelStyle``.
