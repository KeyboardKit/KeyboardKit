# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if needed.

These release notes only cover the current major version. Check out version tags for older release notes.  


## 9.0

This version removes all deprecated code, simplifies many concepts, and prepares for future conformance to strict concurrency.

This version introduces `migration deprecations` that will help you transition from KeyboardKit 8.9 to 9.0. They will be removed in 9.1. 

### 🧪 Experiments

The next keyboard button experiments have been made permanent.

### ⌨️ Essentials

The `KeyboardContext` has a new `keyboardCase` property, and the `.alphabetic` keyboard type is decoupled from the case.

The `KeyboardController` protocol now requires `services` and `state`, to make it more versatile and used in more places.

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

English emoji localization has been drastically improved. 

This version also adds support for Swedish emoji localization. 

The `EmojiKeyboardStyle` has been moved from KeyboardKit Pro to KeyboardKit.

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
