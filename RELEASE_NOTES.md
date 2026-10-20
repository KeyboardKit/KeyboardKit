# Release notes

[KeyboardKit](https://github.com/KeyboardKit/KeyboardKit) honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes can occur in `minor` updates, if the alternative is worse.
* Beta version release tags are removed after the next minor or major version.

This document covers the current major version. See older versions for older release notes.



## 11.1

This version adds support for Khmer, Korean, Luxembourgish, Thai, Xhosa, and Yoruba.

This version detects iPhone Duo devices, and adjusts the keyboard layout and design to match a native Duo experience.

This version replaces mutually exclusive docked, floating, and split placement states with a single placement engine. 

This version adds split keyboard support. Small phone screens will however only support this in landscape orientation.

This version adds a new, experimental autocomplete engine to the plugin, which can handle English, Italian, and Swedish.

### 🌱 Essentials

This version adds a keyboard placement enum and improves how locales are displayed.

* `Keyboard.AddedLocale` will only show its layout type when needed, to avoid clutter.
* `Keyboard.DuoDetector` is a new type that can detect if the device is an iPhone Duo.
* `Keyboard.LayoutType` has two new Thai-specific types - `.thai4Row` and `.thai5Row`.
* `Keyboard.Placement` is a new enum that defines mutually exclusive keyboard placements.
* `Keyboard.PlacementContextMenu` and `Keyboard.PlacementPicker` are two new poicker views.
* `Keyboard.SpacebarLongPressBehavior` has a new `.keyboardPlacementMenu` menu alternative.
* `Keyboard.SpacebarMenuType` has a new `keyboardPlacement` that replaces `keyboardDockEdge`.
* `KeyboardContext` has new `availableKeyboardPlacements` and `keyboardPlacement` properties.
* `KeyboardContext` has a new `isDuoDevice` property, which uses the `DuoDetector`'s detection.
* `KeyboardContext` has a new `setPersistedKeyboardPlacement(_:)` function, which persists a placement.
* `KeyboardView` supports split mode and applies a keyboard placement menu to the dismiss keyboard key.
* `KeyboardView` removes the emoji keyboard switcher if `EmojiSettings.isEmojiSwitcherEnabled` is false.

### 💡 Autocomplete

This version adds a new `Langlot` engine that supports English, Italian, and Swedish.

* `AutocompleteEngine` has new download capabilities.
* `AutocompleteEngineDownloadMenu` is a new menu view.
* `AutocompleteSettings` has a new `isLexiconEnabled` setting.
* `AutocompleteSettingsScreen` has a new lexicon suggestions toggle.
* `AutocompleteToolbarStyle` corner radius defaults to 25.
* `KeyboardAppView` can now inject an autocomplete engine.
* `KeyboardInputViewController` can now inject an autocomplete engine.
* `KeyboardKitAutocompletePlugin` has a new `pluginAutocompleteEngine`. 
* `KeyboardKitAutocompletePlugin` has a new `.langlot(...)` engine builder. 
* `StandardAutocompleteService` ignores the system lexicon when `isLexiconEnabled` is disabled.

### 💬 Callouts

This version lets callout actions define rows, which is used by Thai to present all signs in two rows.

* `KeyboardActionCallout` now renders callout action rows as multiple rows that grow upwards.
* `KeyboardCalloutActions` has a new `actionRowsDictionary` and a new `actionRows(for:)` function.
* `KeyboardCalloutActions` has a new `RowsBuilder` and `keyboardCalloutActionRows(_:)` view modifier.
* `KeyboardCalloutContext` has a new `updateSecondaryActionRows(_:for:in:alignment:)` update function.
* `KeyboardCalloutContext` has new `secondaryActionsRowItemCounts` and `secondaryActionsRowCount` values.
* `KeyboardCalloutContext` drag selection can move up between rows, if callout actions have multiple rows.

### 😀 Emojis

This version adds more emoji settings and a new settings screen.

* `EmojiSettings` has a new `isEmojiSwitcherEnabled` setting.
* `EmojiSettingsScreen` is a new settings screen with toggles and pickers.

### 🔣 Layout

This version adds iPhone Duo-specific keyboard layouts that match the native ones.

* `CGSize` has new `.iPhoneDuoClosedScreen` and `.iPhoneDuoOpenScreen` sizes.
* `KeyboardLayoutConfiguration` has new open and closed iPhone Duo configurations.
* `KeyboardLayoutConfiguration.standard` functions have a new `isDuoDevice` parameter.
* `KeyboardAction.standardButtonFontSize` uses larger input fonts on an open iPhone Duo.
* `KeyboardLayout.iPhoneLayout` adds bottom row spacers on iPhone Duo, to match the native keyboard.
* `KeyboardInputViewController` and `EmojiKeyboard` ignore the iPhone Duo safe area, to match the keyboard.

### 🌐 Localization

This version adds support for `Khmer`, `Korean`, `Luxembourgish`, `Thai`, `Xhosa`, and `Yoruba`.

* `Keyboard.LayoutType` has new `.thai4Row` and `.thai5Row` Thai layout types.
* `Locale.khmer`, `.korean`, `.luxembourgish`, `.thai`, `.xhosa`, and `.yoruba` are new supported locales.
* `Locale` has a new `prefersAutocapitalization` property, `false` for Khmer and Thai.
* `Keyboard.Diacritic` has new `khmerSign` and `khmerSigns` Khmer diacritics.
* `KeyboardLayout` has new `.khmer`, `.korean`, `.luxembourgish`, `.thai`, `.xhosa`, and `.yoruba` builders.
* `StandardKeyboardActionHandler`can now handle Korean input with a separate engine.

### ⚙️ Settings

This version cleans up `KeyboardLocaleSettingsScreen` and moves adding locales to a sheet.

* `KeyboardLocaleSettingsScreen` has a new button that opens an "add more languages" sheet.
* `KeyboardLocaleSettingsScreen` will show suggested languages based on the current locale.
* `KeyboardSettings` has a new `keyboardPlacement` setting, which replaces `keyboardDockEdge`.
* `KeyboardSettings` has a new `isSplitKeyboardSettingAvailable` property which checks the device.
* `KeyboardSettingsScreen` has a new keyboard placement picker, which replaces the one-handed keyboard picker.

### 🐛 Bug Fixes

* `KeyboardCalloutActions` now resolves callout actions for Navajo.
* `KeyboardInputViewController` resolves the input case earlier, to avoid initial flicker.
* `KeyboardView` no longer applies layout edge insets to overlays, like the emoji keyboard.
* `KeyboardLayout` caching now regards the screen size, to handle folding on an iPhone Duo.
* `StandardAutocompleteService` no longer autocorrects valid words to match capitalized contact names.
* `StandardAutocompleteService` now adjusts text replacement casing to match the replaced word.
* `UITextDocumentProxy` fixes an autocomplete bug in how space after the cursor was handled.
* `Vietnamese` fixes a problem where TELEX/VNI/VIQR stopped working after diacritic changes.

### 🚨 Breaking Changes

This version had to change the autocomplete engine due to findings when integrating Langlot.

* `AutocompleteEngineWithDownloadSupport` has been merged into `AutocompleteEngine`.
* `Keyboard.SpacebarLongPressBehavior` and `Keyboard.SpacebarMenuType` has renamed cases.
* `KeyboardLocaleSettingsScreenLocalization` has breaking changes due to its new structure.
* `KeyboardSettingsScreenLocalization.topSectionOneHandedKeyboard` has been renamed to placement.



## 11.0.2, 11.0.3

This version makes the `KeyboardAppHomeScreen` support the iPhone Duo.

### 📱 App

* `KeyboardAppHomeScreen` can now inject a custom `content` view builder.
* `KeyboardAppHomeScreen` can now inject a `selection` and `splitViewColumnVisibility`.
* `KeyboardAppHomeScreenItem` is a new enum that describes all home screen list menu items.
* `KeyboardAppHomeScreenDetail` is a new content view that renders default `KeyboardAppHomeScreenItem` content.
* `KeyboardAppHomeScreenSplitViewMode` is a new enum that can be used to set how the screen adapts to split view.
* `KeyboardAppHomeScreenStyle` has a new `sidebarBackgroundColor` that can be used to customize the sidebar background.

### ⚙️ Settings

* `KeyboardSettingsScreen` now shows a keyboard status section if needed.

### 🩺 Status

* `KeyboardStatusSectionStyle` is renamed to `KeyboardStatusSectionVisibility`.
* `KeyboardStatusSectionVisibility` no longer applies the system settings values.



## 11.0.1

This patch makes it easier to set up dictation, fixes some dictation race conditions, and fixes some App Store submit warnings.

### 🎤 Dictation

* `KeyboardAppView` can now inject a dictation engine, instead of having to use `.keyboardDictation(withEngine:)`.
* `PluginDictationEngine` fixes some thread-related audio session warnings, by using modern, async AVFoundation APIs.
* `StandardDictationService` fixes some engine activation race conditions, and will apply new locales while being idle.

### 📱 App

* `KeyboardAppHomeScreen` can now be used as the sidebar of a `NavigationSplitView`, by providing a selection binding.
* `KeyboardAppHomeScreenItem` and `KeyboardAppHomeScreenDetail` are new types that can be used to show the detail of a selected home screen item.

### 🌐 Localization

This version fixes a warning when submitting your app to the App Store, by removing localized content for locales that the App Store doesn't support.

* `Locale` no longer has empy placeholder files for `cst`, `fla`, `hch`, `kio`, and `nez`.



## 11.0

KeyboardKit 11 uses Swift 6.2 and strict concurrency. This made it possible to remove a lot of dispatch and `MainActor.run` code, which makes the library more stable. This work also involved making more types `MainActor`, while aiming to keep most of the library unchanged. The `KeyboardContext` proxy logic is thus moved to a new main actor-bound `KeyboardControllerContext`, to keep the core context versatile.

KeyboardKit 11 almost doubles the number of supported locales, bringing the total to `111`. This is made possible by the improved diacritics engines, which now supports combination marks. As part of this, we have also improved the layout engine and harmonized many layouts, to keep them consistent across configuration changes, and fixed a bunch of incorrect swipe down actions on iPad.

KeyboardKit 11 also adds a new plugin architecture, which lets us move sensitive code, like permissions and system API usage, out of the core library. This plugin model is an exciting new part of KeyboardKit, and will let us build more capabilities and integrations outside of the core SDK, and let you decide which plugins you want to use.

Finally, this version removes deprecated code, ends all experiments, and uses `LocalizedStringResource` for UI components localization.

### 💡 Biggest Changes

The biggest structural changes in KeyboardKit 11 that will most likely affect you, is how controller-related state has been moved from the keyboard context to the new controller context, and how dictation and host application detection now requires plugins to be enabled.

### 📦 Package

KeyboardKit 11 uses Swift 6.2 and strict concurrency, and defines brand new plugin products.

* The package now uses Swift 6.2 and strict concurrency.
* The package defines new `KeyboardKit...Plugin` products.
* Many types are now `Sendable`, and types that need it are now `@MainActor`.
* dSYMs are now included in the package, so there's no need for a separate download.

### 🌱 Essentials

KeyboardKit 11 cleans up large parts of the library and adds new, powerful diacritic support.

* `Keyboard.BackgroundStyle` is a new, separate background style type.
* `Keyboard.Diacritic` has new Apache, Choctaw, Hawaiian, Hebrew, Navajo, and Samoan variants.
* `Keyboard.Diacritic` has new `combiningMark` replacement support.
* `Keyboard.DiacriticInsertionResult` has been renamed to `DiacriticReplacement`.
* `Keyboard.Diacritic.CombiningMark` is a new type with common combining marks.
* `Keyboard.SpacebarMenuTitle` can now render an image.
* `Keyboard.SpacebarMenuType` has a new `layout` menu that switches between the current locale's layout types.
* `Keyboard.SpacebarMenuType` has a new `dockEdge` menu that switches the one-handed keyboard dock edge.
* `KeyboardContext` has a new `localePresentationCase` that defaults to capitalized.
* `KeyboardControllerContext` is a new context type for controller-specific state.
* `KeyboardInputViewController` has a new `setPreferredKeyboardCase()` function.
* `KeyboardInputViewController`'s setup function can now inject autocomplete engines.
* `KeyboardInputViewController`'s setup function can now inject a host application resolver.
* `KeyboardSettings.isUndoManagerEnabled` is now `true` by default.
* `KeyboardState` has a new `controllerContext` property of type `KeyboardControllerContext`.
* `KeyboardViewDragGestureOverlay` is a new view that maps drag gestures to layout items.
* `KeyboardViewDragGestureOverlayStyle` is a new style that can be applied with `.keyboardViewDragGestureOverlayStyle(_:)`.

### 💥 Actions

KeyboardKit 11 doesn't change the action model in any significant way.

* `KeyboardAction` has a new `isDiacriticAction` property.

### 📱 App

KeyboardKit 11 adds new ways to instruct users how to return to the keyboard.

* `KeyboardAppOpenReasonMessage` is a new message struct.
* `KeyboardAppOpenReasonMessageView` is a new message view.

### 💡 Autocomplete

The new `KeyboardKitAutocompletePlugin` will be used to define additional autocomplete engines in future KeyboardKit versions.

* `KeyboardKitAutocompletePlugin` is a new plugin package.
* `AutocompleteContext` no longer uses dispatch queues to update itself.
* `AutocompleteContext.isLoading` property has been removed.
* `AutocompleteContext` has a new `controllerThrottleInterval` property.
* `AutocompleteEngine` is now public and adjusted to align with the plugin.
* `AutocompleteService` moves some logic to the engine protocol.
* `AutocompleteService` has a new `supportedLocales` property.
* `AutocompleteService` has a new `warmUp()` function.
* `AutocompleteService.autocomplete(_:updating:)` is now `async throws`.
* `AutocompleteSettings.isAutoLearnEnabled` has been removed.
* `AutocompleteSettingsScreen` has been cleaned up and polished.
* `AutocompleteSuggestion` has a new `deleteBackwardsCount` property.
* `AutocompleteSuggestion.isUnknown` has been renamed to `isCurrent`.
* `AutocompleteSuggestionSource` is a new enum with known sources.
* `StandardAutocompleteService` warms up its engine to avoid launch hangs.
* `StandardAutocompleteService` now honors the new delete backwards count.
* `KeyboardInputViewController` now uses the new throttle interval to throttle autocomplete operations.

### 🎤 Dictation

The new `KeyboardKitDictationPlugin` makes it a lot easier to set up dictation, and isolates permissions to the plugin.

* `KeyboardKitDictationPlugin` is a new plugin package.
* `KeyboardKit` has new ways to inject a dictation engine.
* `DictationEngine` defines a standard implementation in the plugin.
* `DictationKeyboardOverlay` now enforces the `DictationSettings.silenceLimit`.
* `DictationMethod` has been removed, since dictation now uses a single method.
* `DictationVolumeRecorder` and `DictationSpeechRecognizer` have moved to the plugin.
* `StandardDictationService` has a new `shouldTryToReturnToKeyboardAfterStartingDictation` property.
* `StandardDictationService` has a new `tryToReturnToKeyboardAfterStartingDictation(with:)` function.

### 🏠 Host Application

The new `KeyboardKitHostPlugin` contains all host application bundle ID logic, and isolates system API usage to the plugin.

* `KeyboardKitHostPlugin` is a new plugin package.
* `KeyboardKit` has new ways to inject a host application resolver.

### 🔣 Layout

This version harmonizes many layouts to keep them consistent across configuration changes.

* Numeric iPad layouts adjust the bottom right keys to enable swipe down.
* All layouts with 3 and 4 input rows now have the same total height.
* `KeyboardLayout` has new `itemFrames`, `item(at:)` and `action(at:)` functions.

### 🌐 Localization

This version adds support for new locales, bringing the total number of supported locales to `111`.

* New supported locales:
    * `Afrikaans`
    * `Basque (France)`
    * `Basque (Spain)`
    * `Bosnian`
    * `English (South Africa)`
    * `Esperanto`
    * `Galician (Spain)`
    * `Kalaallisut`
    * `Kyrgyz`
    * `Māori`
    * `Romansh`
    * `Samoan`
    * `Turkmen`
    * `Yiddish`
    * `Zulu`
* New supported Indigenous North American locales:
    * `Apache`
    * `Blackfoot`
    * `Chickasaw`
    * `Chochenyo`
    * `Choctaw`
    * `Comanche`
    * `Kiowa`
    * `Lushootseed`
    * `Mvskoke`
    * `Nez Perce`
    * `Osage`
    * `Salish`
    * `Wixarika`
* New supported Sámi locales:
    * `Kildin Sámi`
    * `Lule Sámi`
    * `Pite Sámi`
    * `Skolt Sámi`
    * `South Sámi`
    * `Ume Sámi`
    
This version also updates locale information and localized input logic.

* `KeyboardSettings` screens now uses `LocalizedStringResource`.
* `Locale` no longer defines a `flag` and its list items just show text.

### 📄 Proxy

This version removes some task wrappers around async operations.
 
* `UITextDocumentProxy` has new `deleteFullDocumentContext` functions.
* `UITextDocumentProxy.moveTextInputCursor` functions are now async throws.

### ⚙️ Settings

KeyboardKit 11 rewrites the settings store to work better with Swift concurrency.

* `KeyboardSettings` uses a new thread-safe store resolver.
* `KeyboardSettings` now requires a `deviceType` when created.
* `KeyboardSettings` has new `resetStore(for:)` and `resetStore(forAppGroup:)` functions.
* `KeyboardSettingsScreen` has a new top keyboards section that links to the language settings screen.

### 🇻🇳 Vietnamese

KeyboardKit 11 drastically improves the Vietnamese input support.

* `Vietnamese.Diacritic` has new `combiningMark` and `combiningMarkChars` properties.
* `Vietnamese.Diacritic.CombiningMark` mirrors the base `Keyboard.Diacritic.CombiningMark`.
* `Vietnamese.Diacritic.mũ`, `móc` and `trăng` can now be applied to vowels with tones, e.g. `á` + `a` => `ấ`.
* `Vietnamese.Diacritic.mũ` and `móc` can now replace each other, e.g. `ô` + `w` => `ơ`, just like `mũ` and `trăng`.
* `VietnameseInputEngine` can now apply tones to full words, e.g. `Tuân` + `s` becomes `Tuấn` and `moi` + `j` becomes `mọi`.

### 🐛 Bug Fixes

* `KeyboardAction` adjusts the font for currencies like "kr".
* `KeyboardInputViewController` now performs autocomplete on locale change.
* `KeyboardLayout` has been fixed for Hawaiian, by applying a proper macron.

### 🚨 Breaking Changes

* `DictationMethod` has been removed.
* `DictationSpeechRecognizer` has moved to the dictation plugin.
* `DictationVolumeRecorder` has moved to the dictation plugin.
* `GestureButtonScrollState` has been removed.
* `KeyboardApp.keyboardSettingsKeyPrefix` has been removed.
* `KeyboardAppHomeScreen` separates keyboard settings from feature settings.
* `KeyboardAppHomeScreen` `settingsSection*` localization and visibility is renamed to `featureSettingsSection*`.
* `KeyboardAppHomeScreen` keyboard link has moved to a new `keyboardSettingsSection*` section.
* `KeyboardContext` moves proxy logic to `KeyboardControllerContext`.
* `KeyboardContext` moves Liquid Glass logic to `ProcessInfo`.
* `KeyboardContext.autocapitalizationTypeOverride` has been removed.
* `KeyboardExperiment` has no active experiments.
* `KeyboardExperimentContext` has been removed.
* `KeyboardExperimentSettings` has been removed.
* `KeyboardHostApplicationProvider` has been removed.
* `KeyboardInputViewController` lifecycle functions have been reduced.
* `KeyboardInputViewController` now syncs to its contexts, not the other way around.
* `KeyboardInputViewController.originalTextDocumentProxy` is now fully internal.
* `KeyboardSettings.store` and `.storeKeyPrefix` are no longer mutable.
* `Locale.flag` has been removed.
* `Locale.keyboardKitName` has been removed.
* `Vietnamese.allDiacriticVariantsFor*` and `Vietnamese.allDiacriticVowelVariants` have been removed.
