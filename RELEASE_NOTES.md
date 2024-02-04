# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` versions.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes can occur in `minor` and `patch` updates, if needed for critical fixes.

These release notes only cover the current major version. 



## 8.3

The documentation has been thoroughly rewritten to be more consistent, up to date, and include more images and code samples.

### ✨ Features

* There are a bunch of new `Image.keyboard...` images.
* `KeyboardLayout.ItemRow` has a new `hasKeyboardSwitcher` function.
* `KeyboardLayout.ItemRow` has a new `suggestedInputWidth` function.
* `KeyboardLayout.ItemRows` has a new `hasKeyboardSwitcher` function.
* `KeyboardLayout.ItemRows` has a new `inputWidth` function.

### 🌐 Localization

* `KKL10n` has a new `capsLock` key, which is currently only localized in English.

### 🗑️ Deprecations

* `Image.keyboardLeft` has been renamed to `.keyboardArrowLeft`.
* `Image.keyboardRight` has been renamed to `.keyboardArrowRight`.



## 8.2.1

### 👑 KeyboardKit Pro

* `SystemKeyboard` now only shows an emoji button if the license key unlocks the emoji keyboard.



## 8.2

This version adjusts localization and adds support for Inari Sámi and Northern Sámi.

### ✨ Features

* `SubmitLabel+CaseIterable` makes the type implement `CaseIterable`.

### 🌐 Localization

* `KeyboardLocale.northernSami` is a new supported locale.
* `KeyboardLocale.inariSami` is a new supported locale.

### 💡 Adjustments

* `KeyboardInputViewController` now unregisters itself as shared controller in deinit.
* `KKL10n` no longer has a `.searchEmoji` key.

### 👑 KeyboardKit Pro

* `PreviousAppNavigator` has been deprecated.
* `.keyboardDictation` modifiers now support injecting a custom service.

### 🗑️ Deprecations

* `KeyboardUrlOpener` has been deprecated.
* `KKL10n.emergencyCall` has been deprecated.
* `KKL10n.keyboardTypeAlphabetic` has been renamed to `.switcherAlphabetic`.
* `KKL10n.keyboardTypeNumeric` has been renamed to `.switcherNumeric`.
* `KKL10n.keyboardTypeSymbolic` has been renamed to `.switcherSymbolic`.
* `KKL10n.ok` has been deprecated.



## 8.1.1

This version fixes a configuration bug in KeyboardKit Pro, that caused autocorrect to not disable.



## 8.1

This version improves autocomplete and localized provider capabilities.

### 🚨 Important Information

This version removes the temporary migration types that were added in 8.0. To upgrade to this or any later version, first update to 8.0 and follow the migration guides. This will remove any breaking changes when upgrading to this version.

### ✨ Features

* `Autocomplete` has a new `AutocorrectionDisabledToContextModifer` modifier.
* `AutocompleteContext` has a new `isAutocorrectDisabled` property.
* `LocaleDictionary` has new getters and setters.
* `StandardCalloutActionProvider` has a new `registerLocalizedProvider` function.
* `StandardKeyboardLayoutProvider` has a new `registerLocalizedProvider` function.
* `View` has a new `autocorrectionDisabled(with:)` modifier.

### 💡 Adjustments

* `SystemKeyboard` now automatically honors any `.autocorrectionDisabled()` that is applied above it.

### 👑 KeyboardKit Pro

* `LocalAutocompleteProvider` `maxCount` is now `public` and mutable.
* `LocalAutocompleteProvider` removes autocorrect suggestions if the context has autocorrect disabled.
* `RemoteAutocompleteProvider` `autocompleteSuggestions` is now `open`.
* `RemoteAutocompleteProvider` properties are now `public` and mutable.
* `RemoteAutocompleteProvider` removes autocorrect suggestions if the context has autocorrect disabled.

### 🐛 Bug fixes

* `KeyboardLocale.kurdish_sorani_pc` now displays its localized name properly in iOS 17.

### 🗑️ Deprecations

* `AutocompleteContext` `isEnabled` is renamed to `isAutocompleteEnabled`.



## 8.0.11

This patch removes previous app navigation from KeyboardKit Pro after sudden App Store review rejections.

### 👑 KeyboardKit Pro

* `KeyboardInputViewController` no longer shows license validation error alerts by default.
* `KeyboardInputViewController` now lets you define whether or not to show a license validation error alert.
* `PreviousAppNavigator` default navigator is removed, since it started causing occasional review rejections.



## 8.0.10

This patch improves the performance of the KeyboardKit Pro license validation.



## 8.0.9

This patch reverts the dictation navigation change that was added to `8.0.7`.



## 8.0.8

This patch improves system keyboard toolbars and the ToggleToolbar in KeyboardKit Pro.

The demo app has been improved to persist the typed text and to show more pro features, like the full document reader and a theme picker. 

### ✨ New Features

* `Collection<KeyboardTheme>` has a new, static `allPredefined` property.
* `KeyboardTheme.ShelfView` is a new view that creates scrolling shelves.
* `KeyboardTheme.ShelfViewItem` is a new view that can be used in a theme shelf view.

### 💡 Adjustments

* `KeyboardTheme.Collection` is now `Identifiable`.
* `SystemKeyboard` now applies a minimum height to custom toolbars, to avoid confusion where they disappear when no height is applied.
* `SystemKeyboardButtonPreview` now disables hit testing for the button view.

### 🐛 Bug fixes

* `Gestures.GestureButton` now has a public initializer.
* `Gestures.ScrollViewGestureButton` now has a public initializer.
* `SystemKeyboardButtonPreview` now uses the passed in style provider, if any.
* `ToggleToolbar` now uses the same default `.slideUp` animation for all initializers.
* `ToggleToolbar` now applies a content shape to the default toggle to improve tap area.

### 🗑️ Deprecations

* `ToggleToolbar` deprecates the `toggleView` initializer in favor for the shorter `toggle` one.



## 8.0.7

This patch fixes an iOS 17 dictation navigation bug and syncs the controller's host bundle ID with the keyboard context.

### ✨ New Features

* `KeyboardContext` has a new `hostApplicationBundleId` property.

### 💡 Adjustments

* `SystemKeyboardButtonPreview` has been simplified and made greedy.
* `SystemKeyboardPreview` can now be used as a header/footer without useing any modifiers.

### 👑 KeyboardKit Pro

* `PreviousAppNavigator` has been configured to work even in iOS 17.
* `StandardKeyboardDictationService` can once again navigate back when dictation finishes.

### 🐛 Bug fixes

* `InputSet.Turkish` has been slightly adjusted.
* `SystemKeyboardButtonPreview` now renders themes correctly.
* `PreviousAppNavigator` now renders themes correctly.

### 💥 Breaking changes 

* `SystemKeyboardPreview` header/footer modifiers are removed since they're no longer needed. See the docs.



## 8.0.5

This patch makes the `BaseKeyboardLayoutProvider` input set properties mutable.



## 8.0.4

This patch makes the `LocalAutocompleteProvider` callout function `open` instead of `public`.



## 8.0.3

This patch improves the text routing views and fixes a big in the text field.

### ✨ New Features

* `KeyboardTextView` makes it easier to define leading and trailing views for the native text field.

### 💡 Adjustments
  
* `KeyboardTextView` applies padding to the native text field's left and right side views.

### 🐛 Bug fixes

* `KeyboardTextView` auto-reset in 8.0.2. This has been fixed.



## 8.0.2

This patch tweaks some migration guides before removing them in 8.1.

This patch moves emoji features from `Emojis` (which was introduced in 8.0) to `Emoji` after developer feedback that `Emojis` was a strange prefix.

This patch makes some Pro views throwing instead of rendering empty content, since this was confusing. If you run into problems with this, just prefix your call with `try?`.

### 🐛 Bug fixes

* KeyboardKit Pro's text routing views no longer crashes in iOS 17 when full access is disabled.

### 💥 Breaking changes 

* `EmojiCategory` initializers are now throwing.
* `Emoji` skin tones are now throwing.
* `Emoji.Version` functionality is now throwing.
* `Emojis` is deprecated since all functionality is moved into `Emoji`.



## 8.0

Welcome to KeyboardKit 8.0 - a massive update to the KeyboardKit SDK!


### 📣 Major Changes

KeyboardKit 8.0 is all about cleaning up the library to make it better structured and easier to use. It removes previously deprecated code, moves types into namespaces, and removes low-value utilities, including types solely used for DocC exposure.

Central types like `SystemKeyboard` are easier to use. Passing state and services instead of a controller reduces the risk for memory leaks. It also no longer needs a width, but will take up as much space as it needs.

These updates has helped enabling new features, like fading the keyboard buttons while moving the cursor with space and other quality of life improvements and fixes. Accessibility has been drastically improved and the emoji keyboard redesigned.

Most emoji features are now Pro features, including the emoji keyboard. The `SystemKeyboard` automatically removes the emoji key if no emoji keyboard is available.

The documentation has been extensively updated to provide more information and code examples. Please report any inconsistencies found, as many changes have been made.

I hope that you will love this major update to KeyboardKit!


### 🛟 KeyboardKit 8 Migration Help

If you're a KeyboardKit 7 user, the best way to migrate to KeyboardKit 8 is to first upgrade to the last available 7.9 version. This version contains deprecations that helps you prepare for some of the changes in KeyboardKit 8.

As you then upgrade to KeyboardKit 8, the 8.0 release has many TEMPORARY deprecations to assist migration from KeyboardKit 7. These temporary deprecations will be removed in 8.1.

You may run into some breaking changes, since there are some type changes that can't be handled by these deprecations. I have tried to keep these to a minimum, but see the breaking changes section below if you run into any problems.

### 🚨 Important Information

Here's a list of some things that may be important to know

* `KeyboardInputViewController` has moved state properties into a `state` property.
* `KeyboardInputViewController` has moved service properties into a `services` property.
* `StandardKeyboardActionHandler` no longer remembers tapped emojis. This is done with the pro handler.
* `SystemKeyboard` provides MUCH easier customization, but requires explicit view builders.
* `SystemKeyboard` now hides the `emoji` keyboard key if `emojiKeyboard` is an `EmptyView`. 
* `SystemKeyboard` no longer has an emoji keyboard by deafult, since it's now a Pro feature.
* `SystemKeyboard` no longer auto-hides the toolbar. You can do this in the `toolbar` builder.

### ✨ New Features

* `InputSetBasedKeyboardLayoutProvider` is a new provider.
* `KeyboardAction` now has a `standardAccessibilityLabel`.
* `KeyboardAction.emoji` can now be created with a string.
* `KeyboardActionHandler` now handles autocomplete suggestions.
* `KeyboardButton` now has `edgeInsets` and an `isPressed` binding.
* `KeyboardContext` has proxy properties that mirror the controller.
* `KeyboardInputViewController` has a new `setupProError` property.
* `KeyboardLayout.Item` has a new `width(forRowWidth:inputWidth:)` function.
* `KeyboardLocale` has new initializer that supports fuzzy name initialization.
* `KeyboardLocale` has new, convenient collection extensions to get locales.
* `KeyboardStyle.Background` now supports specifying images in more ways.
* `KeyboardStyle.Background` now supports specifying the image content mode.
* `KeyboardStyle.Button` now supports background color AND background style.
* `KeyboardStyle.EmojiKeyboard` has a lot more configuration parameters now.
* `SpaceDragGestureHandler` properties are now mutable to allow customizations.
* `SystemKeyboard` has new view builders to make it MUCH easier to customize it.
* `SystemKeyboard` now fades out the buttons when a space cursor drag is active.
* `StandardKeyboardActionHandler` can now be created on all supported platforms.
* `StandardKeyboardActionHandler` has a new `emojiRegistration` property.
* `StandardKeyboardActionHandler` has a new `tryRegisterEmoji(after:on:)`.
* `StandardKeyboardActionHandler` has a new `tryPerformAutocomplete(after:on:)`.
* `StandardKeyboardStyleProvider` now adjusts styles when a space drag is active.
* `View.keyboardButton` supports custom insets and applies a menu to `nextLocale`.
* `View.keyboardButton` applies accessibility labels for actions that define them.
* `View.keyboardButton` is a new extension that applies both a style and gestures.
* `View.keyboardCalloutContainer` is a new extension that will apply both callouts. 
* `View.keyboardLayoutItemSize` is a new extension that applies a layout item size.

### 💡 Adjustments
  
* `AutocompleteProvider` is now async.
* `EmojiKeyboard` uses the standard context style as default.
* `Gesture.KeyboardButtonGestures` no longer blocks space releases.
* `InputSet` has been converted to a struct. All subsets are removed.
* `KeyboardAction` no longer defines a default `.nextKeyboard` action.
* `KeyboardController` has fewer functions, since it's not used as much.  
* `KeyboardInputViewController` is no longer used to insert suggestions.
* `SystemKeyboard` no longer needs you to provide it with an explicit width.
* `SystemKeyboard` now guides you to use the controller-based setup function.
* `KeyboardInputViewController` `textDidChange` performs operations after a delay. 

### 👑 KeyboardKit Pro

* Many emoji types have become Pro features.
* Many routing types have become Pro features.
* The pro setup error view has been redesigned.
* The pro setup error view now overlays your view.

* `EmojiKeyboard` has a new state/services initializer.
* `EmojiKeyboard` has menu icons that look more native.
* `Emojis.Categories` filters out all unavailable emojis.
* `Emojis.Version` has more ways to handle emoji versions.
* `ExternalKeyboardContext` class is now a Pro feature.
* `FeedbackToggle` parameter is renamed to configuration.
* `FullDocumentContextReader` has been removed (use proxy).
* `KeyboardTextField` & `KeyboardTextView` are now Pro features.
* `LocalAutocompleteProvider` autocorrects `i` to `I` in English.
* `ProCalloutActionProvider` is a new Pro callout action provider.
* `RemoteAutocompleteProvider` is now available to all license tiers.
* `SystemKeyboardPreview` replaces all other system keyboard previews.
* `SystemKeyboardButtonPreview` is a new system keyboard button preview.
* `KeyboardInputViewController` has a license config action for both setups.

### 🐛 Bug fixes

* `Emojis.Version` fixes an iOS availability bug for Unicode v15.
* `FeedbackConfiguration` used an incorrect disabled audio config by default.
* `KeyboardAction.backspace` didn't properly trigger autocapitalization.
* `SystemKeyboard` now uses images for `.space` from the style provider.
* `textDidChange` performs autocomplete after an async delay, to let the proxy update.
* `textDidChange` applies autocapitalization after an async delay, to let the proxy update.
    
### 💥 Breaking changes 

* All deprecated code has been removed.
* DocC exposing types have been removed. 
* Many emoji types have been moved to Pro.
* Many routing types have been moved to Pro.
* English input sets have been moved to Pro.
* Migration deprecations are not listed here.

* `AudioFeedback.Engine` is no longer open to inheritance.
* `Autocomplete.ToolbarItemSubtitle` init takes a suggestion.
* `CalloutContext.ActionContext` no longer uses an action handler.
* `CasingAnalyzer` has been removed (use `String` extensions).
* `DisabledCalloutActionProvider` has been removed.
* `EmojiKeyboardItem` has been removed.
* `EmojiProvider` has been removed.
* `EnglishCalloutActionProvider` is now a Pro feature.
* `EnglishKeyboardLayoutProvider` has been removed.
* `ExternalKeyboardContext` is now a Pro feature.
* `FeatureToggle` has been removed.
* `HapticFeedback.Engine` is no longer open to inheritance.
* `KeyboardAction.emojiCategory` has been removed.
* `KeyboardCharacterProvider` has been removed (use `String` extensions).
* `KeyboardColor` has been made internal.
* `KeyboardColorReader` has been removed (use `Color` extensions).
* `KeyboardContext` no longer has a controller-based init (use `sync(with:)`).
* `KeyboardContext` `textDocumentProxy` is read-only, but `originalTextDocumentProxy` can be set.
* `KeyboardHostingController` has been made internal.
* `KeyboardSettingsUrlProvider` has been removed (use `URL.keyboardSettings`).
* `KeyboardStyle.EmojiKeyboard` has different parameters for the new menu design.
* `KeyboardTextContext` was not used and has been removed to avoid complexity.
* `Routing` text input components are now Pro features.
* `KeyboardTextField` was not used and has been removed to avoid complexity.
* `LocaleDirectionAnalyzer` has been removed (use `Locale` extensions).
* `LocaleNameProvider` has been removed (use `Locale` extensions).
* `NextKeyboardController` has been made internal.
* `QuotationAnalyzer` has been removed (use `String` extensions). 
* `SentenceAnalyzer` has been removed (use `String` extensions).
* `StandardCalloutActionProvider.standardProvider` has been removed.
* `StaticKeyboardLayoutProvider` has been removed.
* `SystemKeyboard` now requires explicit view builders.
* `SystemKeyboardItem` can no longer be initialized outside the library. 
* `ToggleToolbar` is now a Pro feature.
* `View.keyboardButtonStyle(...)` no longer has an `isPressed` parameter.
* `WordAnalyzer` has been removed (use `String` extensions).
