# ``KeyboardKit``

KeyboardKit helps you build custom keyboards with Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit helps you build custom keyboards with Swift and SwiftUI. It extends Apple's native keyboard extension APIs and provides you with more functionality than is otherwise available. 

KeyboardKit also provides you with utilities that lets you mimic native iOS keyboards. You can use ``SystemKeyboard`` and style it as much as you want and customize it with completely custom views or designs.



## Supported Platforms

KeyboardKit supports `iOS 13`, `macOS 11`, `tvOS 13` and `watchOS 6`.

Although KeyboardKit builds on all platform, some features are unavailable on some platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

or with CocoaPods:

```
pod KeyboardKit
```

You can add the library to the main app, the keyboard extension and any targets that need it.



## About this documentation

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that extensions to native types are not included in this documentation. Future versions of this library will aim at adding protocols for these extensions, to make them appear in the documentation.



## Localization

KeyboardKit is localized in 60 keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />

🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />

🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />

🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />

🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 <br />



## License

KeyboardKit is available under the MIT license.



## Topics

### Getting Started

- <doc:Getting-Started>

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
- <doc:Keyboard>
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
- ``KeyboardEnabledState``
- ``KeyboardEnabledStateInspector``
- ``KeyboardHostingController``
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
- ``KeyboardActionMappable``
- ``StandardKeyboardActionHandler``

### Appearance

- ``KeyboardAppearance``
- ``KeyboardAppearanceViewModifier``
- ``KeyboardBackgroundStyle``
- ``KeyboardButtonStyle``
- ``KeyboardButtonBorderStyle``
- ``KeyboardButtonShadowStyle``
- ``KeyboardCalloutStyle``
- ``KeyboardActionCalloutStyle``
- ``KeyboardInputCalloutStyle``
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
- ``StandardHapticFeedbackEngine``
- ``StandardAudioFeedbackEngine``
- ``DisabledAudioFeedbackEngine``
- ``DisabledHapticFeedbackEngine``

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
- ``InputSetProviderBased``
- ``InputSetRow``
- ``InputSetRows``
- ``LocalizedInputSetProvider``
- ``StandardInputSetProvider``
- ``StaticInputSetProvider``

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

### Locale

- ``KeyboardLocale``
- ``LocaleContextMenu``
- ``LocaleDictionary``
- ``LocaleFlagProvider``
- ``LocalizedService``

### Localization

- ``KKL10n``

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
