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

KeyboardKit is a Swift library that helps you create custom keyboard extensions for `iOS` and `ipadOS`.

KeyboardKit provides you with `actions`, `input sets` and `layouts`, `appearances` and `autocomplete` support, `haptic` and `audio` feedback etc. It lets you create keyboards with `characters`, `numbers`, `symbols`, `emojis`, `images` and more or just use the additional `tools` and `extensions` that it provides. 

The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo app for inspiration.


## Installation

### Swift Package Manager

```
https://github.com/KeyboardKit/KeyboardKit.git
```

### CocoaPods

```ruby
target 'MyApp' do
  pod 'KeyboardKit'
end

target 'MyKeyboard' do
  pod 'KeyboardKit'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
      end
   end
end
```


## Getting Started

To build a keyboard extension with KeyboardKit, add `KeyboardKit` to your project as shown above.

If you use Swift Package Manager, make sure to add KeyboardKit to your *keyboard extension*. You can add it to your hosting app as well, but the keyboard extension must have it.

You can then `import KeyboardKit` and let your `KeyboardController` inherit `KeyboardInputViewController` instead of `UIInputViewController`. It's a KeyboardKit-specific controller that provides you with a lot of additional functionality that extends the native keyboard framework. Your controller will get a bunch of extra properties, like `keyboardContext`, `keyboardActionHandler`, `keyboardAppearance` etc. and the extension will get access to autocomplete logic, extensions and much, much more. 

`KeyboardInputViewController` has a `setup(with:)` function that can be used to setup your extension with any `SwiftUI` view. This will make the view the main view of the extension, inject necessary environment objects and finally resize the keyboard extension to fit the view. 

To learn more about and see KeyboardKit in practice, continue reading about the various parts of the library below and have a look at the demo app to see how it sets up a custom `keyboardView` and adjusts it depending on the keyboard type, locale etc.


## Go Pro!

KeyboardKit Pro is a license-based extensions that unlocks pro features, such as additional locales. Going pro is also a way to support this project. [Read more here][Pro]. 

KeyboardKit Pro is enabled by default in the demo app. It gives the demo app access to many locales and a fully functional autocomplete engine. 


## SwiftUI vs. UIKit

KeyboardKit supports both `SwiftUI` and `UIKit`, but SwiftUI is the main focus going forward. 

You can read more about UIKit support [here][UIKit]. The rest of this readme assumes that you're using SwiftUI, although most information is valid for both UIKit and SwiftUI.

### Important about SwiftUI previews

KeyboardKit contains color and text resources that are embedded within the Swift package and CocoaPods Pod. However, SwiftUI previews outside the original package cannot access there resources, since the `.module` bundle isn't defined. 

Until this is solved in SwiftUI and SPM, call `KeyboardPreviews.enable()` in each preview to use fake colors and texts that don't break the preview.  


## Features


### 💥 Keyboard Actions

KeyboardKit comes with many keyboard-specific actions, like `character` inputs, `emojis`, `backspace`, `space`, `newline`, `image` etc. You can even create your own actions.

[Read more here][Keyboard-Actions]


### 😊 Keyboard Types

KeyboardKit comes with many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own types.

[Read more here][Keyboard-Types]


### 🔤 Input Sets

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in different languages.

[Read more here][Input-Sets]


### ⌨️ Keyboard Layouts

KeyboardKit comes with a layout engine that makes it easy to create specific keyboard layouts for various devices, orientations and locales.

[Read more here][Keyboard-Layouts]


### 🇸🇪 Localization

KeyboardKit comes with built-in support for English keyboards and can be easily extended to support more locales. 

KeyboardKit also has a `KKL10n` enum that provides localized texts.

[Read more here][Localization]


### 🎨 Appearances

KeyboardKit lets you create everything from completely custom keyboards to keyboards that imitate the native keyboards and can be styled with custom appearances.

[Read more here][Appearance]


### 🗯 Callouts

KeyboardKit lets you show callout bubbles as the users type, as well as secondary action callouts that can provide users with optional actions when long pressing a keyboard button.

[Read more here][Callouts]


### 💡Autocomplete

KeyboardKit can present autocomplete suggestions to users as they type. The core library doesn't come with an implemented engine, but you can inject your own. 

[Read more here][Autocomplete]


### ✋ Haptic Feedback

KeyboardKit keyboards can give users haptic feedback as they type. 

[Read more here][Haptic-Feedback].


### 🔈 Audio Feedback

KeyboardKit keyboards can give users audio feedback as they type. 

[Read more here][Audio-Feedback].


### 📦 Extensions

KeyboardKit comes with many keyboard-specific extensions, like providing the text document proxy with powerful, otherwise missing functionalty etc. Check out the demo apps and source code for examples and more information.


## Demo Application

This repository contains a demo app that demonstrates different keyboards, like `alphabetical` (lowercased, uppercased and capslocked), `numerical`, `symbols`, `emojis` and `images`.

The demo app is not intended to be production ready or provide pixel perfection, but rather to give you inspiration to how you can build your own keyboards.

To run the demo app, open and run the `Demo/Demo.xcodeproj` project, then enable the keyboards under system settings. Enable full access to support all features, like audio and haptic feedback.


## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@keyboardkitapp][Twitter]
* Web site: [getkeyboardkit.com][Website]


## Sponsors and Clients

This project is proudly sponsored by the following individuals and companies:

* [@booch](https://github.com/booch)

<a href="https://www.oribi.se/en">
    <img src="Resources/logos/oribi.png" alt="Oribi Logo" title="Oribi" width=150 />
</a>
<a href="http://anomaly.net.au">
    <img src="Resources/logos/anomaly.png" alt="Anomaly Software Logo" title="Anomaly Software" width=150 />
</a>
<a href="https://www.milocreative.com">
    <img src="Resources/logos/milo.png" alt="Milo Creative Logo" title="Milo Creative" width=150 />
</a>

You can support my work by sponsoring the project on [GitHub Sponsors][Sponsors] or hiring me for consultation. I'd be happy to help you out in any way that I can.


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/keyboardkitapp
[Website]: https://getkeyboardkit.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

[Appearance]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Appearance.md
[Audio-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Callouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Callouts.md
[Haptic-Feedback]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Input-Sets]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Actions]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Actions.md
[Keyboard-Layouts]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Layouts.md
[Keyboard-Types]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[Localization]: https://github.com/KeyboardKit/KeyboardKit/blob/master/Readmes/Localization.md

[UIKit]: https://github.com/KeyboardKit/KeyboardKit/blob/master/UIKit/README.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
