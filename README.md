<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/KeyboardKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FKeyboardKit.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" alt="Swift 5.1" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

`KeyboardKit` is a Swift library that helps you create custom keyboard extensions for iOS and ipadOS. It provides you with a set of keyboard-specific tools and actions, supports haptic and audio feedback and lets you create keyboards with characters, emojis, images, custom actions etc.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

If you're new to iOS keyboard extensions, [this great guide][Guide] can help you get started. You can also have a look at the demo app for examples on how to use this library. 


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
```


## Getting Started

After adding `KeyboardKit` to your project, make your extension inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides you with many tools that helps you build custom keyboard extension.

KeyboardKit supports both `UIKit` and `SwiftUI`, so you can pick the option that suits your needs best. `SwiftUI` support is currently kept in a separate library, but will be the main focus going forward.


## SwiftUI

Since version `2.7.0`, KeyboardKit supports `SwiftUI` with new tools that helps you build SwiftUI-based keyboards. 

SwiftUI will be the main focus going forward. The current plan is to improve the SwiftUI development experience in version `3` and move the tools to the main repo in `4`. When this happens, KeyboardKit will target iOS 13 and up.

Due to a [Swift toolchain bug][Bug], SwiftUI support must be kept in a separate library called [KeyboardKitSwiftUI][KeyboardKitSwiftUI]. This is hopefully temporary, until the bug is fixed. Until then, you must add both `KeyboardKit` and `KeyboardKitSwiftUI` if you want to use `KeyboardKit` with SwiftUI.


## Actions

KeyboardKit comes with a set of actions that can be applied to keyboard buttons or triggered programatically, like `character`, `emoji`, `backspace`, `newline`, `space`, `image` etc.

[Read more here][Actions]


## Keyboard Types

KeyboardKit comes with a set of keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc.

[Read more here][Keyboard-Types]


## Autocomplete

KeyboardKit provides autocomplete support, which means that your keyboard can display autocomplete suggestions that replace the current word when a user taps a suggestion. 

[Read more here][Autocomplete]


## Haptic Feedback

KeyboardKit supports haptic feedback, which means that users can get haptic feedback as they type.

[Read more here][Haptic].


## Audio Feedback

KeyboardKit supports audio feedback, which means that users can get audio feedback as they type.

[Read more here][Audio].


## Extensions

`KeyboardKit` comes with a bunch of keyboard-specific extensions. Many are internal and only used within the library, but some are public and can be used to handle common logic, like saving and exporting images. Check out the example app for more information.


## UIKit Components

KeyboardKit has many UIKit component and views that can be composed into UIKit-based keyboards, e.g. `vertical` and `horizontal components`, `button rows`, `collection views`, `toolbars` etc.

Check out [this component guide][Components] and [this view guide][Views] for more information.


## Demo Application

This repository contains a demo app that demonstrates different keyboard types, like `alphabetical` (lower/uppercased and caps locked), `numerical`, `symbols`, `emojis` and `images`.

Note that audio feedback, haptic feedback and image actions require full access. Also, the `image` switcher is only shown on notch devices.

To run the demo app, open and run the `KeyboardKit.xcodeproj` project.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Clients

KeyboardKit is proudly supported by:

[![Anomaly Software](Resources/logos/anomaly.png "Anomaly Software")](http://anomaly.net.au/)


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Actions.md
[Audio]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Audio.md
[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Components]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Components.md
[Haptic]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Haptic.md
[Keyboards]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboards.md
[Views]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Views.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
[Bug]: https://forums.swift.org/t/weak-linking-of-frameworks-with-greater-deployment-targets/26017/24
