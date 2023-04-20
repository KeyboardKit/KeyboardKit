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

KeyboardKit helps you build custom keyboard extensions for iOS and iPadOS, using Swift and SwiftUI. It extends the native keyboard APIs and provides you with a lot more functionality than is otherwise available.

KeyboardKit lets you create keyboards that mimic the native iOS keyboards in a few lines of code. These keyboards can be customized to great extent to change input keys, keyboard layout, design, behavior etc.

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

You can also use entirely custom views together with the rich features of KeyboardKit, to create completely custom keyboards. Most of the library can be used on all major Apple platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

or with CocoaPods:

```
pod KeyboardKit
```

You can add the library to the main app, the keyboard extension and any other targets that need it. If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Supported Platforms

KeyboardKit supports `iOS 14`, `macOS 11`, `tvOS 14` and `watchOS 7`.



## Supported Locales

KeyboardKit is localized in 61 keyboard-specific locales ([read more][Localization]):

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />
🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />
🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />
🇺🇿 <br />



## Features

KeyboardKit comes packed features to help you build amazing and powerful keyboards:
 
* 💥 [Actions][Actions] - KeyboardKit comes with keyboard actions like characters, emojis, actions, custom ones etc.
* 🎨 [Appearance][Appearance] - KeyboardKit comes with an appearance engine that lets you style your keyboards.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform autocomplete and present suggestions as the user types.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input callouts as the user types, as well as callouts with secondary actions.
* 🎤 [Dictation][Dictation] - (BETA) KeyboardKit can perform dictation from the keyboard extension.
* 😊 [Emojis][Emojis] - KeyboardKit defines emojis and emoji categories, as well as emoji keyboards.
* ⌨️ [External Keyboards][External] - KeyboardKit lets you detect whether or not an external keyboard is connected.
* 👋 [Feedback][Feedback] - KeyboardKit keyboards can give and haptic feedback feedback as the user types.
* 👆 [Gestures][Gestures] - KeyboardKit comes with keyboard-specific gestures that you can use in your own keyboards.
* 🔤 [Input][Input] - KeyboardKit supports `alphabetic`, `numeric`, `symbolic` and completely custom input sets. 
* ⌨️ [Keyboard][Keyboard] - KeyboardKit supports different keyboard types, provides observable keyboard state, etc.
* 🔣 [Layout][Layout] - KeyboardKit supports creating keyboard layouts for various devices, locales etc.
* 🌐 [Localization][Localization]- KeyboardKit defines keyboard-specific locales with localized content and assets.
* 👁 [Previews][Previews] - KeyboardKit has utilites that help previewing keyboard views and components in SwiftUI.
* ➡️ [Proxy][Proxy] - KeyboardKit extends `UITextDocumentProxy` and makes it do a lot more.
* 🚏 [Routing][Routing] - KeyboardKit lets you route text to other destinations than the main app.
* ⬅️ [RTL][RTL] - KeyboardKit supports RTL (right-to-left) locales, such as Arabic, Persian, Kurdish Sorani etc.
* ⚙️ [Settings][Settings] - KeyboardKit has tools for accessing and linking to an app's keyboard settings.



## Getting Started

The online documentation has a [getting-started guide][Getting-Started] that will help you get started with the library.

To make your custom keyboard extension use KeyboardKit, just install and import KeyboardKit, then  make it inherit `KeyboardInputViewController` instead of `UIInputController`:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

This will by default set up a fully working U.S. English keyboard. You can then override any functions to customize how it sets up the keyboard, inject your own services, for instance:

```
override viewWillSetupKeyboard() {
    super.viewWillSetupKeyboard()
    setup(with: MyKeyboardView())
}
```

For more information, please see the [online documentation][Documentation] and [getting-started guide][Getting-Started].



## Documentation

The [online documentation][Documentation] has articles, code examples etc. that let you overview the various parts of the library and understand how they all connect to each other.

The online documentation is currently iOS-specific. To generate documentation for the other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] extends KeyboardKit with pro features, such as localized keyboards and services, autocomplete, dictation, emoji skintones, additional views etc. It lets you create fully localized keyboards with a single line of code.



## Demo Application

This project has a `Demo` folder with a demo app that lets you try out KeyboardKit and KeyboardKit Pro. The app has an input text field and shows you how to display the state of a keyboard extension, link to system settings etc.

The demo app has 5 keyboard extensions:

* `English` uses KeyboardKit and has a `SystemKeyboard` with the standard, English locale.
* `Unicode` uses KeyboardKit and has a `SystemKeyboard` with unicode-based input keys.
* `Custom` uses KeyboardKit and has a `SystemKeyboard` with custom keys, layout and appearance.
* `Pro` uses KeyboardKit Pro and has a `SystemKeyboard` with all LRT locales, autocomplete etc.
* `ProRtl` uses KeyboardKit Pro and has a `SystemKeyboard` with all RTL locales, autocomplete etc.

Just open and run the demo app, then enable the keyboards you want to try under System Settings. Note that you need to enable full access to try some features, like audio and haptic feedback.



## Support

KeyboardKit is trusted and proudly sponsored by the following companies:

<a href="https://www.oribi.se/en">
    <img src="Resources/sponsors/oribi.png" alt="Oribi Icon" title="Oribi" width=120 />
</a>
<a href="https://www.phonetoroam.com">
    <img src="Resources/sponsors/phonetoroam.png" alt="phonetoroam Icon" title="phonetoroam" width=120 />
</a>
<a href="https://vitalisapps.com">
    <img src="Resources/sponsors/vitalis.png" alt="Vitalis Icon" title="Vitalis" width=120 />
</a>
<a href="https://letterkey.eu">
    <img src="Resources/sponsors/letterkey.png" alt="LetterKey Icon" title="LetterKey" width=120 />
</a>
<a href="http://anomaly.net.au">
    <img src="Resources/sponsors/anomaly.png" alt="Anomaly Software Icon" title="Anomaly Software" width=120 />
</a>
<a href="https://www.milocreative.com">
    <img src="Resources/sponsors/milo.png" alt="Milo Creative Icon" title="Milo Creative" width=120 />
</a>

KeyboardKit is open-source and completely free, but you can sponsor this project on [GitHub Sponsors][Sponsors], upgrade to [KeyboardKit Pro][Pro] or [get in touch][Email] for freelance work, paid support etc.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [keyboardkit.com][Website]
* Mastodon: [@keyboardkit@techhub.social][Mastodon]
* Twitter: [@getkeyboardkit][Twitter]
* E-mail: [info@getkeyboardkit.com][Email]



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
[Appearance]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/appearance
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/autocomplete
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/callouts
[Dictation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/dictation
[Emojis]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/emojis
[External]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/external-keyboards
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/feedback
[Gestures]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/gestures
[Input]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/input
[Keyboard]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/keyboard
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/layout
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/localization
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/previews
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/proxy-extensions
[Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/routing
[RTL]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/rtl
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/settings


[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
