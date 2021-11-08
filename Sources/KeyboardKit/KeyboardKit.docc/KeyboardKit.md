# ``KeyboardKit``

KeyboardKit helps you build custom keyboard extensions for iOS and iPadOS using SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit extends the native keyboard extension APIs to provide you with a lot more functionality, to simplify creating powerful keyboards. It also provides you with views to mimic the native system keyboards, with support for multiple locales, gestures, callouts etc.


## Installation

The best way to add KeyboardKit to your app is to use the Swift Package Manager.

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any other targets that needs it.  


## Getting started

After adding KeyboardKit to your project, you can start using it in your application.

* The main app target can use KeyboardKit to check if a keyboard is enabled, if full access is granted etc. which helps you build a more helpful application.
* The keyboard extension can use KeyboardKit to get access to a lot more functionality, which helps you build more powerful keyboard extensions.

In your extension, let your `KeyboardViewController` inherit KeyboardKit's `KeyboardInputViewController` instead of `UIInputViewController` to give it access to a lot of additional functionality, like new lifecycle functions, observables like `keyboardContext` and services like `keyboardActionHandler`, `keyboardAppearance`, autocomplete logic etc.  

`KeyboardInputViewController` will call `viewWillSetupKeyboard` when the keyboard should be created or re-created. You can use `setup(with:)` to setup your extension with any `SwiftUI` view which will make it the main view, inject necessary environment objects, resize the keyboard extension to fit the view etc.


## About this documentation

This documentation is generated, using Xcode's new DocC documentation engine.

Note that the engine currently omit things, like extensions to native types, like `UITextDocumentProxy`, `Color`, `View` etc. Future KeyboardKit versions will aim to incrementally improve these parts.  



## Topics

### Keyboard

- ``KeyboardInputViewController``
- ``KeyboardContext``
- ``KeyboardCasing``
- ``KeyboardType``
- ``KeyboardEnabledState``
- ``KeyboardEnabledStateInspector``
- ``KeyboardHostingController``

### Actions

- ``KeyboardAction``
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

### Behavior

- ``KeyboardBehavior``
- ``StandardKeyboardBehavior``

### Callouts

- ``InputCalloutContext``
- ``SecondaryInputCalloutContext``
- ``SecondaryCalloutActionProvider``
- ``StandardSecondaryCalloutActionProvider``

- ``BaseSecondaryCalloutActionProvider``
- ``EnglishSecondaryCalloutActionProvider``
- ``LocalizedSecondaryCalloutActionProvider``

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

- ``KeyboardInput``
- ``KeyboardInputRow``
- ``KeyboardInputSet``
- ``KeyboardInputSetProvider``
- ``StandardKeyboardInputSetProvider``

- ``AlphabeticKeyboardInputSet``
- ``NumericKeyboardInputSet``
- ``SymbolicKeyboardInputSet``

- ``DeviceSpecificInputSetProvider``
- ``EnglishKeyboardInputSetProvider``
- ``LocalizedKeyboardInputSetProvider``
- ``StaticKeyboardInputSetProvider``

### Layout

- ``KeyboardLayout``
- ``KeyboardLayoutConfiguration``
- ``KeyboardLayoutItem``
- ``KeyboardLayoutItemRow``
- ``KeyboardLayoutItemSize``
- ``KeyboardLayoutItemWidth``
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

- ``PreviewKeyboardActionHandler``
- ``PreviewKeyboardAppearance``
- ``PreviewKeyboardInputSetProvider``
- ``PreviewKeyboardLayoutProvider``
- ``PreviewSecondaryCalloutActionProvider``
- ``PreviewTextDocumentProxy``

### Proxy

- ``TextInputProxy``

### Styles

- ``AutocompleteToolbarStyle``
- ``AutocompleteToolbarItemStyle``
- ``AutocompleteToolbarItemBackgroundStyle``
- ``AutocompleteToolbarSeparatorStyle``
- ``CalloutStyle``
- ``EmojiKeyboardStyle``
- ``InputCalloutStyle``
- ``SecondaryInputCalloutStyle``
- ``SystemKeyboardButtonStyle``
- ``SystemKeyboardButtonBorderStyle``
- ``SystemKeyboardButtonShadowStyle``

### Views

- ``AutocompleteToolbar``
- ``AutocompleteToolbarItem``
- ``AutocompleteToolbarItemSubtitle``
- ``AutocompleteToolbarItemTitle``
- ``AutocompleteToolbarSeparator``
- ``CalloutButtonArea``
- ``CalloutCurve``
- ``InputCallout``
- ``SecondaryInputCallout``
- ``EmojiCategoryKeyboard``
- ``EmojiCategoryKeyboardMenu``
- ``EmojiKeyboard``
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


### Misc. enums

These enums are used by other types. They are listed here to
keep the other sections focused.

- ``AutocompleteSpaceState``
- ``DeleteBackwardRange``
