# Release notes

KeyboardKit tries to honor semantic versioning:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes can still occur in minor versions and patches, though, if the alternative is to not be able to release new critical features or fixes.



## Planned changes for 7.0

Some things that are planned for the 7.0 release:

* The keyboard action should only support `press` and `release` and not `tap`.
* The system keyboard gestures should support swipe to type and predictive type.
* All dependencies to the shared instances will be replaced with init parameters, even for the smallest view.  



## 6.8.1  

### 🐛 Bug fixes

* This release fixes an invalid localization for the English return key.



## 6.8

This release adds 5 new locales, which brings the number of supported locales to 60!

To get locales like Armenian to work, this version starts to break up the layout engine in smaller parts, to make it easier to manage as the number of locales grow. The iPhone and iPad layout providers will be converted to base classes and inherited by locale-specific providers.

Note that a bunch of `StandardKeyboardLayoutProvider` things are deprecated in comments only, since the library still has to use them. These will be removed in the next major update.  

### 🌐 New locales

* 🇦🇲 Armenian
* 🏳️ Cherokee
* 🇮🇩 Indonesian
* 🇲🇾 Malay
* 🇺🇿 Uzbek

### 👑 KeyboardKit Pro

* `FullDocumentContextConfiguration` now uses a longer, default delay. 
* `FullDocumentContextResult` now contains more information. 
* `ProKeyboardLayoutProvider` is a new base class for pro layout providers.
* `ProKeyboardLayoutProvider.Armenian` is the first, new layout provider that uses this new architecture.
* `ProKeyboardLayoutProvider.German` and all German variants now correctly replaces `.return` with `.newLine`.
* `UITextDocumentProxy` `fullDocumentContext` has been adjusted to behave better.
* `UITextDocumentProxy` `fullDocumentContext` will now throw an error if it's called while a read operation is in progress.

### ✨ New features

* `EnglishKeyboardLayoutProvider` is a new, open class that provides English keyboard layouts.
* `InputSetProviderBased` is a new protocol that is used to keep track of types that rely on an input set provider.
* `KeyboardActions` has new character margin actions properties.
* `KeyboardContext` has a new `keyboardDictationReplacement` property.
* `KKL10n` has a new `join` case, although localiations are missing for most locales.
* `StandardInputSetProvider` `keyboardContext` is now public.
* `StandardKeyboardLayoutProvider` can now take a collection of localized layout providers.

### 💡 Behavior changes

* `SystemKeyboard` now applies locale as identifier to force update its rows.
* `StandardKeyboardActionHandler` now ignores autocomplete suggestions when the cursor is at the beginning of a word.
* `SystemKeyboardLayoutProvider` now uses the `KeyboardContext` `keyboardDictationReplacement` instead of the injected value.
* `SystemKeyboardLayoutProvider` will for now set the `KeyboardContext` `keyboardDictationReplacement`, if one is provided, to not cause any old code to break.

### 🗑 Deprecations

* `KeyboardLayoutProvider` dictation replacement initializers and properties are deprecated.
* `StandardCalloutActionProvider` `providerDictionary` has been renamed to `localizedProviders`.
* `StandardInputSetProvider` `providerDictionary` has been renamed to `localizedProviders`.
* `KeyboardInputTextComponent` has been renamed to `KeyboardInputComponent`.
* `StandardKeyboardLayoutProvider` `inputSetProvider` is in-comment deprecated.
* `StandardKeyboardLayoutProvider` `iPhoneProvider` is in-comment deprecated.
* `StandardKeyboardLayoutProvider` `iPadProvider` is in-comment deprecated.
* `StandardKeyboardLayoutProvider` leading and trailing margin action functions are deprecated.
* `SystemKeyboardActionButtonContent` now applies a padding and minimum scale factor to text views. 

### 💥 Breaking changes

* `StandardKeyboardLayoutProvider` now requires a keyboard context.
* `KeyboardAction` no longer implements `KeyboardRowItem`.



## 6.7.3

### 👑 KeyboardKit Pro

* `ProCalloutActionProvider` has a new `all()` function.
* `ProInputSetProvider` has a new `all()` function.
* `English` and `US English` callout action providers now also show emoji skin tone variants.



## 6.7.2

### ✨ New features

* `KeyboardAction` has a new `isSpacer` property.
* `KeyboardButtonStyle` has a new, static `spacer` style.

### 💡 Behavior changes

* `SystemKeyboardButtonRowItem` now always apply the new spacer button style to spacer actions.

### 🐛 Bug fixes

* Some system keyboard character margin actions have been corrected.



## 6.7.1

### 🐛 Bug fixes

* English no longer replaces alternate ending quotation delimiters for English.



## 6.7

This version adds more emoji features, such as improved unicode names and localized names.

Localizing emojis is a major undertaking and therefore a community effort. Please see the documentation for information on how to help with localizing emojis.

### ✨ New features

* `AutocompleteToolbarStyle` has a new optional `height` parameter.
* `CharacterProvider` is a new protocol that will let us design better character-based extensions over time.
* `Emoji` has new `localizationKey` properties that are used to translate emoji names.
* `Emoji` has new `localizedName(for:)` functions that are used to translate emoji names.
* `Emoji` has new `unicodeNameOverride` properties, to provide good names and localization keys for the various flags.
* `Emoji` has new `matches` functions, that lets you match on emoji unicode and localized names.
* `Emoji` collections have new `matching` functions, that lets you search for emojis that match a certain search query.
* `EmojiCharacterAnalyzer` is a new protocol that is implemented by `Character`.
* `EmojiStringAnalyzer` is a new protocol that is implemented by `String`.
* `KeyboardInputViewController` now only syncs proxy if it changes, which leads to fewer redraws.
* `KeyboardRootView` no longer defines an explicit id.
* `KKL10n` has a new `searchEmoji` key that must be localized in all `Localizable.strings` files.
* `KKL10n` can now be used to translate custom keys as well, using the same bundle resolve.
* `LocaleContextMenu` is a new view modifier for applying a locale context menu to any view.
* `PrefersAutocompleteResolver` is a new protocol that is implemented by `KeyboardType` and `UIKeyboardType`.
* `StringProvider` is a new protocol that will let us design better string-based extensions over time.

### 💡 Behavior changes

* `AutocompleteToolbar` now applies the height from its style.
* `Emoji` has better unicode names for all flag emojis.
* `EmojiCategoryTitle` doesn't have a default padding anymore.
* `KeyboardRootView` no longer applies an explicit id.
* The demo keyboards use the autocomplete prefered info to adjust the toolbar's opacity.

### 🐛 Bug fixes

* By no longer applying an explicit id to `KeyboardRootView`, the keyboard view no longer has to observe the `KeyboardContext`.
* By no longer applying an explicit id to `KeyboardRootView`, the full document context correctly updates the view after the async operation completes. 

### 🗑 Deprecations

* `KKL10n` `hasText` is deprecated, since it produces incorrect results.
* `InputSetProvider` row functions are deprecated.
* `InputSetRow` initializers with implic names are deprecated.
* `View+localeContextMenu` with locales parameter is deprecated.

### 💥 Breaking changes

* `EmojiCategoryKeyboard` no longer allows customizing the keyboard view.



## 6.6

This version adds a brand new gesture engine, which aims to make typing feel a lot more like in the native keyboards.

This version also adds new emoji capabilities, such as a unicode id and name, as well as support for skin tone variants (Pro feature). These new capabilities are used by the emoji keyboards, which can now show input callouts and skin tone variants when you type on an emoji keyboard.   


### How to disable the new button gesture engine

Since typing is such an important part of this library, the new gesture engine can be toggled off if you find problems with it:

```
FeatureToggle.shared.toggleFeature(.newButtonGestureEngine, .off)
```

Note that the new gesture engine is only available in iOS 14+. Devices running iOS 13 will still get the current gesture engine, even if you toggle on this feature.

  
### 👑 KeyboardKit Pro

* `Emoji` implements the new `ProEmojiInfo` protocol.
* `ProCalloutActionProvider` now returns skin tone variant actions for emojis. 
* `ProEmojiInfo` is a new protocol for Pro emoji information.  
* `ProEmojiInfo` has `hasSkinToneVariants`, `neutralSkinToneVariant`, `skinToneVariants` and `skinToneVariantsActions` properties.

### ✨ New features

* `ActionCalloutContext.shared` is now public.
* `Emoji` has new `unicodeIdentifier` and `unicodeName` properties.
* `EmojiKeyboard` and `EmojiCategoryKeyboard` now supports keyboard gestures and skin tone callouts.
* `EmojiKeyboard` has a new `applyGestures` parameter, that you can set to true to apply standard keyboard gestures.
* `EmojiKeyboard` has a new `standardKeyboardActionHandler` property.
* `EmojiKeyboardItem` is a new view for rendering a keyboard item view.
* `GestureButton` is a new view that lets you handle many different gestures with a single button.
* `InputCalloutContext.shared` is now public.
* `InputCalloutContext` has a new, configurable `minimumVisibleDuration` property that controls the minimum visibility of the input callout.
* `KeyboardAction` has a new `image` property.
* `KeyboardAction` has a new `isEmojiAction` property.
* `SpaceCursorDragGestureHandler` is now open to inheritance.

### 💡 Behavior changes

* `EmojiKeyboard` uses smaller emojis for standard iPad in portrait.
* `InputCallout` no longer allows hit testing.
* `KeyboardAction.backspace` now triggers on `press` instead of `tap`.
* `KeyboardGestures` now has private state to avoid press gesture problems when providing a constant binding.
* `SystemKeyboardButtonRowItem` now avoids applying a negative width.
* `View+KeyboardGestures` now render a plain button that triggers the press, release and tap action on tvOS.

### 🐛 Bug fixes

* `KeyboardGestures` now use internal state to avoid problems when passing in a constant binding.
* `LocaleProvider` now wraps Swift 5.7 code in a compile version version check.
* `SystemKeyboardButtonRowItem` now protects itself against getting a negative width.
* Words with an autocompleting autocomplete suggestion will no longer autocomplete when ending a space cursor drag on them.

### 🗑 Deprecations

* `KeyboardAction` `.isShift` has been renamed to `isShiftAction`.
* `KeyboardAction` `.isUppercaseShift` has been renamed to `isUppercasedShiftAction`.
* `KeyboardImageButton` has been deprecated and will be removed in KeyboardKit 7.
* `SystemAudio` types have been renamed to `AudioFeedback` to make the concept match haptic feedback types.
* `SystemAudio` `play` has been renamed to `trigger` to make it match the haptic feedback trigger.
* `SystemAudioPlayer` types have been renamed to `SystemAudioEngine` to make the concept match other feedback engines.
* `View+KeyboardGestures` no longer need a keyboard context.
 


## 6.5

This version adjusts the KeyboardKit Pro license model. 

There are some minor breaking changes in KeyboardKit Pro that should be straightforward to fix. 
 
### 👑 KeyboardKit Pro
  
* `License` contains new information and capabilities, to enable future license features.
* `ProInputSetProvider` now nests all pro input set providers for a cleaer api.
* `ProCalloutActionProvider` now nests all pro callout action providers for a cleaer api.

### ✨ New features

* `KeyboardLocale` implements the new `LocaleProvider` and `LocaleFlagProvider` protocols.
* `Locale` implements the new `LocaleProvider` and `LocaleFlagProvider` protocols.
* `LocaleProvider` is a new protocol that defines how to resolve locales.
* `LocaleFlagProvider` is a new protocol that defines how to resolve flags for a locale.



## 6.4.4

### 👑 KeyboardKit Pro

* The `UITextDocumentProxy` full text content extensions have been tweaked to perform better.

### 💡 Behavior changes

* `KeyboardLocale.kurdish_sorani_arabic` uses `ckb_IQ` instead of `ckb_AR` to get a valid locale identifier.
* `View+LocaleContextMenu` now iterates over the locales without enumerating.



## 6.4.3

### 👑 KeyboardKit Pro

* The `UITextDocumentProxy` full text content extensions are now configurable.

### ✨ New features

* `ActionCalloutStyle.standardFont` can now be set to change the global callout font.
* `KeyboardButtonShadowStyle.standard` can now be set to change the global style.
* `KeyboardColorReader` standard values can now be set to change the global style.  



## 6.4.2

This release rolls back the localized name adjustment in the last version.

The Kurdish Sorani Arabic language folder uses a localization ID that isn't recognized by Apple, which causes uploads to App Store generate a warning.

If you want to customize the display name for a keyboard locale, you have to do so manually in your app.

### 💡 Behavior changes

* `KeyboardLocale` now only resolves `localizedName` from its ID, as it did before 6.4.1.
* The new `KKL10n` `localizedName` property has been rolled back.



## 6.4.1

This release adds a new localized strings and new document proxy extensions.

### 👑 KeyboardKit Pro

* `UITextDocumentProxy` has a new `fullDocumentContext()` extension that gets all the text from the proxy, not just the closest one.
* `UITextDocumentProxy` has a new `fullDocumentContextBeforeInput()` extension that gets all the text before the input cursor.
* `UITextDocumentProxy` has a new `fullDocumentContextAfterInput()` extension that gets all the text after the input cursor.

### ✨ New features

* `KeyboardLocale` now supports defining a localized string to override its localized name.

### 💡 Behavior changes

* `KeyboardLocale` now uses `localizedName` from its localized strings, if any.
* `KeyboardLocale.kurdish_sorani_arabic` has a new localized name and adjusted keyboard layouts.



## 6.4

This release bumps the package Swift version to 5.6.

The release also makes more types, extensions, mocks and unit tests available for macOS, tvOS and watchOS, and binds a bunch of extensions to protocols, which make them show up in DocC and makes it possible to use them on more types.

There are also new layout utilities that make adjusting keyboard locales a lot easier, and a bunch of struct properties have been converted from `let` to `var` as well, to make them mutable.

The demos have been adjusted as well. There's also a brand new demo keyboard that shows how to customize the layout. 

### 👑 KeyboardKit Pro changes

* `KurdishSoraniPcInputSetProvider` is a new input set provider for Kurdish Sorani PC.
* `KurdishSoraniPcCalloutActionProvider` is a new callout action provider for Kurdish Sorani PC.
* `AlphabeticInputSet` has new `kurdishSoraniPc` input set builder.

### 🌐 New locales

* 🇹🇯 Kurdish Sorani PC

### ✨ New features

* `CaseAdjustable` is a new protocol that can be implemented by types that should be able to adjust themselves to a casing.
* `EmojiKeyboardStyle` now lets you provide a device type in the standard style builder.
* `HapticFeedback` now uses `HapticFeedbackPlayer` for its `player`. 
* `InputCallout` now lets you provide a device type in the initializer.
* `InputSet` properties are now mutable.
* `InputSetItem` properties are now mutable.
* `KeyboardColorReader` is a new protocol that is implemented by `Color` and lets its implementations access keyboard colors.
* `KeyboardContext` has a new `keyboardType` property.
* `KeyboardContext` no longer requires a controller in the initializer, although it's good to provide one.
* `KeyboardFeedbackHandler` is now available on all platforms.
* `KeyboardImageReader` is a new protocol that is implemented by `Image` and lets its implementations access keyboard images.
* `KeyboardLayout` has new ideal height and inset properties, which can be used to create new item types easier.
* `KeyboardLayoutConfiguration` properties are now mutable.
* `KeyboardLayoutConfiguration` has a new standard layout for device type.
* `KeyboardLayoutItem` properties are now mutable.
* `KeyboardLayoutItemSize` properties are now mutable.
* `KeyboardRowItem` has a bunch of new collection extensions.
* `StandardAutocompleteSuggestion` properties are now mutable.
* `StandardKeyboardFeedbackHandler` is now available on all platforms.
* `SystemAudio` now uses `SystemAudioPlayer` for its `player`.

### 💡 Behavior changes

* `Color` extensions have been moved to `KeyboardColorReader`.
* `KeyboardContext` `activeAppBundleId` has been converted to a calculated property.
* `StandardKeyboardLayoutProvider` now fallbacks to iPhone layout instead of an empty layout.
* `StandardKeyboardLayoutProviderTests` now runs on all platforms.
* `String` casing extensions have been moved to `CaseAdjustable`.

### 🐛 Bug fixes

* A memory leak has been fixed.

### 🗑 Deprecations

* The `Color.DarkAppearanceStrategy` is no longer used and has been deprecated.
* The `KeyboardContext` `device` initializer and property has been deprecated.
* The `KeyboardContext` `activeAppBundleId` no longer works in iOS 16 and has been deprecated.
* The `KeyboardLayoutConfiguration` standard configuration for idiom has been deprecated.
* The `KeyboardInputViewController` `activeAppBundleId` no longer works in iOS 16 and has been deprecated.
* The `MockCollectionViewLayout` is no longer used and has been deprecated.
* Two `Sequence` extensions for mapping casing are no longer used and have been deprecated.
* The `StandardKeyboardLayoutProvider` `fallbackProvider` has been deprecated.
* The `StandardKeyboardLayoutProvider` `layoutProvider(for:)` has been renamed to `keyboardLayoutProvider(for:)`.



## 6.3

This release adds two new locales and a bunch of input set changes.

### 👑 KeyboardKit Pro changes

* `AlphabeticInputSet` has new `qwertz` and `azerty` input set builders.
* `AlphabeticInputSet`, `NumericInputSet` and `SymbolicInputSet` has input set builders for all keyboard locales.
* `InputSetProvider`s that support `QWERTY`, `QWERTZ` and `AZERTY` now lets you inject a custom alphabetic input set.
* `KurdishSoraniArabicInputSetProvider` has been tweaked to render a more correct layout.
* `StandardInputSetProvider` now handles lexicon-based completions differently and ignores single-char suggestions.

### ✨ New features

* `KeyboardContext` has new `hasKeyboardLocale` and `hasKeyboardLocale` functions.
* `AlphabeticInputSet` has a new `qwerty` input set builder.
* `NumericInputSet` has a new `standard` input set builder.
* `SymbolicInputSet` has a new `standard` input set builder.

### 🌐 New locales

* 🇺🇸 Hawaiian
* 🇰🇪 Swahili

### 🗑 Deprecations

* A bunch of `SystemKeyboardLayoutProvider` layout util functions have been deprecated.


## 6.2

This release adds a bunch of new emojis that have been added since emojis were last updated.

### ✨ New Features

* `EmojiCategory` has a bunch of new emojis.
* `EnglishInputSetProvider` now supports specifying an alphabetic input set.
* `InputSetRow` has new convenience initializers.
* `KeyboardContext` has a new KeyboardLocale-based `setLocale()`.

* `AlphabeticInputSet`, `NumericInputSet` and `SymbolicInputSet` has new set builders for `.english`.

### 🗑 Deprecations

* `DeviceSpecificInputSetProvider` has been deprecated.
* The `EnglishInputSetProvider` currency properties have been deprecated. 
* The `InputSetProvider` row extensions have been deprecated.
* The `InputSetRow` initializer extensions have been deprecated. 



## 6.1

### ✨ New Features

* `AutocompleteContext` has a new `lastError` property.
* `AutocompleteProvider` has a new `caseAdjust(suggestion:for:)` extension to help handle casing.
* `Bundle+KeyboardKit` adds a new `.keyboardKit` bundle.
* `StandardAutocompleteProvider` has a new `caseAdjustExactMatch` init argument to let you choose whether or not to apply the case adjustment to exact matches.
* `String+Casing` adds an `isCapitalized` property to String.

### 🌐 New locales

* 🇹🇯 Kurdish Sorani (Arabic)

### 💡 Behavior changes

* `KeyboardColor` no longer needs or is affected by enabling preview mode.
* `KKL10n` no longer needs or is affected by enabling preview mode.
* `StandardAutocompleteProvider` in KeyboardKit Pro uses the new case adjustments to provide better completions.
* `KeyboardInputViewController` will now update the autocomplete context on the main queue.
* `KeyboardInputViewController` will now write any autocomplete errors to the context's `lastError` property.

### 🗑 Deprecations

* `KeyboardPreviewMode` is not longer needed and enabling it has no effect from now on. 



## 6.0.3

This version adds more primary button types.

### ✨ New Features

* `KeyboardAction.PrimaryType` has new `join` and `custom` cases.
* `KeyboardAction.PrimaryType` now maps unrepresented `UIReturnKeyType` types to the new `custom` type.
* `UIReturnKeyType` has new extensions for getting the `keyboardAction` and `primaryButtonType`.

### 💡 Behavior changes

* `KeyboardGestures` shortens the time it takes for the secondary action callout to be presented.



## 6.0.2

This version fixes bugs in the Kurdish Sorani keyboard.

### 🐛 Bug fixes

* Tapping `"ھ"` triggered multiple inserts.



## 6.0.1

This version fixes bugs in the Kurdish Sorani keyboard.

### 🐛 Bug fixes

* Tapping `"ھ"` now inserts `"ه"` for Kurdish Sorani.


## 6.0

This version makes the library build on more platforms and removes old, deprecated code.

### 📺 Platform support

* KeyboardKit now supports iOS, iPadOS, macOS, tvOS and watchOS.

### ✨ New Features

* `ActionCalloutContext` has a new, static `shared` property.
* `ActionCalloutContext` has a new `verticalOffset` that can be used to move the callout up and down.
* `AudioFeedbackConfiguration` is now mutable.
* `HapticFeedbackConfiguration` is now mutable.
* `InputCalloutContext` has a new, static `shared` property.
* `KeyboardInputViewController` has a new `didMoveToParent` property, which is used to avoid calling `needsInputModeSwitchKey` when it generates a warning.

### 💡 Behavior changes

* Autocomplete now only applies autocorrections for pure `space` actions and not character actions with a single space.
* `ActionCallout` uses the new `ActionCalloutContext` `verticalOffset` to offset the callout bubble.
* `ActionCalloutContext` applies a vertical offset to iPad devices, and adjust the demo toolbar to be 50 on iPad as well.
* `StandardKeyboardBehavior` now has a 0.5 double tap threshold instead of 0.2, and also handles caps lock better.
* `StandardKeyboardFeedbackHandler` now triggers the haptic feedback for long press on space, not the `SpaceCursorDragGestureHandler`.
* `SystemKeyboard` initializers now use `nil` as default value for the controller and width, to avoid Swift errors in binary framework builds.  

### 🐛 Bug fixes

* `UITextDocumentProxy` `isCursorAtNewSentenceWithSpace` has been adjusted to handle non-empty space content.

### 💥 Breaking changes

* All previously deprecated code has been removed.

* `ActionCalloutContext` `verticalOffset` has been moved to `ActionCalloutStyle`.
* `Bundle` `isExtension` has been made internal.
* `Color.standardButtonBackgroundColor(for:)` has been renamed to `standardButtonBackground(for:)`.
* `Color.standardButtonForegroundColor(for:)` has been renamed to `standardButtonForeground(for:)`.
* `Color.standardButtonShadowColor(for:)` has been renamed to `standardButtonShadow(for:)`.
* `Color.standardDarkButtonBackgroundColor(for:)` has been renamed to `standardDarkButtonBackground(for:)`.
* `Color.standardDarkButtonForegroundColor(for:)` has been renamed to `standardDarkButtonForeground(for:)`.
* `KeyboardAction` `isKeyboardType` has been removed.
* `KeyboardAction` `isSpace` has been removed.
* `KeyboardAction` `standardTextDocumentProxyInputAction` has been merged with `standardTextDocumentProxyAction`.
* `KeyboardAppearance` `systemKeyboardButtonStyle(for:)` has been renamed to `buttonStyle(for:)`.
* `KeyboardFeedbackHandler` no longer has any action provider-based logic and no typealiases.
* `KeyboardInputViewController` `needsInputModeSwitchKeyOverride` has been removed.
* `StandardKeyboardActionHandler` `GestureAction` has been removed.
* `StandardKeyboardFeedbackHandler` `triggerFeedbackForLongPressOnSpaceDragGesture` has been removed.
* `StandardKeyboardFeedbackHandler` `shouldTriggerFeedback` has been moved to `StandardKeyboardActionHandler`.
* `SystemKeyboardButtonStyle` has been renamed to `KeyboardButtonStyle`.
* `SystemKeyboardButtonBorderStyle` has been renamed to `KeyboardButtonBorderStyle`.
* `SystemKeyboardButtonShadowStyle` has been renamed to `KeyboardButtonShadowStyle`.
