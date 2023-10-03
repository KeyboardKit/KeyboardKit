# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and aims to make the library more discoverable.

This version also moves many types into namespaces and parent types, which will make the library easier to overview. 

Some nice-to-have utilities that bloated the library while providing little value have been removed, such as types that only served to exposed functionality to DocC.

If you need any removed functionality, just grab them from an earlier version of KeyboardKit.

### 🚨 Important information

* Renamed and moved types have temporary typealiases to help you migrate from KeyboardKit 7.
* Just follow the deprecation warnings after upgrading, and your code should migrate properly.
* These typealiases will be removed in 8.1, so make sure to go from 7.x to 8.0 to get this help. 
* If you use a custom action handler with Pro, make sure to inherit the new `ProKeyboardActionHandler`.
  
* `KeyboardInputViewController` has moved state properties into a new `state` property.
* `KeyboardInputViewController` has moved services properties into a new `services` property.
* `ProKeyboardActionHandler` is a new keyboard action handler with Pro-specific action handling.
* `StandardKeyboardActionHandler` no longer registers most recent emojis. This has moved to Pro.
* `SystemKeyboard` provides MUCH easier customization, but must be given explicit view builders.
* `SystemKeyboard` no longer adds an emoji keyboard, since this component has been moved to Pro.
* `SystemKeyboard` no longer hides or configures the autocomplete toolbar. You can do this in the new `toolbar` view builder.
* `SystemKeyboard` provides you with the standard view in the view builders. Just return `$0.view` to use this standard view. 

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new base provider.
* `KeyboardAction.emoji` can now be created with a string as well.
* `KeyboardActionHandler` can now handle autocomplete suggestions.
* `KeyboardButton` now supports `edgeInsets` and an `isPressed` binding.
* `KeyboardContext` has new proxy properties that mirrors the controller.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `KeyboardLocale` has new, convenient `all` and `locales` collection extensions.
* `SpaceDragGestureHandler` properties are now mutable to allow for customizations.
* `SystemKeyboard` has new initializers that make it MUCH easier to customize views.
* `StandardKeyboardActionHandler` now builds for all platforms, including macOS and watchOS.
* `StandardKeyboardStyleProvider` now adjusts button styles if a space cursor drag is active.
* `View.keyboardButton` supports custom edge insets and applies a menu to nextLocale buttons.
* `View.keyboardButton` is a new view extension that applies both a button style and gestures.
* `View.keyboardCalloutContainer` is a new extension that applies input and action callout modifiers. 
* `View.keyboardLayoutItemSize` is a new extension that applies layout-specific size and insets to a view.

### 💡 Adjustments

* Renamed types and functions are not included in these release notes.  

* `AutocompleteProvider` is now async.
* `Gesture.KeyboardButtonGestures` no longer stops release on space.
* `InputSet` has been converted to a struct and all sub types removed.
* `KeyboardAction` no longer specifies a default action for `.nextKeyboard`.
* `KeyboardController` has a lot less now, since the controller isn't used as much.  
* `KeyboardInputViewController` is no longer used to insert autocomplete suggestions.
* `SystemKeyboard` now fades out the button content when space cursor movement is active.

### 👑 Pro Adjustments

* `EmojiCategory` has been added from the base library.
* `EmojiKeyboard` has been added from the base library.
* `FeedbackToggle` init parameter is renamed to `configuration`.
* `FullDocumentContextReader` has been removed (use proxy extensions).
* `ProCalloutActionProvider` has new utility functions to return actions.
* `ProKeyboardActionHandler` is a new action handler that does pro things.
* `SystemKeyboardButtonPreview` is a new convenient system button preview. 
    
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
* `KeyboardContext` no longer has a controller initializer (use `sync(with:)` after creating it).
* `KeyboardContext` `.textDocumentProxy` can no longer be set. Instead, set `originalTextDocumentProxy`.
* `KeyboardHostingController` has been made internal.
* `KeyboardSettingsUrlProvider` has been removed (use `URL.keyboardSettings`).
* `KeyboardTextContext` was not used by the library and has been removed to avoid unnecessary complexity.
* `LocaleDirectionAnalyzer` has been removed (use `Locale` extensions).
* `LocaleNameProvider` has been removed (use `Locale` extensions).
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed (use `String` extensions). 
* `SentenceAnalyzer` has been removed (use `String` extensions).
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` is now requires explicit view builders (as mentioned earlier).
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `WordAnalyzer` has been removed (use `String` extensions). 
