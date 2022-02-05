# ``KeyboardKit``

KeyboardKit helps you build custom keyboard extensions for iOS and iPadOS.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit extends the native keyboard extension APIs that are provided by Apple, to provide you with a lot more functionality than is available by default. 

KeyboardKit also provides you with views and tools to help you mimic native iOS keyboards. See ``SystemKeyboard`` for more info.

KeyboardKit is flexible and doesn't force your keyboard to look or behave in a certain way. You can use ``SystemKeyboard`` to mimic native iOS keyboards and style them a little (or a lot) or use completely custom views or designs.


#### About this documentation

This documentation is generated with Xcode's new DocC engine. Since DocC currently omits extensions, a lot of library functionality is currently missing in the documentation.



## Topics

### Essentials

- <doc:Getting-Started>
- <doc:Going-Further>
- <doc:Understanding-Keyboard-Actions>
- <doc:Understanding-Keyboard-Appearance>
- <doc:Understanding-Keyboard-Feedback>
- <doc:Understanding-Keyboard-Input-Sets>
- <doc:Understanding-Keyboard-Layout>
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
