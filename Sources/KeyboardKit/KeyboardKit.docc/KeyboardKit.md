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

KeyboardKit supports **64** keyboard-specific ``KeyboardLocale``s:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />

KeyboardKit provides a basic keyboard layout with basic callout actions. [KeyboardKit Pro][Pro] unlocks localized layouts, callouts & behaviors for all supported locales, as described in the <doc:Localization-Article> article.



## Features

KeyboardKit comes packed features to help you build amazing keyboard extensions:

* ⌨️ <doc:Essentials> - KeyboardKit provides essential utilities, types & views.
* 💥 <doc:Actions-Article> - KeyboardKit makes it easy to trigger keyboard-related actions.
* 🤖 <doc:AI-Article> - KeyboardKit has features that are needed for AI.
* 📱 <doc:App-Article> - KeyboardKit has app-specific screens & views.
* 💡 <doc:Autocomplete-Article> - KeyboardKit can perform autocomplete.
* 🗯 <doc:Callouts-Article> - KeyboardKit can show input & secondary action callouts.
* 🌈 <doc:Colors-Article> - KeyboardKit defines keyboard-specific colors.
* 🖥️ <doc:Device-Article> - KeyboardKit has device-specific utilities.
* 🎤 <doc:Dictation-Article> - KeyboardKit can perform dictation from the keyboard.
* 😀 <doc:Emojis-Article> - KeyboardKit defines emojis, categories, versions, skin tones, etc.
* ⌨️ <doc:External-Keyboards-Article> - KeyboardKit can detect defines emojis, categories, versions, skin tones, etc.
* 🔉 <doc:Feedback-Article> - KeyboardKit can trigger audio & haptic feedback.
* 👆 <doc:Gestures-Article> - KeyboardKit has a customizable keyboard gesture engine.
* 🏠 <doc:Host-Article> - KeyboardKit can identify the host application.
* 🖼️ <doc:Images-Article> - KeyboardKit defines keyboard-specific images.
* 🔣 <doc:Layout-Article> - KeyboardKit has customizable input sets & keyboard layouts.
* 🌐 <doc:Localization-Article> - KeyboardKit supports **64 locales**.
* 🗺️ <doc:Navigation-Article> - KeyboardKit lets you open urls and apps from the keyboard.
* 👁 <doc:Previews-Article> - KeyboardKit has extension keyboard preview support.
* ➡️ <doc:Proxy-Article> - KeyboardKit extends the text document proxy with a lot more capabilities.
* ⚙️ <doc:Settings-Article> - KeyboardKit has tools for in-app settings & System Settings.
* 🩺 <doc:Status-Article> - KeyboardKit can detect if a keyboard is enabled, has full access, etc.
* 🎨 <doc:Styling-Article> - KeyboardKit lets you style your keyboards to great extent.
* 📝 <doc:Text-Input-Article> - KeyboardKit can route text to input fields within the keyboard.
* 🍭 <doc:Themes-Article> - KeyboardKit can use themes to style keyboards in flexible ways.

Many features are open-source and free to use. You can upgrade to [KeyboardKit Pro][Pro] to unlock Pro features.



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
- <doc:Host-Article>
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

### Host

- ``KeyboardHostApplication``

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
