# ``KeyboardKit``

KeyboardKit helps you build custom keyboard extensions for iOS and iPadOS, using SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit extends the native keyboard extension APIs to provide you with a lot more functionality. It also provides you with views and utils to help you mimic native keyboards.

KeyboardKit is flexible and doesn't force your keyboard to look or behave in a certain way. You can go with a standard system keyboard, tweak the standard design a little (or a lot) or use completely custom views or designs.


## Installation

The best way to add KeyboardKit to your app is to use the Swift Package Manager.

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add KeyboardKit to the main app, the keyboard extension and any other targets that needs it.


## About this documentation

This documentation is generated with Xcode's new DocC engine.

Note that DocC currently omits extensions, which means that there are a lot of functionality in the library that is missing in the documentation. Future versions will aim to improve this.


## Topics

### Essentials

- <doc:Getting-Started>

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

### Callouts

- ``ActionCalloutContext``
- ``CalloutActionProvider``
- ``InputCalloutContext``
- ``StandardCalloutActionProvider``

- ``BaseCalloutActionProvider``
- ``EnglishCalloutActionProvider``
- ``LocalizedCalloutActionProvider``

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

- ``KeyboardPreviewMode``

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
- ``SystemKeyboardButtonStyle``
- ``SystemKeyboardButtonBorderStyle``
- ``SystemKeyboardButtonShadowStyle``

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
