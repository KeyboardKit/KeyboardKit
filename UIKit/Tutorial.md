# UIKit Tutorial

If you're new to KeyboardKit, this short tutorial can help you get started with UIKit-based keyboard extensions.


## Step 1 - Create an iOS app

First create a new iOS app project, if you haven't got one already.


## Step 2 - Add a keyboard extension

Now add a new keyboard extension target to your app:

* Under `File/New` select `Target...`.
* Add a new `Custom Keyboard Extension` target to the app.
* Configure the extension's display name.
* Make sure the extension has the same bundle id prefix as the main app.
* Make sure the extension has the same version number as the main app.
* If your extension needs full access, add `RequestsOpenAccess` `YES` to your extension's `Info.plist` extension attributes section.

You can configure the app and extension in any way that fits your needs.

KeyboardKit only requires full access for some features, like haptic and audio feedback, but those are optional.


## Step 3 - Add KeyboardKit to the extension

Now let's add `KeyboardKit` to the extension, using Swift Package Manager: 

* Select your project in the app navigator.
* Under `Project/Swift Packages` search for `KeyboardKit` and add the latest version.
* When prompted about which target to add it to, choose the keyboard extension.
* You can add the `KeyboardKit` dependency to your main app as well, but that's not needed.

You can also use CocoaPods to add KeyboardKit to your app. See the main [README][Readme] for more info.


## Step 4 - Setup your extension

You are now ready to ue KeyboardKit to create your keyboard extension.

* First, make `KeyboardViewController` inherit `KeyboardInputViewController` instead of `UIInputViewController`.
* This gives your view controller access to a lot of additional functionality.
* For instance, the vertical `keyboardStackView` is added to the view hierarchy when you use it for the first time.
* Adding views to `keyboardStackView` will cause the extension's size to change to fit the stack view's content.

You can now add your own views or any KeyboardKit views to build a keyboard extension that automatically changes it's size depending on its content.


## Step 5 - Get information, trigger actions etc.

When you inherit `KeyboardInputViewController`, you get access to a lot of other information as well. 

* The view controller has a `keyboardContext` that implements `KeyboardContext` and provides you with a lot of information.
* The view controller has a `keyboardActionHandler`, which you can use to handle keyboard actions.
* The view controller has a bunch  `keyboardActionHandler`, which you can use to handle keyboard actions.
* You can call `actionHandler` programatically or with any button, to handle any keyboard actions you like.
* You can subclass `StandardKeyboardActionHandler` or implement `KeyboardActionHandler` to create your own action handler.
* You can change the context's `actionHandler` to change the global action handler.
* For any view that inherits `KeyboardButton`, you can use your `controller`'s `addKeyboardGestures(to:)` to add the proper keyboard gestures to the button. 

Check the documentation and demo apps for more information and examples.


[Readme]: https://github.com/danielsaidi/KeyboardKit/blob/master/README.md
[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/UIKit/README.md
