# Navigation

This article describes the KeyboardKit navigation engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

A custom keyboard extension may sometimes have to open URLs or trigger deep links, for instance to open the app or System Settings.

Keyboard extensions can however not access **UIApplication.shared**, which means that you have to jump through hoops to open URLs.

KeyboardKit therefore provides ways to open URLs from a keyboard extension, without using **UIApplication.shared**.



## How to open URLs from a keyboard extension

One way to open a URL from a keyboard, is to use the controller's ``KeyboardInputViewController/openUrl(_:)``.

A better way is to trigger a ``KeyboardAction/url(_:id:)`` action and let the ``KeyboardActionHandler`` in ``KeyboardInputViewController/services`` handle it. This lets us avoid having to depend on the controller, which can lead to memory leaks. 



## How to open System Settings

KeyboardKit defines a ``Foundation/URL/systemSettings`` URL, which can be used to open your app in System Settings.

If your keyboard randomly navigates to the System Settings root instead of your app, try to add an empty settings bundle to your app. 



## How to navigate back to the keyboard from the app

[KeyboardKit Pro][Pro] used to have a **PreviousAppNavigator** that could navigate back to the keyboard (in the previously open app) from the main app. This was for instance used to navigate back to the keyboard after performing dictation in the app.

The first implementation (which is also used by apps like Gboard) stopped working in iOS 17, leaving dictation stuck in the main app. To fix this, KeyboardKit 8 added a new navigator that used **LSApplicationWorkspace** to open the bundle ID of the previous app. 

The fix was however rejected by Apple, and had to be removed from KeyboardKit. As such, there is therefore *no way* to navigate back to the keyboard from the main app. If you find a way that doesn't get rejected by Apple, feel free to share it. 

Since the lack of back navigation results in a bad user experience, for instance when opening the app to perform a quick action,  please use the Apple Feedback Assistant to ask Apple to provide a native way to achieve this.

### Sample Code

If you want to take a risk at adding the rejected code to your app, here is the code for the two navigators. **Use them at your own risk!**


#### Option 1 - Using LSApplicationWorkspace

The following code works in iOS 17, and uses **LSApplicationWorkspace** to navigate "forward" to any bundle ID.

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


#### Option 2 - Resolving UIApplication.shared

This code tries to resolve **UIApplication.shared** to perform a back navigation, in a way that works in iOS 16 and earlier.

```swift
func openPreviousApplication() {
    let sysNavIvar = class_getInstanceVariable(UIApplication.self, variableId),
    let action = object_getIvar(UIApplication.shared, sysNavIvar) as? NSObject,
    _ = action.perform(#selector(getter: PrivateSelectors.destinations)).takeUnretainedValue() as? [NSNumber],
}
```


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro   
