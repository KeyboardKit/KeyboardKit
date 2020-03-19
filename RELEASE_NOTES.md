# Release Notes


## 2.7.0

This version adds the very first (and so far limited) support for `SwiftUI`. Many new features are iOS 13-specific.

This version also deprecates a bunch of action handling logic and adds new functions that doesn't rely on `UIView`.


### New features

* `KeyboardInputViewController` has a new `setupNextKeyboardButton(...)` which turns any `UIButton` into a system-handled "next keyboard" button.
* `NextKeyboardUIButton` makes use of this new functionality, and sets itself up with a `globe` icon as well.
* `PhotoImageService` and `StandardPhotoImageService` can be used to save images to photos with a completion instead of a target and a selector.
* `KeyboardImageActions` makes it easy to create a bunch of `.image` actions from a set of image names.
* `KeyboardActionHandler` has a new `open handle(_ gesture:on:view:)`  which is already implemented in `StandardKeyboardActionHandler`.

* The global `isKeyboardEnabled` function can be used to check if a certain keyboard extension is enabled or not.
* The `keyboardSettings` `URL` extension is a convenience extension for finding the url to application settings.
* The `evened(for gridSize: Int)` `[KeyboardAction]` extension appends enough `.none` actions to evenly fit the grid size.
* The `saveToPhotos(completion:)` `UIImage` extension is a completion-based way of saving images to photos.

### SwiftUI

There are some new views that can be used in SwiftUI-based apps and keyboard extensions:

* `KeyboardGrid` distributes actions evenly within a grid.
* `KeyboardGridRow` is used for each row in the grid.
* `KeyboardHostingController` can be used to wrap any `View` in a keyboard extension.
* `KeyboardImageButton` view lets you show an `.image` action or `Image` in a `Button`.
* `NextKeyboardButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `PersistedKeyboardSetting` is a new property wrapper for persisting settings in `UserDefaults`. 

* `Color.clearInteractable` can be used instead of `.clear` to allow gestures to be detected.
* `Image.globe` returns the icon that is used for "next keyboard".
* `KeyboardInputViewController` `setup(with:View)`  sets up a `KeyboardHostingController`.
* `View` `withClearInteractableBackground()` can be used to make an entire view interactable.

All SwiftUI-related functionality is placed in the `SwiftUI` folder.

### UIKit

There are some new UIKit features and extensions:

* `NextKeyboardUIButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `UIImage.globe` returns the icon that is used for "next keyboard".

All UIKit-specific functionality is placed in the `UIKit` folder. UIKit logic that can be used in SwiftUI is outside it.

### Changes:

* `isInputAction` now includes `.space`.
* `isSystemAction` no longer includes `.space`.

### Deprecations

* `UIColor.clearTappable` has been renamed to `UIColor.clearInteractable`.
* `KeyboardActionHandler` has deprecated the gesture-explicit handle functions.
* `KeyboardActionHandler` has deprecated the view-explicit handle function in favor of an optional `Any` sender variant.
* `StandardKeyboardActionHandler` has deprecated a bunch of `UIView`-explicit functions in favor of an optional `Any` sender variant.


## 2.6.2

This version fixes a [bug](https://github.com/danielsaidi/KeyboardKit/issues/60), where `moveCursorForward` moved the cursor incorrectly.


## 2.6.1

This version adds `enableScrolling()` and `disableScrolling()` to `AutocompleteToolbar`. This makes it possible to make the entire toolbar scroll if its content doesn't fit the screen.


## 2.6.0

This version adds more autocomplete functionality:

* `AutocompleteToolbar` has a new convenience initializer that makes it even easier to setup autocomplete.
* `AutocompleteToolbarLabel` is the default autocomplete item view and can be tapped to send text to the text document proxy.
* `AutocompleteToolbarLabel` behaves like the native iOS autocomplete view and displays centered text until the text must scroll.
* Autocomplete no longer requires the bugfix timer. Instead, just let the action handler request autocomplete suggestions when a tap action is triggered.

The `StandardKeyboardActionHandler` has new functionality:
* `animationButtonTap()` - can be overridden to change the default animation of tapped buttons.

Deprecations:
* The `AutocompleteBugFixTimer` and all timer-related logic has been deprecated.
* The `AutoCompleteSuggestionProvider`'s `provideAutocompleteSuggestions(for:completion:)` is deprecated and replaced with `autocompleteSuggestions(for:completion:)`.
* The `StandardKeyboardActionHandler`'s `handleXXX(on:)` are now deprecated and replaced with `handle(:on:view:)`. 


## 2.5.0

This version adds a bunch of features, tweaks some behaviors and deprecates some logic:

New stuff:
* There is a new `KeyboardActionGesture` that will be used to streamline the action handling api:s.
* There is a new `AudioFeedback` enum that describes various types of audio feedback.
* There is a new `AudioFeedbackConfiguration` that lets you gather all configurations in one place.
* There is a new `HapticFeedback.standardFeedback(for:)` function that replaces the old specific properties.
* There is a new `HapticFeedbackConfiguration`  that lets you gather all configurations in one place.
* There is a new `StandardKeyboardActionHandler` init that uses this new configuration.
* There is a new `StandardKeyboardActionHandler.triggerAudioFeedback(for:)` that can be used to trigger audio feedback.
* There is a new `StandardKeyboardActionHandler.triggerHapticFeedback(for:on:)` that replaces the old gesture-specific ones.
* There is a new `StandardKeyboardActionHandler.gestureAction(for:)` function that is used by the implementation. The old ones are still around.
* There is a new `KeyboardType.images` case that is used by the demo.

Changed behavior:
* There is a new `standardButtonShadow` `Shadow` property that can be used to mimic the native button shadow.

Deprecated stuff:
* The old `StandardKeyboardActionHandler.init(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForLongPress(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForRepeat(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForTap(...)` is deprecated, use the new one.
* The old `HapticFeedback.standardTapFeedback` and `standardLongPressFeedback` have been replaced by the new function.

The old `handle` functions are still declared in the `KeyboardActionHandler` protocol, but will be removed in the next major version. 


## 2.4.0

This version adds Xcode 11 and iOS 13 support, including support for dark mode and high contrast color variants.


## 2.3.0

This version adds autocomplete support, which includes an autocomplete suggestion provider protocol, a new toolbar and new extensions.

The new `AutocompleteSuggestionProvider` protocol describes how to provide your keyboard with autocomplete suggestions. You can implement it in any way you like, e.g. to use a built-in suggestion database or by connecting to an external data source, using network requests. Note that the network option will be a lot slower and also require you to request full access from your users.

The new `AutocompleteToolbar` is a toolbar that can display any results you receive from your suggestion provider (or any list of strings for that matter). Just trigger the provider anytíme the text changes and route the result to the toolbar. The toolbar can be populated with any kind of views. Have a look at the demo app for an example.

The new `UITextDocumentProxy+CurrentWord` extension helps you get the word that is (most probably) being typed. You could use this when requesting autocomplete suggestions, if you only want to autocomplete the current word.

Besides these additions, there are a bunch of new extensions, like `UITextDocumentProxy` `deleteBackwards(times:)`, which lets you delete a certain number of characters. Have a look at the `Extensions` namespace for a complete list.

There is also a new `KeyboardShiftState` enum that you can use to keep track of which state your keyboard has, if any. This enum is extracted from demo app code that was provided by @arampak earlier this year. 

 **IMPORTANT** iOS has a bug that causes `textWillChange` and `textDidChange` to not be called when the user types, only when the cursor moves. This causes autocomplete problems, since the current word is not changing as the user types. Due to this, the input view controller must use an ugly hack to force the text document proxy to update. Have a look at the demo app to see how this is done.


## 2.2.1

This version solves some major bugs in the repeating gesture recognizer and makes some `public` parts of the library `open`.

The standard action handler now handles repeating actions for backspace. You can customize this in the same way as you customize tap and long press handling.

You can test the new repeating logic in the demo app.


## 2.2.0

This version adds more keyboard actions that don't exist in iOS, but that may serve a functional or semantical purpose in your apps:

* `command`
* `custom(name:)`
* `escape`
* `function`
* `option`
* `tab`

The new `custom` action is a fallback that you can use if the existing action set is insufficient for your specific app.

I have added a `RepeatingGestureRecognizer` and an extension that you can use to apply it as well. It has a custom initial delay as well as a custom repeat interval, that will let you tap and hold a button to repeat its action. In the next update, I will apply this to the backspace and arrow buttons.

Thanks to [@arampak](https://github.com/arampak), the demo app now handles shift state and long press better, to make the overall experience much nicer and close to the native keyboard. The keyboard buttons also registers tap events over the entire button area, not just the button view.


## 2.1.0

This version makes a bunch of previously internal extensions public. It also adds a lot more unit tests so that almost all parts of the library are tested.

The default tap animation has been configured to allow user interaction, which reduces the frustrating tap lag that was present in 2.0.0.

I have added a `KeyboardToolbar` class, which you can use to create toolbars. It's super simple so far, and only creates a stack view to which you can any views you like.


## 2.0.1

This version adds a public shadow extension to the main library and shuffles classes and extensions around. It also restructures the example project to make it less cluttered.

I noticed that the build number bump still (and randomly) bumps the build number incorrectly, which causes build errors. I have therefore abandoned this approach, and instead fixes the build number to 1 in all targets.


## 2.0.0

This version aim at streamlining the library and remove or refactor parts that make it hard to maintain. It contains several breaking changes, but I hope that the changes will make it easier for you as well, as the library moves forward.

Most notably, the view controller inheritance model has been completely removed. Instead, there is only one `KeyboardInputViewController`. It has a stack view to which you can add any views you like, like the built-in `KeyboardButtonRow` and `KeyboardCollectionView`, which means that your custom keyboards is now based on components that you can combine.

Since `KeyboardInputViewController` therefore can display multiple keyboards at once, it doesn't make any sense to have a single `keyboard` property. You can still use structs to organize your actions (in fact, I recommend it - have a look at the demo app), but you don't have to.

All action handling has been moved from the view controller to `KeyboardActionHandler` as well. `KeyboardInputViewController` use a `StandardActionHandler` by default, but you can replace this by setting `keyboardActionHandler` to any `KeyboardActionHandler`. This is required if you want to use certain actions types, like `.image`.

New `KeyboardAction`s are added and `nextKeyboard` has been renamed to `switchKeyboard`. Action equality logic has also been removed, so instead of `isNone`, you should use `== .none` from now on. All help properties like `image` and `imageName` are removed as well, since they belong in the app. These are the new action types

* capsLock
* dismissKeyboard
* moveCursorBackward
* moveCursorForward
* shift
* shiftDown
* switchToKeyboard(type)

`KeyboardInputViewController` will now resize the extension to the size of the stack view, or any other size constraints you may set. The old `setHeight(to:)` function has therefore been removed.


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
