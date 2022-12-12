# Getting Started

This article discusses how get started using KeyboardKit in your app.

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo apps for examples and inspiration.



## How to use KeyboardKit

You can use KeyboardKit in many different ways:

* Keyboard extensions can use KeyboardKit to create more powerful keyboards.
* Apps can use KeyboardKit to check if a keyboard is enabled, has full access etc.
* Apps can create custom input controllers and use KeyboardKit for the text field.
* Other targets, like widgets can use KeyboardKit to build upon its functionality.

KeyboardKit supports iOS, iPadOS, macOS, tvOS and watchOS, although some functionality is only available on some platforms.



## How to install KeyboardKit

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

or with CocoaPods:

```
pod KeyboardKit
```

You can add the library to the main app, the keyboard extension and any other targets that need it. 



## How to setup KeyboardKit

In your keyboard extension, `import KeyboardKit` then make `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`. 

Inheriting ``KeyboardInputViewController`` gives your controller access to a lot of additional functionality, such as new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable properties like ``KeyboardInputViewController/keyboardContext``, keyboard services like ``KeyboardInputViewController/keyboardActionHandler`` and much more.

Your controller will call ``KeyboardInputViewController/viewWillSetupKeyboard()`` when the keyboard should be created. You can then use ``KeyboardInputViewController/setup(with:)`` to make the keyboard extension use any `SwiftUI` view, for instance:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup(with: MyKeyboardView())
    }
}
```

This will make the view you use the main view of the keyboard extension, which makes the extension size to fit its content. It also injects all observable properties as environment objects into the view hierarchy, to ensure that the view updates whenever they change. 

If you want to create a standard keyboard that imitates the iOS stock keyboard, you can use a ``SystemKeyboard``;

```swift
struct MyKeyboardView: View {
    
    @State
    private var text = "Text"
    
    @EnvironmentObject
    private var autocompleteContext: AutocompleteContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext
    
    var body: some View {
        VStack(spacing: 0) {
            if keyboardContext.keyboardType != .emojis {
                AutocompleteToolbar(
                    suggestions: autocompleteContext.suggestions,
                    locale: keyboardContext.locale
                )
            }
            SystemKeyboard()
        }
    }
}
```

The view above creates a system keyboard with an autocomplete toolbar that only shows when the system keyboard doesn't display an emojis keyboard. The view will automatically update when things change, such as the ``KeyboardContext/keyboardType``.

It's important that the view observes the global ``KeyboardInputViewController/keyboardContext``, either by using the injected environment object or by setting it up as an observed object, otherwise it will be unresponsive to context changes. If your view doesn't react when you change keyboard type, this is most probably the cause.



## How to use the standard keyboard configuration

When you inherit ``KeyboardInputViewController`` and launch your extension, the controller will by default be configured with a bunch of observable properties and services.

All observable properties will be injected into the view hierarchy when you setup KeyboardKit with a view, which means that you can use environment objects to observe the state of these properties.

```swift
struct MyButton: View {

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        Button("Insert banana!") {
            context.textDocumentProxy.insertText("Banana!")
        }.disabled(context.keyboardType == .emojis)
    }
}
```

All services will be configured with standard implementations when KeyboardKit is started. For instance, ``KeyboardInputViewController/keyboardActionHandler`` is initialized with a ``StandardKeyboardActionHandler``. All services can be replaced with your own custom implementations.


## How to observe changes

To access observable objects that are injected into the view hierarchy, you can use `@EnvironmentObject`, for instance:

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

You can use any of these options as you see fit. Environment objects are convenient, but KeyboardKit itself uses init injection, since it makes dependencies more explicit.

There are a bunch of KeyboardKit-specific environment objects that can provide you with important information, such as ``KeyboardContext``, ``AutocompleteContext``, ``InputCalloutContext`` etc.



## How to use keyboard services

Unlike contexts, services can't be injected into the view hierarchy and resolved using environment objects. You must instead inject any services you want to use into your types, for instance via the initializer:

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
