# Release notes

KeyboardKit tries to honor semantic versioning:

* Only remove deprecated code in `major` versions.
* Only deprecate code in `minor` and `patch` versions.
* Avoid breaking changes in `minor` and `patch` versions.
* Code can be marked as deprecated at any time.

Breaking changes can still occur in minor versions, patches and BETA features, if the alternative is to not be able to release new critical features or fixes.



## 7.8

### ✨ New Features

* `KeyboardActionHandler` has a new `handle` function.
* `KeyboardBackgroundStyle` has many new properties and builder functions.
* `KeyboardButtonStyle` now has separate border and shadow properties.
* `NextKeyboardButton` no longer throws assert failures by default.
* `PreviewAutocompleteProvider` is a new preview service.
* `SystemKeyboard` has a new `renderBackground` property.
* `ToggleToolbar` is a new toolbar that can be used to toggle between two toolbars.

### 👑 Pro changes

* `KeyboardTheme` style variations have been adjusted to use the new background style model.
* `KeyboardThemeAppearance` is now open for inheritance.
* `KeyboardThemeAppearance` will now use the largest shadow size to determine the bottom edge insets.
* `KeyboardThemeFormModel` is a new observable type.
* `KeyboardThemeLivePreview` has new initializers.
* `KeyboardThemeLivePreviewHeader` is a new header preview.
* `ToggleToolbar` is now part of the main library, and is no longer throwing.

### 🗑️ Deprecations

* `KeyboardBackgroundStyle` has deprecated the type-based initializer and its property.
* `KeyboardBackgroundType` has been deprecated.
* `KeyboardInputViewController` pro setup functions have been redesigned.
* `ToggleToolbar` throwing initializers have been deprecated.



## 7.7.1

### 💡 Adjustments

* `EnglishCalloutActionProvider` `localeKey` is now mutable.
* `EnglishInputSetProvider` is now open to inheritance.
* `EnglishInputSetProvider` `localeKey` is now mutable.
* `EnglishKeyboardLayoutProvider` `localeKey` is now mutable.
* `StandardKeyboardAppearance` `backgroundStyle` is now `open`.
* `StandardKeyboardAppearance` `foregroundColor` is now `open`.

### 🐛 Bug fixes

* `StandardKeyboardActionHandler` once again activates the space drag gesture on long press instead of on press. 



## 7.7

This version aims to reduce the amount of lost keystrokes by adding a release outside tolerance, to let a button trigger a release event even if the release is a bit outside of the button bounds. The lack of such a tolerance may have caused lost keystrokes before, since it's easy to slide with your finger while typing and ending up with your finger outside the button bounds.

Since the best tolerance amount is still unclear, the `keyboardButtonGestures` view extension now lets you specify a tolerance, which is a percentage of the button width.

This version also adds a vertical threshold when moving the input cursor with the space button, since dragging the finger too much up and down can result in unexpected movement. 

This version also tweaks the emoji keyboards to look better and closer to the native ones.

There are also new keyboard actions, new url opening utilities, and a bunch of theme adjustments.   

### ✨ New Features

* `KeyboardAction` has new `systemSettings` and `url` actions.
* `KeyboardAction` has a new `standardAction` property.
* `KeyboardAppearance` has new, optional `foregroundColor` property.
* `KeyboardController` has a new `openUrl` function.
* `KeyboardLayout` has a new `hasEmojiKeyboardSwitcher`.
* `KeyboardUrlOpener` is a new class for opening URLs.

### 💡 Adjustments

* Thanks to [krizhanovskii](https://github.com/krizhanovskii) the Pro Max layout configuration has been improved.
* `KeyboardEmojiKeyboard` `KeyboardEmojiCategoryKeyboard` are tweaked to look closer to the system keyboards.
* `KeyboardGestures` now handles a release outside as a release inside, if the release happens within a tolerance area.

### 👑 Pro changes

* `KeyboardTheme` has new `author`, `collectionName` and `foregroundColor` properties.
* `KeyboardThemeLivePreview` now renders light mode only as default.
* `License` has new `localizedCalloutActionProviders`, `localizedInputSetProviders` and `localizedKeyboardLayoutProviders` properties.
* Some themes define a foreground color to make the emoji keyboard look good.
* The license-based `StandardInputSetProvider` convenience initializer has been deprecated.
* The license-based `StandardKeyboardLayoutProvider` convenience initializer has been deprecated.

### 🐛 Bug fixes

* `KeyboardTheme` didn't set the identifier when it was created with a `MinimalStyle`. 
* `View+SystemKeyboardButton` didn't send the pressed state to the system keyboard button body.

### 🗑️ Deprecations

* `KeyboardThemePreview` has been renamed to `KeyboardThemeLivePreview`.
* The `keyboardGestures` view extensions have been renamed to  `keyboardButtonGestures`.

### 💥 Breaking changes 

* `KeyboardTheme` no longer has a `styleName` property.
  


## 7.6

This version updates the new dictation beta feature, adjusts a lot of emoji skin tones and fixes some bugs.

The version also adds tools that make it possible to start keyboard dictation from DocumentGroup-based apps.

### 🚨 Important information

After receiving reports that the new dictation features required all apps to add dictation permissions to their `Info.plist`, a lot of work has been put into separating speech recognition from dictation.

As a result, you must now provide a `SpeechRecognizer` when using the built-in dictation features. An already implemented recognizer can be copied from the `SpeechRecognizer` docs. 

Removing the speech recognizer parts from the library makes the feature a little harder to use, but removes the need for all apps to specify the permission keys they really don't need.

### ✨ New Features

* `DictationContext` has new initializers for specific usages.
* `DictationContext` has a new `silenceLimit` that can be used to define after how many seconds of silence dictation should finish.
* `DictationContext` has a new `isDictationStartedByKeyboard` that can be used when a deep link can't be used to start dictation.
* `KeyboardDictationConfiguration` has a new `matchesDeepLink` that simplifies checking if a specific deep link should start dictation.

### 💡 Behavior changes

* More parts of the dictation implementations now update the `DictationContext` `lastError`.

### 👑 Pro changes

* `DictationIndicator` has been renamed to `DictationBarVisualizer`.
* `DictationOverlay` has been renamed to `DictationScreen`.
* `DictationScreen` now supports adding a done button.
* `DictationScreen` supports a style instead of using many parameters.
* `SpeechRecognizer` is a new protocol that is used to separate speech recognition from dictation.
* `StandardDictationService` now requires a speech recognizer.
* `StandardKeyboardDictationService` now requires a speech recognizer.
* `View.keyboardDictation(...)` now requires a speech recognizer.
* `View.keyboardDictationOnAppear(...)` is a new view modifier that can be used in DocumentGroup-based apps.
* `View.keyboardDictationOnDeepLink(...)` is a new view modifier that can be used to start dictation without an overlay.

### 🐛 Bug fixes

* A duplicate emoji has been removed.
* Incorrect Pro themes have been adjusted.
* Incorrect `Emoji` skin tone variants have been adjusted.
* Incorrect `Emoji` neutral skin tone variants have been adjusted.
* `GestureButton` no longer triggers timed events if it's removed before it's released. 

### 💥 Breaking changes 

* `KeyboardDictationService` `stopDictationInKeyboard` has been renamed to `handleDictationResultInKeyboard`.
* `KeyboardInputViewController` `viewWillPerformDictation` has been renamed to `viewWillHandleDictationResult`.



## 7.5.2

This version adjusts how the next keyboard button behaves.

The next keyboard gestures is now moved from the system keyboard button content view to the gesture modifier, which means that it will always apply to views that are modified with gestures for that action.

This release also fixes a problem, where `StandardKeyboardActionHandler` marking one initializer as convenience caused problems when inheriting it.

### 💡 Behavior changes

* `SystemKeyboardButtonContent` no longer applies a `NextKeyboardButton` for `.nextKeyboard`.
* `StandardKeyboardActionHandler` no longer marks the `inputViewController` initializer as convenience.
* `View+KeyboardGestures` now applies a `NextKeyboardButton` for `.nextKeyboard`.



## 7.5.1

This version adds more emoji versions.

### 👑 Pro changes

* `EmojiVersion` now includes 13.1, 13.0, 12.1, 12.0 and 11.0.



## 7.5

This version improves the theme and dictation engines to make them easier to use.

This version also deprecates the feature toggle for the new autocomplete provider and makes it the standard engine. It also renames the external provider to remote to better reflect what it does.  

### 🚨 Important information

This version adds a mandatory `id` to `KeyboardTheme`, which will make it possible to implement features like marking a theme as a favorite, persist references instead of values etc. While it's not mandatory to specify an `id` when creating a theme, it *is* a mandatory property, which means that any previously encoded data will fail to decode.

If you have persisted `KeyboardTheme` values in your app, please reach out via `info@getkeyboardkit.com` and decode failure handling will be added to the library to handle any lacking IDs.

### ✨ New features

- `DictationContext` has a new `appDeepLink` property.
- `DictationContext` has a new `setup(with:)` function.
- `KeyboardAction` now uses `performDictation` for the `dictation` action.
- `KeyboardController` has a new `performDictation` function.
- `KeyboardEnabledLabel` now supports more styling.
- `KeyboardInputViewController` has a new `dictationConfig` property.
- `KeyboardInputViewController` has a new `performDictation` function.
- `KeyboardLayout` has a new `bottomRowIndex` property.
- `KeyboardLayout` has a new `bottomRowSystemItems` property.
- `KeyboardLayout` has a new `tryCreateBottomRowItem(for:)` function.
- `KeyboardSettingsLink` now supports custom labels.

### 💡 Behavior changes

* `KeyboardEnabledLabel` no longer colors text by default.
* `KeyboardInputViewController` now changes `primaryLanguage` when the context locale changes.
* `KeyboardLocale` has new collection extension.

### 👑 Pro changes

* `KeyboardTheme` and all styles now have static IDs.
* `KeyboardTheme` and all styles have a new `copy` function.
* `KeyboardTheme.allPredefined` is now stored instead of computed. 
* `KeyboardTheme.standard` is no longer throwing.
* `KeyboardThemeButtonPreview` is a new preview.
* `KeyboardThemeCopyable` is a new protocol that specifies theme copy behavior.
* `KeyboardThemeStyleVariation` is a new protocol that can be used by theme styles.

### 🗑️ Deprecations

* `ExternalAutocompleteProvider` is renamed to `RemoteAutocompleteProvider`.
* `ExternalAutocompleteResult` is renamed to `RemoteAutocompleteResult`.
* `FeatureToggle.Feature.newAutocompleteEngine` is no longer used.
* `KeyboardContext.tempIsPreviewMode` is no longer used.
* `KeyboardLocale` sort with insert first parameter is replaced by atomic operations.
* `StandardAutocompleteProvider` is renamed to `LocalAutocompleteProvider`.

### 🐛 Bug fixes

* Thanks to `@gonzalonunez` the `KeyboardTextField` and `KeyboardTextView` now disables `captureTextFromCamera`.
 
### 📄 Documentation

* Thanks to `@f-person` some documentation errors have been fixed.

### 💥 Breaking changes 

* `DictationContext.lastAppGroupId` has been removed.
* `KeyboardTheme.allPredefined` is no longer throwing.



## 7.4

This release adds support for 🇰🇿 Kazakh and more locale and emoji features.

### ✨ New features

* `EmojiCategory` has new emojis for iOS 16.4, macOS 13.3, tvOS 16.4 and watchOS 9.4.
* `KeyboardReturnKeyType` has new `next` and `send` cases.

### 🇸🇪 New Locales

* 🇰🇿 Kazakh (thanks to @mirasaujan)

### 🎨 New Themes

* `KeyboardTheme.candyShop` has a new `.cuppyCake` style.
* `KeyboardTheme.standard` has new `.green`, `.purple` and `.yellow` styles.
* `KeyboardTheme.minimal` can use all available `StandardStyle` style variations.
* `KeyboardTheme.swifty` can use all available `StandardStyle` style variations.

### 🌐 Localization

* `KKL10n` has new `next` and `send` keys.
* `KeyboardLocale.armenian` localizes more texts (thanks to @f-person).
* `KeyboardLocale.english` adds localizations for all emojis.
* `KeyboardLocale.russian` localizes more texts (thanks to @f-person).

### 👑 Pro changes

* `Emoji` collections have a new `allAvailableInSystemVersion` that can filter out unavailable emojis.
* `EmojiVersionInfo` is a new type that contains information about when certain emojis were introduced.
* `ProEmojiInfo` is deprecated in favor of just using the already defined `Emoji` extensions.
* `KeyboardTheme` `.candy` is renamed to `.candyShop`.
* `KeyboardTheme` `.standard` and `.swifty` now applies a standard shadow.
* `KeyboardTheme` `CandyStyle` is renamed to `CandyShopStyle`. 
* `KeyboardTheme` `SwiftyStyle` deprecated in favor of reusing `StandardStyle`. 

### 🗑️ Deprecations

* `KeyboardAction.ReturnType` is renamed to `KeyboardReturnKeyType`.
* `KeyboardActionMappable` is deprecated.

### 🐛 Bug fixes

* `ActionCallout` now handles single actions.
* Some incorrect blue square emojis have been corrected.



## 7.3.1

This release adds more name and sorting capabilities to the locale types.

### ✨ New features

* `KeyboardContext` has new locale setter functions.
* `KeyboardLocale` has new `sorted` by name functions.
* `Locale` has new `localizedName` and `sorted` by name functions.
* `LocaleDirectionProvider` is a new protocol that exposes `Locale` extensions to DocC. 
* `LocaleNameProvider` is a new protocol that exposes `Locale` name extensions to DocC. 

### 💡 Behavior changes

* `Locale` no longer capitalizes `localizedName` or `localizedLanguageName`.
* `Locale` `localizedName` and `localizedLanguageName` are no longer optional.
* `LocaleContextMenu` no logner sorts the keyboard context locales collection.

### 🗑️ Deprecations

* Some `KeyboardLocale` extensions that used the native locale have been deprecated.
* Some `Locale` localization extensions were redundant and have been deprecated. 



## 7.3

This version adds a first PREVIEW of dictation support. It's a very early version that is not yet tested, but your feedback is very important.

This version keeps the experimental flag for the recently introduced autocomplete provider, until the next minor version. Make sure to test it and provide feedback.

This version adds a bunch of new keyboard themes with new style variations. This means that you can easily tweak a theme-specific set of parameters for the various themes.

### 🚨 Important information

This version introduces breaking changes with reference to "Breaking changes can still occur in minor versions and patches...". In this case, the benefits are massive since it lets us make many more types `Codable` and `Equatable`, which unlocks a bunch of capabilities.

This requires that the types can't contain non-codable types, such as `Image` or `Font`, which requires breaking changes to the current setup. Types that have `Image` properties will instead use raw `Data`, while types that have `Font` properties will use a new `KeyboardFont` property. `KeyboardFont` can be created in the same way as `Font` but if you want to use it with a SwiftUI view modifier, you have to use `.font(font.font)`.

Just reach out if these breaking changes cause problems. 

### ✨ New features

* `Dictation` is a new namespace with PREVIEW types that defines how to perform keyboard dictation.
* `KeyboardBackgroundStyle` has a new convenience initializer.
* `KeyboardBackgroundType` has a new `.clear` and `.verticalGradient` type.
* `KeyboardBackgroundType` is extracted from `KeyboardBackgroundStyle.BackgroundType`.
* `KeyboardFont` is a new `Codable` type that is used to make various styles codable as well.
* `KeyboardFontType` is a new `Codable` type that is used to make various styles codable as well.
* `KeyboardFontWeight` is a new `Codable` type that is used to make various styles codable as well.
* `KeyboardInputViewController` has a `dictationContext` that can be used to manage and observe dictation state.
* `KeyboardInputViewController` has a `dictationService` that can be used to start dictation from your keyboard.
* `KeyboardInputViewController` has re-added the old `hostBundleId` property, which can be used to get the ID of the parent app.

### 👑 Pro changes

* `KeyboardTheme` has a new `styleName` property.
* `KeyboardTheme` can now support style variations.
* `KeyboardTheme` has many new themes with style variations.
* `KeyboardTheme` has a new `grouped` function that groups themes into named collections.
* `KeyboardThemeCollection` is a new type that can be used to group themes into named collections.
* `PreviousAppNavigator` is a new protocol that can be used to navigate back to the recently open app.
* `StandardDictationService` is a new service that can be used to perform dictation within an app target.
* `StandardKeyboardDictationService` is a new service that can be used to start dictation from a keyboard extension. 

### 💡 Behavior changes

The following types are now `Codable` and `Equatable`:

* `AutocompleteToolbarStyle`
* `AutocompleteToolbarItemStyle`
* `AutocompleteToolbarItemBackgroundStyle`
* `KeyboardActionCalloutStyle`
* `KeyboardInputCalloutStyle`
* `KeyboardBackgroundStyle`
* `KeyboardBackgroundType`
* `KeyboardButtonStyle`
* `KeyboardButtonShadowStyle`
* `KeyboardCalloutStyle`
* `KeyboardInputCalloutStyle`
* `KeyboardTheme`

### 🗑️ Deprecations

* `KeyboardTheme.cottonCandy` has been renamed to `KeyboardTheme.candy(.cottonCandy)`.  
* `KeyboardTheme.neonNights` has been renamed to `KeyboardTheme.neon(.night)`.  

### 💥 Breaking changes 

* `AutocompleteToolbarItemStyle` fonts are now of type `KeyboardFontStyle`.
* `KeyboardBackgroundType` no longer has a `.linearGradient` type.
* `KeyboardBackgroundType` now requires `Data` for `.image` instead of a SwiftUI `Image`.
* `KeyboardActionCalloutStyle` `font` is now of type `KeyboardFontStyle`.
* `KeyboardInputCalloutStyle` `calloutPadding` is now of type  `CGFloat`.
* `KeyboardInputCalloutStyle` `font` is now of type  `KeyboardFontStyle`.  
* `KeyboardTheme` no longer defines insets, but will instead make the bottom shadow fit the screen.
* `LicenseTier` has removed the `kk` name prefix and the `com.keyboardkit.` ID prefix.

### 🐛 Bug fixes

* The new, experimental autocomplete provider fixes a localization sync bug.
* The pressed system keyboard button color overlay is now clipped to the button corner radius.
* The `isAutoCapitalizationEnabled` flag no longer affects automatic downshifting when typing.



## 7.2

This version focuses on making it easier to style keyboards.

This version adds a theme engine to KeyboardKit Pro. The new `KeyboardThemeAppearance` can be used with the new `KeyboardTheme` to style keyboards with themes, which is a lot easier than defining custom appearances.

This version comes with three themes - `.cottonCandy`, `.neonNights` and `.tron`. You can use them in your own keyboads, or tweak them to create your own visual styles. More themes are coming in future versions. 

Due to a bug found in the new autocomplete provider, the old `StandardAutocompleteProvider` will be replaced in the next minor version.

### ✨ New features

* `AutocompleteContext` has a new `isEnabled` property that can be used to disable autocomplete.
* `KeyboardAppearance` has a new `autocompleteToolbarStyle` property.
* `KeyboardAppearance` has a new `keyboardBackground` property.
* `KeyboardBackgroundStyle` is a new style that can be used to the background of a keyboard.
* `KeyboardButtonStyle` properties are now optional to allow for overrides.
* `KeyboardButtonStyle` has a new `pressedOverlayColor` property that can be used to highlight buttons.
* `KeyboardButtonStyle` has a new `extended(with:)` function to let you extend a style with another style.
* `View+SystemKeyboardButton` has a new `isPressed` parameter to let you define pressed state.

### 👑 Pro changes

* `KeyboardInputViewController` will use the new autocomplete context property to disable autocomplete if needed.
* `KeyboardTheme` is a new type that can be used to define keyboard themes.
* `KeyboardThemeAppearance` is a new appearance that can be used with `KeyboardTheme`.
* The new `LocalAutocompleteProvider` that was introduced in 7.1 has been made public.
* The new `LocalAutocompleteProvider` now ignores empty strings when wrapping in quotes.
* The new `LocalAutocompleteProvider` now replaces hyphens with space when suggesting splitting up the word.
* The incorrect Brazilian callout actions have been corrected.

### 🎨 New keyboard themes

* `KeyboardTheme.cottonCandy` is a pink and blue trip to fluffy delight.
* `KeyboardTheme.neonNights` is a metropolitian color explosion.
* `KeyboardTheme.tron` is a black and blue, digital adrenaline rush.

### 💡 Behavior changes

* `SystemKeyboard` uses the new appearance background and autocomplete toolbar styles.

### 🗑️ Deprecations

* `CalloutStyle` has been renamed to `KeyboardCalloutStyle`.
* `ActionCalloutStyle` has been renamed to `KeyboardActionCalloutStyle`.
* `InputCalloutStyle` has been renamed to `KeyboardInputCalloutStyle`.



## 7.1.3

This version adds an `isKeyboardFloating` property to the keyboard context. It's currently not used to change the visual representation of floating keyboards, but please verify that it works as expected.

### ✨ New features

* `KeyboardContext` has a new `isKeyboardFloating` property that can be used to determine if the keyboard is floating.



## 7.1.2

### 💡 Behavior changes

* `GestureButtonDefaults` have adjusted `repeatDelay` to `0.5`.

### 🐛 Bug fixes

* `KeyboardLayoutConfiguration` now applies Pro Max configuration to iPhone 14 Pro Max.
* `SystemKeyboard` will now show autocomplete in Twitter and Mastodon.
* `View+KeyboardGestures` will now trigger repeating actions like backspace more like the native keyboards.



## 7.1.1

This version fixes some bugs in `KeyboardTextField` and `KeyboardTextView` and tweaks their behavior a bit.

The demo app has a new `KeyboardTextInput` demo keyboard that shows `KeyboardTextField` and `KeyboardTextView` in action. 

### ✨ New features

* `KeyboardInputView` is a new protocol that lets you apply a `focused` binding together with a custom done button.

### 💡 Behavior changes

* `KeyboardTextField` and `KeyboardTextView` now implement the new `KeyboardInputView` protocol.
* `KeyboardTextField` and `KeyboardTextView` now apply a basic style before applying any custom configuration.
* `KeyboardTextField` and `KeyboardTextView` now animates together with the focused state.
* `KeyboardTextField` now applies a background color and border style.
* `KeyboardTextView` now applies a background color, corner radius and font.
* `KeyboardTextView` now uses the same font as `KeyboardTextField` by default.

### 🐛 Bug fixes

* `KeyboardTextField` and `KeyboardTextView` now correctly resigns as first responder when they lose focus.



## 7.1

This version fixes some bugs and makes it even easier to setup KeyboardKit.

KeyboardKit Pro also has a new experimental and much better autocomplete provider that you can toggle on with the `FeatureToggle`:

```swift
FeatureToggle.shared.toggleFeature(.newAutocompleteEngine, .on)
```

Once this has been verified to work better than the current provider, it will replace it and this feature toggle flag will be removed.

Furthermore, the locale context menu has been refactored to work and look a lot better on iOS 16 and macOS 12. This unfortunately required a few breaking api changes, that hopefully will not affect anyone.

### ✨ New features

* `FeatureToggle` has a new `.newAutocompleteEngine` feature.
* `KeyboardContext` has a new `localePresentationLocale` property.
* `KeyboardInputViewController` has new `setup` functions that provide a view builder with an unowned controller reference.
* `QuotationAnalyzer` has more functions.
* `String` has new quotation functions.

### 👑 Pro changes

* KeyboardKit Pro has a new experimental autocomplete provider that can be toggled on to replace the standard one.
* Many iPad layouts have been tweaked to look even closer to the native layouts.

### 💡 Behavior changes

* `KeyboardInputViewController` `setup` uses a view builder instead of a static view.
* `KeyboardInputViewController` now calls `viewWillSetupKeyboard` in `viewWillAppear` instead of `viewDidLoad`.
* `KeyboardRootView` uses a view builder instead of a static view. 

### 🐛 Bug fixes

* `iPadKeyboardLayoutProvider` had a line accidentally removed, which caused English layouts to render incorrect. This has been fixed.
* `KeyboardInputViewController` now creates the keyboard view later, which makes it respect the safe areas better in landscape.
* `LocaleContextMenu` now uses the `KeyboardContext` to localize and sort locales. 

### 💥 Breaking changes 

* `SpaceLongPressBehavior` cases have been renamed to read better. This should hopefully affect few people.



## 7.0

KeyboardKit 7.0 involves a major rewrite that aims to bring more consistency in naming and structure and to streamline the library to make future development easier. It bumps the platform deployment targets to iOS 14, macOS 11, tvOS 14 and watchOS 7 and removes all previously deprecated code and todos.

### Migrating from KeyboardKit 6

Although KeyboardKit 7.0 aims to introduce as few breaking changes as possible, there are some surface level APIs that will change. Some such changes are the removal of many shared instances and how more dependencies have to be passed in as parameters. If you are using the now removed shared instances, simply inject the instance as initializer or function parameter instead. 

KeyboardKit 7.0 makes the `SystemKeyboard` easier to use, where it now adds an autocomplete toolbar by default to make sure that the callouts has enough space, and to reduce the risk of memory leaks that was previously easy to add by accident when you connected the toolbar to the keyboard input controller's autocomplete function. If your keyboard uses a custom autocomplete toolbar, you must pass in `autocompleteToolbar: none` in the system keyboard initializer.

If you have problems upgrading to `7.0`, first try upgrading to `6.9`. It has a lot of deprecations in place to provide guidance. You may still experience breaking changes after that, but they will be fewer.

### ✨ New features

* `AutocompleteContext` has a new `reset` function.
* `AutocompleteToolbar` is now available on all platforms.
* `EmojiAnalyzer` is a new protocol that merges `EmojiCharacterAnalyzer` and `EmojiStringAnalyzer`. 
* `EmojiCategoryKeyboard` is now available on all platforms.
* `EmojiCategoryKeyboardMenu` is now available on all platforms.
* `EmojiCategoryTitle` is now available on all platforms.
* `EmojiKeyboard` is now available on all platforms.
* `EmojiKeyboardStyle` has new context-based standard functions.
* `ExternalKeyboardContext` is now available on macOS and tvOS as well.
* `GestureButton` is now available on watchOS 7.
* `Image` `.keyboardEmojiSymbol` provides the old emoji keyboard button icon.
* `InterfaceOrientation` has a new `landscape` case.
* `KeyboardAction` gesture actions are now available on all platforms.  
* `KeyboardAction` gesture actions now use a `KeyboardController` instead of a `KeyboardInputViewController`.  
* `KeyboardAppearance` will now apply to `.nextKeyboard` as well. 
* `KeyboardCalloutContext` is a new context that lets lets us pass around a single context for input and action callouts.
* `KeyboardCharacterProvider` is a new protocol that provides keyboard-specific characters.
* `KeyboardController` is a new protocol that lets us decouple actions from the input view controller.
* `KeyboardContext` has a new `keyboardLocale` and new functions for setting locale and keyboard type.
* `KeyboardContext` has a new `spaceLongPressBehavior` property to control the space button's behavior.
* `KeyboardInputViewController` has a new `calloutContext`.  
* `KeyboardInputViewController` implements `KeyboardController` which gives it a bunch of new functions.
* `KeyboardLocale` implements `LocaleFlagProvider`.
* `KeyboardLocale` has new `Locale` matching extensions.
* `KeyboardType` has new properties.
* `KeyboardLayoutConfiguration` has adjusted the standard corner radius for iPhone buttons.
* `Locale` has new localized name extensions.
* `Locale` has new `KeyboardLocale` matching extensions.
* `LocaleContextMenu` now lets you customize the presentaiton locale.
* `NextKeyboardButton` now supports using any custom content.
* `NextKeyboardController` is used instead of the shared controller.
* `QuotationAnalyzer` is a new protocol for analyzing quotations in strings.
* `ScrollViewGestureButton` is now available on watchOS 7.
* `SpaceCursorDragGestureHandler` is now available on all platforms.
* `SpaceLongPressBehavior` is a new enum that defined the available space long press behaviors.
* `String` has new casing, keyboard character, quotation, word and sentence extensions.
* `SystemKeyboard` will now add an autocomplete toolbar by default.
* `SystemKeyboardButton` is now available on all platforms.
* `Text` is a new namespace for text analysis.
* `UITextDocumentProxy` quotation utilities is now available as `StringQuotationAnalyzer`.

### 👑 Pro changes

* `FeedbackToggle` is a new button to toggle audio and haptic feedback.
* `AudioFeedbackToggleButton` has been replaced with `FeedbackToggle`.
* `HapticFeedbackToggleButton` has been replaced with `FeedbackToggle`.

### 💡 Behavior changes

* `ActionCallout` is no longer greedy.
* `CalloutStyle` has a new standard corner radius.
* `InputCallout` is no longer greedy.
* `InterfaceOrientation` `.current` now returns correct rotations on all platforms.
* `iPadKeyboardLayoutProvider` has been greatly simplified.
* `iPhoneKeyboardLayoutProvider` has been greatly simplified.
* `Image` `.keyboardEmoji` is looks closer to the native icon.
* `KeyboardAction` `.backspace` now triggers on `.press` instead of `.release`.
* `KeyboardLayoutConfiguration` now behaves the same on all platforms.
* `KeyboardSettingsLink` has ben rewritten to only use plain SwiftUI code that works with extensions as well.
* `StandardKeyboardAppearance` now applies medium font weights to the Gregorian ABC keyboard. 

### 💥 Breaking changes

* All deprecated code has been removed.
* The library now targets iOS 14, macOS 11, tvOS 14 and watchOS 7.
* `ActionCalloutContext` `.shared` has been removed.
* `AutocompleteSuggestions` is now a struct instead of a protocol.
* `AutocompleteToolbar` standard actions have been removed.
* `AutocompleteToolbar` `ReplacementAction` has been renamed to `SuggestionAction`.
* `AutocompleteToolbarItem` init parameters have been reordered.
* `AutocompleteToolbarItemTitle` init parameters have been reordered.
* `DeleteBackwardRange` `char` has been renamed to `character`.
* `EmojiCategoryKeyboard` init parameters have been refactored.
* `EmojiCategoryKeyboardMenu` init parameters have been reordered.
* `EmojiCharacterAnalyzer` and `EmojiStringAnalyzer` have been merged into `EmojiAnalyzer`.
* `EmojiKeyboard` init parameters have been refactored. 
* `InputCalloutContext` `.shared` has been removed.
* `InputSet` has been converted to a `protocol` and all input set types converted from `class` to `struct`.
* `KeyboardAction` `.return` and `.newLine` have been replaced by `primary` variants.
* `KeyboardAction` `.shift` `currentState` is renamed to `currentCasing`.
* `KeyboardAction` `standardTextDocumentProxyAction` has been removed.
* `KeyboardAppearance` callout styles have been converted to properties.
* `KeyboardContext` `originalTextDocumentProxy` has been renamed to `mainTextDocumentProxy`.
* `KeyboardGesture` `.tap` has been replaced by `.release`.
* `KeyboardInputViewController` has replaced `actionCalloutContext` and `inputCalloutContext` with a single `calloutContext`.
* `KeyboardInputViewController` `.shared` has been removed.
* `KeyboardInputViewController` `originalTextDocumentProxy` has been renamed to `mainTextDocumentProxy`.
* `KeyboardLayoutConfiguration` portrait configurations have been renamed.
* `KeyboardReturnActionMappable` has been refactored to `KeyboardActionMappable`.
* `KeyboardTextField` now requires an keyboard input view controller.
* `KeyboardTextView` now requires an keyboard input view controller.
* `KeyboardType` has made the `isAlphabetic(with:)` parameter implicit.
* `Locale` `regionIdentifier` has been removed.
* `LocaleProvider` has been removed.
* `LocaleFlagProvider` is now only implemented by `Locale` on iOS 16.
* `StandardAutocompleteSuggestions` has been renamed to `AutocompleteSuggestions`.
* `StandardKeyboardActionHandler` now requires a `KeyboardController`.
* `StandardKeyboardActionHandler` `inputViewController` initializer is now a convenience initializer.
* `StandardKeyboardActionHandler` `changeKeyboardTypeAction` has been removed.
* `StringCasingAnalyzer` has been renamed to `CasingAnalyzer`.
* `StringCasingAnalyzer` has replaced properties with functions. 
* `SystemKeyboard` init parameters have been refactored.
* `SystemKeyboard` `standardKeyboardWidth` has been removed.
* `SystemKeyboardActionButton` has been renamed to ``SystemKeyboardButton`` and requires a callout context.
* `SystemKeyboardActionButtonContent` has been renamed to `SystemKeyboardButtonContent`.
* `SystemKeyboardButton` has been replaced by the renamed action button.
* `SystemKeyboardButtonRowItem` now requires a callout context.
* `UITextDocumentProxy` `isOpenQuotationBeforeInput` has been renamed to `hasUnclosedQuotationBeforeInput`.
* `UITextDocumentProxy` `isOpenAlternateQuotationBeforeInput`has been renamed to `hasUnclosedAlternateQuotationBeforeInput`.
* `UITextDocumentProxy` `preferredReplacement` is renamed to `preferredQuotationReplacement`.
* `View` `.keyboardGestures` now requires a callout context.
