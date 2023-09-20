# Understanding State

This article describes the KeyboardKit state engine.

KeyboardKit has ways to check if a keyboard is enabled in System Settings, if Full Access is granted and if the keyboard is currently being used. This can be used to make the main app help users setup their keyboard properly. 


## Keyboard state

The observable ``KeyboardStateContext`` class can be used to observe the state of any keyboard:

```swift
struct MyView: View {

    @StateObject
    var state = KeyboardStateContext(bundleId: "com.myapp.keyboard")

    var body: some View {
        VStack {
            Text("Is keyboard enabled: \(stateContext.isKeyboardEnabled.description)")
            Text("Is keyboard active: \(stateContext.isKeyboardActive.description)")
            Text("Is full access granted: \(stateContext.isFullAccessEnabled.description)")
        }
    }
} 
```

The context supports bundle id wildcards, which means that it can be used to inspect multiple keyboards:

```
@StateObject
var state = KeyboardStateContext(bundleId: "com.myapp.*")
```

The ``KeyboardStateInspector`` protocol can be implemented by any type, to make it able to inspect the state of a keyboard.


## Views

The ``KeyboardStateLabel`` view can be used to display the state of a keyboard:

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

The label supports custom texts, icons, etc. and can be styled with a ``KeyboardStateLabelStyle``.
