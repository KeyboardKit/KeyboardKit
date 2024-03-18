<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="KeyboardKit Logo" title="KeyboardKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/getkeyboardkit"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fgetkeyboardkit" alt="Twitter: @@getkeyboardkit" title="Twitter: @getkeyboardkit" /></a>
    <a href="https://techhub.social/@keyboardkit"><img src="https://img.shields.io/mastodon/follow/109340839247880048?domain=https%3A%2F%2Ftechhub.social&style=social" alt="Mastodon: @keyboardkit@techhub.social" title="Mastodon: @keyboardkit@techhub.social" /></a>
</p>



## About KeyboardKit

KeyboardKit is a Swift SDK that lets you create fully customizable keyboards in a few lines of code, using SwiftUI.

KeyboardKit extends Apple's native APIs and provides you with a lot more functionality. It lets you mimic the native iOS keyboard and tweak its style and behavior, or create completely custom keyboards. 

<p align="center">
    <img src ="Resources/Demo.gif" width=450 />
</p>

Custom iOS keyboard extensions can be used with all other apps that support text input. It's the only way for your product, brand or technology to directly interact with other apps on iOS. Don't miss out!

KeyboardKit can be used in different ways. Keyboard extensions can use it to create custom keyboards. Apps can use it to check keyboard state, full access, provide settings etc.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

After installing KeyboardKit, make sure to link it to all targets that need it.



## Getting Started

After installing KeyboardKit, just make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to new lifecycle functions like `viewWillSetupKeyboard`, observable state like `state.keyboardContext`, services like `services.actionHandler`, and much more.

To replace the default `SystemKeyboard`, override `viewWillSetupKeyboard` and call `setup` with a custom view:

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



## Features

KeyboardKit comes packed features to help you build amazing keyboard extensions:

* ⌨️ [Essentials][Essentials] - KeyboardKit comes with a bunch of essential features, types and views.
* 💥 [Actions][Actions] - KeyboardKit makes it easy to trigger actions like character insertion, locale switching, etc.
* 🤖 [AI Support][AI] - KeyboardKit unlocks additional capabilities that are useful for AI-based tools.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform on-device and remote autocomplete & autocorrect.
* 🔤 [Buttons][Buttons] - KeyboardKit can style any view as a keyboard button, with rich customization capabilities.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input and secondary action callouts.
* 🌈 [Colors][Colors] - KeyboardKit defines keyboard-specific colors.
* 📱 [Device Utilities][Device] - KeyboardKit provides device-specific utilities.
* 🎤 [Dictation][Dictation] - KeyboardKit can perform dictation from the keyboard.
* 😀 [Emojis][Emojis] - KeyboardKit defines an emoji type, categories, an emoji keyboard, etc.
* ⌨️ [External Keyboards][External] - KeyboardKit can detect and react to external keyboards.
* 🔉 [Feedback][Feedback] - KeyboardKit can trigger and customize audio and haptic feedback.
* 👆 [Gestures][Gestures] - KeyboardKit has rich, customizable keyboard-specific gestures.
* 🖼️ [Images][Images] - KeyboardKit defines keyboard-specific images.
* 🔣 [Layout][Layout] - KeyboardKit defines dynamic input sets and customizable keyboard layouts.
* 🌐 [Localization][Localization] - KeyboardKit supports 63 locales.
* 🗺️ [Navigation][Navigation] - KeyboardKit lets you open urls and other apps from the keyboard.
* 👁 [Previews][Previews] - KeyboardKit has SwiftUI preview support and lets you show keyboard previews to your users.
* ➡️ [Proxy Extensions][Proxy] - KeyboardKit extends the native `UITextDocumentProxy` with a lot more capabilities.
* ⚙️ [Settings][Settings] - KeyboardKit has a bunch of tools for managing in-app settings & System Settings.
* 🩺 [State][State] - KeyboardKit lets you detect if a keyboard is enabled, has full access, etc.
* 🎨 [Styling][Styling] - KeyboardKit provides pre-defined themes and lets you style your keyboards to great extent.
* 🚏 [Text Routing][Text-Routing] - KeyboardKit can route text input from the main app to in-keyboard textfields.
* 🌁 [Views][Views] - KeyboardKit defines a bunch of keyboard-related views and modifiers.



## Supported Locales

KeyboardKit supports [63 keyboard-specific locales][Localization]:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 <br />
🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🏳️ 🇮🇷 🇵🇱 🇵🇹 <br />
🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 <br />
🇹🇷 🇺🇦 🇺🇿 <br />

KeyboardKit provides a basic keyboard layout with basic callout actions. [KeyboardKit Pro][Pro] provides localized layouts, callouts and behaviors for all supported locales.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] is a commercial add-on that extends KeyboardKit with Pro features, like localized keyboards and services, autocomplete & autocorrect, dictation, themes, etc.

If you want to give KeyboardKit Pro a try without having to write any code, the [KeyboardKit app][App] on the App Store lets you try out many pro features directly on your iPhone or iPad.

You can purchase a KeyboardKit Pro license from the [KeyboardKit website][Website].



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.



## Demo App

The demo app shows how to display keyboard state, link to system settings, etc. It also has two demo keyboards: 

* `Keyboard` uses KeyboardKit and a customized `SystemKeyboard`.
* `KeyboardPro` uses KeyboardKit Pro and enables all locales, autocomplete, themes, etc.

Just open and run the demo app in the `Demo` folder, then enable the keyboards under System Settings. Note that you need to enable full access for some features to work.



## Support This Project

KeyboardKit is open-source and completely free, but you can support the project by becoming a [GitHub Sponsor][Sponsors], upgrading to [KeyboardKit Pro][Pro] or [get in touch][Email] for freelance work, paid support etc.



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

[Essentials]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/actions-article
[AI]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/ai-article
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/autocomplete-article
[Buttons]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/buttons-article
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/callouts-article
[Colors]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/colors-article
[Device]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/device-article
[Dictation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/dictation-article
[Emojis]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/emojis-article
[External]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/external-keyboards-article
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/feedback-article
[Gestures]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/gestures-article
[Images]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/images-article
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/layout-article
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/localization-article
[Navigation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/navigation-article
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/previews-article
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/proxy-article
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/settings-article
[State]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/state-article
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/styling-article
[Text-Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/text-routing-article
[Themes]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/themes-article
[Views]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/views

[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started

[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
