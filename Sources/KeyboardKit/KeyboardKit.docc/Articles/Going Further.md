# Going Further

This article discusses how to configure KeyboardKit and add your own logic to the mix.


## Standard Configuration

When you inherit ``KeyboardInputViewController`` and launch your extension, the controller will by default be configured with a bunch of observable properties and services.

All properties will be injected into the view hierarchy when you call ``KeyboardInputViewController/setup(with:)``, which means that you can create environment objects that observe the state of these properties.

All services will be configured with standard implementations, such as ``StandardKeyboardActionHandler``, but can be replaced with your own custom implementations.



## Observing a context

To observe a context in any SwiftUI view, you just have to use `@EnvironmentObject`:

```swift
struct MyView: View {

    @EnvironmentObject private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

SwiftUI will automatically resolve the correct context and start observing its state.

You can also inject the context in the view initializer and setup an `@ObservedObject`:

```swift
struct MyView: View {
    
    init(context: KeyboardContext) {
       _context = ObservedObject(wrappedValue: context)
    }
    
    @ObservedObject private var context: KeyboardContext
    
    var body: some View {
        ...
    }
}
```

You can use any of these options as you see fit. KeyboardKit itself use init injection since that makes it more obvious what dependencies the various library views have. 



## Accessing a service

Unlike contexts, services can not be resolved using environment objects. You must instead inject any services you want to use into the views you want to use it in:


```swift
struct MyView: View {

    // You don't need an initializer if the init is in the same target
    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private let actionHandler: KeyboardActionHandler

    var body: some View {
        Button(action: { actionHandler.handle(.tap, on: .space) }) {
            Text("Custom space bar")
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}
```

In the example above, the view uses an injected action handler to trigger a "tap on space".



## Customizing the standard configuration

You can easily inject your own custom services into KeyboardKit and replace the standard behavior.

For instance, say that you have a custom action handler:

```swift
class MyActionHandler: StandardActionHandler {

    open override func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        false   // Wow, what a useless action handler! 
    }
}
```

You can now use this action handler instead of the standard one, by setting ``KeyboardInputViewController/keyboardActionHandler`` to that new type.

You should inject your custom services in ``KeyboardInputViewController/viewDidLoad()``, before any other services have been resolved. That way, any inter-dependencies between the services will be properly resolved:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

If you want to configure KeyboardKit at a later state, make sure that the service that you replace isn't used in any other services. 

If a service that you want to replace with a custom instance is already being used by another service, you must re-create that service as well, to avoid having the old service instance still hanging around.
