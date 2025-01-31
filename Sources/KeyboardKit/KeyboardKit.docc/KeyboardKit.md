# ``KeyboardKit``

KeyboardKit helps you create fully customizable keyboard extensions, using Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit lets you create amazing [custom keyboards][About] with a few lines of code, using Swift & SwiftUI.

KeyboardKit extends Apple's limited keyboard APIs with more capabilities. It can be extended with [KeyboardKit Pro][Pro], which unlocks Pro features like localized keyboards, autocomplete, an emoji keyboard, AI support, themes, and much more.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.



## Getting Started

The <doc:Getting-Started> guide helps you get started with KeyboardKit, and the <doc:Essentials> article describes the essential types in the library.

> Important: You should also read the <doc:Essentials-Memory-Management> article about the *very* strict memory limitations that Apple puts on keyboard extensions. Learn how to avoid memory-leaks, keep within the limits, and how to monitor your memory consumption.



## Supported Locales

KeyboardKit supports **71** keyboard-specific ``Foundation/Locale``s:

🇺🇸 🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🏳️ 🇭🇷  <br />
🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇦🇺 🇨🇦 🇬🇧 🇺🇸 🇪🇪 🇫🇴  <br />
🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭  <br />
🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿  <br />
🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️  <br />
🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸  <br />
🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇸🇪 🇰🇪 🇹🇷 🇺🇦 🇺🇿  <br />
🏴󠁧󠁢󠁷󠁬󠁳󠁿  <br />

[KeyboardKit Pro][Pro] unlocks localized callouts, input sets, layouts & services for all supported locales, as shown in the <doc:Localization-Article> article.


## Features 

KeyboardKit helps you build amazing keyboard extensions, and provides you with a completely free, open-source keyboard engine. You can upgrade to [KeyboardKit Pro][Pro] to unlock even more features.


### Open-Source

* 🌱 <doc:Essentials> - Essential models, features & views.
* ⌨️ <doc:Essentials-KeyboardView> - Render a native-looking, customizable keyboard.
* 💥 <doc:Actions-Article> - Trigger & handle keyboard-related actions.
* 📱 <doc:App-Article> - Define and set up your app, settings, etc.
* 💡 <doc:Autocomplete-Article> - Perform autocomplete as the user types.
* 🗯 <doc:Callouts-Article> - Show input & secondary action callouts.
* 🖥️ <doc:Device-Article> - Identify device types, capabilities, etc.
* 😀 <doc:Emojis-Article> - Emojis, categories, versions, skin tones, etc.
* 🔉 <doc:Feedback-Article> - Trigger audio & haptic feedback with ease.
* 👆 <doc:Gestures-Article> - Handle a rich set of gestures on any key.
* 🏠 <doc:Host-Article> - Identify the host application.
* 🔣 <doc:Layout-Article> - Define and customize dynamic keyboard layouts.
* 🌐 <doc:Localization-Article> - Localize your keyboard in **71 locales**.
* 🗺️ <doc:Navigation-Article> - Open urls and other apps from the keyboard.
* 👁 <doc:Previews-Article> - Extensive SwiftUI preview support.
* 📄 <doc:Proxy-Article> - Extend the text document proxy with more capabilities.
* ⚙️ <doc:Settings-Article> - Provide keyboard settings & link to System Settings.
* 🩺 <doc:Status-Article> - Detect if a keyboard is enabled, has full access, etc.
* 🎨 <doc:Styling-Article> - Style your keyboard to great extent.


### KeyboardKit Pro

* 🌱 <doc:Essentials> - More essential tools, keyboard previews, etc.
* ⌨️ <doc:Essentials-KeyboardView> - Make the keyboard view do a lot more.
* 🤖 <doc:AI-Article> - Features that are needed for AI.
* 📱 <doc:App-Article> - App-specific screens & views.
* 💡 <doc:Autocomplete-Article> - On-device & remote autocomplete.
* 🗯 <doc:Callouts-Article> - Localized callouts for all locales.
* 🎤 <doc:Dictation-Article> - Trigger dictation from the keyboard.
* 😀 <doc:Emojis-Article> - A powerful emoji keyboard.
* ⌨️ <doc:External-Keyboards-Article> - Detect if an external keyboard is connected.
* 🏠 <doc:Host-Article> - Identify and open specific host applications.
* 🔣 <doc:Layout-Article> - Localized layouts for all locales.
* 🌐 <doc:Localization-Article> - Services & views for all locales.
* 👁 <doc:Previews-Article> - Keyboard & theme previews for in-app use.
* 📄 <doc:Proxy-Article> - Let ``UIKit/UITextDocumentProxy`` read the full document.
* 📝 <doc:Text-Input-Article> - Let users type within the keyboard.
* 🍭 <doc:Themes-Article> - A theme engine with many pre-defined themes.



## Demo & Inspiration

The demo app in the [KeyboardKit GitHub repository][KeyboardKit] lets you try out both KeyboardKit and KeyboardKit Pro. The [KeyboardKit app][App] on the App Store lets you try many pro features directly on your iPhone & iPad, without having to write any code.



## License

KeyboardKit is available under the MIT license.



[About]: https://keyboardkit.com/about
[App]: https://keyboardkit.com/app
[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Website]: https://keyboard.com



## Topics

### Essentials

- <doc:Getting-Started>
- <doc:Essentials>
- <doc:Essentials-KeyboardView>
- <doc:Essentials-Memory-Management>

### Articles

- <doc:Actions-Article>
- <doc:AI-Article>
- <doc:App-Article>
- <doc:Autocomplete-Article>
- <doc:Callouts-Article>
- <doc:Device-Article>
- <doc:Dictation-Article>
- <doc:Emojis-Article>
- <doc:External-Keyboards-Article>
- <doc:Feedback-Article>
- <doc:Gestures-Article>
- <doc:Host-Article>
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

### Keyboard Types

- ``Keyboard``
- ``KeyboardContext``
- ``KeyboardInputViewController``
- ``KeyboardSettings``
- ``KeyboardView``
- ``KeyboardViewItem``

### Keyboard Protocols

- ``KeyboardBehavior``
- ``KeyboardController``
- ``KeyboardModel``
- ``KeyboardViewComponent``

### Actions

- ``KeyboardAction``
- ``KeyboardActionHandler``

### Autocomplete

- ``Autocomplete``
- ``AutocompleteContext``
- ``AutocompleteService``
- ``AutocompleteSettings``

### App

- ``KeyboardApp``
- ``KeyboardAppView``

### Callouts

- ``KeyboardCallout``
- ``KeyboardCalloutContext``
- ``KeyboardCalloutService``

### Device

- ``DeviceType``
- ``InterfaceOrientation``

### Dictation

- ``Dictation``
- ``DictationContext``
- ``DictationService``
- ``DictationSettings``
- ``DictationSpeechRecognizer``

### Emojis

- ``Emoji``
- ``EmojiCategory``
- ``EmojiKeyboard``
- ``EmojiVersion``

### External

- ``ExternalKeyboardContext``

### Feedback

- ``KeyboardFeedback``
- ``KeyboardFeedbackContext``
- ``KeyboardFeedbackService``
- ``KeyboardFeedbackSettings``

### Gestures

- ``Gestures``
- ``GestureButton``
- ``GestureButtonTimer``
- ``GestureButtonScrollState``
- ``DragGestureHandler``

### Host

- ``KeyboardHostApplication``
- ``KeyboardHostApplicationProvider``

### Layout

- ``InputSet``
- ``KeyboardLayout``
- ``KeyboardLayoutService``
- ``KeyboardLayoutServiceProxy``

### Localization

- ``KKL10n``
- ``Foundation/Locale``
- ``Localizable``
- ``LocalizedService``

### Navigation

- ``UrlOpener``

### Previews

- ``KeyboardPreviews``
- ``KeyboardViewPreview``

### Pro

- ``License``

### Proxy

- ``Proxy``

### Status

- ``KeyboardStatus``
- ``KeyboardStatusContext``

### Styling

- ``KeyboardFont``
- ``KeyboardStyle``
- ``KeyboardStyleService``

### Text Input

- ``KeyboardTextField``
- ``KeyboardTextView``

### Themes

- ``KeyboardTheme``
- ``KeyboardThemeContext``
- ``KeyboardThemeCopyable``
- ``KeyboardThemeSettings``
- ``KeyboardThemeStyleVariation``
