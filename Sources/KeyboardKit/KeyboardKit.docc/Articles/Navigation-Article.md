# Navigation

This article describes the KeyboardKit navigation engine.

Keyboard extensions may sometimes have to open a URL or trigger a deep link, for instance to open the main app or System Settings.

Keyboard extensions can however not access **UIApplication.shared**, which means that you have to jump through hoops to open URLs.

KeyboardKit therefore provides alternate ways to open URLs from a keyboard extension, without using **UIApplication.shared**.



## How to open URLs from a keyboard extension

One way to open a URL from a keyboard extension, is to use the ``KeyboardInputViewController/openUrl(_:)``, which opens the provided URL without using the application.

If you don't want to depend on the controller (which can cause leaks), a better way is to trigger a ``KeyboardAction/url(_:id:)`` action and let the ``KeyboardInputViewController/services`` action handler handle it.

The ``KeyboardAction`` approach removes any need to refer to the controller and lets you customize the URL handling with a custom action handler, if needed.



## How to open System Settings

KeyboardKit has a **URL.keyboardSettings** URL extension that can be used to open your app's keyboard settings in System Settings.

If your keyboard randomly navigates to the System Settings root instead of your app, try adding an empty settings bundle to your app. 



## How to navigate back to the keyboard from the app

[KeyboardKit Pro][Pro] used to have a **PreviousAppNavigator** that could be used to navigate back to the keyboard (in the previously open app) from the main app. 

This was used to e.g. take the user back to the keyboard when dictation finished in the app.

However, the first implementation, which is also used by apps like Gboard, stopped working in iOS 17, leaving dictation stuck in the main app.

To fix this, KeyboardKit 8 added a new implementation, that used **LSApplicationWorkspace** to rather open the bundle ID of the previous app. This fix was however rejected by Apple.

At the time of writing, there is therefore *no way* to navigate back to the keyboard from the main app. If you find a way that doesn't get rejected by Apple, feel free to share it.

If you want to take a risk at adding the rejected code, here are two implementations that you can add **at your own risk**. 

Since the lack of back navigation gives a bad user experience, please use the Apple Feedback Assistant to request a native way to achieve this navigation.


### Option 1 - Using LSApplicationWorkspace

The following code uses **LSApplicationWorkspace** to navigate "forward" to any bundle ID.

```swift
func openPreviousApplication() {
    guard let obj = objc_getClass("LSApplicationWorkspace") as? NSObject else { return false }
    let workspace = obj.perform(Selector(("defaultWorkspace")))?.takeUnretainedValue() as? NSObject
    guard let workspace else { return }
    let selector = Selector(("openApplicationWithBundleID:"))
    let bundleId = previousApplicationBundleId
    _ = workspace.perform(selector, with: bundleId)
}
```

The code works in iOS 17, but will most probably be rejected by the App Store review process.


### Option 2 - Resolving UIApplication.shared

This code tries to resolve **UIApplication.shared** to perform a back navigation.

```swift
func openPreviousApplication() {
    let sysNavIvar = class_getInstanceVariable(UIApplication.self, variableId),
    let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
    _ = action.perform(#selector(getter: PrivateSelectors.destinations)).takeUnretainedValue() as? [NSNumber],
}
```

This code works in iOS 16, but doesn't work in iOS 17, and will also most probably be rejected.




[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
