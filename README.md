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

KeyboardKit helps you create custom keyboards for iOS and iPadOS, using technologies like Swift and SwiftUI. It extends Apple's native keyboard APIs and provides you with more functionality than what is otherwise available.

KeyboardKit lets you create keyboards that mimic the native iOS keyboards in a few lines of code. These keyboards can be customized to great extent to change input keys, layout, design, behavior etc.

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

KeyboardKit is localized in **60+** keyboard-specific locales ([read more][Localization]):

🇦🇱 🇦🇪 🇦🇲 🇧🇾 🇧🇬 🇦🇩 🏳️ 🇭🇷 🇨🇿 🇩🇰 <br />
🇳🇱 🇧🇪 🇺🇸 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 <br />
🇧🇪 🇨🇭 🇬🇪 🇩🇪 🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 <br />
🇮🇸 🇮🇩 🇮🇪 🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 <br />
🇲🇰 🇲🇾 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 <br />
🇷🇺 🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 <br />
🇺🇿 <br />



## Features

KeyboardKit comes packed features to help you build amazing and powerful keyboards:
 
* 💥 [Actions][Actions] - KeyboardKit has keyboard actions like characters, emojis, actions, custom ones etc. and ways to handle them.
* 🎨 [Appearance][Appearance] - KeyboardKit has an appearance engine that lets you style your keyboards to great extent.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can perform autocomplete and present suggestions as the user types.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input callouts as the user types, as well as callouts with secondary actions.
* 🎤 [Dictation][Dictation] - (BETA) KeyboardKit can perform dictation from the keyboard extension.
* 😊 [Emojis][Emojis] - KeyboardKit defines emojis and emoji categories, as well as emoji keyboards.
* ⌨️ [External Keyboards][External] - KeyboardKit lets you detect whether or not an external keyboard is connected.
* 👋 [Feedback][Feedback] - KeyboardKit keyboards can give and haptic feedback feedback as the user types.
* 👆 [Gestures][Gestures] - KeyboardKit has keyboard-specific gestures that you can use in your own keyboards.
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

After installing KeyboardKit, just `import KeyboardKit` and make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController` to give your controller access to additional functionality, such as new lifecycle functions, observable properties, keyboard services and much more.

The default ``KeyboardInputViewController`` behavior is to setup an English ``SystemKeyboard`` keyboard. This is all the code that is required to achieve that:

```swift
import KeyboardKit

class KeyboardController: KeyboardInputViewController {}
```

The controller will then call `viewWillSetupKeyboard()` when the keyboard view should be created or updated. You can override this function and call `setup(with:)` to customize the default view or use a custom view.

For instance, here we replace the standard autocomplete toolbar with a custom toolbar:

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

and here we use a completely custom view that requires the app-specific controller type:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { [unowned self] in
            MyCustomKeyboard(
                controller: self
            )
        }
    }
}

struct MyCustomKeyboard: View {

    @unowned 
    var controller: KeyboardViewController 

    var body: some View {
        ... 
    }
}
```

**IMPORTANT** When you use a custom view, it's *very important* to use `[unowned self] in` in the view builder and that any `controller` reference in the custom view is `unowned`, otherwise the strong `self` reference will cause a memory leak.

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

The main app shows you how to display the state of a keyboard extension, link to system settings etc. and has a text field to let you try out the keyboard.

The demo app has 5 keyboard extensions:

* `English` uses KeyboardKit and a `SystemKeyboard` with a standard, English locale.
* `Unicode` uses KeyboardKit and a `SystemKeyboard` with unicode-based input keys.
* `Custom` uses KeyboardKit and a `SystemKeyboard` with custom keys, layout and appearance.
* `Pro` uses KeyboardKit Pro and a `SystemKeyboard` with all LRT locales, autocomplete etc.

Just open and run the demo app in the `Demo` folder, then enable the keyboards you want to try under System Settings. Note that you need to enable full access to try some features, like audio and haptic feedback.



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
