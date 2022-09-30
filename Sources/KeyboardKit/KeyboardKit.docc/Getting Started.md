# Getting started

This article discusses how get started using KeyboardKit in your app.


## How to use KeyboardKit

You can use KeyboardKit in different ways in your iOS app targets:

* Keyboard extensions can use KeyboardKit to create more powerful keyboards.
* Apps can use KeyboardKit to check if a keyboard is enabled, has full access etc.
* Apps can create custom input controllers and use KeyboardKit for the text field.
* Other targets, like widgets can use KeyboardKit to build upon its functionality.

Other platforms, such as macOS, watchOS and tvOS can use KeyboardKit as well, even though creating custom keyboards on those platforms may not be the most common use-case. 



## How to setup KeyboardKit

In your keyboard extension, let `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`. This will give it access to a lot of additional functionality, like new lifecycle functions, observable properties like ``KeyboardInputViewController/keyboardContext``, services like ``KeyboardInputViewController/keyboardActionHandler`` and much more.

The controller will then call ``KeyboardInputViewController/viewWillSetupKeyboard()`` when the keyboard should be created or re-created. You can use ``KeyboardInputViewController/setup(with:)`` to setup KeyboardKit with any `SwiftUI` view:

```swift
func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()
    setup(with: MyKeyboardView())
}
```

This will make the provided view the main view of the keyboard extension, and cause the extension to resize to fit the view content. It will also inject all observable controller properties as environment objects into the view hierarchy. 

Once your keyboard is created, KeyboardKit will observe context changes to automatically update the keyboard, e.g. when the keyboard type changes.

It's important that the view observes the global ``KeyboardInputViewController/keyboardContext``, either by using the injected environment object or by setting it up as an observed object, otherwise it will be unresponsive to context changes. If your view doesn't react when you tap the shift or numeric key, that is most probably the cause.



## Using the standard configuration

When you inherit ``KeyboardInputViewController`` and launch your extension, the controller will by default be configured with a bunch of observable properties and services.

All properties will be injected into the view hierarchy when you setup KeyboardKit with a view, which means that you can use environment objects that observe the state of these properties.

All services will be configured with standard implementations, such as the ``StandardKeyboardActionHandler``, which is bound to ``KeyboardInputViewController/keyboardActionHandler`` when the extension is created, but all these standard services can be replaced with your own custom implementations.



## Observing changes

To observe keyboard context changes in any SwiftUI view, you can use `@EnvironmentObject` to resolve any injected state, for instance:

```swift
struct MyView: View {

    @EnvironmentObject private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

SwiftUI will automatically resolve the correct instance and start observing changes in the instance.

You can also inject an observable object into an initializer and setup an `@ObservedObject` like this:

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

You can use any of these options as you see fit. Environment objects are convenient, but KeyboardKit itself uses init injection, since it makes dependencies more explicit.

There are a bunch of KeyboardKit-specific environment objects that can provide you with important information, such as ``KeyboardContext``, ``AutocompleteContext``, ``InputCalloutContext`` etc.



## Using services

Unlike contexts, services can't be resolved using environment objects. You must instead inject any services you want to use into your various types and views, for instance via the initializer:


```swift
struct MyView: View {

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

You can easily customize the standard configuration, by replacing the standard services with your own custom implementations.

For instance, say that you have a custom action handler:

```swift
class MyActionHandler: StandardActionHandler {

    open override func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        false   // Wow, what a useless action handler! 
    }
}
```

You can now use this action handler instead of the standard one, by setting ``KeyboardInputViewController/keyboardActionHandler`` to that new type:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

You should inject your custom services in ``KeyboardInputViewController/viewDidLoad()``, before any other services have been resolved. That way, any inter-dependencies between the services will be properly resolved. If you want to configure KeyboardKit at a later state, make sure that the service that you replace isn't used in any other services. 

If a service that you want to replace with a custom instance is already being used by another service, you must re-create that service as well, to avoid having the old service instance still hanging around.



## Going further

If you followed the example above, you should now have a keyboard that observes the keyboard context and automatically does a bunch of things right out of the box. You should also have a basic understanding of how to observe state, use keyboard services and customize the standard configuration.

You can now customize your keyboards in all kind of ways. You can change things in the keyboard context to update the keyboard, switch out the main keyboard input controller's various services to change things like the input set, keyboard layout, callouts, audio and haptic feedback etc. You can also use entirely custom views. 

Have a look in the documentation for more articles on how to configure KeyboardKit, create your own service implementations etc. You can also have a look at the demo apps, which replace many services with demo-specific implementations.  

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo apps for inspiration.

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
