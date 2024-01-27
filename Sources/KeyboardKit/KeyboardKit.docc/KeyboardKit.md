# ``KeyboardKit``

KeyboardKit helps you create custom keyboard extensions with Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you create custom keyboards that mimic native iOS keyboards with just a few lines of code.

KeyboardKit lets you customize all parts of the keyboard. You can use custom layouts, designs, views, behavior, etc. and make any key or gesture trigger any action.

Keyboard extensions can use KeyboardKit to create custom keyboards, while apps can use it to check keyboard state, provide shared settings, link to System Settings, etc.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.

> Important: Unlike KeyboardKit, KeyboardKit Pro is a binary target and must ONLY be added to the app target. If you add it to any other target, it may crash at runtime. 



## Gettings Started

See the <doc:Getting-Started> article for information on how to get started with KeyboardKit.



## Supported Locales

KeyboardKit supports **63** keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 <br />

Read more about localization in <doc:Localization-Article>.



## License

KeyboardKit is available under the MIT license.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro



## Topics

### Getting Started

- <doc:Getting-Started>
- <doc:Essentials>

### Features

- <doc:Actions-Article>
- <doc:AI-Article>
- <doc:Autocomplete-Article>
- <doc:Buttons-Article>
- <doc:Callouts-Article>
- <doc:Colors-Article>
- <doc:Device-Article>
- <doc:Dictation-Article>
- <doc:Emojis-Article>
- <doc:Extensions-Article>
- <doc:External-Keyboards-Article>
- <doc:Feedback-Article>
- <doc:Gestures-Article>
- <doc:Images-Article>
- <doc:Layout-Article>
- <doc:Localization-Article>
- <doc:Navigation-Article>
- <doc:Previews-Article>
- <doc:Proxy-Utilities-Article>
- <doc:Settings-Article>
- <doc:State-Article>
- <doc:Styling-Article>
- <doc:Text-Routing-Article>
- <doc:Themes-Article>
- <doc:Views>

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
