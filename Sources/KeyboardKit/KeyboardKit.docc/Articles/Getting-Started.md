# Getting Started

This article describes how to get started with KeyboardKit.

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

KeyboardKit Pro is setup differently in an app, a keyboard extension, and as a package dependency.


### How to setup KeyboardKit in a keyboard extension

The most common use-case is to use KeyboardKit Pro in a keyboard extension.

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable ``KeyboardInputViewController/state``, ``KeyboardInputViewController/services``, and much more.

KeyboardKit will by default use a standard ``SystemKeyboard`` as the main keyboard view. To customize or replace this standard view, just override **viewWillSetupKeyboard()** and call any **setup** function with a custom view:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in MyCustomToolbar() }
            )
        }
    }
}
```

The setup view builder provides you with an **unowned** controller reference, to help avoiding memory leaks. Use it to access state and services, and avoid passing it around. If you do, make sure to keep any references to it unowned.

Read more about how to customize the system keyboard in <doc:Essentials>. 


### How to setup KeyboardKit in an app

You can use KeyboardKit in an app, to provide keyboard settings, show keyboard state, link to system settings, etc.

You don't have to configure KeyboardKit in any way, just `import KeyboardKit` in any file where you want to use it.  


### How to setup KeyboardKit as a package dependency

To use KeyboardKit as a package dependency, just add it to the package dependencies and link it to any target that needs it.



## How to use the standard keyboard configuration

``KeyboardInputViewController`` will by default be configured with ``KeyboardInputViewController/services`` and observable ``KeyboardInputViewController/state``.

KeyboardKit will inject all state as environment objects into the view hierarchy, to let you access them like this:

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

KeyboardKit itself uses init parameters to clearly communicate the dependencies of every view in the library.



## How to customize the standard configuration

You can easily customize the standard configuration by replacing any of the standard services with a custom implementations. 

For instance, here we replace the default keyboard action handler with a custom one:

```swift
class CustomActionHandler: StandardActionHandler {

    open override func handle(
        _ gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) {
        // Wow, what a useless action handler! 
    }
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

Since service instances are lazy, you should customize them as early as possible to make sure that all other services link to your custom types. 



## Going further

You should now have a basic understanding of how to set up KeyboardKit, how to use the various services and state and how to customize the standard configuration.

For more information and examples, see the various articles and take a look at the demo apps, which replace many services with demo-specific implementations.
