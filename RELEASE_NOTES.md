# Release notes

KeyboardKit tries to honor semantic versioning:

* Deprecations can happen at any time.
* Deprecations should only be removed in `major` updates.
* Breaking changes should not occur in `minor` and `patch` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if needed.

These release notes only cover the current major version. 



## 8.7

This version improves the overall autocomplete behavior.

The local autocomplete provider now returns proper unknown statuses for the leading quotation suggestion. The standard action handler will automatically ask the autocomplete provider to learn applied unknown suggestions, if `isAutoLearnEnabled` is `true`.

This way to learn unknown suggestions will hopefully solve many frustrations involved with autocomplete, where the provider will behave better over time. Please provide feedback if these adjustments don't behave as expected.

The local autocomplete provider will also now use any lexicon match as the primary autocorrecting word.

Furthermore, this version adds brand new persistent settings types, adds a `KeyboardLocaleInfo` protocol that makes `KeyboardLocale` and `Locale` share many properties, and makes it possible to define which text to use when ending the current sentence. 

### 🚨 Important Information

* `Autocomplete.LocalProvider` no longer caps suggestions by default. That responsibility is moved to `Autocomplete.Toolbar`.
* `Autocomplete.ToolbarItem` no longer adds quotations around unknown suggestions. That responsibility is moved to `AutocompleteProvider`. 
* `KeyboardInputViewController` now checks more things before performing autocomplete. The keyboard context `prefersAutocomplete` is now also used.
* `KeyboardStyleProvider` and `Keyboard.ButtonStyle` now supports native `Font`s for more design freedom. This may cause breaking changes that should be easy to fix.

### 🆕 New Settings Types
 
* `AutocompleteSettings` is a new observable settings type.
* `DictationSettings` is a new observable settings type.
* `FeedbackSettings` is a new observable settings type.
* `Keyboard.Settings` is a new settings wrapper.

### ✨ Features

* `Autocomplete.Suggestion` has new functions.
* `Autocomplete.TextReplacementDictionary` is new type.
* `AutocompleteContext` has a new `autocorrectDictionary` value.
* `AutocompleteContext` has a new `isAutoLearnEnabled` property.
* `AutocompleteContext` has a new `preferredSuggestionCount` property.
* `AutocompleteContext` has a new `suggestionsToDisplay` property.
* `AutocompleteProvider` has new `ignoreWords(_:)` and suggestion functions.
* `KeyboardBehavior` and its implementations have a new `endSentenceText` property.
* `KeyboardAction.StandardProvider` can now automatically learn unknown suggestions.
* `KeyboardContext` has a new `syncKeyboardType(with:)` to sync type with the proxy.
* `KeyboardController` has a new `endSentence(withText:)` function to end sentences.
* `KeyboardInputViewController` has a new `settings` property for setting instances.
* `KeyboardInputViewController` has a new `viewWillSetupInitialKeyboardType` method.
* `KeyboardLocaleInfo` is a new protocol that is shared by KeyboardLocale and Locale.
* `KeyboardSettings` has new ways to register a custom store and settings key prefix.
* `KeyboardStyleProvioder` has new ways to register a custom store and settings key prefix.
* `UserDefaults` has a new `.keyboardSettings` value that can be used to persist data.

### 💡 Adjustments

* `Autocomplete.Toolbar` no longer needs an injected locale.
* `Autocomplete.ToolbarItem` no longer needs an injected locale.
* `Autocomplete.ToolbarItem` no longer adds quotations to unknown suggestions.
* `KeyboardContex` `prefersAutocomplete` is now computed and no longer synced.
* `KeyboardInputViewController` now checks `KeyboardContext.prefersAutocomplete`.
* `KeyboardLayout.iPhoneProvider` now handles more keyboard types in a better way.
* `KeyboardSettings` have been converted from a namespace to being a part of `Keyboard`.
* `KeyboardStyle.StandardProvider` now sets a smaller font size for the `.text` action type.
 
### 👑 KeyboardKit Pro

* `Autocomplete.LocalProvider` no longer takes a `maxCount` parameter.
* `Autocomplete.LocalProvider` will now return proper unknown state for suggestions.
* `Dictation.ProKeyboardService` uses an action handler to open app and navigate back.
* `Emoji.KeyboardMenu` will now trigger haptic feedback when tapping an emoji category.
* `KeyboardHostApplication` now implements `Identifiable` and has a new `name` property.
* `KeyboardHostApplication` now defines even more applications and has a `url` property.
* `KeyboardHostApplicationProvider` is a new protocol that is implemented by some types.

### 🐛 Bug fixes

* `KeyboardAction.text` now properly renders its texts.
* `KeyboardInputViewController` now sets the initial keyboard type when the native type is ready.
* `KeyboardLayout.iPhoneProvider` no longer inserts two . keys for email keyboards with a go key.
* `UITextDocumentProxy` now proceeds inserting a word replacement even if there's no current word.

### 🗑️ Deprecations

* `Keyboard.ReturnKeyType` `prefersAutocomplete` has been deprecated, since the keyboard type should determine this.



## 8.6

This version adds support for 5 new locales, support for diacritics, and makes it easier to identify the host application. It also improves many of the localized system keyboards that are provided by Pro.

This version also changes the default autocomplete behavior, by making `KeyboardInputViewController` only use the pre-cursor part of the current word for autocomplete, which is how the native keyboard behaves. 

This version also makes KeyboardKit Pro no longer overwrite custom services that are set before registering a license. This means that you can now apply custom services at any time, without it being overwritten. 

This version also reduces load times and memory usage in KeyboardKit Pro, by lazily resolving localized callout action providers and layout providers, and makes all supported locales use the iPad Pro layout.

### ✨ Features

* `Keyboard.Accent` is a new typealias for diacritics.
* `Keyboard.Diacritic` is a new type that lets you model diacritics.
* `KeyboardAction.accent` is a new typealias for the `.diacritic` action.
* `KeyboardAction.diacritic` is a new action that lets you insert diacritics.
* `KeyboardController` has a new `insertDiacritic(_:)` function.
* `KeyboardLayout` and its `Item` has much new functionality.
* `KeyboardLocale` has new locale-based initializers and matching functions.
* `UITextDocumentProxy` has a new `insertDiacritic(_:)` function.

### 💡 Adjustments

* `KeyboardInputViewController` `autocompleteText` now uses the pre-cursor part of the current word, instead of the full word.
* `KeyboardInputViewController` `hostBundleId` has been renamed to `hostApplicationBundleId`.

### 🌐 New Locales

* French (Canada) - fr_CA
* Norwegian (Nynorsk) - nn
* Spanish (Latin America) - es_419
* Spanish (Mexico) - es_MX
* Welsh - cy 

### 👑 KeyboardKit Pro

* `Callouts.StandardActionProvider` now allocates license services lazily, on demand.
* `Keyboard.ToggleToolbar` can now use an external toggle binding.
* `Keyboard.ToggleToolbar` no longer relies on a standard `AnyView`.
* `Keyboard.ToggleToolbarToggle` is a new, customizable toolbar toggle.
* `KeyboardContext` has a new `hostApplication` property.
* `KeyboardHostApplication` is a new enum with known applications.
* `KeyboardInputViewController` has a new `hostApplication` property.
* `KeyboardInputViewController` `setupPro` no longer creates a new callout provider.
* `KeyboardInputViewController` `setupPro` no longer creates a new layout provider.
* `KeyboardLayout` has a new `LatinLayoutType` enum.
* `KeyboardLayout.ProProvider.Czech` now uses proper diacritic keys on iPhone & iPad.
* `KeyboardLayout.StandardProvider` now allocates license services lazily, on demand.
* `KeyboardLocale.georgian` no longer uses regular font weight in alphabetic keyboard.
* `KeyboardLocale.norwegian` has adjusted callout actions.

* These locales now use iPad Pro layout:
    * Arabic
    * Belarusian
    * Bulgarian
    * Catalan
    * Cherokee
    * Hebrew
    * Kazakh
    * Kurdish Sorani
    * Kurdish Sorani - Arabic
    * Kurdish Sorani - PC
    * Persian
    
* These locales have improved iPad Pro layouts:
    * French (Switzerland)
    * Greek
    * Inari Sami
    * Macedonian
    * Mongolian
    
* These locales have improved iPhone layouts:
    * Arabic
    
### 🐛 Bug fixes

* `KeyboardAction.tab` now uses an LTR/RTL supporting icon.
* `KeyboardContext` now matches `keyboardLocale` on language code as well, to work around system bug.



## 8.5.6

This version makes it easier to create a themed style provider, and adds a new `.numberPad` keyboard type.

### ✨ Features

* `Keyboard.KeyboardType` has a new `.numberPad` type.
* `KeyboardStyleProvider.themed` has new convenience apis.

### 💡 Adjustments

* `KeyboardContext` will now get its initial keyboard type set to the document text proxy's keyboard type.



## 8.5.3

This version adds a `licenseError` parameter to `setupPro`.

As such, the `setupProError` in `KeyboardInputViewController` is deprecated and no longer used.



## 8.5.2

This version adds a new `SystemKeyboardBottomRow` component, adds some new actions and fixes a bug.

### ✨ Features

* `KeyboardAction` has a new `.text` action to insert long text.
* `KeyboardLayout` has a new `.bottomRowSystemItemWidth` property. 
* `SystemKeyboardComponent` is a new protocol that defines shared typealiases. 

### 💡 Adjustments

* `KeyboardAction.url` is now a system key.

### 👑 KeyboardKit Pro

* `SystemKeyboardBottomRow` is a new Pro component.

### 🐛 Bug fixes

* `SystemKeyboard` no longer shows the emoji key for insufficient KeyboardKit Pro licenses.



## 8.5.1

This version adjusts the autocomplete behavior for empty text and fixes a gesture bug.

### 💡 Adjustments

* `KeyboardInputViewController` no longer hard resets the autocomplete context when the text is empty.

### 🐛 Bug fixes

* `KeyboardGesture` has a new `.end` gesture, which is used to fix a bug that could cause space drag to never end.

### 👑 KeyboardKit Pro

* KeyboardKit Pro has new ways to allow more flexible feature and tier validation. 



## 8.5

This version moves many types into their related namespaces, to make the SDK surface smaller and easier to overview. Since this involves many renamings, the `Deprecations` section below only lists deprecated types. 

The library has deprecation types to help you migrate to the new type names, so you should not run into any breaking changes when migrating from earlier versions to this one.

The `KeyboardState` namespace has been renamed to `KeyboardStatus`, since it was often confused with `Keyboard.KeyboardState`. `Keyboard.KeyboardState` & `Keyboard.KeyboardServices` have also been renamed to the shorter `Keyboard.State` and `Keyboard.Services`, since it reads better in code.

This version also makes it easier register custom audio and haptic feedback, in a way that now requires less or no customizations in the action handler. Just register any custom feedback for any gesture on any action, and it will be triggered by the standard action handler.

This version also makes the action and input callout bubbles look more native.

Finally, KeyboardKit Pro makes more locales use the new iPad Pro layout. It also provides a brand new `KeyboardApp.HomeScreen` that can be used as an app home screen, and a new `KeyboardStatus.Section` that can show all relevant statuses for a keyboard app.

### 🚨 Important Information 

* Many types are moved into their related namespaces.
* The `EmojiKeyboard` sub-components are now throwing as well.
* The `KeyboardStatus.Label` now uses its style to change icons.
* Renamed types use `@available` deprecations to help adjust your code.

### ✨ Features

* `Feedback.Audio` has a new `customUrl` that can play URL-based audio.
* `Feedback.AudioConfiguration` has new ways to register custom feedback.
* `Feedback.HapticConfiguration` has new ways to register custom feedback.
* `FeedbackContext` has new ways to register custom audio/haptic feedback.
* `KeyboardLayout` has a new `copy()` function that creates a mutable copy.
* `KeyboardLayout` has new functions for using and tweaking the bottom row.
* `KeyboardLayout` has a new `inputToolbarLayout()` value builder function.
* `KeyboardLayout` has a new functions for getting the total layout height.
* `SystemKeyboard`'s service-based initializer now allows a layout override.
* `View` has a new `keyboardInputToolbarDisplayMode` modifier for input toolbars.

### 💡 Adjustments

* `Callouts` now use curves that look a lot more native.
* `Keyboard.Button` no longer has a minimum scale factor.
* `KeyboardApp` is a new namespace for app-related types.
* `KeyboardApp.HomeScreen` is a new app home screen view template.
* `KeyboardLayout.Configuration` now defines number toolbar height.
* `KeyboardFeedback` is a new namespace for feedback-related types.
* `KeyboardSettings` is a new namespace for settings-related types.
* `KeyboardStatus.Label` now uses filled icon variants, by default.
* `KeyboardStyle.StandardProvider` now applies a light weight to backspace.
* `KeyboardStyle.StandardProvider` now applies more adaptive content insets.
* `SystemKeyboard` has been optimized in how it renders the system keyboard.

### 👑 KeyboardKit Pro

* `KeyboardApp.HomeScreen` is a new app-specific home screen template.
* `KeyboardStatus` has a new `Section` view that can display keyboard statuses.
* `KeyboardTextField` and `KeyboardTextView` can now trigger a custom `onSubmit` function.
* `SystemKeyboard` now has an `addNumberToolbar` parameter to add a number toolbar in KeyboardKit Pro.
* The iPad Pro layout has been tweaked to look more native, and is now used by all these locales as well:
* `Catalan`, `Czech`, `Danish`, `Faroese`, `Finnish`, `Georgian`, `German`, `German (Austria)`, `German (Switzerland)`, `Greek`, `Hawaiian`, `Icelandic`, `Inari Sámi`, `Macedonian`, `Maltese`, `Mongolian`, `Northern Sámi`, `Norwegian`, `Russian`, `Serbian`, `Slovak`, `Turkish`, `Ukrainian`.

### 🗑️ Deprecations

* `Callouts.ButtonArea` has been deprecated.
* `Callouts.Curve` has been deprecated.
* `Emoji.Grid` has been moved to `EmojiKit`.
* `KeyboardStyleProvider.buttonContentBottomMargin` is no longer used.



## 8.4

This version bumps to Swift 5.9 and adds support for visionOS.

This version renames some views and refactors view styling to be injected with view modifiers instead of with the initializer.

This version also convers many emoji features to open-source variants, and no longer requires a license to use these features.

Views that require complex style resolving still use the style provider concept.

### 🚨 Important Information

* Most views are now designed to be styled with view modifiers.

* `.keyboardButtonStyle` only injects style with the environment.
* `Emoji` types are no longer throwing. If you use them, remove `try`.
* `Emoji` keyboard views no longer apply the init style. Use the view modifier instead.

### ✨ Features

* `Autocomplete.ToolbarStyle` has support for more styling.
* `Autocomplete.ToolbarItemStyle` has support for more styling.
* `DeviceType` defines a new `.vision` device to support visionOS. 
* `Keyboard.Background` implements `View` and can be used as a plain view.
* `Keyboard.Toolbar` is a new view that applies a min height to its content.
* `Keyboard.ToolbarStyle` is a new style that can be applied with a view modifier.
* `StandardKeyboardBehavior` modifies some functions to be `open` to modifications.

### 💡 Adjustments

* `AutocompleteToolbar` has been renamed to `Autocomplete.Toolbar`.
* `InputSet.standardNumeric` has been renamed to `InputSet.numeric`.
* `InputSet.standardSymbolic` has been renamed to `InputSet.symbolic`.
* `KeyboardButton.Button` and all related views have been moved to `Keyboard`.  
* `KeyboardStyle` styles have all been renamed, e.g. `Autocomplete.ToolbarStyle`.
* `NextKeyboardButton` has been moved and renamed to `Keyboard.NextKeyboardButton`.

### 💡 Renamed View Modifiers

* `.keyboardButtonStyle` has been renamed to `.keyboardButton`.
* `.withEnvironment(fromState:)` has been renamed to `.keyboardState(_:)`.
* `.withEnvironment(fromController:)` has been renamed to `.keyboardState(from:)`.

### 👑 KeyboardKit Pro

* Many `Emoji` functions and types are moved to the base library.

* `Dictation.BarVisualizer` now applies more things with its style.
* `Dictation.BarVisualizer` now applies style with the environment.

### 🐛 Bug fixes

* Some themes have been adjusted to apply correct autocomplete toolbar styles.

### 🗑️ Deprecations

* `Emoji` renames a lof of types & categories, and many things non-throwing.
* `Emoji.Picker` has been deprecated in favor of the EmojiKit open-source view.
* `LazyHGrid`/`LazyVGrid` emoji initializers are replaced by the new `Emoji.Grid`.  
* `KeyboardButton` has been deprecated and all views have been moved to `Keyboard`.
* `KeyboardStyle.AutocompleteToolbarItemBackground` is replaced by `Autocomplete.ToolbarItem`. 
* `Autocomplete.ToolbarItem` nested views are replaced by just using `Autocomplete.ToolbarItem`.

    

## 8.3.3

This version optimizes the binary size of the KeyboardKit Pro framework.

### 👑 KeyboardKit Pro

* The framework size is now almost half in size compared to the 8.0 version.
* The `Color` extension changes in 8.3.1 are now implemented in Pro as well.



## 8.3.1

This version renames all colors to have more obvious naming.

### 🗑️ Deprecations

* `Color` extensions now use `keyboard` as prefix instead of `standard`.



## 8.3

This version adds support for iPad Pro layouts to KeyboardKit Pro, for selected locales.

The documentation has been thoroughly rewritten to be more consistent and to include more images and code samples.

### ✨ Features

* `DeviceType` has a new boolean properties.
* `Image` has many more keyboard image extensions.
* `KeyboardAction` has a new `capsLock` action.
* `Keyboard.Case` has a new `isCapsLocked` property.
* `Keyboard.KeyboardType` has a new `isAlphabeticCapsLocked` property.
* `Keyboard.ReturnKeyType` has a new `nativeType` property on `iOS`.
* `KeyboardLayout.ItemRow` has new `hasKeyboardSwitcher` and `suggestedInputWidth` function.
* `KeyboardLayout.ItemRows` has new `hasKeyboardSwitcher` and `inputWidth` function.
* `KeyboardStyleProvider` has a new `buttonContentInsets` function.

### 👑 KeyboardKit Pro

* `iPadProKeyboardLayoutProvider` is a new layout provider for iPad Pro layouts.
* `ProKeyboardLayoutProvider.spanish` now supports QWERTY, QWERTZ and AZERTY.

### 🔣 Layout Changes

* The new `iPadProKeyboardLayoutProvider` is (so far) used by the following locales:
- `.english` 
- `.albanian`
- `.croatian`
- `.dutch`
- `.dutchBelgium`
- `.estonian`
- `.filipino`
- `.french`
- `.french_belgium`
- `.french_switzerland`
- `.hungarian`
- `.indonesian`
- `.irish`
- `.italian`
- `.latvian`
- `.lithuanian`
- `.malay`
- `.polish`
- `.portuguese`
- `.portuguese_brazil`
- `.romanian`
- `.serbian_latin`
- `.spanish`
- `.slovenian`
- `.swahili`
- `.swedish`
- `.uzbek`

### 🌐 Localization

* `KKL10n` has a new `capsLock` key, which is currently only localized in English.

### 🐛 Bug fixes

* `InputSet.azerty` now displays correctly on iPad.

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
