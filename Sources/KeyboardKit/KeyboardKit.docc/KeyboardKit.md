# ``KeyboardKit``

KeyboardKit is a Swift SDK that lets you create fully customizable keyboards in SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit is a Swift SDK that lets you create fully customizable keyboards in a few lines of code, using SwiftUI.

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you mimic the native iOS keyboard and tweak its style and behavior, or create completely custom keyboards.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.

> Important: If you're a KeyboardKit Pro user, please note that unlike KeyboardKit, it's a binary target and must thus ONLY be added to the app target. If you add it to any other target, it may crash at runtime. 



## Gettings Started

The <doc:Getting-Started> article helps you get started with KeyboardKit.



## Supported Locales

KeyboardKit supports **63** keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 <br />

KeyboardKit provides a basic keyboard layout with basic callout actions. [KeyboardKit Pro][Pro] unlocks localized layouts, callouts & behaviors for all supported locales, as described in the <doc:Localization-Article> article.



## Features

KeyboardKit comes packed features to help you build amazing keyboard extensions:

* ⌨️ <doc:Essentials> - KeyboardKit provides essential utilities, types & views.
* 💥 <doc:Actions-Article> - KeyboardKit makes it easy to trigger keyboard-related actions.
* 💡 <doc:Autocomplete-Article> - KeyboardKit can perform autocomplete.
* 🗯 <doc:Callouts-Article> - KeyboardKit can show input & secondary action callouts.
* 🌈 <doc:Colors-Article> - KeyboardKit defines keyboard-specific colors.
* 🖥️ <doc:Device-Article> - KeyboardKit has device-specific utilities.
* 😀 <doc:Emojis-Article> - KeyboardKit defines emojis, categories, versions, skin tones, etc.
* 🔉 <doc:Feedback-Article> - KeyboardKit can trigger audio & haptic feedback.
* 👆 <doc:Gestures-Article> - KeyboardKit has a customizable keyboard gesture engine.
* 🖼️ <doc:Images-Article> - KeyboardKit defines keyboard-specific images.
* 🔣 <doc:Layout-Article> - KeyboardKit has customizable input sets & keyboard layouts.
* 🌐 <doc:Localization-Article> - KeyboardKit defines localized texts & assets for 63 locales.
* 🗺️ <doc:Navigation-Article> - KeyboardKit lets you open urls and apps from the keyboard.
* 👁 <doc:Previews-Article> - KeyboardKit has extensive SwiftUI preview support.
* ➡️ <doc:Proxy-Article> - KeyboardKit extends `UITextDocumentProxy` with a lot more capabilities.
* ⚙️ <doc:Settings-Article> - KeyboardKit has tools for in-app settings & System Settings.
* 🩺 <doc:Status-Article> - KeyboardKit can detect if a keyboard is enabled, has full access, etc.
* 🎨 <doc:Styling-Article> - KeyboardKit lets you style your keyboards to great extent.

These features are all open-source and free to use. You can upgrade to [KeyboardKit Pro][Pro] to unlock Pro features.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks Pro features, like fully localized and locale-specific system keyboards, layouts & services, on-device and remote autocomplete & autocorrect, dictation, themes, etc.

* ⌨️ <doc:Essentials> - KeyboardKit Pro unlocks more essential tools, system keyboard previews, etc.
* 💥 <doc:Actions-Article> - KeyboardKit Pro auto-registers the most recently used emojis.
* 🤖 <doc:AI-Article> - KeyboardKit Pro unlocks features that are needed for AI.
* 📱 <doc:App-Article> - KeyboardKit Pro unlocks app-specific screens & views.
* 💡 <doc:Autocomplete-Article> - KeyboardKit Pro unlocks on-device & remote autocomplete.
* 🗯 <doc:Callouts-Article> - KeyboardKit Pro unlocks localized callouts for all locales.
* 🎤 <doc:Dictation-Article> - KeyboardKit Pro can perform dictation from the keyboard.
* 😀 <doc:Emojis-Article> - KeyboardKit Pro unlocks a powerful emoji keyboard.
* ⌨️ <doc:External-Keyboards-Article> - KeyboardKit Pro can detect if an external keyboard is connected. 
* 🔉 <doc:Feedback-Article> - KeyboardKit Pro unlocks tools for toogling feedback on & off.
* 🔣 <doc:Layout-Article> - KeyboardKit Pro unlocks localized layouts for all locales.
* 🌐 <doc:Localization-Article> - KeyboardKit Pro unlocks **63** locale-specific services and system keyboards.
* 👁 <doc:Previews-Article> - KeyboardKit Pro unlocks system keyboard and theme previews.
* ➡️ <doc:Proxy-Article> - KeyboardKit Pro unlocks ways for ``UIKit/UITextDocumentProxy`` to read the full document.
* 📝 <doc:Text-Input-Article> - KeyboardKit Pro unlocks tools to let you type within the keyboard.
* 🍭 <doc:Themes-Article> - KeyboardKit Pro unlocks a theme engine with many pre-defined themes.

Every article in this documentation describes in detail what KeyboardKit Pro unlocks for that part of the SDK.



## Demo & Inspiration

The demo app in the [KeyboardKit repository][SDK] lets you try out both KeyboardKit and KeyboardKit Pro. The [KeyboardKit app][App] on the App Store lets you try many pro features directly on your iPhone & iPad, without having to write any code.



## License

KeyboardKit is available under the MIT license.


[App]: https://keyboardkit.com/app
[SDK]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Website]: https://keyboard.com



## Topics

### Getting Started

- <doc:Getting-Started>

### Features

- <doc:Essentials>
- <doc:Actions-Article>
- <doc:AI-Article>
- <doc:App-Article>
- <doc:Autocomplete-Article>
- <doc:Callouts-Article>
- <doc:Colors-Article>
- <doc:Device-Article>
- <doc:Dictation-Article>
- <doc:Emojis-Article>
- <doc:External-Keyboards-Article>
- <doc:Feedback-Article>
- <doc:Gestures-Article>
- <doc:Images-Article>
- <doc:Layout-Article>
- <doc:Localization-Article>
- <doc:Navigation-Article>
- <doc:Previews-Article>
- <doc:Proxy-Article>
- <doc:Settings-Article>
- <doc:Status-Article>
- <doc:Styling-Article>
- <doc:Text-Input-Article>
- <doc:Themes-Article>

### Essentials

- ``Keyboard``
- ``KeyboardBehavior``
- ``KeyboardContext``
- ``KeyboardController``
- ``KeyboardInputViewController``
- ``SystemKeyboard``
- ``SystemKeyboardBottomRow``
- ``SystemKeyboardComponent``
- ``SystemKeyboardItem``
- ``SystemKeyboardPreview``
- ``SystemKeyboardButtonPreview``

### Actions

- ``KeyboardAction``
- ``KeyboardActionHandler``

### Autocomplete

- ``Autocomplete``
- ``AutocompleteContext``
- ``AutocompleteProvider``

### App

- ``KeyboardApp``

### Callouts

- ``Callouts``
- ``CalloutContext``
- ``CalloutActionProvider``

### Device

- ``DeviceType``
- ``InterfaceOrientation``

### Dictation

- ``Dictation``
- ``DictationContext``
- ``DictationService``
- ``KeyboardDictationService``
- ``SpeechRecognizer``

### Emojis

- ``Emoji``
- ``EmojiCategory``
- ``EmojiKeyboard``
- ``EmojiKeyboardStyle``
- ``EmojiVersion``
- ``FrequentEmojiProvider``
- ``MostRecentEmojiProvider``

### External

- ``ExternalKeyboardContext``

### Feedback

- ``Feedback``
- ``FeedbackContext``

### Gestures

- ``Gestures``
- ``DragGestureHandler``

### Layout

- ``InputSet``
- ``KeyboardLayout``
- ``KeyboardLayoutIdentifiable``
- ``KeyboardLayoutProvider``
- ``KeyboardLayoutProviderProxy``

### Localization

- ``KeyboardLocale``
- ``KKL10n``
- ``Localizable``
- ``LocalizedService``

### Previews

- ``KeyboardPreviews``

### Proxy

- ``Proxy``
- ``TextInputProxy``

### Settings

- ``KeyboardSettings``

### Status

- ``KeyboardStatus``
- ``KeyboardStatusContext``
- ``KeyboardStatusInspector``

### Styling

- ``KeyboardFont``
- ``KeyboardStyle``
- ``KeyboardStyleProvider``

### Text Input

- ``KeyboardTextField``
- ``KeyboardTextView``

### Themes

- ``KeyboardTheme``
- ``KeyboardThemeStyleVariation``
