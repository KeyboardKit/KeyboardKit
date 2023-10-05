# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

Welcome to KeyboardKit 8.0 - a massive update to the KeyboardKit library.

KeyboardKit 8.0 is all about cleaning up and polishing the library to make it more approachable, better structured and easier to use.

This version removes all previously deprecated code, reorganizes types into namespaces for a streamlined library, and removes low-value utilities, such as types that only helped exposing functionality to DocC. This has helped reducing the codebase by about 25%.

Some central types, including `SystemKeyboard`, are much easier to use. You can for instance pass in state and services directly into the system keyboard, reducing memory leak risks by eliminating the need to pass around a controller. However, the controller’s setup function still offers an unowned reference for safetly accessing state and services.

To make things even easier, the `SystemKeyboard` no longer needs an explicit width. It will now take up as much space as it can horizontally, and as much as it needs vertically. It also makes it a lot easier to provide a custom toolbar and emoji keyboard.

All in all, these updates simplify future scaling of the library and has already enabled a new feature that fades out the system keyboard button labels while moving the input cursor with the space key. The next minor update will also support floating keyboards on iPad.

There are many quality of life improvements. Accessibility has been drastically improved when typing on the keyboard, and the emoji keyboard has been redesigned to look a lot more like the native keyboard.

And speaking of emojis, many emoji features, including the emoji keyboard and category information, are now Pro features. The system keyboard will automatically remove the emoji key if an emoji keyboard isn't provided.

Finally, the documentation has gotten a big overview, and will now provide you with a lot more information, more code examples, etc. Please reach out if you find any inconsistencies in the documentation, since much has changed in this version.


### 💡 Migrating from KeyboardKit 7

Before you upgrade to KeyboardKit 8.0, it may be a good idea to upgrade to the last 7.x version, since it contains now removed deprecations and types.

KeyboardKit 8.0 includes temporary deprecations to assist migration from KeyboardKit 7. Follow the deprecation warnings for a proper code migration. 

These temporary deprecations will be removed in 8.1, so make sure that you always upgrade to 8.0 before upgrading to a later version.

If you run into breaking changes, please refer to the breaking changes section below.


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

### 👑 Pro Adjustments

* `EmojiCategory` has been converted to a Pro feature.
* `EmojiKeyboard` has been converted to a Pro feature.
* `EmojiKeyboard` has a new state/services initializer.
* `EmojiKeyboard` has a menu that looks more native now.
* `FeedbackToggle` parameter is renamed to configuration.
* `FullDocumentContextReader` has been removed (use proxy).
* `LocalAutocompleteProvider` now autocorrects "i" in English.
* `ProKeyboardActionHandler` is a new Pro keybard action handler.
* `SystemKeyboardButtonPreview` is a new system keyboard button preview. 

### 🐛 Bug fixes

* `SystemKeyboard` now uses images for `.space` from the style provider.
    
### 💥 Breaking changes 

* All deprecated code has been removed.
* DocC exposing types have been removed. 
* Many emoji types have been moved to Pro.
* English input sets have been moved to Pro.
* Changes with migration deprecations are not listed here.

* `AudioFeedback.Engine` is no longer open to inheritance.
* `Autocomplete.ToolbarItemSubtitle` init takes a suggestion.
* `CalloutContext.ActionContext` no longer uses an action handler.
* `CasingAnalyzer` has been removed (use `String` extensions).
* `DisabledCalloutActionProvider` has been removed.
* `EmojiKeyboardItem` has been removed.
* `EmojiProvider` has been removed.
* `EnglishCalloutActionProvider` has been moved to Pro.
* `EnglishKeyboardLayoutProvider` has been removed.
* `ExternalKeyboardContext` has been moved to Pro.
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
* `LocaleDirectionAnalyzer` has been removed (use `Locale` extensions).
* `LocaleNameProvider` has been removed (use `Locale` extensions).
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed (use `String` extensions). 
* `SentenceAnalyzer` has been removed (use `String` extensions).
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` now requires explicit view builders.
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `WordAnalyzer` has been removed (use `String` extensions). 
