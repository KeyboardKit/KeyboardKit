# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and aims to make the library more discoverable.

This version also moves a lot of types into namespaces and grouping types, which will also make the surface area smaller. 

Some nice-to-have utilities that bloated the library while providing little value have been removed. If you need them, just grab them from an earlier version.

### 🚨 Important information

* Renamed and moved types have temporary typealiases to help you migrate from KeyboardKit 7. 
* Just follow the deprecation warnings after upgrading. These typealiases will be removed in 8.1.
* If you use a custom action handler with Pro, make sure to inherit the new `ProKeyboardActionHandler`. 
  
* `KeyboardInputViewController` moves state properties into a new `keyboardState` property.
* `KeyboardInputViewController` moves services properties into a new `keyboardServices` property.
* `ProKeyboardActionHandler` is a new keyboard action handler with Pro-specific action handling.
* `StandardKeyboardActionHandler` no longer registers the most recently used emojis. This has moved to Pro.
* `SystemKeyboard` provides MUCH easier customizations, but must be provided with explicit view builders.
* `SystemKeyboard` no longer adds an emoji keyboard, since this component has been moved to Pro.
* `SystemKeyboard` no longer hides or configures the autocomplete toolbar. Do this in the new `toolbar` view builder.

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new provider that replaces the English and static ones.
* `KeyboardAction.emoji` can now be created with a string as well.
* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `KeyboardInputViewController` has a new `keyboardState` property.
* `KeyboardInputViewController` has a new `keyboardServices` property.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `SystemKeyboard` has new initializers that make it MUCH easier to customize its views.
* `View.keyboardButton` is a new view extension that applies both a button style and gestures.
* `View.keyboardCalloutContainer` is a new view extension that applies both input and action modifiers to the view. 
* `View.keyboardLayoutItemSize` is a new view extension that applies a layout-specific size and insets to the view.

### 💡 Adjustments

* Renamed types and functions are not included in these release notes.  

* `AutocompleteProvider` is now async.
* `InputSet` has been converted to a struct.
* `View+KeyboardButton` now supports custom intrinsic edge insets.
* `View+KeyboardButton` now applies a locale menu to `nextLocale` buttons.

### 👑 Pro Adjustments

* `EmojiCategory` has been added from the base library.
* `EmojiKeyboard` has been added from the base library.
* `FeedbackToggle` init parameter is renamed to `configuration`.
* `FullDocumentContextReader` has been removed (use the proxy extensions).
* `ProCalloutActionProvider` has new utility functions to return actions.
* `ProKeyboardActionHandler` is a new action handler that does pro things.
* `SystemKeyboardButtonPreview` is a new system button preview. 
    
### 💥 Breaking changes 

* All deprecated code has been removed.
* DocC exposing types have been removed. 
* Many emoji types have been moved to Pro.
* English input sets have been moved to Pro.

* `AudioFeedback.Engine` is no longer open to inheritance. 
* `Autocomplete.ToolbarItemSubtitle` is now initialized with a suggestion.
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
* `KeyboardContext` no longer has a controller init. Just call `sync(with:)` after creating it.
* `KeyboardHostingController` has been made internal.
* `KeyboardInputViewController` `mainTextDocumentProxy` has been renamed to `originalTextDocumentProxy`.
* `KeyboardInputViewController` state properties can now only be set via `keyboardState`.
* `KeyboardInputViewController` services properties can now only be set via `keyboardServices`.
* `KeyboardSettingsUrlProvider` has been removed (use `URL.keyboardSettings`).
* `LocaleDirectionAnalyzer` has been removed (use `Locale` extensions).
* `LocaleNameProvider` has been removed (use `Locale` extensions).
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed (use `String` extensions). 
* `SentenceAnalyzer` has been removed (use `String` extensions). 
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` is much easier to configure, but requires explicit view builders.
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
* `WordAnalyzer` has been removed (use `String` extensions). 
