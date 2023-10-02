# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and aims to make the library more discoverable.

Many types are moved into new namespaces, which will help reduce the surface area of the library. 

Renamed and moved types have temporary typealiases to help you migrate from KeyboardKit 7. Just follow the deprecation warnings after upgrading and you should be fine. These typealiases will be removed in 8.1.

Some nice-to-have utilities that bloated the library while providing little value have been removed. If you need them, just grab them from an earlier version.

### 🚨 Important changes

* Make sure to inherit the new `ProKeyboardActionHandler` if you use a custom action handler together with KeyboardKit Pro.
* The communicated keyboard font changes will not be performed in this major version. 
 
* `ProKeyboardActionHandler` is a new action handler that registers the most recently used emojis.
* `StandardKeyboardActionHandler` no longer registers the most recently used emojis, since this has moved to KeyboardKit Pro.
* `SystemKeyboard` provides MUCH easier customizations, but must be provided with explicit view builders.
* `SystemKeyboard` no longer has an emoji keyboard by default, since it has been moved to KeyboardKit Pro.
* `SystemKeyboard` no longer hides or configures the autocomplete toolbar. Do this in the new `toolbar` view builder.

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new provider that replaces the English and static ones.
* `KeyboardAction.emoji` can now be created with a string as well.
* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `SystemKeyboard` has new initializers with view builders that make it much easier to customize button content, button views, emoji keyboard and toolbar.
* `View.keyboardButton` is a new view extension that applies both a style and gestures.
* `View.keyboardCalloutContainer` is a new view extension that applies both input and action callout container modifiers to the view. 
* `View.keyboardLayoutItemSize` is a new view extension that applies a layout-specific size and insets to the view.

### 📦 New Namespaces

* `Autocomplete` is a new namespace for autocomplete-related functionality.
* `Callouts` is a new namespace for callout-related functionality.
* `Dictation` is a new namespace for dictation-related functionality.
* `Emojis` is a new namespace for emoji-related functionality.
* `Gestures` is a new namespace for gesture-related functionality.
* `KeyboardPreviews` is a new namespace for preview-related functionality.
* `Proxy` is a new namespace for proxy-related functionality.

### 💡 Adjustments

* Many types and functions have been moved into namespaces or renamed.
* These types and functions have temporary mappings to help you migrate.
* Renamed types and functions are not included in these release notes.  

* `AutocompleteProvider` is now async instead of using completions.
* `InputSet` has been converted to a struct.
* `SystemKeyboard` no longer has an emoji keyboard by default, since it has been moved to KeyboardKit Pro.
* `SystemKeyboard` no longer hides or configures the autocomplete toolbar. Do this in the new `toolbar` view builder.
* `View+KeyboardButton` now has support for custom, intrinsic edge insets.
* `View+KeyboardButton` now applies a locale context menu to `nextLocale` buttons.

### 👑 Pro Adjustments

* `Emojis` has types that have been added from the base library.
* `FullDocumentContextReader` has been removed (just use the proxy extensions).
* `ProCalloutActionProvider` has new utility functions to return actions.
* `ProKeyboardActionHandler` is a new handler that does pro things.
* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.
* `SystemKeyboardButtonPreview` is a new system button preview. 
    
### 💥 Breaking changes 

* All deprecated code has been removed or fixed.
* All types that exposed to DocC have been removed. 
* Many emoji types have been moved to KeyboardKit Pro.
* English input sets have been moved to KeyboardKit Pro.

* `AudioFeedback.Engine` is no longer open to inheritance. 
* `Autocomplete.ToolbarItemSubtitle` is now initialized with a suggestion.
* `CasingAnalyzer` has been removed. Use `String` extensions directly instead.
* `DisabledCalloutActionProvider` has been removed.
* `EmojiKeyboardItem` has been removed.
* `EmojiProvider` has been removed.
* `EnglishCalloutActionProvider` has been moved to KeyboardKit Pro.
* `EnglishKeyboardLayoutProvider` has been removed.
* `ExternalKeyboardContext` has been moved to KeyboardKit Pro.
* `FeatureToggle` has been removed.
* `HapticFeedback.Engine` is no longer open to inheritance.
* `KeyboardAction.emojiCategory` has been removed.
* `KeyboardCharacterProvider` has been removed. Use `String` extensions directly instead.
* `KeyboardColor` has been made internal.
* `KeyboardColorReader` has been removed. Use `Color` extensions directly instead.
* `KeyboardHostingController` has been made internal.
* `KeyboardInputViewController` `mainTextDocumentProxy` has been renamed to `originalTextDocumentProxy`.
* `KeyboardSettingsUrlProvider` has been removed. Use `URL.keyboardSettings` directly instead.
* `LocaleDirectionAnalyzer` has been removed.
* `LocaleNameProvider` has been removed.
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed. Use `String` extensions directly instead. 
* `SentenceAnalyzer` has been removed. Use `String` extensions directly instead. 
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` is much easier to configure, but requires explicit view builders.
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
* `WordAnalyzer` has been removed. Use `String` extensions directly instead. 
