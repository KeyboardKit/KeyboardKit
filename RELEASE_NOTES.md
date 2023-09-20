# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecated code will only be removed in `major` versions.
* Breaking changes should not happen in `minor` and `patch` versions.
* Breaking changes can still occur in minor versions and BETA features, if the alternative is to not be able to release new critical features or fixes.

These release notes will only contain the current version. Just check out an older branch or version tag to access older release notes. 



## 8.0

This version removes all previously deprecated functions and aims to make the library cleaner by moving types into namespaces.

The goal with all these new namespaces is to increase discoverability and make it easier to overview the different parts of the library.

As a result, some nice-to-have utilities have been removed, if their existence bloated the library while providing little value.

Note that the library no longer sets up English services by default, so make sure that you are aware of that before upgrading. 

You must either implement these services yourself, or get them by upgrading to KeyboardKit Pro.

### 🚨 Important changes

* `StandardCalloutActionProvider` doesn't provide English callout actions by default anymore.

### ✨ New Features

* `KeyboardButton` now supports providing interactable `edgeInsets`.
* `KeyboardButton` now supports providing an external `isPressed` state.
* `KeyboardLayoutItem` has a new `width(forRowWidth:inputWidth:)` function.
* `SystemKeyboard` has new initializers that make it much easier to customize the content and view of its keys.
* `View.keyboardButton` is a new view extension that applies both a style and gestures.
* `View.keyboardCalloutContainer` is a new view extension that applies both input and action callout container modifiers to the view. 
* `View.keyboardLayoutItemSize` is a new view extension that applies a layout-specific size and insets to the view. 

### 💡 Adjustments

* `AutocompleteProvider` is now async instead of using completions.
* `View+KeyboardButton` now applies a locale context menu to `nextLocale` buttons.
* `View+KeyboardButton` now has support for custom edge insets.

### 👑 Pro Adjustments

* `RemoteAutocompleteProvider.AutocompleteError.noData` has been removed.
    
### 💥 Breaking changes 

* All deprecated code has been removed or addressed.
* Many types have been moved into a new `Autocomplete` namespace.
* Many types have been moved into a new `Callouts` namespace.
* Many types have been moved into a new `KeyboardButton` namespace.

* `ActionCallout` has been renamed to `Callouts.ActionCallout`.
* `Autocomplete.ToolbarItemSubtitle` is now initialized with a suggestion.
* `BaseCalloutActionProvider` has been removed.
* `CalloutButtonArea` has been renamed to `Callouts.ButtonArea`.
* `CalloutContext.ActionCallout` has been renamed to `CalloutActionContext`.
* `CalloutContext.InputCallout` has been renamed to `CalloutInputContext`.
* `DictationAuthorizationStatus` has been renamed to `Dictation.AuthorizationStatus`.
* `Dictation.Configuration` has been renamed to `Dictation.Configuration`.
* `DisabledCalloutActionProvider` has been removed.
* `EnglishCalloutActionProvider` has been removed.
* `InputCallout` has been renamed to `Callouts.InputCallout`.
* `KeyboardEnabledContext` has been renamed to `KeyboardStateContext`.
* `KeyboardEnabledLabel` has been renamed to `KeyboardStateLabel`.
* `KeyboardEnabledStateInspector` has been renamed to `KeyboardStateInspector`.
* `KeyboardLayoutItem` `insets` has been renamed to `edgeInsets`.
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `SystemKeyboard` no longer has a `buttonContent` initializer.
* `SystemKeyboardButton` has been renamed to `KeyboardButton.Button`.
* `SystemKeyboardButtonBody` has been renamed to `KeyboardButton.Key`.
* `SystemKeyboardButtonContent` has been renamed to `KeyboardButton.Content`.
* `SystemKeyboardButtonShadow` has been renamed to `KeyboardButton.Shadow`.
* `SystemKeyboardButtonText` has been renamed to `KeyboardButton.Title`.
* `SystemKeyboardButtonRowItem` has been renamed to `SystemKeyboardItem`.
* `SystemKeyboardItem` can no longer be initialized outside the library.
* `SystemKeyboardSpaceContent` has been renamed to `KeyboardButton.SpaceContent`.
* `View.actionCallout(...)` has been renamed to `View.actionCalloutContainer(...)`.
* `View.inputCallout(...)` has been renamed to `View.inputCalloutContainer(...)`.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `View.systemKeyboardButtonStyle(...)` has been renamed to `.keyboardButtonStyle(...)`.
