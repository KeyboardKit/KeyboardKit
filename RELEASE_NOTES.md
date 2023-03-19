# Release notes

KeyboardKit tries to honor semantic versioning:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes can still occur in minor versions and patches, though, if the alternative is to not be able to release new critical features or fixes.


## Older release notes

Older versions have their release notes listed in the `Release_Notes` folder.



## 7.2

This version adds a theme engine to KeyboardKit Pro, which makes it a lot easier to style `SystemKeyboard`.

The new `KeyboardTheme` can be used with the new `KeyboardThemeAppearance` to use themes to customize keyboard design.

This version comes with two theme - `.cottonCandy` and `.tron` - that you can use in your  own keyboads. More are coming soon. 

Due to a bug found in the new autocomplete provider, the old `StandardAutocompleteProvider` will be replaced in the next minor version.

### ✨ New features

* `AutocompleteContext` has a new `isEnabled` property that can be used to disable autocomplete.
* `KeyboardAppearance` has a new `autocompleteToolbarStyle` property.
* `KeyboardAppearance` has a new `keyboardBackground` property.
* `KeyboardBackgroundStyle` is a new style that can be used to the background of a keyboard.
* `KeyboardButtonStyle` properties are now optional to allow for overrides.
* `KeyboardButtonStyle` has a new `pressedOverlayColor` property that can be used to highlight buttons.
* `KeyboardButtonStyle` has a new `extended(with:)` function to let you extend a style with another style.
* `View+SystemKeyboardButton` has a new `isPressed` parameter to let you define pressed state.

### 👑 Pro changes

* `KeyboardInputViewController` will use the new autocomplete context property to disable autocomplete if needed.
* `KeyboardTheme` is a new type that can be used to define keyboard themes.
* `KeyboardThemeAppearance` is a new appearance that can be used with `KeyboardTheme`.
* The new `LocalAutocompleteProvider` that was introduced in 7.1 has been made public.
* The new `LocalAutocompleteProvider` now ignores empty strings when wrapping in quotes.
* The incorrect Brazilian callout actions have been corrected.

### 🎨 New keyboard themes

* `KeyboardTheme.cottonCandy` is a pink and blue trip to fluffy delight.
* `KeyboardTheme.neonNights` is a metropolitian color explosion.
* `KeyboardTheme.tron` is a black and blue, digital adrenaline rush.

### 💡 Behavior changes

* `SystemKeyboard` uses the new appearance background and autocomplete toolbar styles.

### 🗑️ Deprecations

* `CalloutStyle` has been renamed to `KeyboardCalloutStyle`.
* `ActionCalloutStyle` has been renamed to `KeyboardActionCalloutStyle`.
* `InputCalloutStyle` has been renamed to `KeyboardInputCalloutStyle`.



## 7.1.3

This version adds an `isKeyboardFloating` property to the keyboard context. It's currently not used to change the visual representation of floating keyboards, but please verify that it works as expected.

### ✨ New features

* `KeyboardContext` has a new `isKeyboardFloating` property that can be used to determine if the keyboard is floating.



## 7.1.2

### 💡 Behavior changes

* `GestureButtonDefaults` have adjusted `repeatDelay` to `0.5`.

### 🐛 Bug fixes

* `KeyboardLayoutConfiguration` now applies Pro Max configuration to iPhone 14 Pro Max.
* `SystemKeyboard` will now show autocomplete in Twitter and Mastodon.
* `View+KeyboardGestures` will now trigger repeating actions like backspace more like the native keyboards.



## 7.1.1

This version fixes some bugs in `KeyboardTextField` and `KeyboardTextView` and tweaks their behavior a bit.

The demo app has a new `KeyboardTextInput` demo keyboard that shows `KeyboardTextField` and `KeyboardTextView` in action. 

### ✨ New features

* `KeyboardInputView` is a new protocol that lets you apply a `focused` binding together with a custom done button.

### 💡 Behavior changes

* `KeyboardTextField` and `KeyboardTextView` now implement the new `KeyboardInputView` protocol.
* `KeyboardTextField` and `KeyboardTextView` now apply a basic style before applying any custom configuration.
* `KeyboardTextField` and `KeyboardTextView` now animates together with the focused state.
* `KeyboardTextField` now applies a background color and border style.
* `KeyboardTextView` now applies a background color, corner radius and font.
* `KeyboardTextView` now uses the same font as `KeyboardTextField` by default.

### 🐛 Bug fixes

* `KeyboardTextField` and `KeyboardTextView` now correctly resigns as first responder when they lose focus.



## 7.1

This version fixes some bugs and makes it even easier to setup KeyboardKit.

KeyboardKit Pro also has a new experimental and much better autocomplete provider that you can toggle on with the `FeatureToggle`:

```swift
FeatureToggle.shared.toggleFeature(.newAutocompleteEngine, .on)
```

Once this has been verified to work better than the current provider, it will replace it and this feature toggle flag will be removed.

Furthermore, the locale context menu has been refactored to work and look a lot better on iOS 16 and macOS 12. This unfortunately required a few breaking api changes, that hopefully will not affect anyone.

### ✨ New features

* `FeatureToggle` has a new `.newAutocompleteEngine` feature.
* `KeyboardContext` has a new `localePresentationLocale` property.
* `KeyboardInputViewController` has new `setup` functions that provide a view builder with an unowned controller reference.
* `QuotationAnalyzer` has more functions.
* `String` has new quotation functions.

### 👑 Pro changes

* KeyboardKit Pro has a new experimental autocomplete provider that can be toggled on to replace the standard one.
* Many iPad layouts have been tweaked to look even closer to the native layouts.

### 💡 Behavior changes

* `KeyboardInputViewController` `setup` uses a view builder instead of a static view.
* `KeyboardInputViewController` now calls `viewWillSetupKeyboard` in `viewWillAppear` instead of `viewDidLoad`.
* `KeyboardRootView` uses a view builder instead of a static view. 

### 🐛 Bug fixes

* `iPadKeyboardLayoutProvider` had a line accidentally removed, which caused English layouts to render incorrect. This has been fixed.
* `KeyboardInputViewController` now creates the keyboard view later, which makes it respect the safe areas better in landscape.
* `LocaleContextMenu` now uses the `KeyboardContext` to localize and sort locales. 

### 💥 Breaking changes 

* `SpaceLongPressBehavior` cases have been renamed to read better. This should hopefully affect few people.



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
