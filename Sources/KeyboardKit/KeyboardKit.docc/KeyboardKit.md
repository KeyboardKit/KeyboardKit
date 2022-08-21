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

The best way to add KeyboardKit to your app is to use the Swift Package Manager.

```
https://github.com/danielsaidi/KeyboardKit.git
```

KeyboardKit also supports CocoaPods:

```
pod KeyboardKit
```

You can add the library to the main app, the keyboard extension and any other targets that need it.



## About this documentation

The online documentation is currently iOS only. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that type extensions are not included in this documentation.



## License

KeyboardKit is available under the MIT license.



## Topics

### Articles

- <doc:Getting-Started>
- <doc:Going-Further>
- <doc:Understanding-Keyboard-Actions>
- <doc:Understanding-Keyboard-Appearance>
- <doc:Understanding-Keyboard-Feedback>
- <doc:Understanding-Keyboard-Input-Sets>
- <doc:Understanding-Keyboard-Layout>
- <doc:Understanding-Keyboard-Localization>
- <doc:Understanding-Autocomplete>

### Keyboard

- ``KeyboardInputViewController``
- ``KeyboardContext``
- ``KeyboardCasing``
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
- ``KeyboardColor``
- ``StandardKeyboardAppearance``

### Audio

- ``SystemAudio``
- ``SystemAudioPlayer``
- ``StandardSystemAudioPlayer``
- ``DisabledSystemAudioPlayer``

### Autocomplete

- ``AutocompleteContext``
- ``AutocompleteProvider``
- ``AutocompleteSuggestion``
- ``StandardAutocompleteSuggestion``

### Autocomplete Types

- ``AutocompleteCompletion``
- ``AutocompleteResult``
- ``AutocompleteSpaceState``

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

### Input

- ``InputSet``
- ``InputSetItem``
- ``InputSetProvider``
- ``InputSetRow``
- ``InputSetRows``
- ``StandardInputSetProvider``

- ``AlphabeticInputSet``
- ``NumericInputSet``
- ``SymbolicInputSet``

- ``DeviceSpecificInputSetProvider``
- ``EnglishInputSetProvider``
- ``LocalizedInputSetProvider``
- ``StaticInputSetProvider``

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
