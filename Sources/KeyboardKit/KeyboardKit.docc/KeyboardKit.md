# ``KeyboardKit``

KeyboardKit helps you create fully customizable keyboard extensions, using Swift and SwiftUI.


## Overview

![KeyboardKit logo](Logo.png)

KeyboardKit lets you create amazing [custom keyboard extensions][About] with a few lines of code, using Swift & SwiftUI.

KeyboardKit extends Apple's limited keyboard APIs with more capabilities. It can be extended with [KeyboardKit Pro][Pro], which unlocks Pro features like localized keyboards, autocomplete, an emoji keyboard, AI support, themes, and much more.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

KeyboardKit must be linked to all targets that will use it, while KeyboardKit Pro must only be linked to the main app target. Other targets will still be able to use KeyboardKit Pro without linking directly to it.



## Getting Started

The <doc:Getting-Started-Article> guide helps you get started with KeyboardKit, and the <doc:Essentials-Article> article describes the essential types in the library.

> Important: Make sure to read the <doc:Developer-Memory-Management> article about the *very* strict memory limitations that Apple puts on custom keyboards.



## Supported Locales

KeyboardKit supports **73** ``Foundation/Locale``s:

🇺🇸 🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🏳️ 🇭🇷 <br />
🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇦🇺 🇨🇦 🇬🇧 🇺🇸 🇪🇪 🇫🇴 <br />
🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 <br />
🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 <br />
🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️ <br />
🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 <br />
🇹🇯 🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇸🇪 🇰🇪 🇹🇷 🇺🇦 <br />
🇺🇿 🇻🇳 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />

[KeyboardKit Pro][Pro] unlocks localized callouts, input sets, layouts & services for all supported locales, as shown in the <doc:Localization-Article> article.


## Features 

KeyboardKit helps you build amazing keyboard extensions, and provides you with a completely free, open-source keyboard engine. You can upgrade to [KeyboardKit Pro][Pro] to unlock even more features.


### Open-Source

* 🌱 <doc:Essentials-Article> - Essential models, services, utilities & views.
* ⌨️ <doc:Essentials-KeyboardView> - A native-looking, customizable keyboard.
* 💥 <doc:Actions-Article> - Trigger & handle keyboard-related actions.
* 📱 <doc:App-Article> - Set up your app, keyboard, sync settings, etc.
* 🗯 <doc:Callouts-Article> - Show input & secondary action callouts.
* 🖥️ <doc:Device-Article> - Identify device type, capabilities, etc.
* 😀 <doc:Emojis-Article> - Emojis, categories, versions, skin tones, etc.
* 🔉 <doc:Feedback-Article> - Trigger audio & haptic feedback.
* 👆 <doc:Gestures-Article> - Handle a rich set of gestures on any key.
* 🔣 <doc:Layout-Article> - Define and customize dynamic keyboard layouts.
* 🌐 <doc:Localization-Article> - Additional locale-related utilities.
* 🗺️ <doc:Navigation-Article> - Open urls and other apps from the keyboard.
* 👁 <doc:Previews-Article> - Extensive SwiftUI preview support.
* 📄 <doc:Proxy-Article> - Extend the text document proxy with more capabilities.
* ⚙️ <doc:Settings-Article> - Provide keyboard settings & link to System Settings.
* 🩺 <doc:Status-Article> - Detect if a keyboard is enabled, has full access, etc.
* 🎨 <doc:Styling-Article> - Style your keyboard to great extent.


### KeyboardKit Pro

* 🌱 <doc:Essentials-Article> - More essential tools, previews, toolbars, etc.
* ⌨️ <doc:Essentials-KeyboardView> - Make the keyboard view do a lot more.
* 🤖 <doc:AI-Article> - Features that are needed for AI.
* 📱 <doc:App-Article> - App-specific screens & views.
* 💡 <doc:Autocomplete-Article> - Local & remote autocomplete, next word prediction, etc.
* 🗯 <doc:Callouts-Article> - Localized callout actions for all supported locales.
* 🎤 <doc:Dictation-Article> - Dictate text from the keyboard.
* 😀 <doc:Emojis-Article> - A powerful emoji keyboard, search, etc.
* ⌨️ <doc:External-Keyboards-Article> - Detect if an external keyboard is connected.
* 🏠 <doc:Host-Article> - Identify and open specific host applications.
* 📝 <doc:Input-Article> - Keyboard input fields, Vietnamese support, etc.
* 🔣 <doc:Layout-Article> - More input sets and layouts for all supported locales.
* 🌐 <doc:Localization-Article> - Localize your keyboard in all supported locales.
* 👁 <doc:Previews-Article> - Keyboard & theme previews for in-app use.
* 📄 <doc:Proxy-Article> - Allow `UITextDocumentProxy` to read the full document.
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

- <doc:Getting-Started-Article>
- <doc:Essentials-Article>
- <doc:Essentials-KeyboardView>

### Developer Guides

- <doc:Developer-Custom-Keyboards-Explained>
- <doc:Developer-Data-Syncing>
- <doc:Developer-Debugging>
- <doc:Developer-Memory-Management>

### Features

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
- <doc:Input-Article>
- <doc:Layout-Article>
- <doc:Localization-Article>
- <doc:Navigation-Article>
- <doc:Previews-Article>
- <doc:Proxy-Article>
- <doc:Settings-Article>
- <doc:Status-Article>
- <doc:Styling-Article>
- <doc:Themes-Article>

### Essentials Types

- ``Keyboard``
- ``KeyboardBehavior``
- ``KeyboardContext``
- ``KeyboardController``
- ``KeyboardInputViewController``
- ``KeyboardModel``
- ``KeyboardSettings``
- ``KeyboardView``
- ``KeyboardViewComponent``
- ``KeyboardViewItem``
- ``KeyboardViewStyle``

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
- ``GestureButtonConfiguration``
- ``GestureButtonTimer``
- ``GestureButtonScrollState``
- ``DragGestureHandler``

### Host

- ``KeyboardHostApplication``
- ``KeyboardHostApplicationProvider``

### Input

- ``KeyboardInput``
- ``KeyboardTextField``
- ``KeyboardTextView``
- ``Vietnamese``
- ``VietnameseInputEngine``

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

### Themes

- ``KeyboardTheme``
- ``KeyboardThemeContext``
- ``KeyboardThemeSettings``
- ``KeyboardThemeStyleVariation``
