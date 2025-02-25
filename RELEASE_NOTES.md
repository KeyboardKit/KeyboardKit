# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking should only occur in `major` updates, but *can* occur in `minor` and `patch` updates.
* Breaking should only occur in `major` updates, but *can* occur in `minor` and `patch` updates.

These release notes cover the current major version. See older versions for older release notes. 



## 9.3

This version adds support for Vietnamese TELEX, VIQR, and VNI (Beta).

### ✨ Features

* `Autocomplete.ServiceResult` has a new `emojiCompletions` property.
* `Autocomplete.Settings` has a new `isEmojiColonSearchEnabled` property.
* `AutocompleteContext` has a new, observable `emojiCompletions` property.
* `Keyboard.Diacritic` has a new `insertionResult(whenAppendedTo:)` function.
* `Keyboard.LayoutType` has new enum cases for Vietnamese Telex, VIQR and VNI.
* `KeyboardTextInput` is a new namespace for alternate Pro text input methods.

### 👑 Pro

* `App.KeyboardSettingsScreen` has a new toggle to enable emoji colon search.
* `Autocomplete.LocalAutocompleteService` uses emoji colon search if enabled.
* `Emoji.ColonSearch` is a new class for searching emojis with a colon prefix.
* `Keyboard.Diacritic` has new Vietnamese diacritics like the `vietnameseSac`.
* `KeyboardSettings` has new functions for its added locales and layout types.
* `KeyboardTextInput+Vietnamese` is a new namespace for Vietnamese text input.

### 🇻🇳 Localization

* This version adds support for typing in Vietnamese TELEX, VIQR, and VNI.
* `Locale` has brand new support for and localized resources for Vietnamese.

### 💡 Adjustment

* `KeyboardCallout.ActionCallout` now shrinks actions on iPhone if needed.
* `KeyboardCalloutContext` makes it easier to swipe select callout actions.
* `UITextDocumentProxy.insertDiacritic` uses the new diacritic insertion result.

### 🐛 Bug Fixes

* `KeyboardCalloutContext` now properly handles drag gestures on RTL devices.

### 🗑️ Deprecations

* `KeyboardPreviews.CalloutService` is replaced by `KeyboardCallout.BaseCalloutService`.

### 🚨 Breaking Changes

* `KeyboardCalloutContext.updateSecondaryActionsSelection` now requires a drag gesture value.



## 9.2

This version adds a bunch of new settings, for instance to customize the long press behavior of the spacebar and add leading and trailing context menus to it. There are also new settings to add an input toolbar with numbers, emojis, or custom characters, and to dock the keyboard to a horizontal edge. These settings are added to the KeyboardKit Pro settings screen, which means that it's as easy for you to change them with code, as it is for your users to change them in the app.

This version also makes it possible to use alternate keyboard layouts for locales that support it, and to add many keyboards with the same locale, but different layouts, like QWERTY, AZERTY, QWERTZ and Colemak (NEW!). These new layout capabilities are used by the locale context menu, KeyboardKit Pro locale screen, and all pro services, which means that you can let users pick between supported layouts and have them apply automatically, without having to write any additional code for it.

This also version makes the `hostApplicationBundleId` property auto-persisted, so that it can be read from the main app when it's opened from the keyboard. This makes it easy to identify the host app for certain operations. Implementing this exposed a SwiftUI bug, where having AppStorage properties in an observed context class could cause strange SwiftUI rendering loops that caused apps to freeze. To counter this bug, the persistency mechanism have been moved from the context to the settings. 

### ✨ Features

* `Image` has new keyboard picker-specific images.
* `Keyboard.AddedLocale` is a new type for added locales.
* `Keyboard.InputToolbarDisplayMode` has new value builders.
* `Keyboard.LayoutType` is a new, abstract layout type enum.
* `Keyboard.SpaceContextMenu` is a new enum for space menus.
* `Keyboard.SpaceLongPressBehavior` has a new view modifier.
* `KeyboardContext` has new ways to select & switch locales.
* `KeyboardContext` has new ways get the locales datasource.
* `KeyboardContext` auto-persists `hostApplicationBundleId`.
* `KeyboardContext` has new `hostApplication` date properties.
* `KeyboardSettings` has new added locale capabilites and functions.
* `KeyboardSettings` has new space, input toolbar, and dock edge settings.
* `Locale.ListItem` can now display an extra, optional layout type description.

### 💡 Adjustment

* More types implement the `KeyboardModel` protocol.
* The `.keyboardInputToolbarDisplayMode` value is now optional.

* `KeyboardAppView` now injects a `KeyboardStatusContext` environment object.
* `KeyboardContext` now auto-persists the `hostApplicationBundleId` property.
* `KeyboardContext` now uses key paths to minimize the controller sync logic.
* `KeyboardHostApplication` now uses a case-insensitive bundle ID init match.
* `KeyboardView` uses the new environment values, if any, else the keyboard settings.
* `KeyboardLocale.ProLayoutService` now uses the context layout type, if this is set.

* To fix rare SwiftUI hangs, @AppStorage properies have moved from contexts to settings.

### 👑 Pro

* `InputSet.colemak` is used for a Colemak layout.
* `Keyboard.LayoutType` is a new layout type enum.
* `KeyboardApp.LocaleScreen` has new keyboard settings.
* `KeyboardApp.LocaleScreen` has new visibility settings.
* `KeyboardApp.SettingsScreen` has new keyboard settings.
* `Locale` has a new `.supportedLayoutType` for alternate layouts. 

### 🗑️ Deprecations

* `Keyboard.InputToolbarDisplayMode.hidden` is renamed to `.none`.
* `Keyboard.InputToolbarDisplayMode.inputs` is renamed to `.characters`.
* `Keyboard.SpaceLongPressBehavior` deprecates the locale switcher case.
* `Keyboard.SpaceLongPressBehavior` deprecates various should properties. 
* `KeyboardContext.spaceLongPressBehavior` is moved to `KeyboardSettings`.
* `KeyboardSettings` and all other settings types are now top level types.
* `KeyboardSettings.addedLocaleIdentifiers` is replaced by `.addedLocales`.
* `KeyboardTheme` renames `allPredefined` themes and styles to `predefined`.

### 🚨 Breaking Changes

* `Locale.ContextMenu` now passes in a layout type in the view builder.
* `KeyboardContext.addedLocales` now contains `Keyboard.AddedLocale` values instead of `Locale`s.



## 9.1

> [!IMPORTANT]
> This version removes the KeyboardKit 8 migration support! Migrate to the last 9.0 version before updating to 9.1 or later.

This version makes it easier to set up a custom `KeyboardApp`, by removing the need to specify the application `bundleId`. 

This version makes it possible to dock the keyboard to the leading or trailing edge, to simplify one handed typing on iPhone.

This version makes it possible to add a locale context menu directly to the spacebar, instead of using an extra keyboard key.  

### ✨ Features

* `Keyboard.DockEdge` is a new enum that can be used to enable keyboard docking.
* `Keyboard.Settings` has a new `keyboardDockEdge` that enables keyboard docking.
* `Keyboard.SpaceLongPressBehavior` has a new `.moveInputCursorWithLocaleSwitcher`.
* `KeyboardContext` has new `enabledLocales` that usess `addedLocales` or `locales`.
* `KeyboardView` can now docks to any horizontal edge, if `keyboardDockEdge` is set.
* `KeyboardView` now automatically augments emoji keyboard styles for input toolbars.
* `Locale` has a new `shortDisplayName` that returns the language code or identifier.
* `View` has a new `.keyboardDockEdge(...)` modifier, which can apply a custom value.

### 👑 Pro

* `EmojiKeyboard` now renders a lot better for more device types.
* `Emoji.KeyboardMenu` now gets a style builder from the environment.
* `iPadProLayoutService` now renders URL and email keyboard keys better.

### 💡 Adjustment

* Many types now conform to `Codable`, `Sendable` and other essential protocols.
* Upper-case shift and caps-lock has adjusted, default idle colors in dark mode.
* `KeyboardApp` no longer needs you to define `bundleId` and `keyboardBundleId`.
* `KeyboardLayout` & `BaseLayoutService` removes `number` from input toolbar naming.

### 🇪🇸 Localization

* All emojis and emoji catetegories have been localized in Spanish.

### 🐛 Bug Fixes

* `Keyboard.KeyboardType.URL` now renders input keys and bottom actions correctly.
* `KeyboardView` doesn't remove the emoji key if a custom `emojiKeyboard` is used.

### 📄 Documentation

* The documentation has been updated with more information and examples.

### 🗑️ Deprecations

* All migration deprecations have been removed.
* `Gestures` space models have been moved to `Keyboard`.
* `KeyboardLayout.ipadProLayout` has been renamed to `isIpadProLayout`.



## 9.0.6

This version provides some minor bug fixes and improvements.

### 💡 Adjustments

* `Keyboard.Settings` now enables haptic feedback by default, since it's much better.
* `Locale.ContextMenu` now sorts the listed locales in the locale presentation locale.

### 👑 Pro

Fixed outdated platform version information in the distribution package manifest file.  

### 🐛 Bug Fixes

* `Keyboard.Settings` had accidentally marked utilities for added locales as internal.



## 9.0.4

This version adds support for Chuvash and fixes two bugs.

### 🌐 Localization

This version adds support for 🏳️ Chuvash, bringing the number locales up to `71`.

### 👑 Pro

This version switches smarter between the module bundle and distribution bundles. 

### 🐛 Bug Fixes

* `Keyboard+ButtonContent` now properly updates the content when changing locale.
* `Keyboard+Diacritics` adds missing accents and carons for all affected locales.



## 9.0.3

This version adds emoji category texts to all localized files, to fix emoji localization bugs.

### 🌐 Localization

* `EmojiCategory` is now localized in German.

### 👑 Pro

* `Autocomplete.NextWordPredictionRequest.claude` now uses latest Sonnet 3.5 model by default.



## 9.0.2

This version adds more next word prediction and settings utilities.

### ✨ Features

* `Autocomplete.NextWordPredictionRequest` has a new `type` property.

### 👑 Pro

* `Autocomplete.Settings` has a new `nextWordPredictionRequest` property.
* `KeyboardApp.SettingsScreen` has ne sections and can be customized in even more ways.
* `KeyboardInputViewController` sets up settings-based next word prediction if specified.



## 9.0.1

This version adds more next word prediction utilities.

### ✨ Features

* `Autocomplete.NextWordPredictionRequestType` is a new enum.
* `Autocomplete.Settings` has new next word request type and API key properties.

### 👑 Pro

* `KeyboardApp.SettingsScreen` can now show a custom next word prediction section.
 
### 💡 Adjustments

* The various settings types are moved from the contexts to namespaces.
* For instance, `AutocompleteContext.Settings` is now named `Autocomplete.Settings`.
* The contexts still have `Settings` typealiases to keep the previous APIs unchanged. 



## 9.0

This version targets `iOS 15`, `macOS 12`, `tvOS 15`, `watchOS 8`, and `visionOS 1`, removes all deprecated code, and simplifies many concepts.

This version has migration deprecations to help you transition from KeyboardKit 8. Just follow the instructions to migrate your code if needed.

You may still run into breaking changes, where using migrations were not possible. For such breaking changes, see the changes & comments below.

This version moves many non-essential views & utils from KeyboardKit to KeyboardKit Pro, to make the open-source SDK more basic and overviewable.

### 👑 Pro

KeyboardKit Pro can now be used by multiple targets in the same app, using a single app bundle ID.

KeyboardKit Pro can now activate yearly Gold & Enterprise licenses with a standalone license file. 

### 🧪 Experiments

The next keyboard button experiments have been made permanent.

### ⌨️ Essentials

The `KeyboardContext` has a new `isKeyboardCollapsed` as well as a new `isAutoCollapsedEnabled` setting.

The `KeyboardContext` has a new `keyboardCase` that lets us decouple the keyboard type from the keyboard case. 

The `KeyboardContext` has a new `keyboardTypeForKeyboard` that updates to phone when the keyboard is floating on iPad.

The `KeyboardType.alphabetic` keyboard type is also decoupled from the case, which makes the type a lot easier to use.

The `KeyboardController` protocol now has `services` and `state` properties, so that it can be used in even more places.

The `KeyboardView` now supports being used as a floating keyboard on iPad devices, which will render it as a phone keyboard.

The `KeyboardView` now has a `collapsedView` that will be displayed when the keyboard context `isKeyboardCollapsed` is true.

`Keyboard.CollapsedView` is a new standard view that can be displayed when the keyboard context `isKeyboardCollapsed` is true.

### ⚙️ Services

The service name changes and refactoring was a great adjustment, but went a little too far.

Some feedback has been that it's hard to tell services apart since many have the same name.

As such, we take a step back and add the service type to the name. The shorthands stay the same.

The new name for e.g. `KeyboardLayout.StandardService` is now `KeyboardLayout.StandardLayoutService`.

This will hopefully make it easier to distinguish between services when searching and debugging the SDK.  

### 💥 Actions

The `KeyboardAction.StandardActionHandler` now implements `KeyboardBehavior`.

### 📱 App

The `KeyboardApp` now lets you register a custom next word prediction request.

The `KeyboardApp.SettingsScreen` now lets you customize each section with custom content.

### 💡 Autocomplete

The `AutocompleteService` now returns a `Autocomplete.ServiceResult` instead of just a list of suggestions.

The `Autocomplete.NextWordPredictionRequest` is a new type with `Claude` and `OpenAI` integration requests.

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

### 🧩 Extensions

The `String` `.lastSentence` property now includes the last sentence even if it's not ended.

### ⌨️ External Keyboard

The `ExternalKeyboardContext` has been moved to the open-source library and added to `Keyboard.State`.

### 🔉 Feedback

The `Feedback` namespace has been renamed to `KeyboardFeedback`, and simplified quite a bit.

The haptic feedback has been adjusted to be lighter when typing, to make the typing not feel as heavy.

The `FeedbackContext` no longer has enabled configs, since its `settings` is now used to toggle feedback.

### 🏠 Host

The `Host` informaton has been moved to KeyboardKit Pro.

The `KeyboardHostApplication` struct has more information and even more pre-defined apps.

The `KeyboardAction` has a new `.openHost` action that can be used to open a certain app. 

### 🇸🇪 Localization

The `KeyboardLocale` enum has been replaced with using the native `Locale` everywhere.

This version adds 🇦🇺 English (Australia) and 🇨🇦 English (Canada), bringing the number locales up to `70`.

### 🔣 Layout

`InputSet` can now be created with device variations, which allows for resolving device-specific items at runtime.

This makes it possible to render the same input for different devices, which makes the floating keyboard possible.

`KeyboardLayout` is now a `struct` instead of a `class`, which better reflects the value type nature of its model.

This requires you to change any layout variables to use `var` instead of `let` when you want to mutate the layout.

The `KeyboardLayoutIdentifiable` protocol has been removed to make layout item mutations easier to understand & use.

KeyboardKit Pro adds layout item mutations to the `KeyboardLayout` itself, which will allow for future improvements. 

### 🎛️ Settings

Persistent settings have moved from the various contexts to nested `settings` types, to separate properties from settings.

### 🩺 Status

The `KeyboardStatusInspector` has been made internal to avoid using it in incorrect ways.

Use the `KeyboardStatusContext` instead, which manages status information in a better way. 

### 📝 Text Input

The `KeyboardContext` is now responsible for the `textInputProxy`. The controller refers to this proxy, but the context owns it.

The KeyboardKit Pro input text components can therefore be setup with a `KeyboardContext`, and no longer need a controller instance.

### 🍭 Themes

The `KeyboardStyle.ThemeBasedStyleService` can now be created with a theme context, which makes it auto-update when the theme is changed.

### 🚨 Breaking Changes

There are breaking changes in this version, but most are handled by migration deprecations that will be removed in 9.1.

Make sure that you address any migration deprecation warnings you receive, to avoid breaking changes in KeyboardKit 9.1.

Some things that are not covered by migration deprecations are:

* All previously deprecated code has been removed.
* All previously mutable styles and configs are now computed.
* The dictation changes can't be migrated since the services are merged.
* `Autocomplete.Suggestion` implements protocols that required info constraints.
* `Autocomplete.LocalAutocompleteService` now requires a keyboard context for contextual info.
* `InputSet` no longer implements the removed `KeyboardLayoutIdentifiable` protocol.
* `KeyboardLayout` is now a struct, and must now be a `var` for you to customize it.
* `KeyboardStyleService` and callout style view modifiers now only use the base style.
* `StandardSpeechRecognizer` has been refactored, and must be updated for you to use it.

A problem you may face, is that `KeyboardInputViewController.setupKeyboardView(_ view: @autoclosure @escaping () -> Content)` has been renamed to `setupKeyboardView(with:)` to remove DocC ambiguity. If you do, just add `with:`.
