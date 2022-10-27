# ``KeyboardKit``

KeyboardKit helps you build custom keyboards with Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit helps you build custom keyboards with Swift and SwiftUI. It extends Apple's native keyboard extension APIs and provides you with a lot more functionality than is otherwise available. 

KeyboardKit also provides you with utilities that lets you mimic native iOS keyboards. You can use ``SystemKeyboard`` and style it a little (or a lot) or use completely custom views or designs.



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

You can add the library to the main app, the keyboard extension and any other targets that need it.



## About this documentation

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that extensions to native types are not included in this documentation. Future versions of this library will aim at adding protocols for these extensions, to make them appear in the documentation.



## 🇸🇪 Localization

KeyboardKit is localized in 50+ keyboard-specific locales:

🇺🇸 🇦🇱 🇦🇪 🇧🇾 🇧🇬 🇦🇩 🇭🇷 🇨🇿 🇩🇰 🇳🇱 <br />

🇧🇪 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇭 🇬🇪 <br />

🇩🇪 🇦🇹 🇬🇷 🇭🇺 🇮🇸 🇮🇪 🇮🇹 🇹🇯 🇱🇻 🇱🇹 <br />

🇲🇰 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />

🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇸 🇧🇪 <br />



## License

KeyboardKit is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started>
- <doc:Understanding-Actions>
- <doc:Understanding-Appearances>
- <doc:Understanding-Autocomplete>
- <doc:Understanding-Feedback>
- <doc:Understanding-Input-Sets>
- <doc:Understanding-Layout>
- <doc:Understanding-Localization>
- <doc:Understanding-Previews>
- <doc:Understanding-Proxy-Extensions>
- <doc:Understanding-Text-Routing>

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
- ``StandardKeyboardAppearance``

### Audio

- ``SystemAudio``
- ``SystemAudioPlayer``
- ``StandardSystemAudioPlayer``
- ``DisabledSystemAudioPlayer``

### Autocomplete

- ``AutocompleteCompletion``
- ``AutocompleteContext``
- ``AutocompleteProvider``
- ``AutocompleteResult``
- ``AutocompleteSpaceState``
- ``AutocompleteSuggestion``
- ``DisabledAutocompleteProvider``
- ``StandardAutocompleteSuggestion``

### Behavior

- ``KeyboardBehavior``
- ``StandardKeyboardBehavior``
- ``StaticKeyboardBehavior``

### Callouts

- ``ActionCalloutContext``
- ``CalloutActionProvider``
- ``InputCalloutContext``
- ``StandardCalloutActionProvider``

- ``BaseCalloutActionProvider``
- ``EnglishCalloutActionProvider``
- ``LocalizedCalloutActionProvider``

### Casing

- ``CaseAdjustable``
- ``KeyboardCasing``

### Colors

- ``KeyboardColor``
- ``KeyboardColorReader``

### Device

- ``DeviceType``

### Emojis

- ``Emoji``
- ``EmojiCategory``
- ``EmojiProvider``
- ``FrequentEmojiProvider``
- ``MostRecentEmojiProvider``

### External

- ``ExternalKeyboardContext``

### Feedback

- ``AudioFeedbackConfiguration``
- ``HapticFeedbackConfiguration``
- ``KeyboardFeedbackHandler``
- ``KeyboardFeedbackSettings``
- ``StandardKeyboardFeedbackHandler``

### Gestures

- ``DragGestureHandler``
- ``KeyboardGesture``
- ``RepeatGestureTimer``
- ``SpaceCursorDragGestureHandler``
- ``SpaceDragSensitivity``

### Haptics

- ``HapticFeedback``
- ``HapticFeedbackPlayer``
- ``StandardHapticFeedbackPlayer``
- ``DisabledHapticFeedbackPlayer``

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
- ``KeyboardRowItem``

### Layout Providers

- ``KeyboardLayoutProvider``
- ``StandardKeyboardLayoutProvider``
- ``iPadKeyboardLayoutProvider``
- ``iPhoneKeyboardLayoutProvider``
- ``StaticKeyboardLayoutProvider``
- ``SystemKeyboardLayoutProvider``

### Locale

- ``KeyboardLocale``
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

### Proxy

- ``TextInputProxy``

### Styles

- ``ActionCalloutStyle``
- ``AutocompleteToolbarStyle``
- ``AutocompleteToolbarItemStyle``
- ``AutocompleteToolbarItemBackgroundStyle``
- ``AutocompleteToolbarSeparatorStyle``
- ``CalloutStyle``
- ``EmojiKeyboardStyle``
- ``InputCalloutStyle``
- ``KeyboardButtonStyle``
- ``KeyboardButtonBorderStyle``
- ``KeyboardButtonShadowStyle``

### Views

- ``ActionCallout``
- ``AutocompleteToolbar``
- ``AutocompleteToolbarItem``
- ``AutocompleteToolbarItemSubtitle``
- ``AutocompleteToolbarItemTitle``
- ``AutocompleteToolbarSeparator``
- ``CalloutButtonArea``
- ``CalloutCurve``
- ``InputCallout``
- ``EmojiCategoryKeyboard``
- ``EmojiCategoryKeyboardMenu``
- ``EmojiCategoryTitle``
- ``EmojiKeyboard``
- ``EmojiKeyboardButton``
- ``KeyboardGrid``
- ``KeyboardImageButton``
- ``KeyboardInputTextComponent``
- ``KeyboardTextField``
- ``KeyboardTextView``
- ``NextKeyboardButton``
- ``SystemKeyboard``
- ``SystemKeyboardActionButton``
- ``SystemKeyboardActionButtonContent``
- ``SystemKeyboardButton``
- ``SystemKeyboardButtonBody``
- ``SystemKeyboardButtonRowItem``
- ``SystemKeyboardButtonShadow``
- ``SystemKeyboardButtonText``
- ``SystemKeyboardSpaceButton``
- ``SystemKeyboardSpaceButtonContent``
- ``StandardSystemKeyboardButtonContent``
- ``StandardSystemKeyboardButtonView``
