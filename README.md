# KeyboardKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>



## About KeyboardKit

KeyboardKit helps you build custom keyboard extensions for `iOS` and `iPadOS`, using `SwiftUI`. It extends the native APIs to provide you with more functionality and has views and utils to let you mimic native keyboards.

The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

KeyboardKit is flexible and doesn't force your keyboard to look or behave in a certain way. You can go with a standard system keyboard, tweak the standard design a little (or a lot) or use completely custom views or designs.

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo app for inspiration.



## Installation

The best way to add KeyboardKit to your app is to use the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

You can add the library to the main app, the keyboard extension and any other targets that needs it.  



## Getting started

Once KeyboardKit is added to your project, you can start using it in your application and keyboard extension.

[Read more here][Getting-Started]



## Documentation

The KeyboardKit documentation contains extensive information, code examples etc. and makes it easy to overview the various parts of the library.

You can either [download][Documentation] the documentation or build it directly in Xcode, using `Product/Build Documentation`.



## 🇸🇪 Localization

KeyboardKit is localized in 46 keyboard-specific locales:

🇺🇸 🇦🇱 🇦🇪 🇧🇾 🇧🇬 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 <br />
🇬🇧 🇺🇸 🇪🇪 🇫🇴 🇫🇮 🇫🇷 🇧🇪 🇨🇭 🇩🇪 🇦🇹 <br />
🇨🇭 🇬🇷 🇭🇺 🇮🇸 🇮🇪 🇮🇹 🇹🇯 🇱🇻 🇱🇹 🇲🇰 <br />
🇲🇹 🇲🇳 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇲🇩 🇷🇺 <br />
🇷🇸 🇷🇸 🇸🇰 🇸🇮 🇪🇸 🇸🇪 🇹🇷 🇺🇦

[Read more here][Localization]



## Features 

Even though KeyboardKit contains a lot of features, you can use its' extensions and views alone to simplify working with keyboard extensions. For instance, there are a bunch of `UITextDocumentProxy` extensions that make your life easier, and views that don't require you to use the rest of the library. 

Check out the demo apps and source code for examples and more information.


### 💥 Actions

KeyboardKit comes with many keyboard-specific actions, like `character` inputs, `emojis`, `backspace`, `space`, `newline`, `image` etc. You can even create your own actions.

[Read more here][Actions]


### 🎨 Appearance

KeyboardKit comes with an appearance engine that lets you easily style your keyboards.

[Read more here][Appearance]


### 🔊 Audio

KeyboardKit defines system audio types and ways to play them.

[Read more here][Audio-Feedback]


### 💡Autocomplete

KeyboardKit can present autocomplete suggestions as users type.

[Read more here][Autocomplete]


### 🗯 Callouts

KeyboardKit lets you show input callouts as users type, as well as action callouts with alternate actions for the currently pressed key.

[Read more here][Callouts]


### 😊 Emojis

KeyboardKit defines emojis and emoji categories that you can use in your own keyboards.

[Read more here][Emojis]


### 🧩 Extensions

KeyboardKit provides a bunch of extensions to native types.

[Read more here][Extensions]


### ⌨️ External Keyboards

KeyboardKit lets you detect whether or not an external keyboard is used.

[Read more here][External]


### 👋 Feedback

KeyboardKit keyboards can give audio and haptic feedback as users type. 

Read more about [audio feedback][Audio-Feedback] and [haptic feedback][Haptic-Feedback].


### 👆 Gestures

KeyboardKit comes with keyboard-specific gestures that you can use in your own keyboards.

[Read more here][Gestures]


### 👋 Haptics

KeyboardKit defines haptic feedback types and ways to trigger them.

[Read more here][Haptic-Feedback]


### 🔤 Input

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in different languages.

[Read more here][Input-Sets]


### ⌨️ Keyboard Layouts

KeyboardKit comes with a layout engine that makes it easy to create specific keyboard layouts for various devices, orientations and locales.

[Read more here][Keyboard-Layouts]


### 💱 Keyboard Types

KeyboardKit comes with many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own types.

[Read more here][Keyboard-Types]


### 🌐 Locales

KeyboardKit defines keyboard-specific locales and provides localized content for the supported locales.

[Read more here][Localization]


### 👁 Previews

KeyboardKit defines a bunch of preview-specific types that simplify previewing keyboard views in SwiftUI.

[Read more here][Previews]


### ➡️ Proxy

KeyboardKit defines a bunch of extensions to `UITextDocumentProxy` and ways to route text to other sources.

[Read more here][Proxy]


### ⬅️ RTL

KeyboardKit supports RTL (right-to-left) locales, but your extension need to be configured to support it.

[Read more here][RTL]


### 🎨 Styles

KeyboardKit defines a bunch of styles that simplify customizing the look of various keyboard components and buttons.

[Read more here][Styles]


### 🖼 Views

KeyboardKit comes with a bunch of keyboard-specific views, like keyboards, toobars, buttons etc

[Read more here][Views]



## KeyboardKit Pro

KeyboardKit Pro is a license-based extensions that unlocks pro features, such as additional locales, autocomplete, convenience views etc. It can save you a lot of time when developing more complex keyboards.

KeyboardKit Pro is also a way to support this project, which is otherwise completely free and developed by a single person (with great help from the community). If you appreciate this project, consider going Pro.  

Note that KeyboardKit Pro extends this library by using the same extension points as is available to everyone.

[Go Pro here!][Pro]



## Demo Application

This repository contains a demo app that lets you try out KeyboardKit and KeyboardKit Pro.

The standard keyboard demonstrates different system keyboards, like `alphabetical` (lowercased, uppercased and capslocked), `numerical`, `symbols` and `emojis`.

The "RTL" keyboard is the same as the standard keyboard, but with its Info.plist specifying RTL and an RTL primary language. 

The demo app is not intended to be production ready, but rather to give you inspiration. Just keep in mind that your keyboards can look anyway you like. They don't have to look like a system keyboard.

To run the demo app, open and run the `Demo/Demo.xcodeproj` project, then enable the keyboards under system settings. Enable full access to support all features, like audio and haptic feedback.



## Contact

KeyboardKit is developed by Daniel Saidi, with great help from the community.

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [info@getkeyboardkit.com][Email]
* Twitter: [@getkeyboardkit][Twitter]
* Web site: [getkeyboardkit.com][Website]



## Sponsors and Clients

This project is proudly sponsored by the following companies:

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

KeyboardKit is free, but please consider sponsoring the project if you find it useful. You can support KeyboardKit through [GitHub Sponsors][Sponsors], by signing up for a [Pro][Pro] license, paying for support, donations etc.



## License

KeyboardKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:info@getkeyboardkit.com
[Twitter]: https://twitter.com/getkeyboardkit
[Website]: https://getkeyboardkit.com
[Sponsors]: https://github.com/sponsors/danielsaidi
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE

[Actions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Actions.md
[Appearance]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Appearance.md
[Audio-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Callouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Callouts.md
[Emojis]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Emojis.md
[Extensions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Extensions.md
[External]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/External.md
[Gestures]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Gestures.md
[Getting-Started]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Getting-Started.md
[Haptic-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Input-Sets]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Layouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Layouts.md
[Keyboard-Types]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[Localization]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Localization.md
[Previews]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Previews.md
[Proxy]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Proxy.md
[RTL]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/RTL.md
[Styles]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Styles.md
[Views]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Views.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
