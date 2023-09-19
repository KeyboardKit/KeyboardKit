# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

### ✨ New Features

* `View.keyboardButton` is a new view extension that applies both a style and gestures.

### 💡 Adjustments

* `AutocompleteProvider` is now async instead of using completions.
* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `View+KeyboardButton` now has inset support.

### 👑 Pro Adjustments

* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.
    
### 💥 Breaking changes 

* All deprecated code has been removed or addressed.

* `DisabledCalloutActionProvider` has been removed.
* `EnglishCalloutActionProvider` has been removed.
* `StandardCalloutActionProvider` no longer has a fallback provider.
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `SystemKeyboardButton` has been renamed to `KeyboardButton`.
* `SystemKeyboardButtonBody` has been renamed to `KeyboardButtonBody`.
* `SystemKeyboardButtonContent` has been renamed to `KeyboardButtonContent`.
* `SystemKeyboardButtonShadow` has been moved into `KeyboardButtonBody`.
* `SystemKeyboardButtonText` has been renamed to `KeyboardButtonText`.
* `SystemKeyboardSpaceContent` has been renamed to `KeyboardButtonSpaceContent`.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
