# Getting started

This article discusses how to install KeyboardKit and get started using it in your app.


## Installation

The best way to install KeyboardKit is with the Swift Package Manager.

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add KeyboardKit to the main app, the keyboard extension and any other targets that needs it.



## How to use KeyboardKit

You can use KeyboardKit in different ways in your iOS app targets:

* Keyboard extensions can use KeyboardKit to create more powerful keyboards.
* Main apps can use KeyboardKit to check if a keyboard is enabled, has full access etc.
* Main apps can create KeyboardKit-based input controllers and use them for its text fields.
* Other targets can use KeyboardKit to build upon its functionality.

Other platforms, such as macOS, watchOS and tvOS can use KeyboardKit as well, even though creating custom keyboards on those platforms may not be the most common use-case. 



## How to setup KeyboardKit

In your keyboard extension, let `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`. This will give it access to a lot of additional functionality, like new lifecycle functions, observable properties like ``KeyboardInputViewController/keyboardContext``, services like ``KeyboardInputViewController/keyboardActionHandler`` and much more.

The controller will call `viewWillSetupKeyboard` when the keyboard should be created or re-created. You can use ``KeyboardInputViewController/setup(with:)`` to setup your extension with any `SwiftUI` view:

```swift
func viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()
    setup(with: MyKeyboardView())
}
```

This will inject a bunch of environment objects into the view hierarchy and setup the extension to resize itself after the size of the provided view. 

It's important that the view you use observes the global ``KeyboardContext``, either with an environment object:

```swift
struct MyKeyboardView: View {

    @EnvironmentObject private var context: KeyboardContext

    var body: some View {
        SystemKeyboard()
    }
}
```

or by observing an init-injected context:

```swift
struct MyKeyboardView: View {
    
    init(context: KeyboardContext) {
       _context = ObservedObject(wrappedValue: context)
    }
    
    @ObservedObject private var context: KeyboardContext
    
    var body: some View {
        SystemKeyboard()
    }
}
```

If the view doens't observe the keyboard context, it will be unresponsive to context changes. If your view doesn't react when you tap the shift or numeric key, that is most probably the cause. 

Once your keyboard is created, KeyboardKit will observe context changes to automatically update the keyboard, e.g. when the keyboard type changes.
