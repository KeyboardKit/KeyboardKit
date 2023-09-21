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

You can add KeyboardKit to the main app, the keyboard extension and any targets that need it. 



## How to setup KeyboardKit

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to additional functionality, such as new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable state like ``KeyboardInputViewController/keyboardContext``, services like ``KeyboardInputViewController/keyboardActionHandler`` and much more.

The default ``KeyboardInputViewController`` behavior is to setup an English ``SystemKeyboard``. It will then call ``KeyboardInputViewController/viewWillSetupKeyboard()`` when the keyboard view should be created or updated. 

To set up KeyboardKit with a custom view, you can override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call `.setup(with:)` to customize the `SystemKeyboard` or use a custom view:

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

Here, we use a completely custom view that requires a controller reference:

```swift
struct CustomKeyboard: View {

    unowned var controller: KeyboardViewController 

    var body: some View {
        ... 
    }
}

class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            CustomKeyboard(controller: controller)
        }
    }
}
```

The view builder provides an unowned controller reference to avoid reference cycles and memory leaks.

> Important: It's important to never use `controller: self` and to mark `controller` properties as `unowned`, otherwise the strong controller reference will cause a memory leak. 



## How to use the standard keyboard configuration

``KeyboardInputViewController`` will by default be configured with a bunch of service instances and observable state.

For instance, ``KeyboardInputViewController/keyboardActionHandler`` is set to a ``StandardKeyboardActionHandler``, ``KeyboardInputViewController/calloutActionProvider`` to a ``StandardCalloutActionProvider``, etc. 

The controller also has many observable state properties, such as ``KeyboardInputViewController/keyboardContext``, ``KeyboardInputViewController/autocompleteContext``, ``KeyboardInputViewController/calloutContext``, etc.

The various services can then be passed into any views that need them, and any observable state accessed as environment objects:

```swift
struct CustomKeyboard: View {

    let actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        VStack {
            Text("Space only keyboard")
            Button {
                actionHandler.handle(.space)
            } label: {
                Text("My cool space only keyboard")
            }
        }
    }
}
```

Environment objects are convenient, but the views in the library use init parameters to clearly communicate their dependencies.



## How to customize the standard configuration

You can easily customize the standard configuration by replacing any of the standard services with a custom implementations. 

For instance, here we replace the default keyboard action handler with a custom one:

```swift
class CustomActionHandler: StandardActionHandler {

    open override func canHandle(_ gesture: KeyboardGesture, on action: KeyboardAction) -> Bool {
        false   // Wow, what a useless action handler! 
    }
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

Since service instances are lazy, you should customize them as early as possible to make sure that all parts of the keyboard use the correct service type. 



## Going further

You should now have a basic understanding of how to set up KeyboardKit, how to use the various services and state types and how to customize the standard configuration.

For more information and examples, see the various articles and take a look at the demo apps, which replace many services with demo-specific implementations.  


[Guide]: https://shyngys.com/ios-custom-keyboard-guide
