<p align="center">
    <img src ="Resources/Logo.png" width=400 />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/KeyboardKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FKeyboardKit.svg?style=flat" alt="Version" />
    </a>
    <a href="https://cocoapods.org/pods/KeyboardKit">
        <img src="https://img.shields.io/cocoapods/v/KeyboardKit.svg?style=flat" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/carthage-supported-green.svg?style=flat" alt="Carthage" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.0-orange.svg" alt="Swift 5.0" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

`KeyboardKit` is a Swift library that lets you create custom keyboard extensions for iOS. It supports various keyboard actions and lets you create dynamic keyboards with text inputs, emojis, system actions, images etc.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>


## Basic use case

When using `KeyboardKit`, you typically inherit from `KeyboardInputViewController` instead of `UIInputViewController`. This provides you with a `keyboardActionHandler` to which you can delegate keyboard actions like taps and long presses. You also get a `keyboardStackView` to which you can add various components like toolbars, button rows and entire collection views.


## Installation

### CocoaPods

Add this to your `Podfile` and run `pod install`:
```
pod 'KeyboardKit'
```
Then follow [these instructions](#add) on how to add it to your project.

### Carthage

Add this to your `Cartfile` and run `carthage update`:
```
github "danielsaidi/KeyboardKit"
```
Then follow [these instructions](#add) on how to add it to your project.

### Manual installation

To manually add `KeyboardKit` to your app, clone this repository and add `KeyboardKit.xcodeproj` to your project. Then, select the app target, add the `KeyboardKit` framework as an embedded binary (in `General`) and as a target dependency (in `Build Phases`) then follow [these instructions](#add) on how to add it to your project.

<a name="add"></a>
### Important - How to add KeyboardKit to your extension

When you create your own keyboard extension and want to use `KeyboardKit` in it, you must do the following:

* Create a new `Custom Keyboard Extension` target
* In the host app, add `KeyboardKit.framework` to `Embedded Binaries`
* In the extension, add `KeyboardKit.framework` to `Linked Frameworks And Binaries`
* Enable full access in your extension's `Info.plist`, if your keyboard needs it.


## Features


### Keyboards

In `KeyboardKit`, a `Keyboard` is basically a collection of `KeyboardAction`s, which you can use to model your custom keyboards. It has no action or rendering logic. You define this later, in your input view controller. This means that you can render and handle the same keyboard in many different ways.


### Keyboard actions

`KeyboardKit` comes with the following built-in keyboard actions:

* `backspace` - sends a backspace to the text proxy
* `capsLock` - can be used to lock the keyboard in upper case
* `character` - sends a text character to the text proxy
* `dismissKeyboard` - dismisses the keyboard
* `image` - has a description, keyboard image name and image name
* `moveCursorBack` - moves the cursor back one position
* `moveCursorForward` - moves the cursor forward one position
* `newLine` - sends a new line to the text proxy
* `shift` - can be used to toggle between upper and lower case
* `space` - sends an empty space to the text proxy
* `switchKeyboard` - triggers the default keyboard switcher
* `switchToNumericKeyboard` - can be used to switch to numbers
* `switchToSymbolKeyboard` - can be used to switch to symbols
* `none`- use this for empty "placeholder" keys that do nothing

These actions can be applied to the keyboard buttons. Some have standard behavior that apply to the input view controller or its text proxy, while others have no standard behavior.

`KeyboardInputViewController` has a `keyboardActionHandler` that should handle all actions that are triggered by the user. The `StandardKeyboardActionHandler` class is used by default, but you can replace it with any `KeyboardActionHandler` you like.


### Presentation

`KeyboardInputViewController` has a `keyboardStackView` that you can use to build create your keyboard. 

Since it's a regular `UIStackView`, you can populate it with any views, but the `KeyboardStackViewComponent` protocol can help you work with this stack view in a more well-defined way, since it simplifies setting a specific height for each component.

There are a bunch of built-in `KeyboardStackViewComponent`s, like the `KeyboardButtonRow` and `KeyboardCollectionView` views.

`KeyboardButtonRow` has a `buttonStackView` that you can setup in any way you like and populate with `KeyboardButtonRowComponent`s. It's a regular `UIStackView`, which means that you can distribute its content in any way you like.

`KeyboardCollectionView` is regular `UICollectionView`s that you can setup in any way you like and populate with any views you like. Since it's a regular `UICollectionView`, you can distribute its content in any way you like. You can use the `KeyboardButtonRowCollectionView` subclass to easily distribute a large numbers of actions in even rows that span over multiple pages if needed.


### Alerts

Since keyboard extensions can't display `UIAlertController`s, `KeyboardKit` has a `KeyboardAlert` protocol that can be used to alert messages on top of the keyboard. You can use the built-in `ToastAlert` or create a custom `KeyboardAlert` implementation.


### Haptic Feedback

`KeyboardKit` has support for haptic feedback, which means that you can use vibrations when the user types. The `HapticFeedback` enum defines a set of built-in feedback types that wraps the native iOS feedback types.


### Animations

If you want to animate the buttons as a user types, you can let your buttons implement the `KeyboardButton` protocol, which provides default press, release and tap animations.


### Extension height

The keyboard extension's height will automatically change to fit the `keyboardStackView`'s required height.


### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with keyboard extensions. Many are internal and only used within the library, but some are public and can be used to handle common logic, like saving and exporting images. Check out the example app for more information.


## Example Application

The easiest way to learn how to use `KeyboardKit` is to open the example app and have a look at how it is implemented. It uses a couple of regular strings, emojis, symbols, images and system buttons.

This app uses the built-in `GridKeyboardViewController`, but I will try to add more examples to the example app.


## Contact me

I hope you like this library. Feel free to reach out if you have questions or if
you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com](mailto:daniel.saidi@gmail.com)
* Twitter: [@danielsaidi](http://www.twitter.com/danielsaidi)
* Web site: [danielsaidi.com](http://www.danielsaidi.com)


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/