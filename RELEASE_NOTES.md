# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and makes the library cleaner.

The library no longer sets up English services by default, so make sure that you are aware of that before upgrading.

The English callout action and keyboard layout providers are no longer part of the base library.

### ✨ New Features

* `KeyboardLayoutItem` has a new `width(forRowWidth:inputWidth:)` function.
* `View.keyboardButton` is a new view extension that applies both a style and gestures.

### 💡 Adjustments

* `AutocompleteProvider` is now async instead of using completions.
* `BaseCalloutActionProvider` initializer is no longer throwing.
* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `View+KeyboardButton` now has inset support.

### 👑 Pro Adjustments

* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.

### 🚨 Important changes

* `StandardCalloutActionProvider` provides no actions by default anymore.
    
### 💥 Breaking changes 

* All deprecated code has been removed or addressed.

* `DisabledCalloutActionProvider` has been removed.
* `EnglishCalloutActionProvider` has been removed.
* `KeyboardLayoutItem` `insets` has been renamed to `edgeInsets`.
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `SystemKeyboardButton` has been renamed to `KeyboardButton`.
* `SystemKeyboardButtonBody` has been renamed to `KeyboardButtonBody`.
* `SystemKeyboardButtonContent` has been renamed to `KeyboardButtonContent`.
* `SystemKeyboardButtonShadow` has been moved into `KeyboardButtonBody`.
* `SystemKeyboardButtonText` has been renamed to `KeyboardButtonText`.
* `SystemKeyboardSpaceContent` has been renamed to `KeyboardButtonSpaceContent`.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
