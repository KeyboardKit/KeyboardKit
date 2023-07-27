# ``KeyboardKit``

KeyboardKit helps you build custom keyboards with Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit helps you build custom keyboard extensions for iOS and iPadOS, using Swift and SwiftUI. It extends the native keyboard APIs and provides you with more functionality than is otherwise available. 

KeyboardKit lets you create keyboards that mimic the native iOS keyboards in a few lines of code. These keyboards can be customized to great extent to change input keys, keyboard layout, design, behavior etc.

KeyboardKit also lets you use completely custom views together with the features that the library provides. Most of the library can be used on all major Apple platforms.

KeyboardKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`, although some features are unavailable on some platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any targets that need it.



## About this documentation

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## License

KeyboardKit is available under the MIT license.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro



## Topics

### Getting Started

- <doc:Getting-Started>

### Essentials

- <doc:Keyboard>

### Articles

- <doc:Actions>
- <doc:Appearance>
- <doc:Autocomplete>
- <doc:Callouts>
- <doc:Dictation>
- <doc:Emojis>
- <doc:External-Keyboards>
- <doc:Feedback>
- <doc:Gestures>
- <doc:Input>
- <doc:Layout>
- <doc:Localization>
- <doc:Previews>
- <doc:Proxy-Extensions>
- <doc:Routing>
- <doc:RTL>
- <doc:Settings>

### Keyboard

- ``KeyboardInputViewController``

- ``KeyboardAutocapitalizationType``
- ``KeyboardBehavior``
- ``KeyboardContext``
- ``KeyboardController``
- ``KeyboardType``
- ``KeyboardEnabledLabel``
- ``KeyboardEnabledLabelStyle``
- ``KeyboardEnabledState``
- ``KeyboardEnabledStateInspector``
- ``KeyboardHostingController``
- ``KeyboardReturnKeyType``
- ``KeyboardTextContext``
- ``NextKeyboardButton``
- ``NextKeyboardController``
- ``StandardKeyboardBehavior``
- ``StaticKeyboardBehavior``

### Actions

- ``DeleteBackwardRange``
- ``KeyboardAction``
- ``KeyboardActions``
- ``KeyboardActionRows``
- ``KeyboardActionHandler``
- ``StandardKeyboardActionHandler``

### Appearance

- ``KeyboardAppearance``
- ``KeyboardAppearanceViewModifier``
- ``KeyboardBackgroundStyle``
- ``KeyboardBackgroundType``
- ``KeyboardButtonStyle``
- ``KeyboardButtonBorderStyle``
- ``KeyboardButtonShadowStyle``
- ``KeyboardCalloutStyle``
- ``KeyboardActionCalloutStyle``
- ``KeyboardInputCalloutStyle``
- ``KeyboardFont``
- ``KeyboardFontType``
- ``KeyboardFontWeight``
- ``StandardKeyboardAppearance``

### Autocomplete

- ``AutocompleteCompletion``
- ``AutocompleteContext``
- ``AutocompleteProvider``
- ``AutocompleteResult``
- ``AutocompleteSpaceState``
- ``AutocompleteSuggestion``
- ``AutocompleteToolbar``
- ``AutocompleteToolbarItem``
- ``AutocompleteToolbarItemBackgroundStyle``
- ``AutocompleteToolbarItemStyle``
- ``AutocompleteToolbarItemSubtitle``
- ``AutocompleteToolbarItemTitle``
- ``AutocompleteToolbarSeparator``
- ``AutocompleteToolbarSeparatorStyle``
- ``AutocompleteToolbarStyle``
- ``DisabledAutocompleteProvider``
- ``PrefersAutocompleteResolver``

### Callouts

- ``ActionCallout``
- ``ActionCalloutContext``
- ``CalloutActionProvider``
- ``CalloutButtonArea``
- ``CalloutCurve``
- ``InputCallout``
- ``InputCalloutContext``
- ``KeyboardCalloutContext``
- ``StandardCalloutActionProvider``

- ``BaseCalloutActionProvider``
- ``EnglishCalloutActionProvider``
- ``LocalizedCalloutActionProvider``
- ``DisabledCalloutActionProvider``

### Casing

- ``KeyboardCase``
- ``KeyboardCaseAdjustable``

### Colors

- ``KeyboardColor``
- ``KeyboardColorReader``

### Device

- ``DeviceType``
- ``InterfaceOrientation``

### Dictation

- ``DictationAuthorizationStatus``
- ``DictationConfiguration``
- ``DictationContext``
- ``DictationService``
- ``DictationServiceError``
- ``DisabledDictationService``
- ``DisabledKeyboardDictationService``
- ``KeyboardDictationConfiguration``
- ``KeyboardDictationService``

### Emojis

- ``Emoji``
- ``EmojiAnalyzer``
- ``EmojiCategory``
- ``EmojiCategoryKeyboard``
- ``EmojiCategoryKeyboardMenu``
- ``EmojiCategoryTitle``
- ``EmojiKeyboard``
- ``EmojiKeyboardButton``
- ``EmojiKeyboardItem``
- ``EmojiKeyboardStyle``
- ``EmojiProvider``
- ``FrequentEmojiProvider``
- ``MostRecentEmojiProvider``

### External

- ``ExternalKeyboardContext``

### Features

- ``FeatureToggle``

### Feedback

- ``AudioFeedback``
- ``AudioFeedbackConfiguration``
- ``AudioFeedbackEngine``
- ``HapticFeedback``
- ``HapticFeedbackConfiguration``
- ``HapticFeedbackEngine``
- ``KeyboardFeedbackHandler``
- ``KeyboardFeedbackSettings``
- ``StandardKeyboardFeedbackHandler``

### Gestures

- ``DragGestureHandler``
- ``GestureButton``
- ``GestureButtonDefaults``
- ``KeyboardGesture``
- ``RepeatGestureTimer``
- ``ScrollViewGestureButton``
- ``SpaceLongPressBehavior``
- ``SpaceCursorDragGestureHandler``
- ``SpaceDragSensitivity``

### Images

- ``KeyboardImageReader``

### Input

- ``InputSet``
- ``InputSetItem``
- ``InputSetProvider``
- ``InputSetRow``
- ``InputSetRows``
- ``LocalizedInputSetProvider``
- ``StandardInputSetProvider``

- ``AlphabeticInputSet``
- ``NumericInputSet``
- ``SymbolicInputSet``

- ``EnglishInputSetProvider``

### Layout

- ``KeyboardLayout``
- ``KeyboardLayoutConfiguration``
- ``KeyboardLayoutItem``
- ``KeyboardLayoutItemRow``
- ``KeyboardLayoutItemRows``
- ``KeyboardLayoutItemSize``
- ``KeyboardLayoutItemWidth``
- ``KeyboardLayoutProvider``
- ``KeyboardLayoutProviderProxy``
- ``KeyboardRowItem``

- ``StandardKeyboardLayoutProvider``
- ``iPadKeyboardLayoutProvider``
- ``iPhoneKeyboardLayoutProvider``
- ``LocalizedKeyboardLayoutProvider``
- ``StaticKeyboardLayoutProvider``
- ``SystemKeyboardLayoutProvider``

- ``EnglishKeyboardLayoutProvider``

### Localization

- ``KeyboardLocale``
- ``KKL10n``
- ``LocaleContextMenu``
- ``LocaleDictionary``
- ``LocaleDirectionAnalyzer``
- ``LocaleFlagProvider``
- ``LocaleNameProvider``
- ``LocalizedService``

### Navigation

- ``KeyboardUrlOpener``

### Previews

- ``PreviewCalloutActionProvider``
- ``PreviewInputSetProvider``
- ``PreviewKeyboardActionHandler``
- ``PreviewKeyboardAppearance``
- ``PreviewKeyboardLayoutProvider``
- ``PreviewTextDocumentProxy``

### Routing

- ``TextInputProxy``
- ``KeyboardInputComponent``
- ``KeyboardInputView``
- ``KeyboardTextField``
- ``KeyboardTextView``

### Settings

- ``KeyboardSettingsLink``
- ``KeyboardSettingsUrlProvider``

### System Keyboard

- ``SystemKeyboard``
- ``SystemKeyboardButton``
- ``SystemKeyboardButtonBody``
- ``SystemKeyboardButtonContent``
- ``SystemKeyboardButtonRowItem``
- ``SystemKeyboardButtonShadow``
- ``SystemKeyboardButtonText``
- ``SystemKeyboardSpaceContent``

### Text

- ``CasingAnalyzer``
- ``KeyboardCharacterProvider``
- ``QuotationAnalyzer``
- ``SentenceAnalyzer``
- ``WordAnalyzer``

### Toolbar

- ``ToggleToolbar``
- ``ToggleToolbarAnimation``
