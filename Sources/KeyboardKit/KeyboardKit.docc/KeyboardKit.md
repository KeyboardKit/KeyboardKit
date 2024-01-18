# ``KeyboardKit``

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using Swift and SwiftUI. 

KeyboardKit extends Apple's native keyboard APIs, provides you with more functionality and lets you create custom keyboards that mimic the native iOS system keyboard in a few lines of code.

You can use KeyboardKit in many different ways. Keyboard extensions can use it to create custom keyboards. Apps can use it to check keyboard enabled state, full access, state, provide settings etc. Furthermore, any target can use it to build upon its models and functionality.

KeyboardKit supports iOS, iPadOS, macOS, tvOS and watchOS, although some functionality is only available on some platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.

> Important: Unlike KeyboardKit, KeyboardKit Pro is a binary target and must ONLY be added to the app target. If you add it to any other target, it may crash at runtime. 



## Supported Locales

KeyboardKit supports **63** keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 <br />

Read more about localization in <doc:Understanding-Localization>.



## License

KeyboardKit is available under the MIT license.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro



## Topics

### Getting Started

- <doc:Getting-Started>
- <doc:Essentials>

### Articles

- <doc:Understanding-Actions>
- <doc:Understanding-AI-Support>
- <doc:Understanding-Autocomplete>
- <doc:Understanding-Buttons>
- <doc:Understanding-Callouts>
- <doc:Understanding-Colors>
- <doc:Understanding-Device-Utilities>
- <doc:Understanding-Dictation>
- <doc:Understanding-Emojis>
- <doc:Understanding-Extensions>
- <doc:Understanding-External-Keyboards>
- <doc:Understanding-Feedback>
- <doc:Understanding-Gestures>
- <doc:Understanding-Images>
- <doc:Understanding-Layout>
- <doc:Understanding-Localization>
- <doc:Understanding-Navigation>
- <doc:Understanding-Previews>
- <doc:Understanding-Proxy-Utilities>
- <doc:Understanding-Settings>
- <doc:Understanding-State>
- <doc:Understanding-Styling>
- <doc:Understanding-Text-Routing>

### Essentials

- ``KeyboardInputViewController``
- ``Keyboard``
- ``KeyboardBehavior``
- ``KeyboardContext``
- ``KeyboardController``
- ``StandardKeyboardBehavior``
- ``SystemKeyboard``
- ``SystemKeyboardItem``

### Actions

- ``KeyboardAction``
- ``KeyboardActionHandler``
- ``StandardKeyboardActionHandler``

### Autocomplete

- ``Autocomplete``
- ``AutocompleteContext``
- ``AutocompleteProvider``
- ``AutocompleteToolbar``

### Buttons

- ``KeyboardButton``
- ``NextKeyboardButton``

### Callouts

- ``Callouts``
- ``CalloutContext``
- ``CalloutActionProvider``
- ``StandardCalloutActionProvider``
- ``BaseCalloutActionProvider``

### Device

- ``DeviceType``
- ``InterfaceOrientation``

### Dictation

- ``Dictation``
- ``DictationContext``
- ``DictationService``
- ``KeyboardDictationService``

### Emojis

- ``Emoji``

### Feedback

- ``AudioFeedback``
- ``HapticFeedback``
- ``FeedbackConfiguration``

### Gestures

- ``Gestures``
- ``DragGestureHandler``

### Layout

- ``InputSet``
- ``KeyboardLayout``
- ``KeyboardLayoutProvider``
- ``KeyboardLayoutProviderProxy``
- ``KeyboardLayoutRowItem``

- ``BaseKeyboardLayoutProvider``
- ``StandardKeyboardLayoutProvider``
- ``InputSetBasedKeyboardLayoutProvider``
- ``iPadKeyboardLayoutProvider``
- ``iPhoneKeyboardLayoutProvider``

### Localization

- ``KKL10n``
- ``KeyboardLocale``
- ``LocaleContextMenu``
- ``LocaleDictionary``
- ``LocalizedService``

### Previews

- ``KeyboardPreviews``

### Proxy

- ``Proxy``
- ``TextInputProxy``

### Settings

- ``KeyboardSettingsLink``

### State

- ``KeyboardStateContext``
- ``KeyboardStateInspector``
- ``KeyboardStateLabel``
- ``KeyboardStateLabelStyle``

### Styling

- ``Styling``
- ``KeyboardFont``
- ``KeyboardStyle``
- ``KeyboardStyleProvider``

- ``StandardKeyboardStyleProvider``
