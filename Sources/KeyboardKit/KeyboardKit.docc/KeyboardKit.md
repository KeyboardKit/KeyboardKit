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

### Articles

- <doc:Getting-Started>
- <doc:Actions>
- <doc:Appearance>
- <doc:Autocomplete>
- <doc:Emojis>
- <doc:Feedback>
- <doc:Input>
- <doc:Layout>
- <doc:Localization>
- <doc:Previews>
- <doc:Proxy-Extensions>
- <doc:Text-Routing>

### Keyboard

- ``KeyboardInputViewController``
- ``KeyboardContext``
- ``KeyboardType``
- ``KeyboardEnabledState``
- ``KeyboardEnabledStateInspector``
- ``KeyboardHostingController``

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
- ``StandardAutocompleteSuggestion``

### Behavior

- ``KeyboardBehavior``
- ``StandardKeyboardBehavior``
- ``StaticKeyboardBehavior``

### Bridging

- ``CharacterProvider``
- ``StringProvider``

### Callouts

- ``ActionCallout``
- ``ActionCalloutContext``
- ``ActionCalloutStyle``
- ``CalloutActionProvider``
- ``CalloutButtonArea``
- ``CalloutCurve``
- ``CalloutStyle``
- ``InputCallout``
- ``InputCalloutContext``
- ``InputCalloutStyle``
- ``StandardCalloutActionProvider``

- ``BaseCalloutActionProvider``
- ``EnglishCalloutActionProvider``
- ``LocalizedCalloutActionProvider``
- ``DisabledCalloutActionProvider``

### Casing

- ``CaseAdjustable``
- ``KeyboardCasing``

### Colors

- ``KeyboardColor``
- ``KeyboardColorReader``

### Device

- ``DeviceType``
- ``InterfaceOrientation``

### Emojis

- ``Emoji``
- ``EmojiCategory``
- ``EmojiCategoryKeyboard``
- ``EmojiCategoryKeyboardMenu``
- ``EmojiCategoryTitle``
- ``EmojiCharacterAnalyzer``
- ``EmojiKeyboard``
- ``EmojiKeyboardButton``
- ``EmojiKeyboardItem``
- ``EmojiKeyboardStyle``
- ``EmojiProvider``
- ``EmojiStringAnalyzer``
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
- ``LocaleProvider``
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

### Proxy

- ``TextInputProxy``

### Styles

- ``KeyboardButtonStyle``
- ``KeyboardButtonBorderStyle``
- ``KeyboardButtonShadowStyle``

### System Keyboard

- ``SystemKeyboard``
- ``SystemKeyboardActionButton``
- ``SystemKeyboardActionButtonContent``
- ``SystemKeyboardButton``
- ``SystemKeyboardButtonBody``
- ``SystemKeyboardButtonRowItem``
- ``SystemKeyboardButtonShadow``
- ``SystemKeyboardButtonText``
- ``SystemKeyboardSpaceContent``

### Views

- ``KeyboardEnabledLabel``
- ``KeyboardGrid``
- ``KeyboardInputComponent``
- ``KeyboardTextField``
- ``KeyboardTextView``
- ``NextKeyboardButton``
