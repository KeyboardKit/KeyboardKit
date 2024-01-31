<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="KeyboardKit Logo" title="KeyboardKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.8-orange.svg" alt="Swift 5.8" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/getkeyboardkit"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fgetkeyboardkit" alt="Twitter: @@getkeyboardkit" title="Twitter: @getkeyboardkit" /></a>
    <a href="https://techhub.social/@keyboardkit"><img src="https://img.shields.io/mastodon/follow/109340839247880048?domain=https%3A%2F%2Ftechhub.social&style=social" alt="Mastodon: @keyboardkit@techhub.social" title="Mastodon: @keyboardkit@techhub.social" /></a>
</p>



## About KeyboardKit

KeyboardKit helps you create custom keyboard extensions with Swift and SwiftUI. 

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you create custom keyboards that mimic native iOS keyboards with just a few lines of code. 

<p align="center">
    <img src ="Resources/Demo.gif" width=450 />
</p>

KeyboardKit lets you customize all parts of the keyboard. You can use custom layouts, designs, behavior, etc. and make any key or gesture trigger any action. You can even use completely custom views and just use the underlying functionality.

You can use KeyboardKit in many different ways. Keyboard extensions can use it to create custom keyboards. Apps can use it to check keyboard enabled state, full access, state, provide settings etc. Furthermore, any target can use it to build upon its models and functionality.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.



## Supported Locales

KeyboardKit supports [63 keyboard-specific locales][Localization]:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 <br />

KeyboardKit provides a basic keyboard layout and callout actions, while [KeyboardKit Pro][Pro] provides localized layouts, callouts and behaviors for all supported locales.



## Features

KeyboardKit comes packed features to help you build amazing keyboard extensions:

* ⌨️ [Essentials][Essentials] - KeyboardKit comes with a bunch of essential features and types.
* 💥 [Actions][Actions] - KeyboardKit has keyboard actions like characters, actions, etc.
* 🤖 [AI Support][AI] - KeyboardKit has capabilities that are needed for AI.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform autocomplete and autocorrect.
* 🔤 [Buttons][Buttons] - KeyboardKit can style any view as a keyboard button.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input and secondary callouts.
* 🌈 [Colors][Colors] - KeyboardKit defines a bunch of keyboard-related colors.
* 📱 [Device Utilities][Device-Utilities] - KeyboardKit has a bunch of device-specific utilities.
* 🎤 [Dictation (BETA)][Dictation] - KeyboardKit can perform dictation from the keyboard.
* 😀 [Emojis][Emojis] - KeyboardKit defines an emoji type with a lot of information.
* 🔉 [Feedback][Feedback] - KeyboardKit can trigger audio and haptic feedback.
* 👆 [Gestures][Gestures] - KeyboardKit has rich, keyboard-specific gestures.
* 🖼️ [Images][Images] - KeyboardKit defines a bunch of keyboard-related images.
* 🔣 [Layout][Layout] - KeyboardKit defines dynamic input sets and keyboard layouts.
* 🌐 [Localization][Localization] - KeyboardKit supports 63 locales.
* 🗺️ [Navigation][Navigation] - KeyboardKit lets you open urls and other apps.
* 👁 [Previews][Previews] - KeyboardKit lets you preview views and components in SwiftUI.
* ➡️ [Proxy Extensions][Proxy] - KeyboardKit makes `UITextDocumentProxy` do a LOT more.
* ⚙️ [Settings][Settings] - KeyboardKit has a bunch of settings tools.
* 🩺 [State][State] - KeyboardKit lets you detect if a keyboard is enabled, has full access, etc.
* 🎨 [Styling][Styling] - KeyboardKit lets you style your keyboards to great extent.
* 🍭 [Themes][Themes] - KeyboardKit Pro defines a theme engine with many predefined themes.
* 🚏 [Text Routing][Text-Routing] - KeyboardKit kan route text to other places.

[KeyboardKit Pro][Pro] extends KeyboardKit with a lot of Pro features, such as localized keyboards and services, autocomplete, autocorrect, dictation, emoji keyboards and features, themes, etc.



## Getting Started

After installing KeyboardKit, just make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to new lifecycle functions like `viewWillSetupKeyboard`, observable state like `state.keyboardContext`, services like `services.actionHandler`, and much more.

KeyboardKit will use a `SystemKeyboard` as the default keyboard view. To customize or replace it, override `viewWillSetupKeyboard()` and call any `setup` function with any custom view:

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

For more information, please see the [getting started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.



## Demo App

The repository has a demo app that shows how to display keyboard state, link to system settings, etc. 

The app has two keyboards: 

* `Keyboard` uses KeyboardKit and a customized `SystemKeyboard`.
* `KeyboardPro` uses KeyboardKit Pro and a customized `SystemKeyboard` with all locales, autocomplete, themes etc.

Just open and run the demo app in the `Demo` folder, then enable the keyboards under System Settings. Note that you need to enable full access for some features, like haptic feedback.



## KeyboardKit App

If you want to try KeyboardKit Pro without having to write any code or build the demo app from Xcode, there [KeyboardKit app][App] in the App Store lets you try out many pro features.



## Support This Project

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

[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Gumroad]: https://kankoda.gumroad.com
[App]: https://keyboardkit.com/app

[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started

[Essentials]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-actions
[AI]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-ai-support
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-autocompletion
[Buttons]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-buttons
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-callout
[Colors]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-colors
[Device-Utilities]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-device-utilities
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
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-settings
[State]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-state
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-styling
[Themes]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-themes
[Text-Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-text-routing

[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
