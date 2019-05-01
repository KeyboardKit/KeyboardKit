# Release Notes


## 2.0.0

This version aim at streamlining the library and remove or refactor parts that make it hard to maintain. It contains several breaking changes, but I hope that the changes will make it easier for you as well, as the library moves forward.

Most notably, the view controller inheritance model has been completely removed. Instead, there is only one `KeyboardInputViewController`, which you should use instead of `UIInputViewController`. It has a stack view, to which you can add any views you like, like the built-in `KeyboardButtonRow` and `KeyboardCollectionView`.

All keyboard action handling has also been moved from the view controllers to a new `KeyboardActionHandler`, using the new `keyboardActionHandler` property. All view controllers use a `StandardActionHandler` by default, but you can replace this at any time by setting the `keyboardActionHandler` property to a new handler.

New `KeyboardAction` types have been added - `moveCursorBack`, `moveCursorForward` and `dismissKeyboard`. `nextKeyboard` has been renamed to `switchKeyboard`. Action equality logic has also been removed, so instead of `isNone`, you should use `== .none` from now on.  All help properties like `image` and `imageName` are removed as well, since they belong in the app.

Since the height of the extension automatically changes depending on the constraints of its views, the old `setHeight(to:)` function has been removed. Instead, `KeyboardInputViewController` will resize the extension to the size of the stack view.


## 1.0.0

This version upgrades `KeyboardKit` to Swift 5 and has many breaking changes:

 * `KeyboardInputViewController` has been renamed to `KeyboardViewController`
 * `CollectionKeyboardInputViewController` has been renamed to `CollectionKeyboardViewController`
 * `GridKeyboardInputViewController` has been renamed to `GridKeyboardViewController`
 * `KeyboardAlerter` has been renamed to `KeyboardAlert`
 * `ToastAlerter` has been renamed to `ToastAlert`
 * `ToastAlert` now has two nested view classes `View` and `Label`
 * `ToastAlert`'s two style function has changed signature
 * `ToastAlerterAppearance` is now an internal `ToastAlert.Appearance` struct
 * Most extensions have been made internal, to avoid exposing them externally


## 0.8.0

`Keyboard` has been given an optional ID, which can be used to uniquely identify a keyboard. This makes it easier to manage multiple keyboards in an app.

`KeyboardInputViewController` implements the `KeyboardPresenter` protocol, which means that you can set the new optional `id` property to make a `KeyboardSetting` exclusive to that presenter. This is nice if your app has multiple keyboards. If you do not specify an id, the settings behave just like before.

A PR by [micazeve](https://github.com/micazeve) is merged. It limits the current page index that is persisted for a keyboard, to avoid bugs if the page count has changed since persisting the value.


## 0.7.1

This version updates KeyboardKit to `Swift 4.2` and makes it ready for Xcode 10.


## 0.7.0

The grid keyboard view controller uses a new way to calculate the available item space and item size for a certain number of rows and buttons per row. This means that we can now use top and bottom content insets to create vertical margins for grid-based keyboards.


## 0.6.2

I previously used the async image functions to quickly setup a lot of images for "emoji" keyboards. Since I didn't use a collection view for emoji keyboards then, all image views were created at the same time, which caused rendering delays. By using the async image approach, image loading was moved from the main thread and allowed individual images to appear when they were loaded instead of waiting for all images to load before any image could be displayed.

However, `KeyboardKit` now has collection view-based keyboards, which are better suited for the task above, since they only render the cells they need. This will solve the image loading issues, which means that the async image extensions will no longer be needed. I have therefore removed `UIImage+Async` and the `Threading` folder from the library, to keep it as small as possible.


## 0.6.1

No functional changes, just README updates and improvements. The version bump is required to give CocoaPod users the latest docs.


## 0.6.0

This is a complete rewrite of the entire library. KeyboardKit now targets iOS 11 and the code has been improved a lot. Check out the demo app to see how to setup keyboards from now on.
