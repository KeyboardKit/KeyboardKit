# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if needed.

These release notes only cover the current major version. Check out version tags for older release notes.  


## 💡 KeyboardKit 9.0 Migration Guide

When migrating from KeyboardKit 8.x to 9.x, first upgrade to the last 8.9 version and fix all the deprecation warnings that it provides you with. This will help you prepare for KeyboardKit 9.0.

When you have fixed all deprecation warnings, you should first upgrade to KeyboardKit 9.0. It will provide you with migration deprecations that help you migrate to its many architectural changes.

Once you have fixes all migration deprecations, you are ready to start using KeyboardKit 9.0. You can now configure SPM to use the latest major version number, which will make it use the latest 9.x version.

Note that the legacy migrations will be removed in 9.1, so make sure that you always first upgrade to 9.0 when you upgrade from KeyboardKit 8. If you're on KeyboardKit 7, you should first follow the same procedure to update to 8.0.



## 9.0

This version removes all deprecated code, simplifies many concepts, and prepares for future strict concurrency.

This version has migration deprecations to help you transition from KeyboardKit 8.9. They will be removed in 9.1. 

### 🧪 Experiments

The next keyboard button experiments have been made permanent.

### ⌨️ Essentials

The `KeyboardContext` has a new `keyboardCase` that lets us decouple the keyboard type from the keyboard case. 

The `KeyboardType.alphabetic` keyboard type is also decoupled from the case, which makes the type model a lot easier to use.

The `KeyboardContext` has a new `keyboardTypeForKeyboard` property that updates to `.phone` when a keyboard is floating on iPad.

The `KeyboardController` protocol now requires `services` and `state`, to make it more versatile and able to be used in more places.

The `KeyboardView` now supports being used as a floating keyboard on iPad devices.

### 💥 Actions

The `KeyboardAction.StandardHandler` now implements `KeyboardBehavior`.

### 💡 Autocomplete

The `AutocompleteService` now returns a proper `Autocomplete.ServiceResult` instead of just a list of suggestions.

The `Autocomplete.Suggestion` type implements `Codable` and `Equatable`. This required constraining additional info to `String`.

The `Autocomplete.Toolbar` now lets you define custom views with builder params. The standard views are polished to look more native.

The `KeyboardInputController` now ignores if the keyboard type prefers autocomplete and instead disables autocorrections for system suggestions.

### 🎤 Dictation

The `Dictation` namespace has been simplified to only use a single service that can handle all dictation scenarios.

The new `DictationService` doesn't need a configuration. It uses a `KeyboardContext` & `KeyboardApp` to determine its behavior.

### 😀 Emojis

Emoji localization has been drastically improved, and now supports Swedish. 

The `EmojiKeyboardStyle` has been moved from KeyboardKit Pro to KeyboardKit. The `.emojiKeyboardStyle` view modifier now takes a style builder instead of a style, to allow root level styling.

The standard emoji styles no longer take an input toolbar display mode, which can be used to increate the number of grid rows. You can use the new `.augmented(for:)` style function if you need to.

The EmojiKeyboard in KeyboardKit Pro has been rebuilt from scratch, and now behaves more like a native keyboard. It now lets users scroll through categories instead of require them to tap in the menu.

### 🇸🇪 Localization

The `KeyboardLocale` enum has been replaced with using the native `Locale` everywhere.

### 🔣 Layout

An `InputSet` can now be created with device variations, which allows for resolving device-specific items at runtime.

The `KeyboardLayout` type is now a `struct` instead of a `class`, to better represent the value type that it's meant to be.

The `KeyboardLayout.BaseService` type has more utility functions.

This change from a reference type to a value type may require you to change how you modify layouts in a custom layout service.

### 🎛️ Settings

Persistent settings have moved from the various contexts to nested types, to separate contextual properties from user settings.

### 👑 Pro

KeyboardKit Pro can now be activated with a license file. License files will be provided to all yearly Gold and Enterprise customers!

The `License` type has new functions to retrieve a license in various ways, to make it easier for you to debug any errors with your license. 

### 🚨 Breaking Changes

There are breaking changes in this version, but most are handled by migration deprecations that will be removed in 9.1. 

Some things that are not covered by migration deprecations are:

* All previously deprecated code has been removed.
* All previously mutable styles and configs are now computed.
* The dictation changes can't be migrated since the new services replace the old ones.
* The `Autocomplete.LocalService` now requires a keyboard context for contextual info`
* The `KeyboardLayout` is now a struct, and must now be a `var` for you to customize it.
* The `StandardSpeechRecognizer` has been refactored, and must be updated for you to use it.`
