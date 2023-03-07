# Release notes

KeyboardKit tries to honor semantic versioning:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes can still occur in minor versions and patches, though, if the alternative is to not be able to release new critical features or fixes.


## Older release notes

Older versions have their release notes listed in the `Release_Notes` folder.



## 7.0.1

KeyboardKit 7.0.1 makes it even easier to setup a keyboard extension, since it will setup a `SystemKeyboard` by default.

### ✨ New features

* `KeyboardInputViewController` has a new `setup` function that provides the controller as an unowned reference.

### 💡 Behavior changes

* `KeyboardInputViewController` `setup` uses a view builder instead of a static view.
* `KeyboardInputViewController` now calls `viewWillSetupKeyboard` in `viewWillAppear` instead of `viewDidLoad`.
* `KeyboardRootView` uses a view builder instead of a static view.

### 🐛 Bug fixes

* `KeyboardInputViewController` now creates the keyboard view later, which makes it respect the safe areas better in landscape.



## 7.0

KeyboardKit 7.0 involves a major rewrite that aims to bring more consistency in naming and structure and to streamline the library to make future development easier. It bumps the platform deployment targets to iOS 14, macOS 11, tvOS 14 and watchOS 7 and removes all previously deprecated code and todos.

### Migrating from KeyboardKit 6

Although KeyboardKit 7.0 aims to introduce as few breaking changes as possible, there are some surface level APIs that will change. Some such changes are the removal of many shared instances and how more dependencies have to be passed in as parameters. If you are using the now removed shared instances, simply inject the instance as initializer or function parameter instead. 

KeyboardKit 7.0 makes the `SystemKeyboard` easier to use, where it now adds an autocomplete toolbar by default to make sure that the callouts has enough space, and to reduce the risk of memory leaks that was previously easy to add by accident when you connected the toolbar to the keyboard input controller's autocomplete function. If your keyboard uses a custom autocomplete toolbar, you must pass in `autocompleteToolbar: none` in the system keyboard initializer.

If you have problems upgrading to `7.0`, first try upgrading to `6.9`. It has a lot of deprecations in place to provide guidance. You may still experience breaking changes after that, but they will be fewer.

### ✨ New features

* `AutocompleteContext` has a new `reset` function.
* `AutocompleteToolbar` is now available on all platforms.
* `EmojiAnalyzer` is a new protocol that merges `EmojiCharacterAnalyzer` and `EmojiStringAnalyzer`. 
* `EmojiCategoryKeyboard` is now available on all platforms.
* `EmojiCategoryKeyboardMenu` is now available on all platforms.
* `EmojiCategoryTitle` is now available on all platforms.
* `EmojiKeyboard` is now available on all platforms.
* `EmojiKeyboardStyle` has new context-based standard functions.
* `ExternalKeyboardContext` is now available on macOS and tvOS as well.
* `GestureButton` is now available on watchOS 7.
* `Image` `.keyboardEmojiSymbol` provides the old emoji keyboard button icon.
* `InterfaceOrientation` has a new `landscape` case.
* `KeyboardAction` gesture actions are now available on all platforms.  
* `KeyboardAction` gesture actions now use a `KeyboardController` instead of a `KeyboardInputViewController`.  
* `KeyboardAppearance` will now apply to `.nextKeyboard` as well. 
* `KeyboardCalloutContext` is a new context that lets lets us pass around a single context for input and action callouts.
* `KeyboardCharacterProvider` is a new protocol that provides keyboard-specific characters.
* `KeyboardController` is a new protocol that lets us decouple actions from the input view controller.
* `KeyboardContext` has a new `keyboardLocale` and new functions for setting locale and keyboard type.
* `KeyboardContext` has a new `spaceLongPressBehavior` property to control the space button's behavior.
* `KeyboardInputViewController` has a new `calloutContext`.  
* `KeyboardInputViewController` implements `KeyboardController` which gives it a bunch of new functions.
* `KeyboardLocale` implements `LocaleFlagProvider`.
* `KeyboardLocale` has new `Locale` matching extensions.
* `KeyboardType` has new properties.
* `KeyboardLayoutConfiguration` has adjusted the standard corner radius for iPhone buttons.
* `Locale` has new localized name extensions.
* `Locale` has new `KeyboardLocale` matching extensions.
* `LocaleContextMenu` now lets you customize the presentaiton locale.
* `NextKeyboardButton` now supports using any custom content.
* `NextKeyboardController` is used instead of the shared controller.
* `QuotationAnalyzer` is a new protocol for analyzing quotations in strings.
* `ScrollViewGestureButton` is now available on watchOS 7.
* `SpaceCursorDragGestureHandler` is now available on all platforms.
* `SpaceLongPressBehavior` is a new enum that defined the available space long press behaviors.
* `String` has new casing, keyboard character, quotation, word and sentence extensions.
* `SystemKeyboard` will now add an autocomplete toolbar by default.
* `SystemKeyboardButton` is now available on all platforms.
* `Text` is a new namespace for text analysis.
* `UITextDocumentProxy` quotation utilities is now available as `StringQuotationAnalyzer`.

### 👑 Pro changes

* `FeedbackToggle` is a new button to toggle audio and haptic feedback.
* `AudioFeedbackToggleButton` has been replaced with `FeedbackToggle`.
* `HapticFeedbackToggleButton` has been replaced with `FeedbackToggle`.

### 💡 Behavior changes

* `ActionCallout` is no longer greedy.
* `CalloutStyle` has a new standard corner radius.
* `InputCallout` is no longer greedy.
* `InterfaceOrientation` `.current` now returns correct rotations on all platforms.
* `iPadKeyboardLayoutProvider` has been greatly simplified.
* `iPhoneKeyboardLayoutProvider` has been greatly simplified.
* `Image` `.keyboardEmoji` is looks closer to the native icon.
* `KeyboardAction` `.backspace` now triggers on `.press` instead of `.release`.
* `KeyboardLayoutConfiguration` now behaves the same on all platforms.
* `KeyboardSettingsLink` has ben rewritten to only use plain SwiftUI code that works with extensions as well.
* `StandardKeyboardAppearance` now applies medium font weights to the Gregorian ABC keyboard. 

### 💥 Breaking changes

* All deprecated code has been removed.
* The library now targets iOS 14, macOS 11, tvOS 14 and watchOS 7.
* `ActionCalloutContext` `.shared` has been removed.
* `AutocompleteSuggestions` is now a struct instead of a protocol.
* `AutocompleteToolbar` standard actions have been removed.
* `AutocompleteToolbar` `ReplacementAction` has been renamed to `SuggestionAction`.
* `AutocompleteToolbarItem` init parameters have been reordered.
* `AutocompleteToolbarItemTitle` init parameters have been reordered.
* `DeleteBackwardRange` `char` has been renamed to `character`.
* `EmojiCategoryKeyboard` init parameters have been refactored.
* `EmojiCategoryKeyboardMenu` init parameters have been reordered.
* `EmojiCharacterAnalyzer` and `EmojiStringAnalyzer` have been merged into `EmojiAnalyzer`.
* `EmojiKeyboard` init parameters have been refactored. 
* `InputCalloutContext` `.shared` has been removed.
* `InputSet` has been converted to a `protocol` and all input set types converted from `class` to `struct`.
* `KeyboardAction` `.return` and `.newLine` have been replaced by `primary` variants.
* `KeyboardAction` `.shift` `currentState` is renamed to `currentCasing`.
* `KeyboardAction` `standardTextDocumentProxyAction` has been removed.
* `KeyboardAppearance` callout styles have been converted to properties.
* `KeyboardContext` `originalTextDocumentProxy` has been renamed to `mainTextDocumentProxy`.
* `KeyboardGesture` `.tap` has been replaced by `.release`.
* `KeyboardInputViewController` has replaced `actionCalloutContext` and `inputCalloutContext` with a single `calloutContext`.
* `KeyboardInputViewController` `.shared` has been removed.
* `KeyboardInputViewController` `originalTextDocumentProxy` has been renamed to `mainTextDocumentProxy`.
* `KeyboardLayoutConfiguration` portrait configurations have been renamed.
* `KeyboardReturnActionMappable` has been refactored to `KeyboardActionMappable`.
* `KeyboardTextField` now requires an keyboard input view controller.
* `KeyboardTextView` now requires an keyboard input view controller.
* `KeyboardType` has made the `isAlphabetic(with:)` parameter implicit.
* `Locale` `regionIdentifier` has been removed.
* `LocaleProvider` has been removed.
* `LocaleFlagProvider` is now only implemented by `Locale` on iOS 16.
* `StandardAutocompleteSuggestions` has been renamed to `AutocompleteSuggestions`.
* `StandardKeyboardActionHandler` now requires a `KeyboardController`.
* `StandardKeyboardActionHandler` `inputViewController` initializer is now a convenience initializer.
* `StandardKeyboardActionHandler` `changeKeyboardTypeAction` has been removed.
* `StringCasingAnalyzer` has been renamed to `CasingAnalyzer`.
* `StringCasingAnalyzer` has replaced properties with functions. 
* `SystemKeyboard` init parameters have been refactored.
* `SystemKeyboard` `standardKeyboardWidth` has been removed.
* `SystemKeyboardActionButton` has been renamed to ``SystemKeyboardButton`` and requires a callout context.
* `SystemKeyboardActionButtonContent` has been renamed to `SystemKeyboardButtonContent`.
* `SystemKeyboardButton` has been replaced by the renamed action button.
* `SystemKeyboardButtonRowItem` now requires a callout context.
* `UITextDocumentProxy` `isOpenQuotationBeforeInput` has been renamed to `hasUnclosedQuotationBeforeInput`.
* `UITextDocumentProxy` `isOpenAlternateQuotationBeforeInput`has been renamed to `hasUnclosedAlternateQuotationBeforeInput`.
* `UITextDocumentProxy` `preferredReplacement` is renamed to `preferredQuotationReplacement`.
* `View` `.keyboardGestures` now requires a callout context.
