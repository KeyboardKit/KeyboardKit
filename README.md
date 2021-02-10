# KeyboardKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/danielsaidi/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

KeyboardKit is a Swift library that helps you create custom keyboard extensions for `iOS` and `ipadOS`.

KeyboardKit provides you with a rich set of `tools` and `actions`, `input sets` and `layouts`, `appearances` and `autocomplete`, `haptic` and `audio` feedback etc. It lets you create keyboards with `characters`, `numbers`, `symbols`, `emojis`, `images` and more, or entirely custom ones that make use of the vast additional functionality that this library provides. The end result can look something like this...or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

KeyboardKit supports both `UIKit` and `SwiftUI`, but SwiftUI is the main focus going forward. You can read more about UIKit support [here][UIKit]. The rest of this readme assumes that you're using SwiftUI, although most information is valid for both UIKit and SwiftUI.

If you're new to iOS keyboard extensions, [this great guide][Guide] will help you get started. You can also have a look at the demo app for inspiration.


## Installation

### Swift Package Manager

```
https://github.com/danielsaidi/KeyboardKit.git
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

To build a keyboard extension with KeyboardKit, start with adding `KeyboardKit` to your project as shown above. 

You should then let your `KeyboardViewController` inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides your extension with many convenient services, tools and extensions.

`KeyboardInputViewController` has a bunch of services and tools that extends the native keyboard framework. For instance, `keyboardContext` provides your extension with contextual information, `keyboardActionHandler` can be used to handle keyboard-specific actions and gestures and `keyboardLayoutProvider` can provide you with keyboard layouts etc. There are many more tools here, as well as extensions that extend types like `UITextDocumentProxy` with more functionality. 

`KeyboardViewController` has a `setup(with:)` function which can be used to setup your extension with any `SwiftUI` view. This will wire up everything and provide the view with the necessary environment objects, then resize the keyboard extension to fit the view. 

To learn more about KeyboardKit and see it in practice, continue reading about the various parts of the library below, follow the [tutorial][Tutorial] and have a look at the demo app.


## Actions

KeyboardKit supports many different keyboard-specific actions, like `character` inputs, `emojis`, `backspace`, `space`, `newline`, `image` etc. You can even create your own, custom actions.

[Read more here][Actions]


## Keyboard Types

KeyboardKit supports many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own, custom keyboard types.

[Read more here][Keyboard-Types]


## Input Sets

KeyboardKit provides you with locale-specific input sets, which makes it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in many languages.

[Read more here][Input-Sets]


## Layouts

KeyboardKit can combine an input set with surrounding actions to create a keyboard layout, which provides you with the total set of keyboard action as well as their sizes.

[Read more here][Keyboard-Layouts]


## Appearances

KeyboardKit lets you create everything from completely custom keyboards to keyboards that imitate the native keyboards and can be styled with custom appearances.

[Read more here][Appearance]


## Callouts

KeyboardKit lets you show callout bubbles as the users type, as well as secondary action callouts that can provide users with optional actions when long pressing a keyboard button.

[Read more here][Callouts]


## Emojis

KeyboardKit contains emoji categories and keyboard views that let you present emojis like the native keyboards do.

[Read more here][Emojis]


## Autocomplete

KeyboardKit can present autocomplete suggestions to users as they type. The core library doesn't come with an implemented engine, but you can inject your own. 

[Read more here][Autocomplete]


## Haptic Feedback

KeyboardKit supports haptic feedback and can give users haptic feedback as they type. 

[Read more here][Haptic-Feedback].


## Audio Feedback

KeyboardKit supports audio feedback and can give users audio feedback as they type. 

[Read more here][Audio-Feedback].


## Localization

KeyboardKit supports multiple locales. You can easily implement and inject your own localized services if the library doesn't support your specific locale. 

[Read more here][Localization]


## Resources & Assets

KeyboardKit comes with colors and images that makes it really easy to create native-looking, dazzling keyboards. 

[Read more here][Resources]


## Extensions

KeyboardKit comes with many keyboard-specific extensions, like providing the text document proxy with powerful, otherwise missing functionalty. Check out the demo apps and source code for examples and more information.


## Demo Applications

This repository contains a demo app that demonstrates different keyboards, like `alphabetical` (lowercased, uppercased and capslocked), `numerical`, `symbols`, `emojis` and `images`.

The demo app is not intended to be production ready or provide pixel perfection, but rather to give you inspiration to how you can build your own keyboards.

To run the demo app, open and run the `Demo/Demo.xcodeproj` project, then enable the keyboards under system settings. Enable full access to support all features, like audio and haptic feedback.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Sponsors and Clients

This project is proudly sponsored by the following individuals and companies:

* [@booch](https://github.com/booch)

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
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Actions.md
[Appearance]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Appearance.md
[Audio-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Haptic-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Callouts]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Callouts.md
[Emojis]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Emojis.md
[Gestures]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Gestures.md
[Input-Sets]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Layouts]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Layouts.md
[Keyboard-Types]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[Localization]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Localization.md
[Resources]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Resources.md
[SwiftUI]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI.md
[Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI-Tutorial.md

[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/UIKit/README.md
[UIKit-Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/UIKit/Tutorial.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide

[Anomaly]: http://anomaly.net.au
[Milo]: https://www.milocreative.com
