<p align="center">
    <img src ="Resources/Logo.png" width=600 alt="KeyboardKit Logo" title="KeyboardKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/Swift-5.6-orange.svg" alt="Swift 5.6" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/getkeyboardkit">
        <img src="https://img.shields.io/badge/contact-@getkeyboardkit-blue.svg?style=flat" alt="Twitter: @getkeyboardkit" />
    </a>
</p>



## About KeyboardKit

KeyboardKit is a Swift library that helps you build custom keyboards with Swift and SwiftUI. It extends the native keyboard APIs and provides you with a lot more functionality than is otherwise available.

The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

KeyboardKit lets you create keyboards that mimic the iOS stock keyboard in a single line of code. These keyboards can be customized to great extent to change their input keys, keyboard layout, design, behavior etc.

You can also use entirely custom views with the rich features of KeyboardKit, to create completely custom keyboard extensions. Most of the KeyboardKit features can be used on all major Apple platforms as well. 



## Supported Platforms

KeyboardKit supports `iOS 13`, `macOS 11`, `tvOS 13` and `watchOS 6`.

Although KeyboardKit builds on all platform, some features are unavailable on some platforms.



## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

or with CocoaPods:

```
pod KeyboardKit
```

You can add the library to the main app, the keyboard extension and any other targets that need it.



## Getting started

The online documentation has a [getting-started guide][Getting-Started] that will help you get started with the library.



## Documentation

The [online documentation][Documentation] has articles, code examples etc. that let you overview the various parts of the library and understand how they all connect to each other.

The online documentation is currently iOS-specific. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.

Note that extensions to native types are not included in this documentation. Future versions of this library will refactor the extensions in a way that makes them appear in the documentation.



## ✨ Features

KeyboardKit is localized in 50+ keyboard-specific locales ([read more][Localization]):

🇺🇸 🇦🇱 🇦🇪 🇧🇾 🇧🇬 🇦🇩 🇭🇷 🇨🇿 🇩🇰 🇳🇱 <br />
🇧🇪 🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇭 🇬🇪 <br />
🇩🇪 🇦🇹 🇬🇷 🇭🇺 🇮🇸 🇮🇪 🇮🇹 🇹🇯 🇱🇻 🇱🇹 <br />
🇲🇰 🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />
🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇰🇪 🇸🇪 🇹🇷 🇺🇦 🇺🇸 🇧🇪 <br />

KeyboardKit comes packed features to help you build amazing and powerful keyboards:
 
* 💥 [Actions][Actions] - KeyboardKit comes with keyboard actions like characters, emojis, actions, custom ones etc.
* 🎨 [Appearances][Appearances] - KeyboardKit comes with an appearance engine that lets you easily style your keyboards.
* 💡 [Autocomplete][Autocomplete] - KeyboardKit can present autocomplete suggestions as the user types.
* 🗯 [Callouts][Callouts] - KeyboardKit can show input callouts, as well as long press callouts with secondary actions.
* 😊 [Emojis][Emojis] - KeyboardKit defines emojis and emoji categories that you can use in your own keyboards.
* 🧩 [Extensions][Extensions] - KeyboardKit provides a bunch of extensions to native types.
* ⌨️ [External Keyboards][External] - KeyboardKit lets you detect whether or not an external keyboard is used.
* 👋 [Feedback][Feedback] - KeyboardKit keyboards can give and haptic feedback feedback as the user types.
* 👆 [Gestures][Gestures] - KeyboardKit comes with keyboard-specific gestures that you can use in your own keyboards.
* 🔤 [Input Sets][Input-Sets] - KeyboardKit supports creating `alphabetic`, `numeric` and `symbolic` and custom input sets. 
* ⌨️ [Keyboard Layouts][Keyboard-Layouts] - KeyboardKit supports creating keyboard layouts for various devices, locales etc.
* 💱 [Keyboard Types][Keyboard-Types] - KeyboardKit supports keyboard types, like `alphabetic`, `numeric`, `symbolic` etc.
* 🌐 [Locales][Localization]- KeyboardKit defines keyboard-specific locales with localized content and assets.
* 👁 [Previews][Previews] - KeyboardKit defines a bunch of tools that simplify previewing keyboard views in SwiftUI.
* ➡️ [Proxy][Proxy] - KeyboardKit defines a bunch of extensions to `UITextDocumentProxy`.
* ⬅️ [RTL][RTL] - KeyboardKit supports RTL (right-to-left) locales, such as Arabic, Persian, Kurdish etc.
* 🎨 [Styles][Styles] - KeyboardKit defines a bunch of styles that simplify customizing the look of various components.
* 🚏 [Text Routing][Text-Routing] - KeyboardKit lets you route text to other destinations than the main app.
* 🖼 [Views][Views] - KeyboardKit comes with a bunch of keyboard-specific views, like keyboards, toobars, buttons etc.



## KeyboardKit Pro

[KeyboardKit Pro][Pro] extends KeyboardKit with pro features, such as additional locales, autocomplete engines, more extensions, additional views etc. It lets you create fully localized system keyboards with a single line of code. 

KeyboardKit Pro requires a commercial license. Licenses can be purchased from the [website][Website] or from [Gumroad][Gumroad].



## Demo Applications

This project contains a `Demo` folder with two demo apps that lets you try out KeyboardKit.

`Demo` uses KeyboardKit and lets you type in a light and dark text field. It has three keyboards:

* `English` uses a `SystemKeyboard` to mimic a native English keyboard.
* `Unicode` uses a `SystemKeyboard` and a custom, unicode-based input set.
* `Custom` shows you how to easily customize input sets and layouts.

`ProDemo` uses KeyboardKit Pro and supports 50+ locales, autocomplete etc. It has two keyboards:  

* `System LTR` uses a `SystemKeyboard` with all left-to-right locales.
* `System RTL` uses a `SystemKeyboard` with all right-to-left locales.

Just open and run any of these projects, then enable the keyboards you want to try under System Settings. 

Note that you need to enable full access to try some features, like audio and haptic feedback.



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

KeyboardKit is open-source and completely free, but you can sponsor this project on [GitHub Sponsors][Sponsors], upgrade to [KeyboardKit Pro][Pro] or get in touch for paid support.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [info@getkeyboardkit.com][Email]
* Twitter: [@getkeyboardkit][Twitter]
* Website: [getkeyboardkit.com][Website]



## License

KeyboardKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:info@getkeyboardkit.com
[Twitter]: https://twitter.com/getkeyboardkit
[Website]: https://getkeyboardkit.com
[Sponsors]: https://github.com/sponsors/danielsaidi
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Gumroad]: https://danielsaidi.gumroad.com

[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started
[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-actions
[Appearances]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-appearances
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-autocomplete
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-feedback
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-layout
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-localization
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-previews.md
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-proxy-extensions.md
[Text-Routing]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/understanding-text-routing.md

[Callouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Callouts.md
[Emojis]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Emojis.md
[Extensions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Extensions.md
[External]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/External.md
[Gestures]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Gestures.md
[Input-Sets]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Types]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[RTL]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/RTL.md
[Styles]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Styles.md
[Views]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Views.md

[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE
