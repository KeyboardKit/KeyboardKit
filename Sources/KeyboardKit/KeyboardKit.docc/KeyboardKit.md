# ``KeyboardKit``

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using Swift and SwiftUI. It extends Apple's native keyboard APIs and provides you with more functionality.

KeyboardKit lets you create keyboards that mimic native iOS keyboards in a few lines of code. 

These keyboards can be customized to change input keys, layout, design, behavior etc. You can also use completely custom views.

KeyboardKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any targets that need it.



## Supported Locales

KeyboardKit is localized in **60+** keyboard-specific locales:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />
🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />
🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />
🇺🇿 <br />

Read more about localization in <doc:Understanding-Localization>.



## About this documentation

The online documentation is currently iOS-specific.



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
- <doc:Understanding-Routing>
- <doc:Understanding-Settings>
- <doc:Understanding-State>
- <doc:Understanding-Styling>
- <doc:Understanding-System-Keyboards>

### Essentials

- ``KeyboardInputViewController``
- ``Keyboard``
- ``KeyboardBehavior``
- ``KeyboardContext``
- ``KeyboardController``
- ``StandardKeyboardBehavior``

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

- ``Emojis``
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

- ``StandardKeyboardLayoutProvider``
- ``BaseKeyboardLayoutProvider``
- ``InputSetBasedKeyboardLayoutProvider``
- ``iPadKeyboardLayoutProvider``
- ``iPhoneKeyboardLayoutProvider``

### Localization

- ``KKL10n``
- ``KeyboardLocale``
- ``LocaleContextMenu``
- ``LocaleDictionary``
- ``LocalizedService``

### Navigation

- ``KeyboardUrlOpener``

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

### System Keyboard

- ``SystemKeyboard``
- ``SystemKeyboardItem``
