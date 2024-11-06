# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if needed.

These release notes cover the current major version. Check out version tags for older release notes.  


## 💡 KeyboardKit 9.0 Migration Guide

When migrating from KeyboardKit 8.x to 9.x, first upgrade to the last 8.9 version and fix all the deprecation warnings that it provides you with. This will help you prepare for KeyboardKit 9.0.

When you have fixed all deprecation warnings, you should first upgrade to KeyboardKit 9.0. It will provide you with migration deprecations that help you migrate to its many architectural changes.

Once you have fixes all migration deprecations, you are ready to start using KeyboardKit 9.0. You can now configure SPM to use the latest major version number, which will make it use the latest 9.x version.

Note that the legacy migrations will be removed in 9.1, so make sure that you always first upgrade to 9.0 when you upgrade from KeyboardKit 8. If you're on KeyboardKit 7, you should first follow the same procedure to update to 8.0.



## 9.0

This version upgrades the deployment targets to `iOS 15`, `macOS 12`, `tvOS 15`, `watchOS 8`, and `visionOS 1`, removes all deprecated code, and simplifies many concepts.

This version has migration deprecations to help you transition from KeyboardKit 8. Just follow the instructions to migrate your code if needed. They will be removed in 9.1.

You may still run into a few breaking changes, where migrations were not possible due to architectural changes. For such breaking changes, see the changes & comments below.

Migration-based changes that are not listed under "Breaking Changes" will become breaking if you don't address any such warnings before upgrading to KeyboardKit 9.1 and later.

### 🧪 Experiments

The next keyboard button experiments have been made permanent.

### ⌨️ Essentials

The `KeyboardContext` has a new `keyboardCase` that lets us decouple the keyboard type from the keyboard case. 

The `KeyboardType.alphabetic` keyboard type is also decoupled from the case, which makes the type a lot easier to use.

The `KeyboardContext` has a new `keyboardTypeForKeyboard` that updates to `phone` when the keyboard is floating on iPad.

The `KeyboardController` protocol now has `services` and `state` properties, so that it can be used in even more places.

The `KeyboardView` now supports being used as a floating keyboard on iPad devices, which will render it as a phone keyboard.

### 💥 Actions

The `KeyboardAction.StandardHandler` now implements `KeyboardBehavior`.

### 💡 Autocomplete

The `AutocompleteService` now returns a `Autocomplete.ServiceResult` instead of just a list of suggestions.

The `Autocomplete.Suggestion` type now implements `Codable` and `Equatable`. This required additional info changes.

The `Autocomplete.Toolbar` now uses views builder params. The standard views are also polished to look more native.

The `KeyboardInputController` now disables autocorrect instead of autocomplete if a keyboard type doesn't prefer autocomplete.

The reason for the autocomplete change is that custom keyboards must always have top padding, so hiding autocomplete makes little sense.

### 🗯️ Callouts

The `Callouts` namespace has been renamed to `KeyboardCallout` and simplified to only use a single style and a single context.

Most changes have migration deprecations, where using the old ways will either map to the new way, or in some cases do nothing.  

The `KeyboardStyleService` has been adjusted to return an optional callout style, to only override the environment style if it's defined.

The `KeyboardTheme` has been adjusted to only provide a single `calloutStyle`, instead of providing individual action & input callout styles.

The `.calloutStyle` view modifier can therefore be applied to `KeyboardView` now, which will either use the service style or the environment one.

### 🎤 Dictation

The `Dictation` namespace has been simplified to only use a single service that can handle all dictation scenarios.

The new `DictationService` doesn't need a configuration. It uses a `KeyboardContext` & `KeyboardApp` to determine its behavior.

### 😀 Emojis

Emoji localization has been drastically improved, and now supports Swedish localizations. 

The `EmojiKeyboardStyle` has been moved to KeyboardKit. The `.emojiKeyboardStyle` modifier takes a style builder instead of a style, to allow root level styling.

The standard emoji styles no longer take an input toolbar display mode. You can instead use the new `.augmented(for:)` style function if you need to adjust the style.

The KeyboardKit Pro `EmojiKeyboard` has been rebuilt from scratch, and now behaves more like a native keyboard, by scrolling through all categories and supporting search.

### 🇸🇪 Localization

The `KeyboardLocale` enum has been replaced with using the native `Locale` everywhere.

This version adds support for 🇦🇺 English (Australia) and 🇨🇦 English (Canada), bringing the number of supported locales up to `70`.

### 🔣 Layout

An `InputSet` can now be created with device variations, which allows for resolving device-specific items at runtime.

The `KeyboardLayout` type is now a `struct` instead of a `class`, to better represent the value type it's meant to be.

This change from a reference type to a value type may require you to change from `let` to `var` when you modify a layout.

### 🎛️ Settings

Persistent settings have moved from the various contexts to nested `settings` types, to separate properties from settings.

### 📝 Text Input

The `KeyboardContext` is now responsible for the `textInputProxy`. The controller refers to this proxy, but the context owns it.

The KeyboardKit Pro input text components can therefore be setup with a `KeyboardContext`, and no longer need a controller instance. 

### 👑 Pro

KeyboardKit Pro can now be activated with a license file. License files will be provided to all yearly Gold and Enterprise customers. 

### 🚨 Breaking Changes

There are breaking changes in this version, but most are handled by migration deprecations that will be removed in 9.1.

Make sure that you address any migration deprecation warnings you receive, to avoid breaking changes in KeyboardKit 9.1.

Some things that are not covered by migration deprecations are:

* All previously deprecated code has been removed.
* All previously mutable styles and configs are now computed.
* The dictation changes can't be migrated since a new service replaces the old ones.
* The `Autocomplete.Suggestion` additional info are now limited to string-based data.
* The `Autocomplete.LocalService` now requires a keyboard context for contextual info.
* The `KeyboardLayout` is now a struct, and must now be a `var` for you to customize it.
* The `KeyboardStyleService` and callout style view modifiers now only use the base style.
* The `StandardSpeechRecognizer` has been refactored, and must be updated for you to use it.

A problem that you may run into, is that the `KeyboardInputViewController` `setupKeyboardView(_ view: @autoclosure @escaping () -> Content)` has been renamed to `setupKeyboardView(with:)` to remove DocC ambiguity with the controller-based function. If you use this variant, just add an `with:` parameter name.
