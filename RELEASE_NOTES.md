# Release notes

[KeyboardKit](https://github.com/KeyboardKit/KeyboardKit) honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version release tags are removed after the next minor or major version. 

This document covers the current major version. See older versions for older release notes.



## 10.1

This version adds support for secondary swipe down actions on iPad, and improves performance through view cleanups and layout caching.

Swipe down actions are automatically applied to all localized input sets with 3 input rows, and can also be customized for any layout.

This version also makes `KeyboardApp.HomeScreen` and `KeyboardStatus.Section` non-pro features. This means that everyone can use them.

This version also lets you create and pass in your own custom host application values, which lets you extend this logic with more apps.

### 💥 Actions

* `KeyboardAction` has a new `.keyboardInputType` action.

### 📱 App

* `KeyboardApp.HomeScreen` is now available for everyone to use.
* `KeyboardApp.HomeScreen` will only link to available features.

### 📺 Device

* `DeviceType` has a new `prefersSecondarySwipeDownActions` property.

### ⌨️ External Keyboards

* `ExternalKeyboardContext` has a new `isEnabledOnSimulator` property.

### 🧪 Experiments

* `Experiments` is a new type that can be used to enable and disable experimental features.

### 🏠 Host

* `KeyboardHostApplication` can now use an additional app collection.
* `KeyboardHostApplicationProvider` has a `hostApplication(...)` that takes an additional app collection.

### 🔣 Layout

* `KeyboardLayout` and related types now support secondary actions.
* `KeyboardLayout` now applies secondary swipe down actions on iPad.
* `KeyboardLayout.InputSet` can apply secondary actions from other sets.

### 🌐 Localization

* `Locale` has a new `prefersSecondarySwipeDownActions` property.

### 📈 Performance

* `Keyboard+ButtonGestures` doesn't render additional geometry proxies.
* `KeyboardLayout` uses a new layout cache to improve typing performance.
* `KeyboardLayout` caching must be enabled with the new `Experiments` type.

### 🎛️ Settings

* `KeyboardSettings` has a new `isSwipeDownActionsEnabled` setting.

### 🐛 Bug fixes

* `Autocomplete.ToolbarItem` fixes a title alignment bug.
* `ExternalKeyboardContext` will by default not be enabled on Simulator.
* `Keyboard.ButtonStyle` fixes a font weight bug for some image actions.
* `Keyboard.StandardBehavior`'s double tap on space logic is more robust.
* `KeyboardLayout` now hides the emoji key for unsupported keyboard types.
* `KeyboardInputViewController` handles keybord type and input type changes better.

### 🚨 Breaking Changes

* All migration deprecations have been removed.
* `GestureButton` now provides a geometry proxy in its actions.



## 10.0.5

This patch adds some layout extensions and fixes layout bugs.

This patch also adds missing deprecation attributes that should have been in 10.0. 

### 🔣 Layout

* `KeyboardLayout` has a new `hasKey(for:)` extension.
* `KeyboardLayout` has new iPhone and iPad bottom row logic.

### 🗑️ Deprecations

* `KeyboardContext` sets two unused properties to deprecated.
* `KeyboardContext.hasDictationKey` should have been deprecated in 10.0. 
* `KeyboardContext.keyboardDictationReplacement` should have been deprecated in 10.0. 



## 10.0.4

This patch fixes some liquid glass bugs.

### 🐛 Bug fixes

* `KeyboardAction.standardButtonText(for:)` returns nil for some iPad keys on Liquid Glass.
* `KeyboardAction.standardButtonBackgroundColor(for:)` fixes a primary key press color bug.
* `KeyboardAction.standardButtonForegroundColor(for:)` fixes an upper-case shift color bug.



## 10.0.3

This patch fixes a dictation race condition, where the dictated text weren't always sent to the host application.

### 🐛 Bug fixes

* `Dictation.StandardDictationService` has a race condition fix.



## 10.0.2

This patch includes dSYMs, which should make it possible to retrieve detailed crash reports from production.



## 10.0.1

This patch adds more host applications and fixes a bug where keys were not highlighted if a theme wasn't applied.

The emoji keyboard handles skin tones swipes better and tweaks the popover offset to avoid cutting off top emojis.

This patch also improves and fixes accessibility, and enables the accessibility rotor which can change the typing mode. 

### 🌱 Essentials

* `Keyboard.ButtonStyle` now defines a background opacity.

### ♿ Accessibility

* `Keyboard+ButtonGestures` now applies `isKeyboardKey` instead of `isButton`.
* `Keyboard+ButtonGestures` now enables the rotor and setting the typing mode.
* `Keyboard+ToggleToolbar` applies `.accessibilityHidden` to the hidden toolbar.
* `Keyboard+ToggleToolbar` applies new accessibility guides to the toolbar toggle.
* `KeyboardView` uses these new updates to activate the rotor in the main keyboard.

### 😀 Emojis

* `EmojiKeyboard` lets you swipe between skin tones without first having to swipe up.
* `EmojiKeyboard` uses the `.popoverSwipeDownCancelThreshold` to dismiss the popover.
* `EmojiKeyboard.Sizes` adjusts the `popoverVerticalOffset` to avoid popover cut-offs.
* `EmojiKeyboard.Sizes` has a new customizable `popoverSwipeDownCancelThreshold` property.

### 🏠 Host Application

* `KeyboardHostApplication.allCases` defines some new apps.

### 🐛 Bug fixes

* `Clipboard.SettingsScreen` doesn't show empty clip sections.
* `Keyboard.ButtonStyle` now applies highlighting without a theme.



## 10.0

> [!IMPORTANT]
> KeyboardKit 10 no longer has binary licenses encoded into the binary. You need a license file or a subscription license key. The license files use a new format, which means old license files no longer work. License file customer will receive an updated license file when KeyboardKit 10 is released. Until then, email us at  info@keyboardkit.com to get an updated license.

KeyboardKit 10 merges KeyboardKit and KeyboardKit Pro into a single, unified SDK that targets iOS 16, macOS 13, tvOS 16, watchOS 10, and visionOS 1.

There's a new 📋 clipboard feature that can paste text from the system clipboard, of from a collection of user-created text clips. The new clipboard keyboard type will automatically switch to a clipboard screen that can paste from the keyboard.

There's a new 𝓐 fonts feature that makes it possible to type with a unicode font.

The local autocomplete service can now perform remote prediction, using requests. As a result, the remote service is not needed and has been removed and the local service has been renamed to `StandardAutocompleteService`.

The Pro settings screens have been improved, and separated into feature-specific screens. These screens expose more settings than before, and there are also more keyboard settings to let you and your users configure the typing behavior.   

Finally, the callout, layout and style services have been replaced by values and view modifiers and have been removed from the library. All views use environment injections for observable state instead of init injection. Some of these changes are breaking.

### 🛣️ Upgrading from KeyboardKit 9

* To upgrade from even older versions, see each major version upgrade guide.
* To upgrade from KeyboardKit 9.x to 10.x, first upgrade to KeyboardKit 9.9.
* Make sure to address all deprecation warnings (if any) before you proceed.
* You can now upgrade to KeyboardKit 10.0, using the new, unified framework.
* If you face breaking changes, see the breaking changes section at the end.
* If you get migration deprecation warnings during build, you must fix them.
* You are done upgrading when you have no more breaking changes or warnings.

### ⚠️ Migration Deprecation Warnings

* Most outdated parts of the library have been removed in this major version.
* Some outdated parts still remain, to help you migrate from KeyboardKit 9.9.
* These outdated parts will trigger migration deprecation warnings when used.
* Code that triggers a migration migration warning will not work as expected.
* The legacy migration deprecations will then be removed in KeyboardKit 10.1.

### 📦 Package

* KeyboardKit now targets iOS 16 and aligned versions.
* The binary framework file is now almost 20% smaller.

### 🤝 License

* KeyboardKit 10 requires a new license file format.
* KeyboardKit 10 now requires a license file or key.
* There are no binary licenses bundled with the SDK.
* License locales are no longer parsed from Gumroad.
* Basic and Silver licenses must specify locales in the keyboard app value.

### 🌐 Localization

* `Keyboard.LayoutType` has `.turkishQ` an `.turkishF` values.
* `Turkish` now supports `Turkish Q`, `Turkish F` and `QWERTY`.

### 📱 App

* `KeyboardApp` only contains the `HomeScreen`.
* `KeyboardApp` screens have been moved to their separate namespaces.
* `Keyboard.SettingsScreen` has been split up into individual screens.

### ⚡️ Autocomplete

* `Autocomplete` has a new `SettingsScreen`.
* `LocalAutocompleteService` is renamed to `StandardAutocompleteService`.
* `NextWordPredictionRequest` has been renamed to `RemotePredictionRequest`.
* `NextWordPredictionRequestType` has a new `standardRequest(for:)` builder.
* `RemotePredictionRequest` can now create fully custom prediction requests.
* `RemotePredictionRequest.claude` uses `claude-sonnet-4-20250514` by default.
* `RemotePredictionRequest.claude` can now be used to perform custom requests.
* `RemotePredictionRequest.openAI` can now be used to perform custom requests.
* `RemotePredictionRequest.SystemPrompt` has Claude & OpenAI-specific prompts.
* `StandardAutocompleteService` has renamed and removed some public functions.
* `StandardAutocompleteService` has a new `remoteAutocompleteRequest` property.
* `StandardAutocompleteService` `shouldPerformNextWordPredictions` is now true for empty text.

### 📋 Clipboard

* `Clipboard` is a new namespace with clipboard-related features.
* `Clipboard` has a `ClipsScreen` for managing custom user clips.
* `Clipboard` has a `SettingsScreen` for clipboard clip settings.
* `ClipboardContext` can be used to manage a user's custom clips.
* `ClipboardSettings` has an auto-persisted `clips` list property.

### 😀 Emojis

* `EmojiKeyboard` has been rewritten from the ground up.
* `EmojiKeyboard` has rewritten styling and configurations.
* `EmojiKeyboard` is now more performant and memory efficient.

### 𝓐 Fonts

* `Fonts` is a new namespace with font-related features.
* `Fonts` has a `SettingsScreen` that can pick a custom font.
* `Fonts.UnicodeFont` is a model with Unicode-based font logic.

### 🎛️ Settings

* `KeyboardSettings` has a new `isDoubleTapOnShiftToCapsLockEnabled`.
* `KeyboardSettings` has a new `isDoubleTapOnSpacebarToCloseSentenceEnabled`.

### 🍭 Themes

* `KeyboardTheme.blueprint` is a brand new theme.
* `KeyboardTheme.aesthetic(.boho)` has been removed.

### ✨ Misc. Features

* `DeviceType` has a `preferredKeyboardDeviceType`.
* `Feedback.Toggle` no longer requires a Pro license.
* `Keyboard.BottomRow` no longer requires a Pro license.
* `Keyboard.InputType` is a new enum to handle input types.
* `KeyboardLayout` makes many features available to everyone.
* `KeyboardType` has a new `.clipboard` specific keyboard type.
* `KeyboardViewStyle` has new rounded corner radius properties.
* `KeyboardViewStyle` now applies rounded corners on Liquid Glass.
* `View` has a `.keyboardViewBackground` modifier to set the background.

### 💡 Misc. Changes

* Views now use environment injection for all observable contexts.
* The library has changed many space occurences to use "spacebar".
* This makes it easier to see when it means the physical spacebar.
* `Autocomplete.StandardAutocompleteService` fixes unknown quotes.
* `Keyboard.ButtonContent` no longer shows locale name for spaces.
* `Keyboard.KeyboardType` has converted some types to input types.
* `KeyboardApp.HomeScreen` now hides links to unavailable features.
* `KeyboardLayout` now uses an iPad Pro layout on all iPad devices.
* `KeyboardSettings.isKeyboardAutocollapseEnabled` default to true.
* `KeyboardView` is easier to create with a lot fewer initializers.
* `KeyboardView` now renders as on iPad on macOS, tvOS and visionOS.
* `KeyboardView` now takes `services` instead of individual services.

### 🐛 Bug Fixes

* `Autocomplete.ToolbarItem` applies quotes to unknown suggestions.
* `AutocompleteSettings.isAutocompleteEnabled` behaves more correct.

### 🚨 Breaking Changes

* All previously deprecated code has been removed.
* The emoji keyboard has been refactored in breaking ways.
* The callout, layout and style services have been removed.
* The services have been replaced by values and view modifiers.
* The pro settings screens have been refactored in breaking ways.
* `Keyboard.BottomRow` now requires using the `services` initializer.
* `Keyboard.KeyboardCase.auto` is no longer used and has been removed.
* `KeyboardApp` screens have all been moved to each related namespace.
* `KeyboardContext` `deviceTypeForKeyboardIsIpadPro` has been removed.
* `KeyboardLayout` `deviceConfiguration` is converted to non-optional.
* `Locale.ContextMenu` no longer supports using custom menu item views.
* `RemoteAutocompleteService` has been replaced by using remote request.
