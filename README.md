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

`KeyboardKit` is a Swift library that helps you create custom keyboards for iOS. It supports a different actions and keyboard types and lets you create keyboards with characters, emojis, images, custom actions etc.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

If you're new to iOS keyboard extensions, [this great guide][Guide] can help you get started. You can also have a look at the demo app for some examples on how you can use this library. 


## Installation

### Swift Package Manager

The easiest way to add KeyboardKit to your project is to use Swift Package Manager:
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

### Carthage

```
github "danielsaidi/KeyboardKit"
```


## Get Started

`KeyboardKit` has a `KeyboardInputViewController`, which you should inherit instead of `UIInputViewController`. It will provide you with many tools, like an action handler handles gestures on various keyboard actions, a stack view that helps you layout your keyboards in a way that automatically resizes the extension etc.

KeyboardKit also has an extensive model and many keyboard-specific tools, like standard handling of a range of actions, gesture recognizion, haptic and audio feedback, alerts, autocompletion etc.

KeyboardKit supports both `UIKit` and `SwiftUI`, so you can pick the option that suits your needs best. `SwiftUI` support is currently limited, but will be the main focus going forward.

Have a look at the demo app for more information and examples.


## Actions

KeyboardKit comes with a set of actions that can be applied to your keyboard buttons, like `character` input, `backspace`, `newline`, `space`, `keyboard switcher`s etc.

Check out [this action guide][Keyboard-Actions] for more information about available actions and how to use them.


## Keyboard Types

`KeyboardKit` comes with the following built-in keyboard types:

* `alphabetic(uppercase/lowercase)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `custom(name)`

You can bind these types to keyboard buttons to let the user switch between different keyboard types. However, since they have no universal meaning but rather refer to a kind of keyboard, you have to implement the corresponding keyboards yourself.


## UIKit

KeyboardKit has many UIKit component that can be composed into keyboards, e.g. `vertical and horizontal components`, `button rows`, `collection views`, `toolbars` etc.

Check out [this component guide][Components] and [this view guide][Views] for information on how to use these views and components in UIKit-based keyboard extensions.


## SwiftUI

Since version `2.7.0`, KeyboardKit has support for `SwiftUI`, with new tools and views that helps you build keyboards in SwiftUI.

SwiftUI will be a major boost for KeyboardKit, but currently contains a tiny set of views and components, like `buttons`, a `grid`, extensions etc.

Due to a [Swift toolchain bug][Bug], SwiftUI support sadly have had to be moved to a separate library: [KeyboardKitSwiftUI][KeyboardKitSwiftUI]. This is hopefully temporary, but until the bug is fixed, you have to add both `KeyboardKit` and `KeyboardKitSwiftUI` yo your SwiftUI-based keyboard.

Please have a look at the [KeyboardKitSwiftUI][KeyboardKitSwiftUI] repo for more information about the SwiftUI-based parts of the library.


## Autocomplete

KeyboardKit supports autocomplete, which means that your keyboard can have a toolbar that displays autocomplete suggestions and use it to replace the current text in the text document proxy when a user taps a suggestion. 

Check out [this guide][Autocomplete] for more information about how to implement autocomplete.


## Alerts

Since keyboard extensions can't display alerts, you can use `KeyboardAlert` to alert messages on top of the keyboard. You can use the built-in `ToastAlert` or create a custom one.


## Haptic Feedback

KeyboardKit has a `HapticFeedback` enum that can be used to give users haptic feedback as they type. It defines native feedback types like `selection changed`, `error`, `success` and makes them easily triggered.

You can enable or disable haptic feedback by providing the `keyboardActionHandler` with a haptic feedback configuration. The default configuration is `none`, which means that no haptic feedback is used.

Note that you have to enable open access for the keyboard for haptic feedback to work.


## Audio Feedback

KeyboardKit has an `AudioFeedback` enum that can be used to give users audio feedback as they type. It defines native system sounds and makes them easily triggered.

You can enable or disable audio feedback by providing the `keyboardActionHandler` with a audio feedback configuration. The default configuration is `standard`, which means that standard audio feedback will be triggered as users type.

Note that you have to enable open access for the keyboard for audio feedback to work.


## Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with keyboard extensions. Many are internal and only used within the library, but some are public and can be used to handle common logic, like saving and exporting images. Check out the example app for more information.


## Demo Application

This repository contains a demo app that demonstrates different kinds of keyboards, including:

 * Alphabetical (lower + upper-case)
 * Numerical
 * Symbols
 * Emojis
 * Images
 
To keep the keyboard layout nice, the image switcher key is only displayed on notch devices, since they don't have to display a next keyboard button.
 
Note that you have to enable open access in keyboard settings for haptic feedback and image actions to work.

To run the demo app, open and run the `KeyboardKit.xcodeproj` project.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Clients

KeyboardKit is proudly supported by the following clients:

[![Anomaly Software](Resources/logos/anomaly.png "Anomaly Software")](http://anomaly.net.au/)


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Components]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Components.md
[Keyboard-Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Actions.md
[Views]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Views.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
[Bug]: https://forums.swift.org/t/weak-linking-of-frameworks-with-greater-deployment-targets/26017/24
