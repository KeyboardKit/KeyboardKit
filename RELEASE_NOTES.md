# Release notes

KeyboardKit tries to honor semantic versioning:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes can still occur in minor versions and patches, though, if the alternative is to not be able to release new critical features or fixes.



## Planned changes for 7.0

Some things that are planned for the 7.0 release:

* Deployment targets will be bumped to iOS 14, macOS 11, tvOS 14 and watchOS 8.
* All TODOS will be addressed.
* All deprecated code will be removed.
* All shared instances should be removed.
* All dependencies to the shared instances should be replaced with init parameters, even for the smallest view.
* KeyboardAction should only support `press` and `release` and not `tap`.
* KeyboardAction.GestureAction should use a protocol instead of a view controller.
* KeyboardAppearance will convert parameterless functions to properties. 
* KeyboardKit Pro active and enabled labels will use an observed object to update when the state changes.
* StandardKeyboardActionHandler changeKeyboardTypeAction will be removed.
* The ActionCallout initializer will require a KeyboardContext



## 6.9

This release starts preparing for the next major version, by deprecating and renaming a lot of things that will change in that version.

Most of the changes only affect functionality that is mostly used internally, but you may have to rename some init and function parameters. 

### ✨ New features

* `DisabledAutocompleteProvider` is now `public`.
* `DisabledCalloutActionProvider` is now `public`.
* `InterfaceOrientation` is a new multi-platform version of `UIInterfaceOrientation`.
* `KeyboardAppearance` has a new `keyboardEdgeInsets` property.
* `KeyboardAppearanceViewModifier` is a new modifier for setting light and dark keyboards.
* `KeyboardAction` has a new `isAlphabeticKeyboardTypeAction` property.
* `KeyboardAction` has a new `isKeyboardTypeAction` function.
* `KeyboardContext` has a new `screenSize` parameter.
* `KeyboardContext` has a new `interfaceOrientation` parameter.
* `KeyboardEnabledLabel` is a new view that can display keyboard states.
* `KeyboardSettingsLink` is a new view that can link to System Settings.
* `KeyboardTextView` has a new `hasFocus` binding.
* `RepeatGestureTimer` init is now `public`.
* `RepeatGestureTimer` time interval is now mutable.
* `StandardCalloutActionProvider` `keyboardContext` is now `public`.
* `StandardKeyboardAppearance` `keyboardContext` is now `public`.
* `StandardKeyboardAppearance` `keyboardLayoutConfiguration` is now `open`.
* `StandardKeyboardBehavior` `keyboardContext` is now `public`.
* `StaticKeyboardBehavior` is now `open`.

### 👑 KeyboardKit Pro

* `StandardAutocompleteProvider` `autocompleteSuggestions` is now `open`.
* `KeyboardActiveLabel` now uses a style and observes changes.
* `KeyboardEnabledLabel` now uses a style and observes changes.

### 💡 Behavior changes

* `GestureButtonDefaults` long press delay is reduced to `0.5` seconds.
* `iPhoneKeyboardLayoutProvider` now adds `.` to `Go` keyboards. 
* `iPhoneKeyboardLayoutProvider` now adds `@` and `.` to e-mail keyboards. 
* `KeyboardAction.primary` now applies autocomplete suggestions if it's a system action.
* `KeyboardContext` controller-based initializer is marked as a convenience initializer.
* `KeyboardGestures` now apply the `GestureButtonDefaults` long press delay.
* `SystemKeyboard` no longer depends on `AnyView`.
* `StandardKeyboardAppearance` now applies insets to system keyboards.
* `StandardKeyboardAppearance` now applies larger font sizes to some system keyboards keys on iPad devices.
* `SystemKeyboardSpaceButtonContent` no longer depends on `AnyView`.  

### 🗑 Deprecations

* `ActionCallout` now prefers a `keyboardContext` to be injected.
* `ActionCallout` `context` is renamed to `calloutContext`.
* `EmojiKeyboard` `context` is renamed to `keyboardContext`.
* `EmojiCategoryKeyboard` `context` is renamed to `keyboardContext`.
* `EmojiCategoryKeyboardMenu` `context` is renamed to `keyboardContext`.
* `FeatureToggle.Feature.newButtonGestureEngine` is deprecated.
* `InputCallout` `context` is renamed to `calloutContext`.
* `LocaleContextMenu` `context` is renamed to `keyboardContext`.
* `KeyboardAction.newLine` is replaced by `KeyboardAction.primary(.newLine)`.
* `KeyboardAction.return` is replaced by `KeyboardAction.primary(.return)`.
* `KeyboardAction.standardTapAction` is replaced by `KeyboardAction.standardReleaseAction`.
* `KeyboardEnabledState` `isKeyboardCurrentlyActive` is renamed to `isKeyboardActive`.
* `KeyboardEnabledStateInspector` `isKeyboardCurrentlyActive` is renamed to `isKeyboardActive`.
* `KeyboardContext` has redesigned initializers that set fewer properties.
* `KeyboardContext` `screenOrientation` is replaced by `interfaceOrientation`.
* `KeyboardType` font size is deprecated and moved to `StandardKeyboardAppearance`.
* `SpaceCursorDragGestureHandler` `context` is renamed to `keyboardContext`.
* `StandardAutocompleteSuggestion` has deprecated the initializer with an implicit text name.
* `StandardCalloutActionProvider` `context` is renamed to `keyboardContext`.
* `StandardKeyboardActionHandler` `changeKeyboardTypeAction` is in-comment deprecated.
* `StandardKeyboardAppearance` `context` is renamed to `keyboardContext`.
* `StandardKeyboardBehavior` `context` is renamed to `keyboardContext`.
* `StandardSystemKeyboardButtonContent` is deprecated.
* `StaticKeyboardBehavior` `context` is renamed to `keyboardContext`.
* `SystemKeyboardActionButton` `context` is renamed to `keyboardContext`.
* `SystemKeyboardActionButtonContent` `context` is renamed to `keyboardContext`.
* `SystemKeyboardButtonRowItem` `context` is renamed to `keyboardContext`.
* `SystemKeyboardButtonText` legacy initializer is deprecated. 
* `SystemKeyboardSpaceButton` is deprecated.
* `SystemKeyboardSpaceButtonContent` is renamed to `SystemKeyboardSpaceContent`.
* `SystemKeyboardSpaceContent` init with a `spaceText` parameter is deprecated.
* `UIScreen` device extensions are deprecated.
* `View+Frame` is deprecated.
* `View.actionCallout` is renamed to `View.keyboardActionCallout`.
* `View.calloutShadow` is renamed to `View.keyboardCalloutShadow`.
* `View.inputCallout` is renamed to `View.keyboardInputCallout`. 

### 💥 Breaking changes

* `KeyboardContext` `screen` is deprecated.
* KeyboardKit Pro labels now use a style instead of init parameters.



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
* `KeyboardEnabledLabel` is a new view that can be used to show enabled/active state.
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



## 5.9.4

This version adjust orientation change handling further.

### 💡 Behavior changes

* `KeyboardInputViewController` now wraps the context sync in a `DispatchQueue.main.async` block. This seems to improve the behavior quite a bit.



## 5.9.3

This version adjust orientation change handling further.

### 💡 Behavior changes

* `KeyboardInputViewController` re-adds sync for layout change, but only once after `viewDidLayoutSubviews` if orientation changes.



## 5.9.2

This version polishes the action callout on iPad further and fixes a layout bug. 

### ✨ New Features

* `ActionCalloutContext` has a new `verticalOffset` property.

### 💡 Behavior changes

* `ActionCallout` is now pushed down a bit on iPad devices.
* `KeyboardInputViewController` no longer syncs context on `viewWillLayoutSubviews`.

### 🐛 Bug fixes

* `KeyboardInputViewController` could get stuck in a loop due to syncing context in `viewWillLayoutSubviews`.



## 5.9.1

This version polishes the action callout on iPad and makes the core library build on macOS. 

### 📺 Platform support

* This version makes the core library build on macOS. KeyboardKit Pro will add macOS support in 6.0.

### ✨ New Features

* `ActionCalloutStyle` has a new `maxButtonSize` property.

### 💡 Behavior changes

* `ActionCallout` now renders differently on iPad devices.
* `ActionCalloutContext` now requires a little less swiping to change action.



## 5.9

This version adds new locales and makes the library build on more platforms.

### 📺 Platform support

* This version makes the library build on tvOS and watchOS.

### 🌐 New locales

* 🇧🇬 Bulgarian
* 🇦🇩 Catalan
* 🇫🇴 Faroese
* 🇵🇭 Filipino
* 🇬🇪 Georgian
* 🇲🇰 Macedonian
* 🇲🇹 Maltese
* 🇲🇳 Mongolian
* 🇷🇸 Serbian
* 🇷🇸 Serbian (Latin)
* 🇸🇰 Slovak

### ✨ New features

* `DeviceSpecificInputSetProvider` has new row functions.
* `DeviceType` is a new enum that can be used to determine device type without having to use the real platform-specific device type.
* `DisabledHapticFeedbackPlayer` is a new feedback player that is used on tvOS and watchOS.
* `InputSetProvider` has new row functions.
* `StandardHapticFeedbackPlayer` is now open to subclassing.
* `StandardKeyboardLayoutProvider` has a new `fallbackProvider` that is used when device is not iPhone or iPad.
* `StandardSystemAudioPlayer` is now open to subclassing.
* `StaticKeyboardBehavior` is a new behavior type that is used on watchOS.

### 💡 Behavior changes

* `DeviceSpecificInputSetProvider` no longer requires a `UIDevice`.
* `EnglishInputSetProvider` no longer requires UIKit.
* The iPhone and iPad keyboard layout provides have been adjusted to provide better layouts. 

### 🐛 Bug fixes

* Some iPad incorrect layouts have been adjusted.

### 🗑 Deprecations

* `SystemAudioPlayer` `playSystemAudio` has been renamed to `play`. 
* All input set providers have the `UIDevice`-based initializer replaced by a device-agnostic one.



## 5.8.2

This version fixes an iPad layout bug that was introduced by 5.8.1.



## 5.8.1

This version adds tap behavior to the margin next to character inputs.

### ✨ New features

* `KeyboardAction` has a new `characterMargin` action.

### 💡 Behavior changes

* `iPadKeyboardLayoutProvider` and `iPhoneKeyboardLayoutProvider` now only adjust input sets with three rows.
* `iPhoneKeyboardLayoutProvider` will now add `characterMargin` to the empty surrounding space around a character key.

### 🗑 Deprecations

Despite the aim described in the release notes header, this patch contains some deprecations, that will only affect devs who create their own system keyboard layouts. 

* `SystemKeyboardLayoutProvider` has new margin action functions.
* `SystemKeyboardLayoutProvider` has been redesigned to let all functions that take multiple parameters with an initial context, place the context parameter last. This gives a cleaner and more harmonized public api.   
* `SystemKeyboardLayoutProvider` `inputs(for:)` has been renamed to `inputRows(for:)`.



## 5.8

This version adds new locales and renames a bunch of types, properties and parameters to make things nicer in preparation for 6.0.

This version also harmonizes `KeyboardLocale` naming to put the language first and the optional country second. This means that the new Belgian locales are called `french_belgium` and `dutch_belgium` and `brazilian` has been renamed to `portuguese_brazil`.  

### 🌐 New locales

* 🇭🇷 Croatian
* 🇧🇪 Dutch (Belgium)
* 🇧🇪 French (Belgium)
* 🇨🇭 French (Switzerland)
* 🇦🇹 German (Austria)
* 🇨🇭 German (Switzerland)
* 🇬🇷 Greek
* 🇭🇺 Hungarian
* 🇸🇮 Slovenian

### ✨ New features

* `SystemKeyboard` has a new, static `standardButtonContent` function.
* `SystemKeyboard` has a new, static `standardButtonView` function.

### 💡 Behavior changes

* `SystemKeyboard` now explicitly applies a `leftToRight` layout direction.

### 🗑 Deprecations

* `AlphabeticKeyboardInputSet` has been renamed to `AlphabeticInputSet`
* `BaseSecondaryCalloutActionProvider` has been renamed to `BaseCalloutActionProvider`.
* `CalloutActionProvider` `secondaryCalloutActions` has been renamed to `calloutActions`.
* `DisabledSecondaryCalloutActionProvider` has been renamed to `DisabledCalloutActionProvider`.
* `EnglishKeyboardInputSetProvider` has been renamed to `EnglishInputSetProvider`.
* `EnglishSecondaryCalloutActionProvider` has been renamed to `EnglishCalloutActionProvider`.
* `KeyboardInput` has been renamed to `InputSetItem`.
* `KeyboardInputRow` has been renamed to `InputSetRow`.
* `KeyboardInputRows` has been renamed to `InputSetRows`.
* `KeyboardInputSet` has been renamed to `InputSet`.
* `KeyboardInputSetProvider` has been renamed to `InputSetProvider`.
* `KeyboardInputViewController` `keyboardInputCalloutContext` has been renamed to `inputCalloutContext`.
* `KeyboardInputViewController` `keyboardSecondaryInputCalloutContext` has been renamed to `actionCalloutContext`.
* `KeyboardInputViewController` `keyboardSecondaryCalloutActionProvider` has been renamed to `calloutActionContext`.
* `KeyboardLocale` `.brazilian` has been renamed to `.portuguese_brazil`.
* `LocalizedSecondaryCalloutActionProvider` has been renamed to `LocalizedCalloutActionProvider`.
* `NumericKeyboardInputSet` has been renamed to `NumericInputSet`
* `PreviewKeyboardInputSetProvider` has been renamed to `PreviewInputSetProvider`.
* `PreviewSecondaryCalloutActionProvider` has been renamed to `PreviewCalloutActionProvider`.
* `RowItem` has been renamed to `KeyboardRowItem`.
* `SecondaryCalloutActionProvider` has been renamed to `CalloutActionProvider`. 
* `SecondaryInputCalloutContext` has been renamed to `ActionCalloutContext`.
* `SecondaryInputCalloutStyle` has been renamed to `ActionCalloutStyle`
* `StandardKeyboardInputSetProvider` has been renamed to `StandardInputSetProvider`.
* `StandardSecondaryCalloutActionProvider` has been renamed to `StandardCalloutActionProvider`.
* `String` `isVowel` is deprecated and will be removed in 6.0.
* `SymbolicKeyboardInputSet` has been renamed to `SymbolicInputSet`
* `SystemKeyboard` has renamed `buttonViewBuilder` to `buttonView` and `buttonContentBuilder` to `buttonContent`.
* `View+secondaryInputCallout` has been renamed to `actionCallout`

### 💥 Breaking changes

Even though most renamed functions have deprecated variants, open functions that can be overridden will have to be renamed if you have overridden them. 



## 5.7

This version adds new locales and improves emoji support.

There are some breaking changes, but they shouldn't affect you if you haven't been customizing emoji keyboards. 

### 🌐 New locales

* 🇧🇾 Belarusian
* 🇨🇿 Czech
* 🇷🇴 Romanian

### ✨ New features

* `Character` has new emoji properties: `isEmoji`, `isCombinedEmoji`, `isSimpleEmoji`.
* `EmojiKeyboardStyle` has renamed and reorganized its parameters.
* `EmojiKeyboardStyle` has a new `verticalKeyboardPadding` property.
* `EmojiKeyboardStyle.standardLargePadLandscape` is now mutable.
* `EmojiKeyboardStyle.standardLargePadPortrait` is now mutable.
* `EmojiKeyboardStyle.standardPadLandscape` is now mutable.
* `EmojiKeyboardStyle.standardPadPortrait` is now mutable.
* `EmojiKeyboardStyle.standardPhoneLandscape` is now mutable.
* `EmojiKeyboardStyle.standardPhonePortrait` is now mutable.
* `String` has new emoji properties: `containsEmoji`, `containsOnlyEmojis`, `emojis`, `emojiScalars`, `emojiString`, `isSingleEmoji`.

### 💡 Behavior changes

* `EmojiCategoryStyle` is adjusted to be more correct on iPad devices.
* `EmojiCategoryKeyboard.CategoryTitleViewProvider` now takes a style.
* `EmojiCategoryKeyboardTitle` now takes a style, but will default to `.standardPhonePortrait`.
* `KeyboardAction.shift` now uses a lighter color scheme for uppercase. 
* `String.wordDelimiters` has been extended with various brackets.
* `SystemKeyboard` now only uppercases for sentence autocapitalization after tapping a space after the sentence delimiter.
* Several iPad layouts has adjusted the lower-right keys for numeric keyboards, to have `,` and `.` on the alphabetic keyboard and `!` and `?` on the numeric and symbolic. This is because these symbols currently don't adjust for uppercase and there is no swipe down support.  

### 🐛 Bug fixes

* `EmojiCategory` now adds accidentally excluded 😵‍💫 emoji.

### 🗑 Deprecations

* A bunch of `SystemKeyboardLayoutProvider` `hasXXXAlphabeticInput` properties have been deprecated.

### 💥 Breaking changes

* `EmojiKeyboardButton` has renamed `configuration` to `style`.
* `EmojiKeyboardStyle` has renamed and reorganized its parameters. There is no deprecations, since the initializer has standard values for each parameter, which cause conflicts.  



## 5.6

This version adds support for new locales and makes it easier to create and use the `SystemKeyboard`.

### 🌐 New locales

* 🇮🇪 Irish
* 🇵🇹 Portuguese
* 🇧🇷 Portuguese (Brazil)
* 🇹🇷 Turkish

### ✨ New features

* `SystemKeyboard` now automatically renders an `EmojiCategoryKeyboard` on iOS 14 and later.
* `SystemKeyboard` has new convenience initializers that just requires a `controller` instead of all granular configurations. The controller is auto-resolved to `.shared` if none is provided.



## 5.5

Thanks to [@ardavank](https://github.com/ardavank) and [@rawandahmad698](https://github.com/rawandahmad698), this release adds support for Persian (Farsi), Arabic, Kurdish Sorani and RTL keyboards.

### 🌐 New locales

* 🇦🇪 Arabic
* 🇹🇯 Kurdish Sorani
* 🇮🇷 Persian

### ✨ New features

* `DeviceSpecificInputSetProvider` has new row functions for lower/uppercase characters.
* `Image` has a new `.keyboardBackspaceRtl` property and `.keyboardBackspace` function.
* `Image` has a new `.keyboardNewlineRtl` property and `.keyboardBackspace` function.
* `Image` has a new `.keyboardZeroWidthSpace` property with a temp arrow icon.
* `KeyboardInputRow` has a new initializer for lower/uppercase characters.
* `KeyboardInputRows` has a new initializer for lower/uppercase characters.
* `String` has new, static `carriageReturn`, `newline`, `space`, `tab` and `zeroWidthSpace` properties.

### 💡 Behavior changes
  
* `KeyboardAction+Button` now resolves RTL variants of backspace and newline.
* `KeyboardAction+Button` now resolves the new `zeroWidthSpace` character to the new `zeroWidthSpace` icon.
* `KeyboardLocale` resolves `isLeftToRight` and `isRightToLeft` through its derived x§locale.

### 🗑 Deprecations

* `DeviceSpecificInputSetProvider` has a bunch of functions that just resolve to `KeyboardInputRow`. These are now marked as deprecated to make the type cleaner.



## 5.4.1

This release fixes issues with `EmojiKeyboard` and `EmojiCategoryKeyboard`.

The internal `EmojiKeyboardItem` that created unique IDs caused the emojis to constantly re-render. It has been removed. 

Note that this change now requires emojis to be unique within a certain keyboard.


### ✨ New features

More styles now have var properties instead of lets, which means that it's easy to create and change a mutable copy of a style.

* `AutocompleteToolbarStyle` are now vars instead of lets.
* `AutocompleteToolbarItemStyle` are now vars instead of lets.
* `AutocompleteToolbarItemBackgroundStyle` are now vars instead of lets.
* `AutocompleteToolbarSeparatorStyle` are now vars instead of lets.
* `EmojiKeyboardStyle` are now vars instead of lets.
* `EmojiKeyboardStyle` now has new `abcText` and `backspaceIcon` which will be used in the next minor version to make category views no longer require appearance.

### 💡 Behavior changes
 
* `EmojiCategoryKeyboard` now resets scroll offset when changing category.
* `EmojiCategoryKeyboard` now persists category changes right away instead of when disappearing.
* `EmojiKeyboard` no longer generates unique IDs for each emoji, which improves performance.
* `EmojiKeyboardStyle` now uses the primary color instead of black to make highlighting show in dark mode.



## 5.4

Thanks to [@digitalheir](https://github.com/digitalheir), this release removes the need for using `AnyView` in many places.

Thanks to [@danielpunkass](https://github.com/danielpunkass), this release makes it possible to use the library within an app target.

This version also adds missing emojis.

### ✨ New emojis

* 🥸😶‍🌫️😮‍💨🤌🤏🦾🦶🦵🦿🦷👣🫀🫁🫂👩‍🦱🧑‍🦱👨‍🦱👩‍🦰🧑‍🦰👨‍🦰👱🧑‍🦳👨‍🦳👩‍🦲🧑‍🦲👨‍🦲🧔‍♀️
  🧔‍♂️👳👮👷💂🕵️🧑‍⚕️🧑‍🌾🧑‍🍳🧑‍🎓🧑‍🎤🧑‍🏫🧑‍🏭🧑‍💻🧑‍💼🧑‍🔧🧑‍🔬🧑‍🎨🧑‍🚒👨‍🚒👩‍✈️🧑‍✈️🧑‍🚀🧑‍⚖️👰‍♀️👰‍♂️🤵‍♀️
  🤵‍♂️🦸‍♀️🦸🦸‍♂️🦹‍♀️🦹🦹‍♂️🧑‍🎄🧙🧝🧛🧟🧞🧞‍♂️🧜🧚👩‍🍼🧑‍🍼👨‍🍼🙇💁🙅🙆🙋🧏‍♀️🧏🧏‍♂️
  🤦🤷🙎🙍💇💆🧖👯👩‍🦽🧑‍🦽👨‍🦽👩‍🦼🧑‍🦼👨‍🦼🚶👩‍🦯🧑‍🦯👨‍🦯🧎‍♀️🧎🧎‍♂️🏃🧍‍♀️🧍🧍‍♂️👩‍❤️‍👨👩‍❤️‍💋‍👨
  👨‍👩‍👦👨‍👩‍👦‍👦🪢🧶🧵🪡🥼🦺👕🩲🩳🩱🥻🩴🥿👟🥾🧣🎩🪖🧳🥽
* 🐻‍❄️🪱🪰🪲🪳🦟🦞🦭🦧🦣🦛🦘🦬🦙🦮🐕‍🦺🐈‍⬛🪶🦤🦚🦜🦢🦩🦝🦨🦡🦫
  🦦🦥🪵🪴🪨🪐
* 🫐🥭🥬🫑🫒🧄🧅🥯🧈🧇🦴🫓🧆🫔🫕🦪🥮🧁🫖🧃🧋🧉🧊🧂
* 🥎🥏🪀🥍🪃🪁🤿🛹🛼🪂🏋️🤼🤸⛹️🤾🏌️🧘🏄🏊🤽🚣🧗🏻🚵🚴🤹🩰🪘
  🪗🪕♟🧩
* 🛻🦯🦽🦼🛺🪝🛖🛕
* 🧭🪔🧯🪙🪜🧰🪛🪚🪤🧱🧲🧨🪓🪦🧿🩹🩺🩸🧬🦠🧫🧪🧹🪠🧺🧻🧼
  🪥🪒🧽🪣🧴🪑🧸🪆🪞🪟🪄🪅🧧🪧🧾🗑🧷🧮
* 🤍🤎❤️‍🔥❤️‍🩹⚧♾👁‍🗨🟠🟡🟢🟣🟥🟧🟨🟩🟦🟪🟫
* 🏴‍☠️🏳️‍⚧️🇺🇳🇻🇮

### ✨ New features

* `Bundle` has new `isExtension` extension property.
* `Locale` has new `localizedName` extension property.
* `StandardSystemKeyboardButtonView` is a new typealias that defines the standard system keyboard button view.
* `StandardSystemKeyboardButtonContent` is a new typealias that defines the standard system keyboard button content.
* `SystemKeyboard` has a new, static `standardKeyboardWidth`.
* `View` has new, generic `localeContextMenu` extensions that can be used to create custom locale context menus.

### 💡 Behavior changes

* `AutocompleteToolbar` is now generic.
* `EmojiKeyboard` is now generic.
* `SystemKeyboard` is now generic.
* `SystemKeyboardSpaceButtonContent` is now generic.

### 🗑 Deprecations

* `KeyboardActionRow` is the same thing as `KeyboardActions` and wasn't used in the library.
* `KeyboardLayout` `items` initializer has been replaced with an `itemRows` initializer.
* `KeyboardLayout` `item` has been replaced with `itemRows`.
* The old `AnyView`-based initializers have been replaced with the new, generic initializers.

### 💥 Breaking changes

Although we aimed to implement the new generic views with no breaking changes, there may be some that slipped us by.



## 5.3

### 🌐 New locales

* 🇦🇱 Albanian
* 🇮🇸 Icelandic
* 🇵🇱 Polish

### ✨ New features
 
* `CGSize` device dimension properties are now public:
    * iPadProLargeScreenPortrait
    * iPadProLargeScreenLandscape
    * iPadProSmallScreenPortrait
    * iPadProSmallScreenLandscape
    * iPadScreenPortrait
    * iPadScreenLandscape
    * iPhoneProMaxScreenPortrait
    * iPhoneProMaxScreenLandscape
    * isScreenSize(...)
* `EmojiKeyboardButton` is a new view that renders a standard emoji keyboard button.
* `EmojiCategoryTitle` is a new view that renders a standard emoji category title.
* `KeyboardFeedbackSettings` has new properties and functions:
    * isAudio/HapticFeedbackEnabled
    * disableAudio/HapticFeedback()
    * enableAudio/HapticFeedback()
    * toggleAudio/HapticFeedback()
* `KeyboardTextField` has a new `placeholder` property.
* `String` has new `vowels` and `isVowel` extension properties.

### ✨ New KeyboardKit Pro features

* `AudioFeedbackToggleButton` is a new view that can be used to toggle audio feedback on and off.
* `EnabledLabel` is a new view that can be used to show different views depending on a provided enabled state.
* `HapticFeedbackToggleButton` is a new view that can be used to toggle haptic feedback on and off.
* `KeyboardActiveLabel` is a new view that can be used to present whether or not a keyboard extension is currently being used to edit a text field.
* `KeyboardEnabledLabel` is a new view that can be used to present whether or not a keyboard extension is enabled in System Settings.
* `License` now implements `Codable` and has a public initializer, as well as new `tier` and `additionalInfo` properties.
* `LicenseCustomer` now implements `Codable` and has a public initializer, as well as a new `additionalInfo` property.
* `LicenseTier` is a new type that defines the level of service for your specific license.
* `ToggleToolbar` is a new view that can be used to toggle between two toolbars.

### 💡 Behavior changes

* Typing an alternate quotation delimiter (\`, ´, etc.) now switches back to the alphabetic keyboard.

### 🐛 Bug fixes

* The Finnish iPad input set provider has been corrected for numeric and symbolic inputs.
* `EmojiCategory.frequent` now uses the frequent provider to resolve its emojis.
* `EmojiCategoryKeyboardMenu` now shows the "frequent" category once more.
* `EmojiCategoryKeyboardMenu` has reduced circle padding to avoid clipping on smaller screens.

### 🗑 KeyboardKit Pro Deprecations

* `KeyboardKitLicense` has been renamed to `License`.
* `KeyboardKitLicense+Customer` has been converted to a typealias for `LicenseCustomer` and has been deprecated.



## 5.2

This version adds support for `Russian` and `Ukrainian` and bumps the package's Swift version to 5.5 to enable DocC support.

By adding DocC support, the documentation has been updated to allow for topics, cross-linking etc. You can download the documentation from the project website or find a zipped version in the `Docs` folder.

### 🌐 New locales

* 🇷🇺 Russian
* 🇺🇦 Ukrainian

### 🐛 Bug fixes

* This version corrects the system button highlight color in dark mode.  



## 5.1

This version adds support for `estonian`, `latvian` and `lithuanian`.

This version also adds new inspection capabilities and fixes some bugs. 

### 🌐 New locales

* 🇪🇪 Estonian
* 🇱🇻 Latvian
* 🇱🇹 Lithuanian

### ✨ New features

* `UITextDocumentProxy` has a new `hasCurrentWord` property.
* `InputCallout` has a new `calloutPadding` property.
* `KeyboardEnabledState` has a new `isKeyboardCurrentlyActive` property.
* `KeyboardEnabledStateInspector` has a new `isFullAccessEnabled` property.
* `KeyboardEnabledStateInspector` has a new `isKeyboardCurrentlyActive` function.

### 💡 Behavior changes

* `InputCallout` now calculates a minimum callout width based on button size, curve size etc.
* `InputCallout` now applies a minimum callout size instead of a fixed one, which means that the callout content can be larger.

### 🐛 Bug fixes

* `InputCallout` was rendered too wide by default, when used in `SystemKeyboard`. This has been fixed.
* `SecondaryInputCallout` applied an incorrect leading corner radius. This has been fixed.



## 5.0

KeyboardKit 5.0 streamlines the library, improves styling and previewing and makes the library easier to use.

This version also removes all UIKit-specific functionality as well as all previously deprecated functionality.

This version also adjust keyboard button sizes to be more correct on more device types, e.g. iPhone Pro Max, iPad Pro etc. 

KeyboardKit 5.0 requires Xcode 13 and Swift 5.5. 

### ✨ New features

* Library types now implement protocols like `Codable` and `Identifiable` to greater extent.
* Library views have a lot more previews than before, which make them much easier to adjust.
* Library views no longer depend on environment objects, which make them easier to create and use.

* `AudioFeedbackConfiguration` has a new action-specific feedback list.
* `AudioFeedbackConfiguration` has a new, static `enabled` configuration.
* `AutocompleteContext` has a new `isLoading` property.
* `AutocompleteToolbarItemSubtitle` is a new view that renders autocomplete subtitles.
* `Collection+RowItem` has new extensions to affect all rows.
* `EdgeInsets` has a new `init(all:)` initializer.
* `EdgeInsets` has a new `init(horizontal:,vertical:)` initializer.
* `EmojiCategory` has a new `emojisString` property.
* `EmojiKeyboardStyle` has new `systemFont` and `selectedCategoryColor` properties.
* `HapticFeedbackConfiguration` has a new action-specific feedback list.
* `HapticFeedbackConfiguration` has a new, static `enabled` configuration.
* `InputCalloutContext` has a new, static `.disabled` context.
* `KeyboardAction` has a new `inputCalloutText` property.
* `KeyboardAction` has a new `isCharacterAction` property.
* `KeyboardAppearance` has a new `inputCalloutStyle()` function.
* `KeyboardAppearance` has a new `secondaryInputCalloutStyle()` function.
* `KeyboardContext` has a new `screen` property.
* `KeyboardInputTextComponent` is now public.
* `KeyboardLayoutConfiguration` is a new type that replaces the `CGFloat` and `UIEdgeInsets` extensions.
* `KeyboardLayoutConfiguration` has a bunch of standard layout configs for different devices.  
* `NextKeyboardButton` is now SwiftUI-based and don't require any special setup.
* `Preview` services have new, static `.preview` protocol properties.
* `SecondaryInputCalloutContext` has a new, static `.disabled` context.
* `StandardHapticFeedbackPlayer` has a new `shared` player.
* `StandardKeyboardFeedbackHandler` now prefers action-specific feedback, if defined.
* `StandardSystemAudioPlayer` has a new `shared` player.
* `SystemKeyboardActionButton` is a new view that makes it easy to create action-based keyboard buttons.
* `SystemKeyboardButton` is a new view that makes it easy to create standalone keyboard buttons.
* `SystemKeyboardButtonText` is a new view that just sets up text correctly. 
* `SystemKeyboardSpaceButton` can now wrap any content.
* `View+Callout` has a new `calloutShadow` extension.

### 🎨 Styling

* `AutocompleteToolbarStyle` is a new style that can style autocomplete toolbars.
* `AutocompleteToolbarItemStyle` is a new style that can style autocomplete toolbar items.
* `AutocompleteToolbarItemBackgroundStyle` is a new style that can style the autocomplete highlight. 
* `AutocompleteToolbarSeparatorStyle` is a new style that can style autocomplete toolbar separators.
* `CalloutStyle` has a new, static `.standard` style.
* `InputCalloutStyle` has a new, static `.standard` style.
* `SecondaryInputCalloutStyle` has a new, static `.standard` style.
* `SystemKeyboardButtonBorderStyle` has a new, static `.standard` style.
* `SystemKeyboardButtonShadowStyle` has a new, static `.standard` style.
* `SystemKeyboardButtonShadowStyle` has new, default init parameter values.  

### 💡 Behavior changes

* `AutocompleteToolbar` now applies the autocomplete background instead of the item view.
* `AutocompleteToolbarItem`'s standard item builder now renders a subtitle if the suggestion has one.
* `InputCallout` and `SecondaryInputCallout` look more like the native callouts.
* `KeyboardAction+Button` now returns `KKL10n.space` for `.space` action.
* `KeyboardGestures` now resolves input contexts from the shared controller, instead of using environment objects.
* `StandardKeyboardAppearance` uses a small transparency to make standard buttons bleed through the underlying vibrancy.
* `SystemKeyboard` uses the new callout styles in the appearance.
* `SystemKeyboardActionButtonContent` now returns a `SystemKeyboardSpaceButtonContent` for `.space`. 
* `SystemKeyboardButtonContent` now uses appearance for both text and image logic.
* `SystemKeyboardButtonContent` no longer applies RTL transforms on the image, since SF symbols do this automatically.
* `SystemKeyboardButtonStyle` now applies a standard shadow style by default.
* `SystemKeyboardSpaceButtonContent` no longer auto-resolves texts, but instead show just what you provide it with.
* `SystemKeyboardSpaceButton` now takes up as much horizontal space as it can.

### 🐛 Bug fixes

* `InputCallout` and `SecondaryInputCallout` no longer get tear lines in some apps.   
* `SystemKeyboardActionButton` now handles the `.nextKeyboard` action correctly.

### 💥 Breaking changes

* All deprecated functionality has been removed.
* All UIKit-specific functionality has been removed.
* Library views that no longer depend on environment objects, may require more init parameters.
* Initializer argument changes are omitted in the list below.

* `AutocompleteProvider` `ignoredWords` is now read-only.
* `AutocompleteResponse` has been renamed to `AutocompleteCompletion`.
* `AutocompleteToolbarItemText` has been renamed to `AutocompleteToolbarItemTitle`.
* `AudioFeedback` has been renamed to `SystemAudio`.
* `BaseSecondaryCalloutActionProvider`'s init is now throwing.
* `CalloutStyle` `buttonOverlayInset` has been renamed to `buttonInset`.
* `CGFloat+Keyboard` has been replaced with `KeyboardLayoutConfiguration`.
* `Color` `clearInteractable` has been made as internal and will be removed over time.
* `EdgeInsets+Keyboard` has been replaced with `KeyboardLayoutConfiguration`.
* `EmojiKeyboard` button builder no longer takes a context.
* `EmojiKeyboardConfiguration` has been renamed to `EmojiKeyboardStyle`
* `HapticFeedback` `prepare` and `trigger` now only has a non-static version.
* `HapticFeedback.player` has been removed.
* `InputCalloutContext` `buttonFrame(for:)` has been removed.
* `InputCalloutContext` `updateInput(for:geo:)` has been renamed to `updateInput(for:,in:)`.
* `KeyboardAction+Button` styles have been moved into `StandardKeyboardAppearance`.
* `KeyboardBehavior` has a new `shouldSwitchToCapsLock` function.
* `KeyboardCasing.neutral` has been removed.
* `KeyboardEnabledStateInspector` `isKeyboardEnabled` `for` parameters has been renamed to `withBundleId`. 
* `KeyboardInputSetProvider` functions have been converted to properties.
* `KeyboardType.custom` has been renamed to `KeyboardType.custom(named:)`.
* `SecondaryInputCalloutContext` `alignment` is now a `HorizontalAlignment`.
* `SecondaryInputCalloutContext` `buttonFrame(for:)` has been removed.
* `SecondaryInputCalloutContext` `updateInputs(for:geo:alignment)` has been renamed to `updateInputs(for:in:alignment:)`.
* `SecondaryInputCalloutStyle` `selectedTextColor` has been renamed to `selectedForegroundColor`.
* `SecondaryInputCalloutStyle` `verticalPadding` has been renamed to `verticalTextPadding`.
* `Sequence` `batched(withBatchSize:)` has been renamed to `batched(into:)`. 
* `SpaceDragSensitivity.custom` has been renamed to `custom(points:)`.
* `SystemAudio` `systemId` has been renamed to `id`.
* `SystemAudio` `trigger` has been renamed to `play`.
* `SystemAudio` `play` now only has a non-static version.
* `SystemAudio.player` is now `SystemAudioPlayer.shared`.
* `SystemAudioPlayer` now takes `SystemAudio` as argument.
* `SystemKeyboardButton` has been renamed to `SystemKeyboardActionButton`.
* `SystemKeyboardButtonContent` has been renamed to `SystemKeyboardActionButtonContent`.
* `SystemKeyboardButtonRowItem` now requires an injected `context`.
* `SystemKeyboardLayoutProvider` `hasElevenElevenSevenAlphabeticInput` is now computed instead of lazy.
* `Toast` has been removed.
* `UITextDocumentProxy` `deleteBackward` with range has been renamed to `deleteBackward(range:)`
* `View+DynamicType` has been removed.
* `View+Autocomplete` has been removed.
* `View+Callout` is now internal.
* `View+DynamicType` has been removed.



## 4.9.3

### ✨ New features

* `PreviewKeyboardAppearance` has been made public.



## 4.9.2

This version renames images to avoid preview problems in apps that define the same image names.

### 🗑 Deprecations

* A bunch of images have been renamed with a `keyboard` name prefix.



## 4.9.1

This version fixes the iOS 15 autorotate bug and adds a property that can suppress the `needsInputModeSwitchKey` warning.

### ✨ New features

* `KeyboardInputViewController` has a new `viewWillSetupKeyboard` function that can be overridden to setup the keyboard at the proper time. It's just a convenience function. You can still setup the keyboard whenever you want.
* `KeyboardInputViewController` has a new, static `needsInputModeSwitchKeyOverride` that can be set to make all input controllers ignore the real value. This can be useful when you want to create a keyboard preview and don't want all the warnings.
* `KeyboardInputViewController` has a new `needsInputModeSwitchKeyOverride` that can be set to make an input controllers ignore the real value. It will default to the static property value.

### 🗑 Deprecations

* `KeyboardInputViewController` `setup(with:)` stack view variant is deprecated and will be removed in 5.0.



## 4.9.0

This version adds styles, which makes it a lot easier to style system keyboards.

It also exposes more system keyboard views and styles publicly.

Starting with this version, the library will start deprecating stuff that willbe changed in KK 5. The aim is to release several patches to prepare the library for the changes to come through deprecations instead of breaking changes.

### ✨ New features

* `KeyboardAppearance` has a new `systemKeyboardButtonStyle` function.
* `NextKeyboardButton` has an iOS 14 exclusive `Color`-based initializer that is now used by `SystemKeyboardButtonContent`
* `SystemKeyboardButtonBody` is a new view that represents the body of a system keyboard button.
* `SystemKeyboardButtonShadow` is a new view that represents the shadow of a system keyboard button.
* `SystemKeyboardButtonStyle` is a new style that can be used to define a system keyboard button style. 
* `SystemKeyboardButtonBorderStyle` is a new style that can be used to define a system keyboard button border.
* `SystemKeyboardButtonShadowStyle` is a new style that can be used to define a system keyboard button shadow.
* `TextInputProxy` now implements `UITextInputTraits` as well.
* `View+systemKeyboardButtonStyle` view extension now taes a style instead of an apperance, action and isPressed bool.

### 🐛 Bug fixes

* Thanks to [@ardavank](https://github.com/ardavank), the `EmojisCategoryKeyboardMenu` now uses fixed fonts.
* `SystemKeyboardButtonContent` now applies the appearance text color to the "next keyboard" button (on iOS 14+).

### 🗑 Deprecations

* `AutocompleteSuggestionProvider` has been renamed to `AutocompleteProvider`.
* `KeyboardAppearance` has deprecated all functions that now can be fetched from the new `systemKeyboardButtonStyle` style.
* `KeyboardInputViewController` `autocompleteSuggestionProvider` has been renamed to `autocompleteProvider`.
* `View+keyboardButtonStyle` has been replaced with `View+systemKeyboardButtonStyle`.

### 💥 Breaking changes

* More system keyboard views require an explicit appearance to be injected.
* The `AutocompleteSuggestionProvider` `autocompleteSuggestions` is now escaping.



## 4.8.0

This versions adds new colors, such as the new standard keyboard background colors, which you can use to mimic keyboard backgrounds.

There are other new colors as well, that are used to work around the iOS color scheme bug, described [here](https://github.com/KeyboardKit/KeyboardKit/issues/305) and in the docs.

This makes it possible for us to finally workaround the dark mode color bug, and let the system keyboard look as the system keyboard in both dark mode and dark appearance keyboards.  

Finally, the dark appearance colors have been renamed and their old names deprecated.

### ✨ New features

* `KeyboardLocale` is now `Codable`.
* `KeyboardColor` has new colors.
* `Color+Keyboard` has new colors.
* `.standardButtonBackgroundForColorSchemeBug` is a new color scheme bug color.
* `.standardDarkButtonBackgroundForColorSchemeBug` is a new color scheme bug color.

### 💡 Behavior changes

* The standard keyboard apperance now uses the new color scheme bug colors, which should make the keyboards look more like the standard ones in dark mode and for dark appearance keyboards.
* `CalloutStyle.standard` now uses the look of `systemStyle`, since that IS the standard. The system styles have been deprecated.
* `SystemKeyboard` uses the new standard callout styles.  


### 🐛 Bug fixes

* `InputCallout` now applies the provided style's callout text color.
* `SecondaryInputCallout` now uses the provided style's callout text color.
* `View+Button` now applies shadows in a way that doesn't affect the button content.
* `SystemKeyboard` now looks closer to the iOS system keyboards, in both dark mode and dark appearance.

### 🗑 Deprecations

* Color extensions for the button background colors are now suffixed with `Background`.
* Color extensions for the button tints colors are now suffixed with `Foreground` instead of `Tint`.
* Color extensions with the name `standardDarkAppearance*` have been renamed to `standard*ForDarkAppearance`.
* `CalloutStyle.systemStyle`, `InputCalloutStyle.systemStyle` and `SecondaryInputCalloutStyle.systemStyle` are deprecated. 

### 💥 Breaking changes

* `KeyboardColor`'s dark appearance cases have been renamed to keep things tight.
* `SecondaryInputCalloutStyle`'s text color property has been removed. Use the callout style's text color instead.  



## 4.7.2

### 🐛 Bug fixes

* Thanks to @AntoineBache, `KeyboardTextField` and `KeyboardTextView` no longer resize if their text content gets to wide. 



## 4.7.1

### ✨ New features

* `Color.darkAppearanceStrategy` is a new, temporary property that lets you inject a custom strategy that controls whether or not to apply a dark appearance color scheme to your keyboard. This lets you work around the current color scheme bug that is described in `Color+Button.swift` and override the standard strategy of always applying dark apperance colors when the keyboard context's `colorScheme` is `.dark`.

If you find a way to determine this correctly and to work around the system behavior, please share your findings.



## 4.7

This version makes KeyboardKit compile for Xcode 13.0 beta 3.

From now, all new versions of KeyboardKit will support the latest Xcode version. 

### 💥 Breaking changes

* `CGFloat+Keyboard` and `EdgeInsets+Keyboard` now uses the shared vc instead of the shared application. 



## 4.6.4

### ✨ New features

* `SystemKeyboardButton` has a new `contentConfig` init param that allows you to modify the button content before wrapping it in a style and applying gestures.

### 💡 Behavior changes

* `KeyboardAction.primary` no longer applies autocomplete by default, which solves e.g. autocomplete suggestions being applied in the Safari address bar. 



## 4.6.3

### ✨ New features

* `KeyboardTextField` and `KeyboardTextView` now accepts a text binding, so that you can access the typed text.

### 💡 Behavior changes

* `KeyboardTextField` and `KeyboardTextView` now share functionality through a new protocol.

### 🐛 Bug fixes

* Thanks to @junyng, deleting backwards now works even when `documentContextBeforeInput` is nil.

### 💥 Breaking changes

* `KeyboardTextField` and `KeyboardTextView` now requires a text binding. 



## 4.6.2

### 🐛 Bug fixes

This version adjusts the colors that are used for dark keyboard appearance and dark mode keyboards, to make keyboards look better in dark appearance when in light mode. 

The problem is discussed [here](https://github.com/KeyboardKit/KeyboardKit/issues/285).

This fix makes the button a little brighter in dark mode, but that's a lot better than having them be a little darker in dark appearance light mode.



## 4.6.1

### 🐛 Bug fixes

This version fixes a bug that caused the keyboard type to not change when typing into a `TextInputProxy` text field.   



## 4.6

This version adds features that makes it possible to add text fields and text views to the keyboard extension and automatically redirect keyboard events there instead of using the hosting app.

You can either set `KeyboardInputViewController.shared.textInputProxy` directly, or use the new `KeyboardTextField` and `KeyboardTextView` views that does this automatically.

### ✨ New features

* There is a new `Proxy` namespace to which the `UITextDocumentProxy` extensions have been moved.
* `KeyboardInputViewController` has a new `textInputProxy` that can be set to redirect the keyboard to that proxy instead of the original `textDocumentProxy`.
* `KeyboardTextField` and `KeyboardTextView` are two new views that can be used in keyboard extensions and that will automatically redirect keyboard events to them when they become first responder.
* `TextInputProxy` is a new class that can be used to redirect the keyboard events to any text input.

### 🐛 Bug fixes

* This version fixes a gesture bug that caused the space tap action to be triggered even after long pressing and dragging the cursor around.   

### 💥 Breaking changes

* `KeyboardInputViewController` `viewWillSyncWithTextDocumentProxy` was not used internally and has been removed. If you override this in your own keyboards, just override `viewWillAppear` instead. 



## 4.5.6

### 🐛 Bug fixes

* `ibayramli2001` and `amirshane` have fixed a crash when deleting backwards without any content in the proxy.   



## 4.5.5

### ✨ New features

* `KeyboardCasing` has a new `auto` case.

### 💡 Behavior changes

* `SystemKeyboardLayoutProvider` uses the new `auto` case for numeric and symbolic keyboard type switches.

### 🐛 Bug fixes

* This version fixes a bug that caused numeric and symbolid keyboards to always switch back to lowercased alphabetic keyboards.

### 🗑 Deprecations

* `BaseKeyboardLayoutProvider` has been renamed to `SystemKeyboardLayoutProvider`.
* `KeyboardCasing.neutral` is deprecated and will be removed. 



## 4.5.4

### ✨ New features

* `StandardKeyboardActionHandler` `canHandle` is now `open` instead of `public`.



## 4.5.3

### 💡 Behavior changes

* `KeyboardGestures` now use the drag gesture to trigger tap actions instead of a tap gesture. This increases responsiveness and ensures that taps aren't cancelled when you press for too long.
* `KeyboardGestures` now only applies a double tap gesture if a double tap action is provided. 
* The changes above helps reducing the number of active gestures and reduces the overall gesture complexity.

### 🐛 Bug fixes

* This version fixes compile errors in Xcode 12.4.

### 🗑 Deprecations

* `Image.settings` has been renamed to `keyboardSettings`.
* `Image.moveCursorLeft/Right` have been renamed to `keyboardLeft/Right`.



## 4.5.2

This version fixes a bug that caused the keyboard layout to not update.



## 4.5.1

This version fixes a bug that caused the secondary actions to not update.



## 4.5

This version adds new locales, external keyboard detection, dynamic type disabling and RTL locale support.

### 🌐 New locales

* 🇫🇷 French
* 🇪🇸 Spanish

### ✨ New features

* `ExternalKeyboardContext` is a new iOS 14 exclusive class that lets you observe whether or not  an external keyboard is connected to the device.
* `KeyboardAction` has a new `standardButtonFontSize` function.
* `KeyboardType` has a new, context-based `standardButtonImage` function that replaces the old property.
* `KeyboardLocale` has new `isLeftToRight` and `isRightToLeft` properties.
* `KeyboardType` has a new `standardButtonFontSize` function.
* `KeyboardType` has a new, context-based `standardButtonText` function that replaces the old property.
* `Locale` has new `characterDirection` and `lineDirection` properties.
* `Locale` has new `isLeftToRight`, `isRightToLeft`, `isBottomToTop`, `isTopToBottom` properties.
* Thanks to [@habaieba](https://github.com/habaieba), KeyboardKit now has French localization.
* There are new localizations for the keyboard type key texts. 

### 💡 Behavior changes

* `KeyboardAction` now flips the standard keyboard button image for RTL locales.
* `SystemKeyboard` will now ignore dynamic type, just like the native keyboards.

### 🐛 Bug fixes

* The German localized newline symbol for Return is now correctly rendered as an image. 

### 🗑 Deprecations

* `KeyboardAction` `standardButtonFont` has been renamed to `standardButtonUIFont`.
* `KeyboardAction` `standardButtonFontWeight` has been renamed to `standardButtonUIFontWeight`.
* `KeyboardAction` `standardButtonImage` has been converted to a context-based function.
* `KeyboardType` `standardButtonText` has been converted to a context-based function.
* `UIApplication` `standardButtonTextStyle` has been renamed to `standardButtonUITextStyle`.

### 💥 Breaking changes

* `KeyboardAction+standardButtonFont` now returns a `Font` instead of a `UIFont`.
* `KeyboardAction+standardButtonFontWeight` now returns a `Font.Weight` instead of a `UIFont.Weight`.
* `KeyboardAction` `standardButtonImage` - the property is deprecated in favor for the context-based function.
* The old properties are now called `standardButtonUIFont` and `standardButtonUIFontWeight`. 



## 4.4

This version adds new locales as well as features that make it easier to work with layouts and collections.

In this version, you can also identify the active app ID, which makes it possible to adjust the keyboard accordingly.

There are also several tweaks and behavior changes that make system keyboards behave even more native-like.

### 🌐 New locales

* 🇬🇧 English U.K. (GB)
* 🇺🇸 English U.S. (same keyboard as base English but different region)

### ✨ New features

* `CGFloat` has a new `standardKeyboardButtonCornerRadius` property.
* `DeleteBackwardRange` is a new enum can be used when deleting backwards.
* `EnglishKeyboardInputSetProvider` has new currency init params.
* `KeyboardAction.PrimaryType` has new `newLine` case, that can be used to force an arrow for primary buttons.
* `KeyboardBehavior` has a new `backspaceRange` property.
* `KeyboardColor` is a new enum that exposes the raw color resources.
* `KeyboardContext` has a new `activeAppBundleId` property that identifies the currently active app.
* `KeyboardContext` has a new `screenOrientation` property that replaces `deviceOrientation`.
* `KeyboardPreviewMode` is a new (hopefully temporary) class that has a static `enable()` function that makes SwiftUI previews work.
* `KeyboardInputViewController` has a new `activeAppBundleId` property that identifies the currently active app.
* `RepeatGestureTimer` has been made public and can be used to inspect how long a repeat gesture has been active.
* `RowItem` is a new protocol that makes it possible to gather row collection functions in one place - `Collection+RowItem`.

* `Collection+RowItem` has new extensions that make it easier to add and remove row items to all collections that contain the new `RowItem` protocol.
* `EdgeInsets+Keyboard` has new context-based extensions.
* `UIInputViewController+Orientation` renames `deviceOrientation` to `screenOrientation`.
* `UITextDocumentProxy+Delete` has a new extension for deleting backwards a certain range.

### 💡 Behavior changes

* `KeyboardAction` now implements `RowItem`.
* `iPadKeyboardLayoutProvider` has been adjusted layout buttons closer to native layouts.
* `iPhoneKeyboardLayoutProvider` has been adjusted layout buttons closer to native layouts.
* `KeyboardInput` now implements `RowItem`.
* `KeyboardLayoutItem` now implements `RowItem`.
* `StandardKeyboardBehavior` now only auto-switches keyboard type on `.tap`.
* `UITextDocumentProxy` handles new lines when checking if the cursor is at new sentence.

* Standard font sizes are adjusted to fit the native keyboards better.
* The standard backspace range is now progressive and will increase after backspace has been pressed for a while.

### 🗑 Deprecations

* `KeyboardContext` `deviceOrientation` has been renamed to `screenOrientation`.
* `UIApplication` `preferredKeyboardInterfaceOrientation` didn't work and will be removed.
* `UIDeviceOrientation` `interfaceOrientation` is no longer used and will be removed.
* `UIInputViewController` `deviceOrientation` has been renamed to `screenOrientation`.
* `UIInterfaceOrientation` - the device orientation-based init is no longer used and will be removed.

### 💥 Breaking changes

* `KeyboardBehavior` has a new `backspaceRange` property that must be implemented. 

Besides the points above, `KeyboardActionHandler` had a convenience `handle` function that didn't require a `sender`.  This caused a conflict with the `StandardKeyboardActionHandler` function with the same signature.  Subclassing `StandardKeyboardActionHandler` and calling `super.handle` thus caused a never-ending loop, since the convenience function called the sender function etc. 

The sender-based functions have thus been removed. If you have a custom action handler that overrides `handle` or `canHandle`, you must remove the `sender` parameter.



## 4.3.1

This version tweaks `KeyboardGestures`  to avoid delays.



## 4.3

This version introduces a bunch of changes to how feedback is being handled.

### ✨ New features

* `AudioFeedbackConfiguration` has default init param values.
* `DragGestureHandler` is a new protocol for handling drag gestures.
* `HapticFeedbackPlayer` is a new protocol for preparing and playing haptic feedback.
* `KeyboardAction` has a new `standardAction(for:gesture)` function.
* `KeyboardFeedbackHandler` is a new protocol for handling keyboard feedback.
* `KeyboardFeedbackSettings` is a new, observable settings object.
* `KeyboardGesture` is now `CaseIterable`.
* `KeyboardInputViewController` has a new `setup(with:)` that takes a `UIStackView`.
* `KeyboardInputViewController` has a new `keyboardFeedbackHandler` property.
* `KeyboardInputViewController` has a new `keyboardFeedbackSettings` property.
* `StandardHapticFeedbackPlayer` is a standard implementation that is used by default.
* `StandardKeyboardActionHandler` has new, cleaner initializers.
* `StandardKeyboardActionHandler` has a new `triggerFeedback` function.
* `StandardKeyboardActionHandler` has a new `spaceDragGestureHandler` that is used to handle space drag gestures.
* `StandardKeyboardFeedbackHandler` is a new, standard feedback handler.
* There are new mocks for the new classes.

### 💡 Behavior changes

* More feedback types are now `Equatable`.
* Action feedback (e.g. tap sound) is now given on `press` instead of `tap`.
* `StandardKeyboardActionHandler` uses the new feedback handler to trigger feedback.

### 🚚 Structure changes

* Audio feedback types have been moved to `Feedback`.
* Haptic feedback types have been moved to `Feedback`.

### 🗑 Deprecations

* `AudioFeedback` `systemPlayer` has been renamed to `player`.
* `KeyboardInputViewController` `keyboardStackView` has been replaced with a new `setup(with:)`.
* `StandardKeyboardActionHandler` has deprecated the two audio/haptic configuration-based initializers.
* `StandardKeyboardActionHandler` `audioConfiguration` is deprecated and converted to a computed property. 
* `StandardKeyboardActionHandler` `hapticConfiguration` is deprecated and converted to a computed property.
* `StandardKeyboardActionHandler` `spaceDragSensitivity` is deprecated.
* `StandardKeyboardActionHandler` `handleSpaceCursorDragGesture` is deprecated.
* `StandardKeyboardActionHandler` `triggerAudioFeedback` is deprecated.
* `StandardKeyboardActionHandler` `triggerHapticFeedback` is deprecated.
* `StandardKeyboardActionHandler` `triggerHapticFeedbackForLongPressOnSpaceDragGesture` is deprecated.



## 4.2

This version adds support for primary actions, such as `.done`, `.go`, `.search` etc.

### ✨ New features

* `BaseKeyboardLayoutProvider` has a new, open `keyboardReturnAction(for:)` function.
* `KeyboardAction` has a new `standardTextDocumentProxyAction`.
* `KeyboardAction` has a new `standardTextDocumentProxyInputAction`.
* `KeyboardAction.primary` is a new action type that gathers all primary action types.
* `KKL10n` has new `text(for:)` functions that let you translate keys for specific contexts and locales. 
* `String+sentenceDelimiters` and `wordDelimiters` can now be modified, if you have specific needs. 
* The iPhone and iPad layout providers now replaces `return` with `done`, `go` and `search` when applicable.

### 🐛 Bug fixes

* English (US) secondary actions now include actions for `$`. 

### 💡 Behavior changes

* New line is now considered to be a `word` delimiter instead of a `sentence` delimiter.
* Due to the new ways to localize content, some signatures must be changed to optional strings.

### 🗑 Deprecations

* `KeyboardAction` `.done`, `.go`, `.ok` and `.search`  have been deprecated and replaced with the new `primary` umbrella type.



## 4.1

[Milestone](https://github.com/KeyboardKit/KeyboardKit/milestone/30).

This version is all about locales and autocomplete, overall: 

This version adds support for `danish`, `finnish`, `norwegian` and `dutch`.

This version also adds many new features aimed at an improved autocomplete experience.

KeyboardKit Pro 4.1 also adds more locale-specific providers as well as a real autocomplete engine.

### 🌐 New locales

* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇫🇮 Finnish
* 🇳🇴 Norwegian

### ✨ New features

* `AutocompleteSpaceState` is a new enum that is used to keep track of how a 
* `AutocompleteSuggestion` has new `isAutocomplete` and `isUnknown` properties.
* `AutocompleteSuggestionProvider` has new functions for ignoring and learning words.
* `AutocompleteToolbar` has a new `itemBuilder` initializer.
* `AutocompleteToolbarItem` is a new view that replicates a native autocomplete item.
* `AutocompleteToolbarItemText` is a new view that replicates the text of a native autocomplete item.
* `KeyboardAction` has a new `isSpace` property.
* `KeyboardAction` has a new `shouldApplyAutocompleteSuggestion` property.
* `KeyboardAction` has a new `shouldReinsertAutocompleteInsertedSpace` property.
* `KeyboardAction` has a new `shouldRemoveAutocompleteInsertedSpace` property.
* `KeyboardLocale` now implementes `Identifiable`.
* `KeyboardLocale` has new `flag`, `id` and `localeIdentifier` properties.
* `KeyboardLocale` has new `sorted` collection extensions.
* `KeyboardInputViewController` has a new `autocompleteSuggestionProvider` property.
* `KeyboardInputViewController` has now implemented `performAutocomplete` and `resetAutocomplete`.
* `StandardKeyboardActionHandler` has a new `tryApplyAutocompleteSuggestion` function.
* `StandardKeyboardActionHandler` has a new `tryHandleReplacementAction` function.
* `StandardKeyboardActionHandler` has a new `tryReinsertAutocompleteRemovedSpace` function.
* `StandardKeyboardActionHandler` has a new `tryRemoveAutocompleteInsertedSpace` function.
* `SystemKeyboardSpaceButtonContent` has a new initializer that lets you inject a custom space view.
* `UITextDocumentProxy` has a new `hasAutocompleteInsertedSpace` property.
* `UITextDocumentProxy` has a new `hasAutocompleteRemovedSpace` property.
* `UITextDocumentProxy` has a new `insertAutocompleteSuggestion` function.
* `UITextDocumentProxy` has a new `isOpenAlternateQuotationBeforeInput(for:)` function.
* `UITextDocumentProxy` has a new `isOpenQuotationBeforeInput(for:)` function.
* `UITextDocumentProxy` has a new `preferredReplacement(for:locale:)` function.
* `UITextDocumentProxy` has a new `tryInsertSpaceAfterAutocomplete)` function.
* `UITextDocumentProxy` has a new `tryReinsertAutocompleteRemovedSpace` function.
* `UITextDocumentProxy` has a new `tryRemoveAutocompleteInsertedSpace` function.

### 💡 Changed behavior

* `KeyboardInputViewController` now uses combine observations to keep locale in sync.

### 🚚 Renamed

* `AutocompleteSuggestion+replacement` has been renamed to `text`.
* `AutocompleteToolbar+ButtonBuilder` has been renamed to `ItemBuilder`.
* `KeyboardLocale+key` has been renamed to `id`.
* `LocaleKey` has been renamed to `KeyboardLocale`.

### 🗑 Deprecations

* `AutocompleteSuggestion+replacement` has been deprecated due to the name change above.
* `AutocompleteToolbar+buttonBuilder` init has been deprecated and replaced with the `itemBuilder` one.
* `AutocompleteToolbar+standardReplacement` has been deprecated.
* `LocaleKey` has been deprecated due to the name change above.
* `KeyboardLocale+key` has been deprecated.
* `KeyboardInputViewController+changeKeyboardLocale` has been deprecated.
* `KeyboardInputViewController+changeKeyboardType` has been deprecated.

### 💥 Breaking changes

* `AutocompleteSuggestionProvider` has new properties and functions that must be implemented. If you have an instance that breaks, just create dummy implementations that does nothing.



## 4.0.3

### 🐛 Bug fixes

This patch fixes a bug with the numeric/symbolic auto-switch back to alphabetic, that could cause a keyboard to get stuck in alpha.



## 4.0.2

This patch fixes a few minor things.

### 🌐 New locales

* 🇮🇹 Italian
* 🇩🇪 German

### 🐛 Bug fixes

* `.done` was accidentally missing a localized text.
* English, German and Italian keyboards used an invalid double quote key text.
* Title1 font is now used for input keys with two characters, e.g. Swedish "kr" currency.
* Numeric and symbolic keyboards didn't auto-switch to alphabetic when tapping space.



## 4.0.1

This patch fixes a few minor things:

### ✨ New features

* `LocaleKey` now implements `CaseIterable`.

### 🚑 Critical fixes

* `StandardKeyboardActionHandler` had a memory leak that has been fixed.



## 4.0

[Milestone](https://github.com/danielsaidi/KeyboardKit/milestone/16?closed=1).

SwiftUI: Rising. In the shadows no more! 

It's time for `SwiftUI` to rise and become the unrelenting force we always knew it would become. 

`KeyboardKitSwiftUI` has been merged into this repository and the deployment target is raised to `iOS 13`. 

SwiftUI support is a first-class citizen from now on. `UIKit` support is still around, but will no longer be actively developed. The future is a bright, declarative one!

Although these release notes aim at covering everything that has changes in this major version, some things will most probably be missed.

### ✨ New features

Besides the new things listed below, there are a bunch of new extensions, images etc. 

* `Callouts` has new types and providers for working with callouts.
* `Image.emoji` no longer requires iOS 14, but uses `person.crop.circle` as fallback on iOS 13.
* `Input` has new types and providers for working with keyboard layouts.
* `KeyboardAction` has new actions - `go`, `nextLocale`, `ok` and `return`.
* `KeyboardAction` has new, localized standard button texts for some actions.
* `KeyboardAction` has new `isPrimaryAction` property.
* `KeyboardAction` has new `standardButtonFontWeight` property.
* `KeyboardAppearance` has a new `image(for:)`.
* `KeyboardCasing` has a new `neutral` case that can be used to show the original state of the inputs.
* `KeyboardContext` has a new  `locales` list and a new `selectNextLocale` function.
* `KeyboardGesture` has new `press` and `release` gestures.
* `KeyboardInput` is a new input type that simplifies building unicode-based keyboards.
* `KeyboardInputSet` is now based on `KeyboardInput`s instead of strings.
* `KeyboardInputViewController` has a new static `shared` instance.
* `KeyboardInputViewController` has a new `keyboardActionHandler`.
* `KeyboardInputViewController` has a new `keyboardAppearance`.
* `KeyboardInputViewController` has a new `keyboardBehavior`.
* `KeyboardInputViewController` has a new `keyboardContext`.
* `KeyboardInputViewController` has a new `keyboardInputCalloutContext`.
* `KeyboardInputViewController` has a new `keyboardInputSetProvider`.
* `KeyboardInputViewController` has a new `keyboardLayoutProvider`.
* `KeyboardInputViewController` has a new `keyboardSecondaryInputActionProvider`.
* `KeyboardInputViewController` has a new `keyboardSecondaryInputCalloutContext`.
* `KeyboardInputViewController` `setup(with:)` is now open and overridable.
* `KeyboardEnabledState` is a new observable class that keeps in sync with the keyboard enabled state.
* `KeyboardLayoutProvider` has a new `register(inputSetProvider:)` to simplify changing global input set provider.
* `Layout` has new types and providers for working with keyboard layouts.
* `Locale` is a new namespace with a few new locale-specific utils.
* `LocaleDictionary` is a simple dictionary wrapper to work with localized resources.
* `LocaleKey` is a simple enum to gather top-level locale identifiers.
* `KKL10n` is a new enum that provides localized strings from KeyboardKit.
* `SystemKeyboard` now highlights buttons when typing on iPad.
* `View` has new `keyboardInputViewController` convenience extensions.
* `View+keyboardToast` has new context-based function.
* `View+localeContextMenu` can be applied to any view to let the user change locale.
* There are new preview-specific implementations that can help you preview keyboard-based views.

### 💡 Changed behavior

* `AutocompleteContext` is now an observable object and not a protocol.
* `AutocompleteToolbar` is now generic, which makes your .
* `AutocompleteToolbar` now uses identifiable bar items, which leads to better separator handling.
* `AutocompleteToolbar` now takes suggestions at init and doesn't require an environment injected `AutocompleteContext`. 
* `AutocompleteToolbar` no longer requires an environment injected `ObservableKeyboardContext`, nor does its builder functions.
* `EmojiCategory` now uses the `Emoji` type instead of a char.
* `FrequentEmojiProvider` now uses the `Emoji` type instead of a char.
* `KeyboardAction` `standardButtonFont` has been coverted to a function.
* `KeyboardAction` `standardButtonText` has been coverted to a function.
* `KeyboardAction` `standardButtonTextStyle` has been coverted to a function.
* `KeyboardAction.emoji` now uses the `Emoji` type instead of a char.
* `KeyboardAction.emojiCategory` no longer has a  standard tap action.
* `KeyboardActionRow` `standardButtonImage` no longer takes a context.
* `KeyboardBehavior` no longer takes a context as function input.
* `KeyboardContext` is now an observable object and not a protocol.
* `KeyboardContext` no longer has any services, just inspectable properties.
* `KeyboardGestures` now handles the new press and release gestures.
* `KeyboardInputSetProvider` implementations now provides punctuation as well.
* `KeyboardInputSetProvider` no longer takes a context as function input.
* `KeyboardInputViewController` `context` is now an `ObservableKeyboardContext`.
* `KeyboardInputViewController` `context` is now called `keyboardContext`.
* `SecondaryCalloutActionProvider` no longer takes a context as function input.
* `SecondaryInputCalloutContext` no longer requires a context init parameter.
* `StandardKeyboardActionHandler` no longer depends on an input view controller.
* `StandardKeyboardActionHandler` now requires an injected keyboard context and behavior.
* `StandardKeyboardActionHandler` now requires an injected autocomplete and keyboard change action.
* `StandardKeyboardActionHandler` now handles the new press and release gestures.
* `StandardKeyboardActionHandler` `triggerAutocomplete` is replaced by an injectable function.
* `StandardKeyboardAppearance` will use `isPrimaryAction` to apply a blue color to those actions.
* `StandardKeyboardAppearance` will fallback to the action's standard font weight instead of `nil`.
* `StandardKeyboardBehavior` now requires an injected keyboard context.
* `StandardKeyboardInputSetProvider` now requires an injected keyboard context.
* `View+KeyboardGestures` now handles the new press and release gestures.

### 🚚 Removed/renamed

* All unused extensions have been removed.
* All previous deprecations have been removed.
* All internal-only used extensions have been made internal.
* `InputCalloutContext.shared` has been removed. Use the environment object instead.
* `KeyboardAction+SecondaryCalloutActions` has been replaced with new `Callouts/Providers` providers.
* `KeyboardActionRow` has been removed, since it's confusing to have two aliases for the same thing.
* `KeyboardAppearance` button properties are prefixed with `button`.
* `KeyboardAppearance` `font` and `fontWeight` have been merged into a single `font` property.
* `KeyboardAppearanceProvider` has been renamed to `KeyboardAppearance`.
* `KeyboardButtonWidth` has been renamed to `KeyboardLayoutWidth`.
* `KeyboardContext` `actionHandler` has been moved to the input vc.
* `KeyboardContext` `keyboardAppearanceProvider` has been moved to the input vc.
* `KeyboardContext` `keyboardBehavior` has been moved to the input vc.
* `KeyboardContext` `keyboardInputSetProvider` has been moved to the input vc.
* `KeyboardContext` `keyboardLayoutProvider` has been moved to the input vc.
* `KeyboardDimensions` is no longer used and has been removed.
* `KeyboardInputSet` locale extensions have been removed.
* `KeyboardInputSet` standard input set extensions have been removed.
* `KeyboardInputViewController` `addKeyboardGestures` has been converted to `KeyboardButton+Gestures`.
* `KeyboardInputViewController` `context` has been renamed to `keyboardContext`.
* `KeyboardInputViewController` `keyboardType` has been removed - use the context directly!
* `KeyboardInputViewController` `setupKeyboard` has been removed and moved to the UIKit demo.
* `KeyboardInputViewController+Gestures` has been converted to `KeyboardButton+Gestures`.
* `KeyboardLayout` `actionRows` has been renamed to `items` and are of a new `KeyboardLayoutItemRows` type.
* `KeyboardCasing` has been renamed to `KeyboardCasing`
* `KeyboardStateInspector` has been renamed to `KeyboardEnabledStateInspector`.
* `ObservableAutocompleteContext` has been renamed to `AutocompleteContext`.
* `ObservableKeyboardContext` has been renamed to `KeyboardContext`. 
* `PhotosImageService` and `StandardPhotosImageService` have been removed.
* `Settings` has been entirely removed.
* `SecondaryInputCalloutContext.shared` has been removed. Use the environment object instead.
* `StandardKeyboardContext` has been replaced by `ObservableKeyboardContext`.
* `StandardKeyboardActionHandler` has a new vc-based initializer.
* `StandardKeyboardActionHandler` no longer takes an optional sender for keyboard actions.
* `StandardKeyboardActionHandler` gesture actions has been gathered in a single `action(for:on)`.
* `StandardKeyboardAppearanceProvider` has been renamed to `StandardKeyboardAppearance`.
* `StandardKeyboardLayoutProvider` no longer has left and right space actions. Implement this in a custom provider instead.
* `SystemKeyboardDimensions` is no longer used and has been removed.
* `UIImage+pasteboard` has been moved to the demo.
* `UIImage+photos` has been moved to the demo.
* `UIImage+resized` has been removed.
* `UIImage+tinted` has been removed.
* `UIInputViewController+NextKeyboard` has been made an internal extension in `UIView+Keyboard`.
* `View+Button` "standard button" functions have been replaced by a single `keyboardButtonStyle` function.
* `View+ClearInteractable` has been removed.
* `View` `keyboardAction(...)` has been renamed to `keyboardGestures(for: ...)`.
* `UIEdgeInsets+Keyboard` `standardKeyboardButtonInsets` has been renamed to `standardKeyboardButtonInsets`.

### 💥 UIKit changes

In this version, `UIKit` is replaced by `SwiftUI` as the primary layout engine.

As such, to avoid `UIKit` parts blocking SwiftUI, types in the `UIKit` folder will be renamed to start with `UI`:

* `AutocompleteToolbarLabel` -> `UIAutocompleteToolbarLabel`
* `AutocompleteToolbarSeparator` -> `UIAutocompleteToolbarSeparator`
* `AutocompleteToolbarView` -> `UIAutocompleteToolbar` (OBS! Name change as well.)
* `HorizontalKeyboardComponent` -> `UIHorizontalKeyboardComponent`
* `KeyboardAlert` -> `UIKeyboardAlert`
* `KeyboardButton` -> `UIKeyboardButton`
* `KeyboardButtonCollectionView` -> `UIKeyboardButtonCollectionView`
* `KeyboardButtonRowCollectionView` -> `UIKeyboardButtonRowCollectionView`
* `KeyboardButtonView` -> `UIKeyboardButtonView`
* `KeyboardButtonRowComponent` -> `UIKeyboardButtonRowComponent`
* `KeyboardCollectionView` -> `UIKeyboardCollectionView`
* `KeyboardToolbarComponent` -> `UIKeyboardToolbarComponent`
* `KeyboardToolbarView` -> `UIKeyboardToolbarView`
* `KeyboardSpacerView` -> `UIKeyboardSpacerView`
* `KeyboardStackViewComponent` -> `UIKeyboardStackViewComponent`
* `PagedKeyboardComponent` -> `UIPagedKeyboardComponent`
* `RepeatingGestureRecognizer` -> `UIRepeatingGestureRecognizer`
* `Shadow` -> `UIShadow`
* `ToastAlert` -> `UIKeyboardToastAlert` (OBS! Name change as well.)
* `VerticalKeyboardComponent` -> `UIVerticalKeyboardComponent`

Their functionality remains intact, however.

There are a new extension as well, as UIKit support moves away from the core layer:

* `UIView+Keyboard` is now used to apply button gestures to a view, instead of having this functionality in the view controller. 



## 3.6.3

This release adds fake protocol implementations, to simplify creating SwiftUI previews.

The release also adds some things for the future:

* `KeyboardButtonWidth` is a new way to express the width of a keyboard button.
* `View+KeyboardButtonWidth` is a new way to apply a width to a keyboard button.

Although not used by the standard keyboards yet, I still wanted to add them before starting working on 4.0.



## 3.6.2

This release rolls back some changes to try improve dark appearance keyboards in SwiftUI. 

Seems like dark appearance can't be detected, since this also enables dark mode. Hopefully this is easier to fix in KK 4.0.



## 3.6.1

This release adds a time threshold to the end sentence action.

This release also fixes so that `CalloutCurve` and `CustomRoundedRect` handles invalid rects.



## 3.6

This release fixes so that the secondary input gesture triggers a tap if there were no secondary actions in the callout.

### New features

* `Emoji` is a new struct that in the future will let us work more with emojis in a more structured and type-safe way.
* `EmojiCategory` now lets you register a `frequentEmojiProvider`, and uses that to populate the frequent category.
* There is a new `EmojiProvider` protocol
* There is a new `FrequentEmojiProvider` protocol
* There is a new `MostRecentEmojiProvider` class
* There is a new `String+Delimiters` extension with word and sentence delimiters.
* There are new `UITextDocumentProxu+Content` extensions to get previous sentences and words.

* `AutocompleteToolbar` has a new, static  `standardReplacement` function.
* `AutocompleteToolbar` has a new, static  `standardReplacementAction` function.
* `AutocompleteToolbar` now lets you provide an optional, custom  `replacementAction` in init.
* `Color+Resources` is a new extension that provides asset-based colors that adapt to dark mode.
* `EmojiCategoryKeyboard` is a new view that lists the emojis of a selected category and a menu.
* `EmojiCategoryKeyboardMenu` is a new view that lets the user select one of multiple categories.
* `EmojiKeyboard` is a new view that renders a set of emojis in a lazy grid. The item action is customizable.

### Behavior changes

* `EmojiCategory` now implements `EmojiProvider`
* `EmojiCategory.frequent` now returns emojis from the `frequentEmojiProvider`.
* `StandardKeyboardActionHandler` now tries to register emojis with the `EmojiCategory` frequent emoji provider.

* `Color+Button` uses the new asset-based colors.
* `SystemKeyboardButtonBody` now only offsets small caps texts.
* The emoji action has a filled standard image instead of an outlined one.
* Due to a secondary callout action bug, the secondary context is now created by the vc.

### Bug fixes

* The `´` accent was accidentally used in standard numeric keyboards. It has now been replaced with `’`, which is the correct one.

### Deprecations

* `KeyboardContext.emojiCategory` has been deprecated. This should be persisted by the view instead.
* `PhotosImageService` and the standard implementation has been deprecated. Copy it to your own project if you want to keep on using it.
* `UIImage+Photos` has been deprecated. Copy it to your own project if you want to keep on using it.

* Some button-specific `Color` extensions have been deprecated.
* `View+keyboardAction(:context:)` has been deprecated. 

### Breaking changes

* `secondaryCalloutInputProvider` has been removed from `KeyboardContext`. It's now only in the secondary context.



## 3.5.2

This release fixes so that the secondary input gesture triggers a tap if there were no secondary actions in the callout.

The release also makes the entire autocomplete button tappable, instead of just the text.



## 3.5.1

This release fixes so that upper-cased chars gets secondary callout actions and that the input callout isn't dismissed if there are no secondary actions.  



## 3.5

This release makes it easier to inject custom views into the `SwiftUI`-based `SystemKeyboard` and `AutocompleteToolbar`. 

There is also a new `SystemKeyboardSpaceButton` which lets you present the current locale before fading to "space".

The release also adds a spacebar drag gesture and deprecates some `haptic` properties as well as some `system` properties in favor of the `standard` naming concept (since the system behavior *is* the standard behavior).

### New features
 
* `AutocompleteSuggestion` is a new protocol that makes the autocomplete provider concept more general.
* `HapticFeedback` has a new `longPressOnSpace` case.
* `KeyboardAppearanceProvider` is a protocol for providing button content and style.
* `KeyboardContext` has a new `keyboardAppearanceProvider` property.
* `StandardKeyboardActionHandler` has new functionality for handling the space drag gesture.
* `StandardKeyboardAppearanceProvider` is a standard appearance provider that returns standard values.

* `SystemKeyboardButtonContent` is new view that extracts content logic from `SystemKeyboardButton`.
* `SystemKeyboardButtonRowItem` can now be created with generic views. 
* `SystemKeyboardSpaceButton` is new view that wraps `SystemKeyboardSpaceButtonContent` and applied a style and gestures to it.
* `SystemKeyboardSpaceButtonContent` is new view that animates between a locale text and a space text.

### Behavior changes

* `HapticFeedback.standard` has almost no haptic feedback now, since that *is* the standard behavior. 
* `SystemKeyboard` now wraps the `buttonBuilder` generated views in a `SystemKeyboardButtonRowItem`.
* `SystemKeyboardButton` now applies a fallback text from the new appearance provider.
* The standard `SystemKeyboard` button builder generates `SystemKeyboardButtonContent` instead of `SystemKeyboardButton`.

### Deprecations

* `HapticFeedback` standard cases have been deprecated, since native keyboards have almost no haptic feedback.
* `KeyboardAction` `systemFont` is renamed to `standardButtonFont`.
* `KeyboardAction` `systemKeyboardButtonText` is renamed to `standardButtonText`.
* `KeyboardAction` `systemTextStyle` is renamed to `standardButtonTextStyle`.
* `KeyboardType` `systemKeyboardButtonText` is deprecated.
* `String` implements `AutocompleteSuggestion` to avoid breaking changes in KK 3.5+. You should provide your own custom types, though.

* `Color` `systemKeyboardButtonBackgroundColorDark` has been renamed to `standardDarkButtonBackgroundColor` 
* `Color` `systemKeyboardButtonBackgroundColorLight` has been renamed to `standardLightButtonBackgroundColor` 
* `Color` `systemKeyboardButtonForegroundColor` has been renamed to `standardButtonForegroundColor` 
* `Color` `systemKeyboardButtonShadowColor` has been renamed to `standardButtonShadowColor`
* `KeyboardAction` `systemKeyboardButtonBackgroundColor` has been renamed to `standardButtonBackgroundColor` 
* `KeyboardAction` `systemKeyboardButtonImage` has been renamed to `standardButtonImage` 
* `KeyboardAction` `systemKeyboardButtonShadowColor` has been renamed to `standardButtonShadowColor`
* `KeyboardCasing` `systemImage` has been renamed to `standardButtonImage`
* `KeyboardCasing` `systemKeyboardButtonImage` was unused and has been deprecated.
* `KeyboardType` `systemKeyboardButtonImage` has been renamed to `standardButtonImage`
* `View` `systemKeyboardButtonStyle` has been renamed to `standardButtonStyle`
* `View` `systemKeyboardButtonBackground` has been renamed to `standardButtonBackground`
* `View` `systemKeyboardButtonFont` has been renamed to `standardButtonFont`
* `View` `systemKeyboardButtonForeground` has been renamed to `standardButtonForeground`
* `View` `systemKeyboardButtonShadow` has been renamed to `standardButtonShadow`

### Breaking changes

* `AutocompleteToolbarView` and `AutocompleteToolbar` now use `AutocompleteSuggestion` instead of `String`. It makes them MUCH more powerful, so I hope this breaking change is acceptable.
* `SystemKeyboardButtonRowItem` has been made generic.
* `SystemKeyboard.ButtonBuilder` now returns an `AnyView` since you may want to use any custom view for any button.


## 3.4.2

This release adds curves and behavior changes to the callout bubbles.

### Behavior changes

* The disabled secondary % callout actions have been re-enabled.
* `CalloutStyle` now applies button frame insets when configured for a system keyboard.
* `InputCallout` has curves between the button area and the callout.
* `InputCalloutContext` has a new `isEnabled` property that is only true for phones, since it should not be displayed on iPads.
* `InputCalloutContext` no longer insets the button rect.
* `SecondaryInputCallout` has curves between the button area and the callout and the design is improved.
* `SystemInputCalloutContext` no longer insets the button rect.

### New features

* `CalloutCurve` is a new shape that can be used to smoothen the two parts of a callout bubble.



## 3.4.1

This release fixes some visual artefacts in the callout bubbles.



## 3.4

From now on, release notes will include changes in both KeyboardKit and KeyboardKitSwiftUI.

This release adds support for input callouts and secondary input callouts.

### New features

This release has new features for secondary callout actions.

* `KeyboardAction+SecondaryCalloutActions` specifies standard, locale-specific secondary callout actions for keyboard actions.
* `KeyboardContext` has a new `secondaryCalloutActionProvider` property.
* `SecondaryCalloutActionProvider` is a protocol for providing secondary callout actions for keyboard actions.
* `StandardSecondaryCalloutActionProvider` is a standard action provider that returns the standard secondary callout actions.

* `CalloutStyle` is a shared style for keyboard button callout.
* `InputCallout` is a callout that can highlight the currently pressed keyboard button.
* `InputCalloutContext` can be used to control `InputCallout` views.
* `InputCalloutStyle` can be used to style `InputCallout` views.
* `SecondaryInputCallout` is a callout that can present secondary actions for the currently pressed keyboard button.
* `SecondaryInputCalloutContext` can be used to control `SecondaryInputCallout` views.
* `SecondaryInputCalloutStyle` can be used to style `SecondaryInputCallout` views.
* `View+InputCallout` can be used to wrap any view in a `ZStack` with a topmost `InputCallout`
* `View+SecondaryInputCallout` can be used to wrap any view in a `ZStack` with a topmost `SecondaryInputCallout`


### Behavior changes

Since the new secondary input callout, which triggers on long press, I have removed the standard long press action for all actions except backspace. 

This also makes standard KeyboardKit keyboards behave more like native iOS keyboards.

* `View+KeyboardGestures` has been extended with gestures for `InputCallout` and `SecondaryInputCallout`.

### Breaking changes

This release also has breaking changes to experimental features.

* `KeyboardInputProvider` has been renamed to `KeyboardInputSetProvider`
* `KeyboardInputSetProvider`s properties are now context-based functions
* `KeyboardContext` `keyboardInputProvider` has been renamed to `keyboardInputSetProvider`
* `ObservableKeyboardContext` `keyboardInputProvider` has been renamed to `keyboardInputSetProvider`



## 3.3

This release contains a bunch of new features that makes the keyboard behave more like the native keyboards when typing, for instance auto-capitalization and auto-lowercasing.

### Keyboard behavior

This release separates action handling from behavior, which I hope makes the code cleaner and easier to test and simplifies reusing behavior outside of an action handling context. 

* `KeyboardBehavior` specifies how a keyboard should behave.
* `StandardKeyboardBehavior` specifies the standard behavior of a western keyboard.

You can create your own behaviors as well as subclass and override parts of the standard behavior.

Note that this is an experimental feature that may have to be revisited before 4.0.

### New features

* `KeyboardContext` has a new `preferredKeyboardType` property.
* `KeyboardContext` has a new `actionBehavior` property.
* `StandardKeyboardBehavior` has caps-lock double tap logic.
* `UITextDocumentProxy` has a new `isCursorAtNewSentence` property.
* `UITextDocumentProxy` has a new `isCursorAtNewWord` property.
* `UITextDocumentProxy` has a new `endSentence` function that removes any space before the cursor, then closes the sentence.
* `UITextDocumentProxy` has a new `sentenceDelimiters` property.
* `UITextDocumentProxy` has a new `wordDelimiters` property.

### Behavior changes

* The caps-lock double tap logic is moved from double-tap on shift to the new keyboard behavior.
* The sentence ending logic is moved from double-tap on space to the new keyboard behavior.
* The sentence ending logic is no longer based on double-tap, which makes it easier to use.
* `KeyboardAction` `standardDoubleTapAction` is not defined for any actions anymore.
* `KeyboardInputViewController` `changeKeyboardType` has no time interval anymore.
* `StandardKeyboardContext` initializer now has a default value for the keyboard type.

### Bug fixes

* The standard keyboard layout has been fixed to use the correct caps-lock button image.

### Deprecations

* `KeyboardAction` `endSentenceAction` has been moved to `UITextDocumentProxy+EndSentence`.
* `KeyboardAction` `standardDoubleTapAction` is not used internally anymore.
* `KeyboardContext` `changeKeyboardType` is not used internally anymore.
* `KeyboardType` `canBeReplaced` is not used internally anymore.
* `StandardKeyboardActionHandler` `handleKeyboardSwitch` is renamed to `handleKeyboardTypeChange`.
* `StandardKeyboardActionHandler` `preferredKeyboardType` has been moved to the keyboard behavior.

These deprecations will be removed in v 4.0.



## 3.2

This release contains improvements to the input set logic:

* There is a new `KeyboardInputProvider` protocol.
* `StandardKeyboardInputProvider` tries to use the current locale (fallback to English) and can be inherited.
* `StaticKeyboardInputProvider` uses three static input sets. 
* `InputSet+English` has been renamed to `InputSet+Locale` and has more sets.
* `InputSet+Locale` extension has support for basic English, German, Italian and Swedish.
* `StandardKeyboardInputProvider` is used by default in the context, but you can change this at anytime.

The release also introduces a new "keyboard layout" concept, where a keyboard layout is an input set with surrounding actions:

* There is a new `KeyboardLayout` struct.
* There is a new `KeyboardLayoutProvider` protocol.
    * `StandardKeyboardLayoutProvider` uses the current context and can be inherited.
    * `StaticKeyboardLayoutProvider` uses a static layout that is provided at init.
* `StandardKeyboardLayoutProvider` is used by default in the context, but you can change this at anytime.

There are new properties in the `KeyboardContext`.

This release also makes it easier to resolve system keyboard dimensions:

* `CGFloat+Keyboard` has utils to resolve the standard keyboard row height.
* `KeyboardStackViewComponent`s use this new standard height as default height.
* `UIEdgeInsets+Keyboard` has utils to resolve the standard keyboard row item insets.
* `KeyboardButtonRowComponent`s use these new standard insets as default insets.

The demos have been updated with these changes.

### Bug fixes:

* The context controller propertis are marked as `@unowned` to fix a memory leak. 

### Deprecations:

* `CGFloat+KeyboardDimensions` is deprecated and will be removed in 4.0.
* `KeyboardContext`'s `controller` is now deprecated and will be removed in 4.0 .Usage is strongly discouraged. Use the context instead. 

### Breaking:

* `KeyboardContext` has new properties to make the new input and layout additions possible. If you have created your own context, you will have to add these.



## 3.1.1

This version contains new features:

* `EmojiCategory` is now `Codable`.
* `EmojiCategory` has a `fallbackDisplayEmoji` that is used as system button text if no custom button image used.
* `KeyboardAction` now has a standard tap action for `.emojiCategory`.
* `KeyboardContext` now has an `emojiCategory`  property.



## 3.1

This version contains new protocols and classes:

* `KeyboardInputViewController` has new, empty `performAutocomplete` and `resetAutocomplete` functions that are called by the system at proper times.
* The new `AutocompleteSuggestions` typealias makes the autocomplete apis cleaner.
* There is a new `AutocompleteContext` protocol that can be used to manage suggestions. 
* There is a new `StandardAutocompleteContext` implementation of `AutocompleteContext`.
* There is a new `UITextDocumentProxy` property to check if the proxy cursor is at the end of the current word.

### Bug fixes:

* The "end sentence" action that is used by space double taps, uses the new proxy property to only close when the cursor is at the end of a word.



## 3.0.2

In this version:

* A memory leak was fixed by making all `StandardBookActionHandler` actions use `[weak self]`.
* The UIKit button shadow logic was improved by @jackhumbert.



## 3.0.1

This version fixes a bug, where the globe button that is used by the demo keyboards didn't do anything.

This version also fixes the system image's font weight.



## 3.0

This version removes all previously deprecated parts of the library and adds improved support for SwiftUI and iOS 13.

If you upgrade from an older version to `3.0` and have many breaking changes, upgrading to `2.9` first provides deprecation help that may make the transition easier.


### New functionality

There is a new `KeyboardContext`, which provides important contextual information.
* `StandardKeyboardContext` is the standard, non-observable implementation.
* `ObservableKeyboardContext` is an iOS 13+ required, observable implementation.
* `StandardKeyboardActionHandler` now automatically handles keyboard type switching and only delays if an action has a double-tap action.
* `StandardKeyboardActionHandler` now automatically switches to certain keyboards after certain actions, as defined by `handleKeyboardSwitch(after:on:)` and `preferredKeyboardType(after:on:)`.

There are new `KeyboardAction` types and properties:
* `.control` represents the system.
* `.systemImage` can be used with SF Symbols.
* `.systemFont` and `.systemTextStyle` provide system look information.

There is a new `System` namespace with utils to help you build native-imitating system keyboards.

There is a new `KeyboardInputSet` concept that will simplify building language-specific keyboards. For now, it contains English characters, numerics and symbols. 

The demo project contains a new `KeyboardKitSwiftUIPreviews` in which you can preview KeyboardKitSwiftUI views. 


### SwiftUI

* This repository has a new SwiftUI-based demo app, which is still in development.
* `KeyboardImageButton` supports the new `systemImage` action.


### Non-breaking changes:

* `KeyboardInputViewController` `deviceOrientation` has been converted to a general `UIInputViewController` extension.
* `setupNextKeyboardButton` has been converted to a general `UIInputViewController` extension.


### Breaking changes:

* `KeyboardInputViewController` has a new `keyboardContext` property.
* `StandardKeyboardContext` is used by default, whenever a keyboard extension is created.
* `ObservableKeyboardContext` is used by whenever a keyboard switches over to use SwiftUI.

* `KeyboardInputViewController` `keyboardActionHandler` has been moved to `KeyboardContext`.
* `KeyboardInputViewController` `canChangeKeyboardType` has been moved to `KeyboardType`.
* `KeyboardInputViewController` `changeKeyboardType` has been moved to `KeyboardContext`.
* `KeyboardInputViewController` `changeKeyboardTypeDelay` is now an argument in `changeKeyboardType`.
* `KeyboardInputViewController` `keyboardType` has been moved to the context.

* `AutocompleteToolbar` has been renamed to `AutocompleteToolbarView`.
* `EmojiCategory.frequents` has been renamed to `frequent`.
* `KeyboardActionHandler` now requires `canHandle(_:on:)` to be implemented.
* `KeyboardAction` has new action types.
* `KeyboardAction` has fewer `isXXX` properties.
* `KeyboardAction` `.capsLock` and `shiftDown` are now part of `KeyboardAction.shift`.
* `KeyboardActionRow.from` has been changed to an initializer.
* `KeyboardActionRows.from` has been changed to an initializer.
* `KeyboardImageActions` has been converted to a `KeyboardActionRow+Images` extension initializer.
* `KeyboardToolbar` has been renamed to `KeyboardToolbarView`. 
* The `shouldChangeToAlphabeticLowercase` has been replaced with the automatic switching mentioned above.
* The `isKeyboardEnabled` function now uses a `for` as external argument name.


### Removed, previously deprecated parts:

* `AutocompleteBugFixTimer`
* `AutocompleteSuggestionProvider` `provideAutocompleteSuggestions`
* `KeyboardAction` `switchKeyboard`
* `KeyboardAction` `switchToKeyboard`
* `KeyboardAction` `standardInputViewControllerAction`
* `KeyboardAction` `standardTextDocumentProxyAction`
* `KeyboardActionHandler` `handleTap/Repeat/LongPress`
* `KeyboardActionHandler` `handle` gesture on `UIView`
* `KeyboardInputViewController` `addSwitchKeyboardGesture`
* `PersistedKeyboardSetting` init with key
* `StandardKeyboardActionHandler` `init` with feedback instances
* `StandardKeyboardActionHandler` `action` for view
* `StandardKeyboardActionHandler` `animationButtonTap`
* `StandardKeyboardActionHandler` `giveHapticFeedbackForLongPress/Repeat/Tap`
* `StandardKeyboardActionHandler` `longPress/repeat/tapAction` for view
* `StandardKeyboardActionHandler` `handleLongPress/Repeat/Tap`
* `StandardKeyboardActionHandler` `triggerAudio/HapticFeedback`
* `UIColor` `clearTappable`
* `UIInputViewController` `createAutocompleteBugFixTimer`
* `UIView` `add/removeLongPress/Repeating/TapAction`
* `isKeyboardEnabled` global function



## 2.9.3

This version updates external test dependencies to their latest versions.



## 2.9.2

This version removes the subview fiddling from `KeyboardCollectionVew` to the built-in subclasses, since it can ruin the view hierarchy for collection views that don't add custom views to the cells.



## 2.9.1

This version adds an `.emoji` keyboard action, which can be used if you need to separate characters from emojis.

This version also extracts the logic of `KeyboardAction` `standardTapAction` into:

* `standardTapActionForController`
* `standardTapActionForProxy`

This makes it possible to use the standard function in other ways, should you need it.

This version also makes `actions` of `KeyboardCollectionView` mutable, causing changes to this property to refresh the view.



## 2.9

This is the last minor version before `3.0`, which will remove a bunch of deprecated members.

This version adds more features, fixes some bugs and deprecates many parts of the library.

A big change, which is not fully covered in these notes, is that `KeyboardInputViewController` and `StandardKeyboardActionHandler` now handles changing keyboard types. Even if you have to fill a "type" with meaning in your app, you now have implemented logic to help you handle this.

Thanks to @eduardoxlau, the demo also has an improved emoji keyboard. 

### New features

* `KeyboardAction` has new `standardTap/DoubleTap/LongPress/Repeat` action properties.
* `KeyboardInputViewController` has a new `deviceOrientation` property.
* `KeyboardInputViewController` has a new `keyboardType` property.
* `KeyboardInputViewController` has new `can/changeKeyboardType` functions and properties.
* `KeyboardInputViewController` has a new `setupKeyboard` function.
* `StandardKeyboardActionHandler` has more logic for handling keyboard type changes.
* The new `EmojiCategory` enum represents the native iOS emoji keyboard categories.
* The new `KeyboardStateInspector` can be implemented to get info about the keyboard.

### Changes

* The demo now switches to caps lock when shift is double-tapped.
* The standard tap animation does not scale up as much as before.
* The standard haptic feedback for tap is light impact instead of medium.

### Deprecations

* `KeyboardAction.switchKeyboard` has been renamed to `nextKeyboard`.
* `KeyboardAction.switchToKeyboard` has been renamed to `keyboardType`.
* `KeyboardAction.standardInputViewControllerAction` has been renamed to `standardTapAction`.
* `KeyboardAction.standardTextDocumentProxyAction` is no longer used by the system`.
* `addSwitchKeyboardGesture(to:)` has been renamed to `addNextKeyboardGesture(to:)`.
* The global `isKeyboardEnabled` has been replaced with a new `KeyboardStateInspector` protocol.

### Bug fixes

* Double tap handling for space no longer inserts an additional space.

### Breaking change

* `KeyboardType.alphabetic` now uses a `KeyboardCasing` property instead of a bool for if it's upper-cased or not.
* `KeyboardAction.switchToKeyboard` is now an alias for `keyboardType`. You can still use it when defining actions, but if you switch over `KeyboardAction`, you have to use `keyboardType` instead of `switchToKeyboard`.



## 2.8.1

This version fixes some division by zero bugs.



## 2.8

This version fixes a gesture-related memory leak by no longer using the gesture extensions that caused the problem. Instead, `KeyboardInputViewController` has a new set of internal gesture extensions that helps with adding gestures to a button.

This version also adds double-tap action handling to KeyboardKit. It's handled like taps, long presses and repeating actions, but it has no default logic. To handle it, create a custom action handler and override `handle(_ gesture:,on action:, sender:)`.

KeyboardKit does not put any rules on the gesture handling. If you return an action for both a single tap and a double tap, both will be triggered.


### New features

* A new `.doubleTap` keyboard gesture.

### Deprecations

* The `UIView` `addLongPressAction` extension is deprecated.
* The `UIView` `removeLongPressAction` extension is deprecated.
* The `UIView` `addRepeatingAction` extension is deprecated.
* The `UIView` `removeRepeatingAction` extension is deprecated.
* The `UIView` `addTapAction` extension is deprecated.
* The `UIView` `removeTapAction` extension is deprecated.



## 2.7.4

This version upgrades the podspec's Swift version.



## 2.7.3

This version upgrades its Nimble and Mockery dependencies.



## 2.7.1, 2.7.2

These versions adjust the keyboard settings url.



## 2.7

This version adds the very first (and so far limited) support for `SwiftUI`. Many new features are iOS 13-specific.

This version also deprecates a bunch of action handling logic and adds new functions that doesn't rely on `UIView`.


### New features

* `KeyboardInputViewController` has a new `setupNextKeyboardButton(...)` which turns any `UIButton` into a system-handled "next keyboard" button.
* `NextKeyboardUIButton` makes use of this new functionality, and sets itself up with a `globe` icon as well.
* `PhotoImageService` and `StandardPhotoImageService` can be used to save images to photos with a completion instead of a target and a selector.
* `KeyboardImageActions` makes it easy to create a bunch of `.image` actions from a set of image names.
* `KeyboardActionHandler` has a new `open handle(_ gesture:on:view:)`  which is already implemented in `StandardKeyboardActionHandler`.

* The global `isKeyboardEnabled` function can be used to check if a certain keyboard extension is enabled or not.
* The `keyboardSettings` `URL` extension is a convenience extension for finding the url to application settings.
* The `evened(for gridSize: Int)` `[KeyboardAction]` extension appends enough `.none` actions to evenly fit the grid size.
* The `saveToPhotos(completion:)` `UIImage` extension is a completion-based way of saving images to photos.

### SwiftUI

There are some new views that can be used in SwiftUI-based apps and keyboard extensions:

* `KeyboardGrid` distributes actions evenly within a grid.
* `KeyboardGridRow` is used for each row in the grid.
* `KeyboardHostingController` can be used to wrap any `View` in a keyboard extension.
* `KeyboardImageButton` view lets you show an `.image` action or `Image` in a `Button`.
* `NextKeyboardButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `PersistedKeyboardSetting` is a new property wrapper for persisting settings in `UserDefaults`. 

* `Color.clearInteractable` can be used instead of `.clear` to allow gestures to be detected.
* `Image.globe` returns the icon that is used for "next keyboard".
* `KeyboardInputViewController` `setup(with:View)`  sets up a `KeyboardHostingController`.
* `View` `withClearInteractableBackground()` can be used to make an entire view interactable.

Note that `KeyboardKitSwiftUI` is a separate framework, which you have to import to get access to these features.

### UIKit

There are some new UIKit features and extensions:

* `NextKeyboardUIButton` sets itself up with a `globe` icon and works as a standard "next keyboard" button.
* `UIImage.globe` returns the icon that is used for "next keyboard".

All UIKit-specific functionality is placed in the `UIKit` folder. UIKit logic that can be used in SwiftUI is outside it.

### Changes:

* `isInputAction` now includes `.space`.
* `isSystemAction` no longer includes `.space`.

### Deprecations

* `UIColor.clearTappable` has been renamed to `UIColor.clearInteractable`.
* `KeyboardActionHandler` has deprecated the gesture-explicit handle functions.
* `KeyboardActionHandler` has deprecated the view-explicit handle function in favor of an optional `Any` sender variant.
* `StandardKeyboardActionHandler` has deprecated a bunch of `UIView`-explicit functions in favor of an optional `Any` sender variant.



## 2.6.2

This version fixes a [bug](https://github.com/danielsaidi/KeyboardKit/issues/60), where `moveCursorForward` moved the cursor incorrectly.



## 2.6.1

This version adds `enableScrolling()` and `disableScrolling()` to `AutocompleteToolbar`. This makes it possible to make the entire toolbar scroll if its content doesn't fit the screen.



## 2.6

This version adds more autocomplete functionality:

* `AutocompleteToolbar` has a new convenience initializer that makes it even easier to setup autocomplete.
* `AutocompleteToolbarLabel` is the default autocomplete item view and can be tapped to send text to the text document proxy.
* `AutocompleteToolbarLabel` behaves like the native iOS autocomplete view and displays centered text until the text must scroll.
* Autocomplete no longer requires the bugfix timer. Instead, just let the action handler request autocomplete suggestions when a tap action is triggered.

The `StandardKeyboardActionHandler` has new functionality:
* `animationButtonTap()` - can be overridden to change the default animation of tapped buttons.

Deprecations:
* The `AutocompleteBugFixTimer` and all timer-related logic has been deprecated.
* The `AutoCompleteSuggestionProvider`'s `provideAutocompleteSuggestions(for:completion:)` is deprecated and replaced with `autocompleteSuggestions(for:completion:)`.
* The `StandardKeyboardActionHandler`'s `handleXXX(on:)` are now deprecated and replaced with `handle(:on:view:)`. 



## 2.5

This version adds a bunch of features, tweaks some behaviors and deprecates some logic:

New stuff:
* There is a new `KeyboardActionGesture` that will be used to streamline the action handling api:s.
* There is a new `AudioFeedback` enum that describes various types of audio feedback.
* There is a new `AudioFeedbackConfiguration` that lets you gather all configurations in one place.
* There is a new `HapticFeedback.standardFeedback(for:)` function that replaces the old specific properties.
* There is a new `HapticFeedbackConfiguration`  that lets you gather all configurations in one place.
* There is a new `StandardKeyboardActionHandler` init that uses this new configuration.
* There is a new `StandardKeyboardActionHandler.triggerAudioFeedback(for:)` that can be used to trigger audio feedback.
* There is a new `StandardKeyboardActionHandler.triggerHapticFeedback(for:on:)` that replaces the old gesture-specific ones.
* There is a new `StandardKeyboardActionHandler.gestureAction(for:)` function that is used by the implementation. The old ones are still around.
* There is a new `KeyboardType.images` case that is used by the demo.

Changed behavior:
* There is a new `standardButtonShadow` `Shadow` property that can be used to mimic the native button shadow.

Deprecated stuff:
* The old `StandardKeyboardActionHandler.init(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForLongPress(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForRepeat(...)` is deprecated, use the new one.
* The old  `StandardKeyboardActionHandler.giveHapticFeedbackForTap(...)` is deprecated, use the new one.
* The old `HapticFeedback.standardTapFeedback` and `standardLongPressFeedback` have been replaced by the new function.

The old `handle` functions are still declared in the `KeyboardActionHandler` protocol, but will be removed in the next major version. 



## 2.4

This version adds Xcode 11 and iOS 13 support, including support for dark mode and high contrast color variants.



## 2.3

This version adds autocomplete support, which includes an autocomplete suggestion provider protocol, a new toolbar and new extensions.

The new `AutocompleteSuggestionProvider` protocol describes how to provide your keyboard with autocomplete suggestions. You can implement it in any way you like, e.g. to use a built-in suggestion database or by connecting to an external data source, using network requests. Note that the network option will be a lot slower and also require you to request full access from your users.

The new `AutocompleteToolbar` is a toolbar that can display any results you receive from your suggestion provider (or any list of strings for that matter). Just trigger the provider anytíme the text changes and route the result to the toolbar. The toolbar can be populated with any kind of views. Have a look at the demo app for an example.

The new `UITextDocumentProxy+CurrentWord` extension helps you get the word that is (most probably) being typed. You could use this when requesting autocomplete suggestions, if you only want to autocomplete the current word.

Besides these additions, there are a bunch of new extensions, like `UITextDocumentProxy` `deleteBackward(times:)`, which lets you delete a certain number of characters. Have a look at the `Extensions` namespace for a complete list.

There is also a new `KeyboardCasing` enum that you can use to keep track of which state your keyboard has, if any. This enum is extracted from demo app code that was provided by @arampak earlier this year. 

 **IMPORTANT** iOS has a bug that causes `textWillChange` and `textDidChange` to not be called when the user types, only when the cursor moves. This causes autocomplete problems, since the current word is not changing as the user types. Due to this, the input view controller must use an ugly hack to force the text document proxy to update. Have a look at the demo app to see how this is done.



## 2.2.1

This version solves some major bugs in the repeating gesture recognizer and makes some `public` parts of the library `open`.

The standard action handler now handles repeating actions for backspace. You can customize this in the same way as you customize tap and long press handling.

You can test the new repeating logic in the demo app.



## 2.2

This version adds more keyboard actions that don't exist in iOS, but that may serve a functional or semantical purpose in your apps:

* `command`
* `custom(name:)`
* `escape`
* `function`
* `option`
* `tab`

The new `custom` action is a fallback that you can use if the existing action set is insufficient for your specific app.

I have added a `RepeatingGestureRecognizer` and an extension that you can use to apply it as well. It has a custom initial delay as well as a custom repeat interval, that will let you tap and hold a button to repeat its action. In the next update, I will apply this to the backspace and arrow buttons.

Thanks to [@arampak](https://github.com/arampak), the demo app now handles shift state and long press better, to make the overall experience much nicer and close to the native keyboard. The keyboard buttons also registers tap events over the entire button area, not just the button view.



## 2.1

This version makes a bunch of previously internal extensions public. It also adds a lot more unit tests so that almost all parts of the library are tested.

The default tap animation has been configured to allow user interaction, which reduces the frustrating tap lag that was present in 2.0.0.

I have added a `KeyboardToolbar` class, which you can use to create toolbars. It's super simple so far, and only creates a stack view to which you can any views you like.



## 2.0.1

This version adds a public shadow extension to the main library and shuffles classes and extensions around. It also restructures the example project to make it less cluttered.

I noticed that the build number bump still (and randomly) bumps the build number incorrectly, which causes build errors. I have therefore abandoned this approach, and instead fixes the build number to 1 in all targets.



## 2.0

This version aim at streamlining the library and remove or refactor parts that make it hard to maintain. It contains several breaking changes, but I hope that the changes will make it easier for you as well, as the library moves forward.

Most notably, the view controller inheritance model has been completely removed. Instead, there is only one `KeyboardInputViewController`. It has a stack view to which you can add any views you like, like the built-in `KeyboardButtonRow` and `KeyboardCollectionView`, which means that your custom keyboards is now based on components that you can combine.

Since `KeyboardInputViewController` therefore can display multiple keyboards at once, it doesn't make any sense to have a single `keyboard` property. You can still use structs to organize your actions (in fact, I recommend it - have a look at the demo app), but you don't have to.

All action handling has been moved from the view controller to `KeyboardActionHandler` as well. `KeyboardInputViewController` use a `StandardActionHandler` by default, but you can replace this by setting `keyboardActionHandler` to any `KeyboardActionHandler`. This is required if you want to use certain actions types, like `.image`.

New `KeyboardAction`s are added and `nextKeyboard` has been renamed to `switchKeyboard`. Action equality logic has also been removed, so instead of `isNone`, you should use `== .none` from now on. All help properties like `image` and `imageName` are removed as well, since they belong in the app. These are the new action types

* capsLock
* dismissKeyboard
* moveCursorBackward
* moveCursorForward
* shift
* shiftDown
* switchToKeyboard(type)

`KeyboardInputViewController` will now resize the extension to the size of the stack view, or any other size constraints you may set. The old `setHeight(to:)` function has therefore been removed.



## 1.0

This version upgrades `KeyboardKit` to Swift 5 and has many breaking changes:

 * `KeyboardInputViewController` has been renamed to `KeyboardViewController`
 * `CollectionKeyboardInputViewController` has been renamed to `CollectionKeyboardViewController`
 * `GridKeyboardInputViewController` has been renamed to `GridKeyboardViewController`
 * `KeyboardAlerter` has been renamed to `KeyboardAlert`
 * `ToastAlerter` has been renamed to `ToastAlert`
 * `ToastAlert` now has two nested view classes `View` and `Label`
 * `ToastAlert`'s two style function has changed signature
 * `ToastAlerterAppearance` is now an internal `ToastAlert.Appearance` struct
 * Most extensions have been made internal, to avoid exposing them externally



## 0.8

`Keyboard` has been given an optional ID, which can be used to uniquely identify a keyboard. This makes it easier to manage multiple keyboards in an app.

`KeyboardInputViewController` implements the `KeyboardPresenter` protocol, which means that you can set the new optional `id` property to make a `KeyboardSetting` exclusive to that presenter. This is nice if your app has multiple keyboards. If you do not specify an id, the settings behave just like before.

A PR by [micazeve](https://github.com/micazeve) is merged. It limits the current page index that is persisted for a keyboard, to avoid bugs if the page count has changed since persisting the value.



## 0.7.1

This version updates KeyboardKit to `Swift 4.2` and makes it ready for Xcode 10.



## 0.7

The grid keyboard view controller uses a new way to calculate the available item space and item size for a certain number of rows and buttons per row. This means that we can now use top and bottom content insets to create vertical margins for grid-based keyboards.



## 0.6.2

I previously used the async image functions to quickly setup a lot of images for "emoji" keyboards. Since I didn't use a collection view for emoji keyboards then, all image views were created at the same time, which caused rendering delays. By using the async image approach, image loading was moved from the main thread and allowed individual images to appear when they were loaded instead of waiting for all images to load before any image could be displayed.

However, `KeyboardKit` now has collection view-based keyboards, which are better suited for the task above, since they only render the cells they need. This will solve the image loading issues, which means that the async image extensions will no longer be needed. I have therefore removed `UIImage+Async` and the `Threading` folder from the library, to keep it as small as possible.



## 0.6.1

No functional changes, just README updates and improvements. The version bump is required to give CocoaPod users the latest docs.



## 0.6

This is a complete rewrite of the entire library. KeyboardKit now targets iOS 11 and the code has been improved a lot. Check out the demo app to see how to setup keyboards from now on.
