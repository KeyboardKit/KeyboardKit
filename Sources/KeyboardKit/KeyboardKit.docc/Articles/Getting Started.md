# Getting Started

This article discusses how get started with KeyboardKit.

You can use KeyboardKit in many different ways:

* Keyboard extensions can use KeyboardKit to create more powerful keyboards.
* Apps can use KeyboardKit to check if a keyboard is enabled, has full access etc.
* Apps can create custom input controllers and use KeyboardKit for the text field.
* All targets, such as apps, keyboard extensions, widgets etc. can use KeyboardKit to build upon its functionality.

KeyboardKit supports iOS, iPadOS, macOS, tvOS and watchOS, although some functionality is only available on some platforms.



## How to install KeyboardKit

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any other targets that need it. 



## How to setup KeyboardKit

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`. 

This gives your controller access to additional functionality, such as new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable properties like ``KeyboardInputViewController/keyboardContext``, keyboard services like ``KeyboardInputViewController/keyboardActionHandler`` and much more.

The default ``KeyboardInputViewController`` behavior is to setup an English ``SystemKeyboard`` keyboard. This is all the code that is required to achieve that:

```swift
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {}
```

The controller will then call ``KeyboardInputViewController/viewWillSetupKeyboard()`` when the keyboard view should be created or updated. You can override this function and call ``KeyboardInputViewController/setup(with:)`` to customize the default view or set up a completely custom one.

Since KeyboardKit uses plain SwiftUI, you can use any custom SwiftUI view hierarchy as your keyboard view. 

For instance, here we replace the standard autocomplete toolbar with a custom toolbar:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            VStack(spacing: 0) {
                MyCustomToolbar()
                SystemKeyboard(
                    controller: controller,
                    autocompleteToolbar: .none
                )
            }
        }
    }
}
```

and here we use a completely custom view that requires the app-specific controller type:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { [unowned self] in
MyKeyboardView(
                controller: self
            )
        }
    }
}
```

When you use a custom view it's *very important* that it has an `unowned` controller reference:

```swift
struct MyKeyboardView: View {

    @unowned var controller: KeyboardViewController 

    var body: some View {
        ... 
    }
}
```

> Important: When you set up a custom view, it's *very* important to use `[unowned self] in`, otherwise the strong `self` reference will cause a memory leak, as well as an `unowned var` within the view! Failing to do so will cause a memory leak. 



## How to use the standard keyboard configuration

``KeyboardInputViewController`` will by default be configured with a bunch of observable properties and services. 

The controller will inject all observable properties into the view hierarchy when you setup KeyboardKit with a view, which means that you can use environment objects to observe the state of these properties.

```swift
struct MyButton: View {

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        Button("Print locale!") {
            print(context.locale.identifier)
        }.disabled(context.keyboardType == .emojis)
    }
}
```

All services are configured with standard implementations when KeyboardKit is started. For instance, ``KeyboardInputViewController/keyboardActionHandler`` is initialized with a ``StandardKeyboardActionHandler``. All services can be replaced with your own custom implementations.


## How to observe keyboard state

You can use `@EnvironmentObject` to access any observable objects that are injected into the view hierarchy, for instance:

```swift
struct MyView: View {

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

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

Environment objects are convenient, but KeyboardKit itself uses init injection to make dependencies more explicit.

There are a bunch of KeyboardKit-specific objects that can provide you with important information, such as ``KeyboardContext``, ``KeyboardCalloutContext``, ``KeyboardTextContext``, ``AutocompleteContext``, etc.



## How to use keyboard services

Unlike contexts, services can't be injected into the view hierarchy and resolved using environment objects. You must instead inject any service you want to use into your types, for instance via the initializer:

```swift
struct MyView: View {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private let actionHandler: KeyboardActionHandler

    var body: some View {
        Button(action: { actionHandler.handle(.release, on: .space) }) {
            Text("Custom space bar")
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}
```

In the example above, the view uses an injected action handler to trigger a "tap on space" action.



## How to customize the standard configuration

You can easily customize the standard configuration by replacing the standard services with your own custom implementations. 

For instance, say that you have a custom keyboard action handler:

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

You should customize your services in ``KeyboardInputViewController/viewDidLoad()`` before any services have been resolved. This way, any inter-dependencies between the services will be properly resolved. 

If you want to configure KeyboardKit at a later state, make sure that the service that you replace isn't used in another service. If so, you must re-create that service as well, to avoid having the old service instance still hanging around.



## Going further

If you followed the example above, you should now have a basic understanding of how to setup KeyboardKit with a custom view, as well as how to use the various keyboard services and observable state and how to customize the standard configuration.

For more information and examples, take a look at the demo apps, which replace many services with demo-specific implementations.  


[Guide]: https://shyngys.com/ios-custom-keyboard-guide
