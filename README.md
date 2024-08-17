<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="KeyboardKit Logo" title="KeyboardKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/getkeyboardkit"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fgetkeyboardkit" alt="Twitter: @@getkeyboardkit" title="Twitter: @getkeyboardkit" /></a>
    <a href="https://techhub.social/@keyboardkit"><img src="https://img.shields.io/mastodon/follow/109340839247880048?domain=https%3A%2F%2Ftechhub.social&style=social" alt="Mastodon: @keyboardkit@techhub.social" title="Mastodon: @keyboardkit@techhub.social" /></a>
</p>



## About KeyboardKit

KeyboardKit is a SwiftUI SDK that lets you create fully customizable [keyboard extensions][About] with a few lines of code.

KeyboardKit extends Apple's limited keyboard APIs, extends the input controller and proxy with more capabilities, and provides you with additional functionality, states and views, to let you build an outstanding, custom keyboards.

<p align="center">
    <img src ="Resources/Demo.gif" width=450 />
</p>

KeyboardKit is open-source and completely free. It can be extended with [KeyboardKit Pro][Pro] to unlock Pro features like 68 locales, autocomplete & autocorrect, an emoji keyboard, AI support, themes, dictation and much more.



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

If you just want to use the standard `KeyboardView`, which mimics a native iOS keyboard, you don't have to do anything else. KeyboardKit will set up everything for you.

To replace or customize the standard `KeyboardView`, just override `viewWillSetupKeyboard` and call `setup` with a `view` builder:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { [weak self] controller in // <-- Use [weak self] or [unowned self] if you need self here.
            KeyboardView(
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



## Supported Locales

KeyboardKit supports [68 keyboard-specific locales][Localization]:

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 <br />
🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 <br />
🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 🇲🇳 🏳️ 🇳🇴 🇳🇴 🇮🇷 <br />
🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 <br />
🇦🇷 🇲🇽 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇿 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />

KeyboardKit provides a basic keyboard layout with basic callout actions. [KeyboardKit Pro][Pro] provides localized layouts, callouts and behaviors for all supported locales.



## Open-Source Features

KeyboardKit comes packed with features to help you build amazing keyboard extensions:

* ⌨️ [Essentials][Essentials] - KeyboardKit provides essential utilities, types & views.
* 💥 [Actions][Actions] - KeyboardKit makes it easy to trigger keyboard-related actions.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit has ways to perform autocomplete.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input & secondary action callouts.
* 🌈 [Colors][Colors] - KeyboardKit defines keyboard-specific colors.
* 🖥️ [Device][Device] - KeyboardKit has device-specific utilities.
* 😀 [Emojis][Emojis] - KeyboardKit defines emojis, categories, versions, skin tones, etc.
* 🔉 [Feedback][Feedback] - KeyboardKit can trigger audio & haptic feedback.
* 👆 [Gestures][Gestures] - KeyboardKit has a customizable keyboard gesture engine.
* 🏠 [Host][Host] - KeyboardKit can identify the host application.
* 🖼️ [Images][Images] - KeyboardKit defines keyboard-specific images.
* 🔣 [Layout][Layout] - KeyboardKit has customizable input sets & keyboard layouts.
* 🌐 [Localization][Localization] - KeyboardKit supports **68 locales**.
* 🗺️ [Navigation][Navigation] - KeyboardKit lets you open urls and apps from the keyboard.
* 👁 [Previews][Previews] - KeyboardKit has extensive keyboard preview support.
* ➡️ [Proxy][Proxy] - KeyboardKit extends the text document proxy with a lot more capabilities.
* ⚙️ [Settings][Settings] - KeyboardKit has tools for in-app settings & System Settings.
* 🩺 [Status][Status] - KeyboardKit can detect if a keyboard is enabled, has full access, etc.
* 🎨 [Styling][Styling] - KeyboardKit lets you style your keyboards to great extent.



## Pro Features

You can upgrade to [KeyboardKit Pro][Pro] to unlock Pro features.

* ⌨️ [Essentials][Essentials] - KeyboardKit Pro unlocks more essential tools, keyboard previews, etc.
* 🤖 [AI][AI] - KeyboardKit Pro unlocks features that are needed for AI.
* 📱 [App][App] - KeyboardKit Pro unlocks app-specific screens & views.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit Pro unlocks on-device & remote autocomplete.
* 🗯 [Callouts][Callouts] - KeyboardKit Pro unlocks localized callouts for all **68** locales.
* 🎤 [Dictation][Dictation] - KeyboardKit Pro can perform dictation from the keyboard.
* 😀 [Emojis][Emojis] - KeyboardKit Pro unlocks a powerful emoji keyboard.
* ⌨️ [External][External] - KeyboardKit Pro can detect if an external keyboard is connected. 
* 🔉 [Feedback][Feedback] - KeyboardKit Pro unlocks tools for toogling feedback on & off.
* 🏠 [Host][Host] - KeyboardKit Pro can identify specific host applications.
* 🔣 [Layout][Layout] - KeyboardKit Pro unlocks localized layouts for all **68** locales.
* 🌐 [Localization][Localization] - KeyboardKit Pro unlocks **68** locale-specific services and keyboard views.
* 👁 [Previews][Previews] - KeyboardKit Pro unlocks keyboard and theme previews.
* ➡️ [Proxy][Proxy] - KeyboardKit Pro unlocks ways for `UITextDocumentProxy` to read the full document.
* 📝 [Text][Text-Input] - KeyboardKit Pro unlocks tools to let you type within the keyboard.
* 🍭 [Themes][Themes] - KeyboardKit Pro unlocks a theme engine with many pre-defined themes.



## Documentation

The [online documentation][Documentation] has more information, articles, code examples, etc.



## Demo App

The demo app shows you how to customize the keyboard, display keyboard state, link to system settings, apply custom styles and themes, etc. 

The demo app has two demo keyboards: 

* `Keyboard` uses KeyboardKit and a customized `KeyboardView`.
* `KeyboardPro` uses KeyboardKit Pro and enables all locales, autocomplete, themes, etc.

Just open and run the demo app in the `Demo` folder, then enable the keyboards under System Settings. Note that you need to enable Full Access for some features to work, like haptic feedback.



## KeyboardKit App

If you want to try KeyboardKit Pro without having to write any code or build the demo app from Xcode, there is a [KeyboardKit app][App] in the App Store, that lets you try out many pro features.



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



[Email]: mailto:info@keyboardkit.com
[Website]: https://keyboardkit.com
[Twitter]: http://twitter.com/getkeyboardkit
[Mastodon]: https://techhub.social/@keyboardkit
[Sponsors]: https://github.com/sponsors/danielsaidi

[About]: https://keyboardkit.com/about

[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Gumroad]: https://kankoda.gumroad.com
[App]: https://keyboardkit.com/app
[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE

[Documentation]: https://keyboardkit.github.io/KeyboardKit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started
[Essentials]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/actions-article
[AI]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/ai-article
[App]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/app-article
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
[Host]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/host-article
[Images]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/images-article
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/layout-article
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/localization-article
[Navigation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/navigation-article
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/previews-article
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/proxy-article
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/settings-article
[Status]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/status-article
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/styling-article
[Text-Input]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/text-input-article
[Themes]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/themes-article
