# Getting started

Once KeyboardKit is installed, you can start using it in your application.



## How to use KeyboardKit

You can use KeyboardKit in different ways in your various app targets:

* Keyboard extensions can use KeyboardKit to create more powerful keyboards.
* Main apps can use KeyboardKit to check if a keyboard is enabled, has full access etc.
* Main apps can create KeyboardKit-based input controllers and use them for its text fields.
* Other targets can use KeyboardKit to build upon its functionality.

Other platforms, such as macOS, watchOS and tvOS can use KeyboardKit as well, even though creating custom keyboards on those platforms may not be the most common use-case. 



## How to setup KeyboardKit

In your extension, let `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`. This gives it access to additional functionality like new lifecycle functions, properties like `keyboardContext`, services like `keyboardActionHandler` etc.

The controller will call `viewWillSetupKeyboard()` when the keyboard should be created or re-created. You can use `setup(with:)` to setup KeyboardKit with any `SwiftUI` view:

```swift
func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()
    setup(with: MyKeyboardView())
}
```

This will make the provided view the main view of the keyboard extension, and cause the extension to resize to fit the view content. It will also inject all observable controller properties as environment objects into the view hierarchy. 

It's important that the view you use observes the global `keyboardContext`, either by using the injected environment object or by setting it up as an observed object, otherwise it will be unresponsive to context changes. If your view doesn't react when you tap the shift or numeric key, that is most probably the cause. 


## Going further

If you followed the example above, you should now have a keyboard that observes the keyboard context and automatically does a bunch of things right out of the box. 

Have a look in the documentation for more articles on how to configure KeyboardKit, create your own service implementations etc. You can also have a look at the demo apps, which replace many services with demo-specific implementations.  
