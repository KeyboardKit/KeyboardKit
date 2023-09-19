<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="KeyboardKit Logo" title="KeyboardKit" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.6-orange.svg" alt="Swift 5.6" />
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

KeyboardKit lets you create keyboards that mimic the native iOS keyboards in a few lines of code. These keyboards can be customized to change input keys, layout, design, behavior etc.

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

KeyboardKit also lets you use completely custom views together with the features that the library provides. Most of the library can be used on all major Apple platforms.

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

KeyboardKit comes with localized input sets, layouts and callouts for U.S. English.



## Features

KeyboardKit comes packed features to help you build amazing and powerful keyboards:
 
* 💥 [Actions][Actions] - KeyboardKit has keyboard actions like characters, emojis, actions, etc.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform autocomplete and present suggestions as the user types.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input and secondary action callouts.
* 🎤 [Dictation][Dictation] - (BETA) KeyboardKit can perform dictation from the keyboard extension.
* 😊 [Emojis][Emojis] - KeyboardKit defines emojis and emoji categories, as well as emoji keyboards.
* ⌨️ [External Keyboards][External] - KeyboardKit lets you detect whether or not an external keyboard is connected.
* 👋 [Feedback][Feedback] - KeyboardKit keyboards can give and haptic feedback feedback as the user types.
* 👆 [Gestures][Gestures] - KeyboardKit has keyboard-specific gestures that you can use in your own keyboards.
* ⌨️ [Keyboard][Keyboard] - KeyboardKit supports different keyboard types, provides observable keyboard state, etc.
* 🔣 [Layout][Layout] - KeyboardKit supports creating keyboard layouts for various devices, locales etc.
* 🌐 [Localization][Localization]- KeyboardKit supports LTR and RTL locales with localized content and assets.
* 👁 [Previews][Previews] - KeyboardKit has utilites that help previewing keyboard views and components in SwiftUI.
* ➡️ [Proxy Extensions][Proxy] - KeyboardKit extends `UITextDocumentProxy` and makes it do a lot more.
* 🚏 [Routing][Routing] - KeyboardKit lets you route text to other destinations than the main app.
* ⚙️ [Settings][Settings] - KeyboardKit has tools for accessing and linking to an app's keyboard settings.
* 🎨 [Styling][Styling] - KeyboardKit has a style engine that lets you style your keyboards to great extent.



## Getting Started

The online documentation has a [getting-started guide][Getting-Started] that helps you get started.

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to additional functionality, such as new lifecycle functions like `viewWillSetupKeyboard()`, observable state like `keyboardContext`, services like `keyboardActionHandler` and much more.

The default ``KeyboardInputViewController`` behavior is to setup an English `SystemKeyboard`. It will then call `viewWillSetupKeyboard()` when the keyboard view should be created or updated. 

To set up KeyboardKit with a custom view, you can override `viewWillSetupKeyboard()` and call `.setup(with:)` to customize the `SystemKeyboard` or use a custom view:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            VStack(spacing: 0) {
                MyCustomToolbar()
                SystemKeyboard(
                    controller: controller,
                    autocompleteToolbar: .none
                )
            }
        }
    }
}
```

The view builder provides an unowned controller reference to avoid reference cycles and memory leaks.

For more information, please see the [online documentation][Documentation] and [getting-started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has articles, code examples etc. that let you overview the various parts of the library and understand how they all connect to each other.

The online documentation is currently iOS-specific. To generate documentation for the other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] extends KeyboardKit with pro features, such as localized keyboards and services, autocomplete, dictation, emoji skintones, additional views etc. It lets you create fully localized keyboards with a single line of code.



## App Store Application

If you want to try out KeyboardKit without having to write any code, there is a [KeyboardKit app][app-store] in the App Store, that lets you try out KeyboardKit and many of its features.

The App Store app uses [KeyboardKit Pro][Pro] to provide support for 60+ locales, autocomplete, dictation, emoji skintones etc. 



## Demo Application

This project has a demo app that lets you try out KeyboardKit and KeyboardKit Pro.

* The main app shows how to display keyboard state, link to system settings, etc.
* `Keyboard` uses KeyboardKit and a `SystemKeyboard` with a standard, English locale.
* `KeyboardCustom` uses KeyboardKit and a `SystemKeyboard` with custom keys, layouts and styles.
* `KeyboardPro` uses KeyboardKit Pro and a `SystemKeyboard` with all locales, autocomplete, etc.
* `KeyboardTextInput` uses KeyboardKit and lets you test text input within the keyboard extension.

Just open and run the demo app in the `Demo` folder, then enable the keyboards you want to try under System Settings. Note that you need to enable full access to try some features, like audio and haptic feedback.



## Support

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
[Gumroad]: https://danielsaidi.gumroad.com

[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/actions
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/autocomplete
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/callouts
[Dictation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/dictation
[Emojis]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/emojis
[External]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/external-keyboards
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/feedback
[Gestures]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/gestures
[Keyboard]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/layout
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/localization
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/previews
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/proxy-extensions
[Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/routing
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/settings
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/styling

[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
