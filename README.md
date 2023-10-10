<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="KeyboardKit Logo" title="KeyboardKit" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.7-orange.svg" alt="Swift 5.6" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/getkeyboardkit">
        <img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fgetkeyboardkit" alt="Twitter: @@getkeyboardkit" title="Twitter: @getkeyboardkit" />
    </a>
    <a href="https://techhub.social/@keyboardkit">
        <img src="https://img.shields.io/mastodon/follow/109340839247880048?domain=https%3A%2F%2Ftechhub.social&style=social" alt="Mastodon: @keyboardkit@techhub.social" title="Mastodon: @keyboardkit@mastodon.social" />
    </a>
</p>



## About KeyboardKit

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using Swift and SwiftUI. It extends Apple's native keyboard APIs and provides you with more functionality.

KeyboardKit lets you create keyboards that mimic native iOS keyboards in a few lines of code. 

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

These keyboards can be customized to change input keys, layout, design, behavior etc. You can also use completely custom views.

KeyboardKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`, although some features are unavailable on some platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any other targets that need it. If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Supported Locales

KeyboardKit is localized in [60+ keyboard-specific locales][Localization]:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />
🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />
🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />
🇺🇿 <br />

KeyboardKit comes with basic input sets, layouts and secondary callout actions.



## Features

KeyboardKit comes packed features to help you build amazing and powerful keyboards:

* ⌨️ [Essentials][Essentials] - KeyboardKit comes with a bunch of essential functionality and types.
* 💥 [Actions][Actions] - KeyboardKit has keyboard actions like characters, actions, etc.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform autocomplete and autocorrect.
* 🔤 [Buttons][Buttons] - KeyboardKit can style any view as a keyboard button.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input and secondary callouts.
* 🌈 [Colors][Colors] - KeyboardKit defines a bunch of keyboard-related colors.
* 📱 [Device][Device] - KeyboardKit has a bunch of device-specific utilities.
* 🎤 [Dictation][Dictation] - (BETA) KeyboardKit can perform dictation from the keyboard.
* 😀 [Emojis][Emojis] - KeyboardKit defines an emoji type with a lot of nite information.
* 🔉 [Feedback][Feedback] - KeyboardKit can trigger audio and haptic feedback.
* 👆 [Gestures][Gestures] - KeyboardKit has rich, keyboard-specific gestures.
* 🖼️ [Images][Images] - KeyboardKit defines a bunch of keyboard-related images.
* 🔣 [Layout][Layout] - KeyboardKit lets you define dynamic keyboard layouts.
* 🌐 [Localization][Localization] - KeyboardKit supports 60+ locales.
* 🗺️ [Navigation][Navigation] - KeyboardKit lets you open urls and other apps.
* 👁 [Previews][Previews] - KeyboardKit lets you preview views and components in SwiftUI.
* ➡️ [Proxy Extensions][Proxy] - KeyboardKit makes `UITextDocumentProxy` do a LOT more.
* ⚙️ [Settings][Settings] - KeyboardKit has tools for accessing and linking to keyboard settings.
* 🩺 [State][State] - KeyboardKit lets you detect if a keyboard is enabled, has full access, etc.
* 🎨 [Styling][Styling] - KeyboardKit lets you style and customize your keyboards to great extent.

[KeyboardKit Pro][Pro] extends these features with many pro features, such as fully localized keyboards, autocomplete, emoji keyboards, dictation, etc.



## Getting Started

The online documentation has a [getting-started guide][Getting-Started] that helps you get started with KeyboardKit.

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to new lifecycle functions, observable state, services, and much more.

KeyboardKit will by default use a standard ``SystemKeyboard``. If you just want to use this standard view, you don’t have to do anything more.

To customize or replace the standard view, you can override `viewWillSetupKeyboard()` and call any of the `setup` functions with a custom view:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in MyCustomToolbar() }
            )
        }
    }
}
```

The setup view builder provides an `unowned` controller reference to help avoiding memory leaks. Use it to access its state and services, and avoid passing it around.

For more information, please see the [online documentation][Documentation] and [getting-started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has articles, code examples etc.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] extends KeyboardKit with a lot of Pro features, such as localized keyboards and services, autocomplete, dictation, pro emoji features (keyboards, categories, versions, skintones, etc). 

KeyboardKit Pro lets you create fully localized keyboards with a single line of code.



## Demo App

The KeyboardKit repository has a demo app that shows how to display keyboard state, link to system settings, etc.

The demo app has three keyboards: 

* `Keyboard` uses KeyboardKit and a standard `SystemKeyboard`.
* `KeyboardPro` uses KeyboardKit Pro and a `SystemKeyboard` with 60+ locales, autocomplete, etc.
* `KeyboardTextInput` uses KeyboardKit Pro and lets you test using text input within the keyboard.

Just open and run the demo app in the `Demo` folder, then enable the keyboards under System Settings. Note that you need to enable full access for some features, like haptic feedback.



## KeyboardKit App

If you want to try KeyboardKit Pro without having to write any code or build the demo app from Xcode, there is a [KeyboardKit app][app-store] in the App Store.



## Support this project

KeyboardKit is open-source and completely free, but you can sponsor this project on [GitHub Sponsors][Sponsors], upgrade to [KeyboardKit Pro][Pro] or [get in touch][Email] for freelance work, paid support etc.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [keyboardkit.com][Website]
* Mastodon: [@keyboardkit@techhub.social][Mastodon]
* Twitter: [@getkeyboardkit][Twitter]
* E-mail: [info@keyboardkit.com][Email]



## License

KeyboardKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:info@getkeyboardkit.com
[Website]: https://keyboardkit.com
[Twitter]: http://twitter.com/getkeyboardkit
[Mastodon]: https://techhub.social/@keyboardkit
[Sponsors]: https://github.com/sponsors/danielsaidi

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Gumroad]: https://kankoda.gumroad.com

[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started

[Essentials]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-actions
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-autocomplete
[Buttons]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-buttons
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-callouts
[Colors]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-colors
[Device]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-device-utilities
[Dictation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-dictation
[Emojis]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-emojis
[External]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-external-keyboards
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-feedback
[Gestures]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-gestures
[Images]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-images
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-layout
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-localization
[Navigation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-navigation
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-previews
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-proxy-utilities
[Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-routing
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-settings
[State]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-state
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-styling

[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
