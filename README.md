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

`KeyboardKit` is a Swift library that helps you create keyboard extensions for iOS. It supports many keyboard actions and keyboard types and lets you create keyboards with text inputs, emojis, actions, images etc.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

With `KeyboardKit`, you inherit `KeyboardInputViewController` instead of `UIInputViewController`. This provides you with a `keyboardActionHandler` that can handle taps, long presses etc. and a `keyboardStackView` to which you can add components like toolbars, button rows and collection views. `KeyboardKit` also provides you with tools for haptic feedback, displaying alerts on top of the keyboard etc.


## Installation

### Swift Package Manager

The easiest way to add Sheeeeeeeeet to your project in Xcode 11 is to use Swift Package Manager:
```
https://github.com/danielsaidi/KeyboardKit.git
```

### CocoaPods

```ruby
target 'HostApp' do
  pod 'KeyboardKit'
end

target 'KeyboardExt' do
  pod 'KeyboardKit'
end
```

### Carthage

```
github "danielsaidi/KeyboardKit"
```

### Manual installation

To manually add `KeyboardKit` to your app, clone this repository, add `KeyboardKit.xcodeproj` to your project and `KeyboardKit.framework` as an embedded app binary and target dependency.


## Get Started

With `KeyboardKit`, your input view controllers should inherit from `KeyboardInputViewController` instead of `UIInputViewController`. It has a `keyboardStackView` to which you can add components like toolbars, button rows and even collection views The keuyboard extension will automatically be resized to fit the content of this stack view.


## Keyboard Actions

`KeyboardKit` comes with a set of actions that can be applied to your keyboard buttons, like `character`s, `backspace`, `newline`, `space`, `keyboard switcher`s etc.

Checkout [this guide][Keyboard-Actions] for more information about the available actions and how to use them.


## Keyboard Types

`KeyboardKit` comes with the following built-in keyboard types:

* `alphabetic(uppercase/lowercase)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `custom(name)`

These types are just keyboard representations, without any logic. You can bind them to a keyboard action to add buttons that switches between various keyboard types, but you have to implement the keyboards types yourself.


## Components

`KeyboardKit` comes with a set of component protocols that can be combined into complete keyboard, e.g. `vertical and horizontal components`, `buttons`, `button rows` etc.

Checkout [this guide][Components] for more information about the available components and how to use them.


## Views

`KeyboardKit` comes with a set of views that implement one or several of the component protocols above, e.g. `vertical and horizontal components`, `buttons`, `button rows` etc.

Checkout [this guide][Views] for more information about the available views and how to use them.


## Autocomplete

KeyboardKit supports autocomplete, which means that you can add a toolbar that displays autocomplete suggestions for the currently typed text and replaces text in your text document proxy when you tap a  suggestion. 

Checkout [this guide][Autocomplete] for more information about how to implement autocomplete in your keyboard.


## Alerts

Since keyboard extensions can't display `UIAlertController`s, you can use `KeyboardAlert` to alert messages on top of the keyboard. You can use the built-in `ToastAlert` or create a custom one.


## Haptic Feedback

`KeyboardKit` has a `HapticFeedback` type, that can be used to give the user haptic feedback as she/he uses the keyboard.  `HapticFeedback` defines a set of feedback types that wraps native feedback types like `selection changed`, `error`, `success` etc.

You can enable or disable haptic feedback by providing the `keyboardActionHandler` with a haptic feedback configuration. The default configuration is to disable haptic feedback.

`NOTE` that you have to enable open access for the keyboard for haptic feedback to work.


## Audio Feedback

`KeyboardKit` has an `AudioFeedback` type, that can be used to give the user audio feedback as she/he uses the keyboard.  `AudioFeedback` defines a set of feedback types that wraps native system sounds.

You can enable or disable audio feedback by providing the `keyboardActionHandler` with a audio feedback configuration. The default configuration is to play standard audio feedback.

`NOTE` that you have to enable open access for the keyboard for haptic feedback to work.


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
 
 You have to enable "full access" in keyboard settings for haptic feedback and the image keyboard to work.

To run the demo app, open and run the `KeyboardKit.xcodeproj` project.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Components]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Components.md
[Keyboard-Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Actions.md
[Views]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Views.md
