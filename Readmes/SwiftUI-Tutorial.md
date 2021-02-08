# SwiftUI Tutorial

If you're new to KeyboardKit, this short tutorial can help you get started with [SwiftUI][SwiftUI]-based keyboard extensions.


## Step 1 - Create an app with a custom keyboard extension

First, create a new project with a keyboard extension, if you haven't got one already:

* Create new app project.
* Add a new `Custom Keyboard Extension` target to the app.
* If your extension needs full access, add `RequestsOpenAccess` `YES` to your extension's `Info.plist` under `NSExtension/NSExtensionAttributes`

You can configure the app and extension in any way that fits your needs. KeyboardKit only requires full access for some features, like haptic and audio feedback, but those are optional.


## Step 2 - Add KeyboardKit to the extension

With the custom keyboard extension setup, let's add `KeyboardKit` to it using Swift Package Manager: 

* Select your project in the app navigator.
* Under `Project/Swift Packages` search for `KeyboardKit` and add the latest version.
* When prompted about which target to add it to, choose your custom keyboard extension.
* You can add the `KeyboardKit` dependency to your main app as well, but that's not needed.

Note that you can also use CocoaPods to add KeyboardKit to your app.


## Step 3 - Setup your extension

You are now ready to use KeyboardKit to create your keyboard extension.

* First, make `KeyboardViewController` inherit `KeyboardInputViewController` instead of `UIInputViewController`.
* This gives your view controller access to a lot of additional functionality.
* For instance, you can now call `setup(with:)` on the controller to initialize it with any `SwiftUI` view you like.
* The extension will automatically resize itself to fit the provided view.
* The provided view hierarchy will get access to `@EnvironmentObject var context: ObservableKeyboardContext`.
* The provided view hierarchy will get access to `@EnvironmentObject var style: SystemKeyboardStyle`.

You can now add custom views and views provided by KeyboardKit to the provided view, to build a keyboard extension that automatically changes it's size depending on its content.

`IMPORTANT BUG INFORMATION` Note that SwiftUI-based keyboard extensions currently doesn't resize properly when the provided view changes its height after being added to the controller.


## Step 4 - Get information, trigger actions etc.

When you inherit `KeyboardInputViewController`, you get access to a lot of other information as well. 

* The view controller has a `keyboardContext` that and provides you with a lot of information.
* When you use `setup(with:)` to setup the controller with a SwiftUI view, the standard context will be replaced with an `ObservableKeyboardContext`.  
* The view controller has a `keyboardActionHandler` that you can use to handle keyboard actions.
* You can call `keyboardActionHandler` programatically or with any button, to handle any keyboard actions you like.
* You can subclass `StandardKeyboardActionHandler` or implement `KeyboardActionHandler` to create your own action handler.
* You can change the context's `keyboardActionHandler` to change the global action handler.
* You can use the `keyboardGestures` view modifier to add keyboard gestures with custom actions to any view.  

Check the documentation and demo apps for more information and examples.


[SwiftUI]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI.md
