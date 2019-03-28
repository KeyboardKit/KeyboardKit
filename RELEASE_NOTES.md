# Release Notes


## 1.0.0

This version upgrades `KeyboardKit` to Swift 5 and has some breaking changes:

* `KeyboardInputViewController` has been renamed to `KeyboardViewController`
* `CollectionKeyboardInputViewController` has been renamed to `CollectionKeyboardViewController`
* `GridKeyboardInputViewController` has been renamed to `GridKeyboardViewController`
* `KeyboardAlerter` has been renamed to `KeyboardAlert`
* `ToastAlerter` has been renamed to `ToastAlert`
* `ToastAlert` now has two nested view classes `View` and `Label`
* `ToastAlert`'s two style function has changed signature
* `ToastAlerterAppearance` is now an internal `ToastAlert.Appearance` struct


## 0.8.0

`Keyboard` has been given an optional ID, which can be used to uniquely identify
a keyboard. This makes it easier to manage multiple keyboards in an app.

`KeyboardInputViewController` implements the `KeyboardPresenter` protocol, which
means that you can set the new optional `id` property to make a `KeyboardSetting`
exclusive to that presenter. This is nice if your app has multiple keyboards. If
you do not specify an id, the settings behave just like before.

A PR by [micazeve](https://github.com/micazeve) is merged. It limits the current
page index that is persisted for a keyboard, to avoid bugs if the page count has
changed since persisting the value.


## 0.7.1

This version updates KeyboardKit to `Swift 4.2` and makes it ready for Xcode 10.


## 0.7.0

The grid keyboard view controller uses a new way to calculate the available item
space and item size for a certain number of rows and buttons per row. This means
that we can now use top and bottom content insets to create vertical margins for
grid-based keyboards.


## 0.6.2

I previously used the async image functions to quickly setup a lot of images for
"emoji" keyboards. Since I didn't use a collection view for emoji keyboards then,
all image views were created at the same time, which caused rendering delays. By
using the async image approach, image loading was moved from the main thread and
allowed individual images to appear when they were loaded instead of waiting for
all images to load before any image could be displayed.

However, `KeyboardKit` now has collection view-based keyboards, which are better
suited for the task above, since they only render the cells they need. This will
solve the image loading issues, which means that the async image extensions will
no longer be needed. I have therefore removed `UIImage+Async` and the `Threading`
folder from the library, to keep it as small as possible.


## 0.6.1

No functional changes, just README updates and improvements. The version bump is
required to give CocoaPod users the latest docs.


## 0.6.0

This is a complete rewrite of the entire library. KeyboardKit now targets iOS 11
and the code has been improved a lot. Check out the demo app to see how to setup
keyboards from now on.
