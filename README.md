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

KeyboardKit is a Swift library that helps you create custom keyboard extensions for `iOS` and `iPadOS`. It has tools for creating keyboards that mimic native keyboards, as well as entirely custom ones. You can use any views and use the tools in any way you like.

The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

The movie above demonstrates an extensions that mimics a native system keyboard. KeyboardKit lets you create rich system keyboards like that with support for multiple locales, multi-gestures, secondary action callouts etc. 

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

You should then inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides you with a lot of additional functionality, e.g. extra properties like `keyboardContext`, `keyboardActionHandler`, `keyboardAppearance` etc. The extension will also get access to autocomplete logic, extensions and much more. 

`KeyboardInputViewController` has a `setup(with:)` function that can be used to setup your extension with any `SwiftUI` view. This will make it the main view of the extension, inject necessary environment objects and resize the keyboard extension to fit the view.

Have a look at the demo application and read more below to see how it all fits together.



## SwiftUI vs. UIKit

KeyboardKit supports both `SwiftUI` and `UIKit`, but SwiftUI is the main focus going forward. The rest of this readme assumes that you're using SwiftUI. You can read more about UIKit support [here][UIKit].

### Important about SwiftUI previews

KeyboardKit contains color and text resources that are embedded within the Swift Package. However, external SwiftUI previews can't access these resources, since the `.module` bundle isn't defined outside of this package. This makes the previews crash. 

Until this is solved in SwiftUI and SPM, call `KeyboardPreviews.enable()` in each preview to use fake colors and texts that don't break the preview.



## 🇸🇪 Localization

KeyboardKit is localized in the following languages:

* 🇺🇸 English (US - Default)

* 🇩🇰 Danish
* 🇳🇱 Dutch
* 🇬🇧 English (UK)
* 🇫🇮 Finnish
* 🇫🇷 French
* 🇩🇪 German
* 🇮🇹 Italian
* 🇳🇴 Norwegian
* 🇪🇸 Spanish
* 🇸🇪 Swedish

KeyboardKit also supports localized keyboards, where the keyboard layout, secondary actions etc. behave just like they should for a certain locale.

[Read more here][Localization]



## Features 


### 📦 Extensions & Views

Even though KeyboardKit contains a lot of features, you can use its' extensions and views alone to simplify working with keyboard extensions. For instance, there are a bunch of `UITextDocumentProxy` extensions that make your life easier, and views that don't require you to use the rest of the library. 

Check out the demo apps and source code for examples and more information.


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


### 🎨 Appearances

KeyboardKit lets you style your custom keyboards with custom appearances.

[Read more here][Appearance]


### 🗯 Callouts

KeyboardKit lets you show callout bubbles as users type, as well as secondary action callouts with optional actions.

[Read more here][Callouts]


### 💡Autocomplete

KeyboardKit can present autocomplete suggestions as users type. The core library doesn't come with an implemented engine, but you can inject your own. 

[KeyboardKit Pro][Pro] adds a localized autocomplete engine that provides localized suggestions.

[Read more here][Autocomplete]


### ✋ Haptic Feedback

KeyboardKit keyboards can give haptic feedback as users type. 

[Read more here][Haptic-Feedback].


### 🔈 Audio Feedback

KeyboardKit keyboards can give audio feedback as users type. 

[Read more here][Audio-Feedback].



## Demo Application

This repository contains a demo app that demonstrates different keyboards, like `alphabetical` (lowercased, uppercased and capslocked), `numerical`, `symbols`, `emojis` and `images`. It's not intended to be production ready, but rather to give you inspiration to how you can build your own keyboards.

To run the demo app, open and run the `Demo/Demo.xcodeproj` project, then enable the keyboards under system settings. Enable full access to support all features, like audio and haptic feedback.



## KeyboardKit Pro

KeyboardKit Pro is a license-based extensions that unlocks pro features, such as additional locales and an autocomplete engine. Going pro is also a way to support this project. 

[Go Pro here!][Pro]



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

You can support KeyboardKit by sponsoring the project on [GitHub Sponsors][Sponsors], signing up for a [KeyboardKit Pro][Pro] license or hiring me for consultation.


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
