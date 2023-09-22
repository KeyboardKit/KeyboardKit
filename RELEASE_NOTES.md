# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and aims to make the library cleaner and more discoverable.

One big change is that many types are moved into new namespaces, which will help reduce the surface area of the library.

Renamed and moved types have temporary migration typealiases to help you migrate from KeyboardKit 7. These typealiases will be removed in 8.1.

Renamed and moved types are not included in these release notes. Just follow the deprecation warnings after upgrading and you should be fine. 

Some nice-to-have utilities have also been removed, if they bloated the library while providing little value. If you need them, grab them from an earlier version.

Note that the library no longer sets up English services by default, so make sure that you are aware of that before upgrading. You must either implement these services yourself, or get them by upgrading to KeyboardKit Pro.

### 🚨 Important changes

* `StandardCalloutActionProvider` doesn't provide English callout actions by default anymore.

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new layout provider that replaces the English and static ones.
* `KeyboardAction.emoji` can now be created with a string as well.
* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `SystemKeyboard` has new initializers that make it much easier to customize the content and view of its keys.
* `View.keyboardButton` is a new view extension that applies both a style and gestures.
* `View.keyboardCalloutContainer` is a new view extension that applies both input and action callout container modifiers to the view. 
* `View.keyboardLayoutItemSize` is a new view extension that applies a layout-specific size and insets to the view.

### 💡 Adjustments

* Many types and functions have been moved into namespaces or renamed.
* These types and functions have temporary mappings to help you migrate.
* Renamed types and functions are not included in these release notes.  

* `AutocompleteProvider` is now async instead of using completions.
* `InputSet` has been converted to a struct.
* `View+KeyboardButton` now has support for custom, intrinsic edge insets.
* `View+KeyboardButton` now applies a locale context menu to `nextLocale` buttons.

### 👑 Pro Adjustments

* `Emojis` has many types that were previously in the base library.
* `ProCalloutActionProvider` has new utility functions to return actions.
* `ProKeyboardActionHandler` is a new handler that does pro things.
* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.
    
### 💥 Breaking changes 

* All deprecated code has been removed or fixed. 
* Many emoji types have been moved to KeyboardKit Pro.
* English input sets have been moved to KeyboardKit Pro.

* `AudioFeedback.Engine` is no longer open to inheritance. 
* `Autocomplete.ToolbarItemSubtitle` is now initialized with a suggestion.
* `BaseCalloutActionProvider` has been removed.
* `DisabledCalloutActionProvider` has been removed.
* `EmojiKeyboardItem` has been removed.
* `EmojiProvider` has been removed.
* `EnglishCalloutActionProvider` has been removed.
* `EnglishKeyboardLayoutProvider` has been removed.
* `ExternalKeyboardContext` has been moved to KeyboardKit Pro.
* `FeatureToggle` has been removed.
* `HapticFeedback.Engine` is no longer open to inheritance.
* `KeyboardAction.emojiCategory` has been removed.
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` no longer has a `buttonContent` initializer.
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
