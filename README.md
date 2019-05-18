<p align="center">
    <img src ="Resources/Logo.png" width=600 />
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

`KeyboardKit` is a Swift library that simplifies creating keyboard extensions for iOS. It supports many keyboard actions and keyboard types and lets you create keyboards with text inputs, emojis, actions, images etc.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

With `KeyboardKit`, you inherit `KeyboardInputViewController` instead of `UIInputViewController`. This provides you with a `keyboardActionHandler` that can handle taps, long presses etc. and a `keyboardStackView` to which you can add components like toolbars, button rows and collection views. `KeyboardKit` also provides you with tools for haptic feedback, displaying alerts on top of the keyboard etc.


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


### Keyboard Actions

`KeyboardKit` comes with the following built-in actions, that can be applied to your keyboard buttons:

* `backspace` - sends a backspace to the text proxy
* `capsLock°` - can be used to lock the keyboard in upper case
* `character` - sends a text character to the text proxy
* `dismissKeyboard` - dismisses the keyboard
* `image` - has a description, keyboard image name and image name
* `moveCursorBackward°` - moves the cursor back one position
* `moveCursorForward°` - moves the cursor forward one position
* `newLine` - sends a new line to the text proxy
* `shift°` - can be used to toggle between upper and lower case
* `shiftDown°` - can be used to toggle between upper and lower case
* `space` - sends an empty space to the text proxy
* `switchKeyboard` - triggers the default keyboard switcher
* `switchToKeyboard(type)°` - can be used to switch to a specific keyboard type
* `none`- use this for empty "placeholder" keys that do nothing

Many actions have standard behavior that apply to the input view controller or its text proxy, but the ones that are marked with a ° require custom handling, since their behavior depend on your application.

`KeyboardInputViewController` has a `keyboardActionHandler` to which you should delegate all actions. It uses a `StandardKeyboardActionHandler` by default, but you can replace with any `KeyboardActionHandler` you like.


### Keyboard Types

`KeyboardKit` comes with the following built-in keyboard types:

* `alphabetic(uppercase/lowercase)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `custom(name)`

These types are just representations, without any built-in logic. You can bind them to keyboard actions to let you add buttons that switches between various keyboard types, but you have to implement the keyboards yourself.

If your app uses a keyboard type that isn't represented in the list above, you can use `.custom` with a custom name.


### Presentation

`KeyboardInputViewController` has a `keyboardStackView`, to which you can add components like toolbars, button rows and collection views. It's a regular `UIStackView`, so you can configure it however you like. The extension will be resized to fit the content of this stack view.

The `KeyboardStackViewComponent` protocol can be implemented by any view that can be added to the main `keyboardStackView`. It simplifies setting the height in a way that resizes the extension properly.

`KeyboardButtonRow` is a `KeyboardStackViewComponent` that displays buttons in a horizontal `buttonStackView`. Just like the main stack view, it's a regular `UIStackView`, so you can configure it in any way you like. 

The `KeyboardButtonRowComponent` protocol can be implemented by any view that can be added to a `KeyboardButtonRow`. It simplifies setting the width in a way that makes it honor the distribution of the stack view. `KeyboardButton`, `KeyboardButtonView` and `KeyboardSpacerView` are built-in row components, that you can use right away.

`KeyboardCollectionView` is a regular `UICollectionView` that you can configure in any way you like. You can use the built-in `KeyboardButtonCollectionView` and `KeyboardButtonRowCollectionView` subclasses to easily distribute a set of actions within the collection view.

Since all these components are regular views, you can use them in your hosting application as well.


### Alerts

Since keyboard extensions can't display `UIAlertController`s, you can use `KeyboardAlert` to alert messages on top of the keyboard. You can use the built-in `ToastAlert` or create a custom one.


### Haptic Feedback

`KeyboardKit` has a set of `HapticFeedback` variants, that can be used to give the user haptic feedback as she/he uses the keyboard. The `HapticFeedback` enum defines a set of haptic feedback types that wraps native iOS feedback types like `selection changed`, `error`, `success` etc.


### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with keyboard extensions. Many are internal and only used within the library, but some are public and can be used to handle common logic, like saving and exporting images. Check out the example app for more information.


## Demo Application

`KeyboardKit` contains a demo app that contains different kind of keyboards, like numeric keyboards, system keyboards, row-based keyboards and a grid-based emoji keyboard.


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
