# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

Welcome to KeyboardKit 8.0 - a massive update to the KeyboardKit SDK.

KeyboardKit 8.0 is all about cleaning up the library to make it more approachable, better structured and easier to use. It removes all previously deprecated code, reorganizes types into namespaces, and removes low-value utilities, including types solely used for DocC exposure.

Central types like `SystemKeyboard` are now easier to use. Passing state and services instead of a controller reduces the risk for memory leaks. It also no longer needs you to provide a width, but will take up as much space as it needs. It also makes it a easier to provide customize its views.

These updates will simplify scaling the library and has helped enabling new features like fading the keyboard buttons while moving the cursor with space. There are many quality of life and bug fixes. Accessibility has been drastically improved for Voice Over and the emoji keyboard has been redesigned.

Most emoji features, including the emoji keyboard and emoji category information, are now Pro features. The `SystemKeyboard` automatically removes the emoji key if no custom emoji keyboard is provided in the view builder.

The documentation has been extensively updated to provide more information and code examples. Please report any inconsistencies found, as much is rewritten.

I hope that you will love this major update to KeyboardKit. 


### 💡 Migrating from KeyboardKit 7

KeyboardKit 8.0 includes TEMPORARY deprecations to assist migration from KeyboardKit 7. They will be removed in 8.1. Just follow the deprecations to migrate your 7.x code to 8.0.

Consider upgrading to the last 7.x version of KeyboardKit before moving to 8.0, as it has types and deprecations that are removed in this version.

See the breaking changes section below if you run into any breaking changes. Reach out if you run into problems that are not mentioned here.


### 🚨 Important information

* Inherit `ProKeyboardActionHandler` when using a custom action handler with Pro. 
  
* `KeyboardInputViewController` has moved state properties into a `state` property.
* `KeyboardInputViewController` has moved services properties into a `services` property.
* `StandardKeyboardActionHandler` no longer remembers tapped emojis. This has moved to Pro.
* `SystemKeyboard` provides MUCH easier customization, but requires explicit view builders.
* `SystemKeyboard` now hides the `emoji` keyboard key if `emojiKeyboard` is an `EmptyView`. 
* `SystemKeyboard` no longer has an emoji keyboard by deafult, since it's now a Pro feature.
* `SystemKeyboard` no longer auto-hides the toolbar. You can do this in the `toolbar` builder.

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new provider.
* `KeyboardAction` now has a `standardAccessibilityLabel`.
* `KeyboardAction.emoji` can now be created with a string.
* `KeyboardActionHandler` now handles autocomplete suggestions.
* `KeyboardButton` now has `edgeInsets` and an `isPressed` binding.
* `KeyboardContext` has proxy properties that mirror the controller.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `KeyboardLocale` has new, convenient collection extensions to get locales.
* `KeyboardStyle.Background` now supports specifying the image content mode.
* `KeyboardStyle.Button` now supports background color AND background style.
* `KeyboardStyle.EmojiKeyboard` has a lot more configuration parameters now.
* `SpaceDragGestureHandler` properties are now mutable to allow customizations.
* `SystemKeyboard` has new view builders to make it MUCH easier to customize it.
* `SystemKeyboard` now fades out the buttons when a space cursor drag is active.
* `StandardKeyboardActionHandler` can now be created on all supported platforms.
* `StandardKeyboardStyleProvider` now adjusts styles when a space drag is active.
* `View.keyboardButton` supports custom insets and applies a menu to `nextLocale`.
* `View.keyboardButton` applies accessibility labels for actions that define them.
* `View.keyboardButton` is a new extension that applies both a style and gestures.
* `View.keyboardCalloutContainer` is a new extension that will apply both callouts. 
* `View.keyboardLayoutItemSize` is a new extension that applies a layout item size.

### 💡 Adjustments

* Renamed types and functions are not included in these release notes.  

* `AutocompleteProvider` is now async.
* `EmojiKeyboard` uses the standard context style as default.
* `Gesture.KeyboardButtonGestures` no longer blocks space releases.
* `InputSet` has been converted to a struct. All subsets are removed.
* `ProKeyboardActionHandler` is a new, Pro-supporting action handler.
* `KeyboardAction` no longer defines a default `.nextKeyboard` action.
* `KeyboardController` has fewer functions, since it's not used as much.  
* `KeyboardInputViewController` is no longer used to insert suggestions.
* `SystemKeyboard` no longer needs you to provide it with an explicit width.
* `SystemKeyboard` now guides you to use the controller-based setup function.
* `KeyboardInputViewController` `textDidChange` performs operations after a delay. 

### 👑 Pro Adjustments

* Many emoji types have become Pro features.
* Many routing types have become Pro features.

* `EmojiKeyboard` has a new state/services initializer.
* `EmojiKeyboard` has menu icons that look more native.
* `Emojis.Version` has a new `current` version.
* `Emojis.Version` has a new `currentUnavailableEmojis` array.
* `Emojis.Version` has a new `currentUnavailableEmojisDictionary` lookup table.
* `Emojis.Version` fixes a bug for `.v15` iOS availability.
* `ExternalKeyboardContext` class is now a Pro features.
* `FeedbackToggle` parameter is renamed to configuration.
* `FullDocumentContextReader` has been removed (use proxy).
* `KeyboardTextField` & `KeyboardTextView` are now Pro features.
* `License.register` is now `async`.
* `LocalAutocompleteProvider` autocorrects `i` to `I` in English.
* `ProKeyboardActionHandler` is a new Pro keyboard action handler.
* `ProCalloutActionProvider` is a new Pro callout action provider.
* `RemoteAutocompleteProvider` is now available to all license tiers.
* `SystemKeyboardButtonPreview` is a new system keyboard button preview.
* `KeyboardInputViewController` has a license config action for both setups.
* `KeyboardInputViewController` no longer returns the resolved rlicense.

### 🐛 Bug fixes

* `KeyboardAction.backspace` didn't properly trigger autocapitalization.
* `SystemKeyboard` now uses images for `.space` from the style provider.
* `textDidChange` performs autocomplete after an async delay, to let the proxy update.
* `textDidChange` applies autocapitalization after an async delay, to let the proxy update.
    
### 💥 Breaking changes 

* All deprecated code has been removed.
* DocC exposing types have been removed. 
* Many emoji types have been moved to Pro.
* Many routing types have been moved to Pro.
* English input sets have been moved to Pro.
* Changes with migration deprecations are not listed here.

* `AudioFeedback.Engine` is no longer open to inheritance.
* `Autocomplete.ToolbarItemSubtitle` init takes a suggestion.
* `CalloutContext.ActionContext` no longer uses an action handler.
* `CasingAnalyzer` has been removed (use `String` extensions).
* `DisabledCalloutActionProvider` has been removed.
* `EmojiKeyboardItem` has been removed.
* `EmojiProvider` has been removed.
* `EnglishCalloutActionProvider` is now a Pro feature.
* `EnglishKeyboardLayoutProvider` has been removed.
* `ExternalKeyboardContext` is now a Pro feature.
* `FeatureToggle` has been removed.
* `HapticFeedback.Engine` is no longer open to inheritance.
* `KeyboardAction.emojiCategory` has been removed.
* `KeyboardCharacterProvider` has been removed (use `String` extensions).
* `KeyboardColor` has been made internal.
* `KeyboardColorReader` has been removed (use `Color` extensions).
* `KeyboardContext` no longer has a controller-based init (use `sync(with:)`).
* `KeyboardContext` `textDocumentProxy` is read-only, but `originalTextDocumentProxy` can be set.
* `KeyboardHostingController` has been made internal.
* `KeyboardSettingsUrlProvider` has been removed (use `URL.keyboardSettings`).
* `KeyboardStyle.EmojiKeyboard` has different parameters for the new menu design.
* `KeyboardTextContext` was not used and has been removed to avoid complexity.
* `Routing` text input components are now Pro features.
* `KeyboardTextField` was not used and has been removed to avoid complexity.
* `LocaleDirectionAnalyzer` has been removed (use `Locale` extensions).
* `LocaleNameProvider` has been removed (use `Locale` extensions).
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed (use `String` extensions). 
* `SentenceAnalyzer` has been removed (use `String` extensions).
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` now requires explicit view builders.
* `SystemKeyboardItem` can no longer be initialized outside the library. 
* `ToggleToolbar` is now a Pro feature.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `WordAnalyzer` has been removed (use `String` extensions).
