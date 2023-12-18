# Understanding Navigation

This article describes the KeyboardKit navigation engine.

Keyboards sometimes have to open urls, trigger deeplinks or navigate from the keyboard to the main app. This is however hard, since keyboard extensions can't use **UIApplication.main**.

KeyboardKit therefore provides ways to open any URLs from a keyboard extension, without using **UIApplication**.



## How to open URLs from a keyboard extension

Since keyboard extensions mustn't refer to `UIApplication.main`, KeyboardKit has alternate ways to open a URL from a keyboard.

One way is to use ``KeyboardInputViewController``.``KeyboardInputViewController/openUrl(_:)``, which opens URLs without using the application. However, this requires you to refer to the controller, which involves a big risk of introducing memory leaks.

A better way is to just trigger a ``KeyboardAction/url(_:id:)``, and let the ``KeyboardInputViewController/services`` action handler handle the operation. This removes any need to refer to the controller, and also lets you customize the URL handling with a custom action handler if needed.



## 👑 Pro features

[KeyboardKit Pro][Pro] used to have a **PreviousAppNavigator** that could navigate back to the previous app. However, the implementation in KeyboardKit 7 stopped working in iOS 17, and the new implementation in KeyboardKit 8 was rejected by Apple.

At the time of writing, there is no way to navigate back to the keyboard from the main application. If you want to take a risk at adding the rejected code, here are two implementations that you can add **at your own risk**:

This code works in iOS 17, but will most probably be rejected:

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

This code works in iOS 16, but will also most probably be rejected:

```swift
func openPreviousApplication() {
    let sysNavIvar = class_getInstanceVariable(UIApplication.self, variableId),
    let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
    _ = action.perform(#selector(getter: PrivateSelectors.destinations)).takeUnretainedValue() as? [NSNumber],
}
```

Since the lack of back navigation makes for a bad user experience, please use the Apple Feedback Assistant to request a native way to achieve this navigation.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
