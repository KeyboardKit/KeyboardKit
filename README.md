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

`KeyboardKit` is a Swift library that lets you create custom keyboard extensions for iOS. It supports several keyboard actions and lets you create keyboards with text inputs, emojis, system actions and images.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>


## Features


### Keyboards

In `KeyboardKit`, a `Keyboard` is basically just a list of `KeyboardAction`s with an optional id. The presentation depends entirely on which `keyboardActionHandler` the keyboard view controller uses and the action handling depends entirely on which `keyboardActionHandler` the view controller uses.


### Actions

`KeyboardKit` currently has the following keyboard actions:

* `backspace` - sends a backspace to the text proxy
* `character` - sends a text character to the text proxy
* `dismissKeyboard` - dismisses the keyboard
* `image` - custom images with a description, keyboard image
* `moveCursorBack` - moves the cursor back one position
* `moveCursorForward` - moves the cursor forward one position
* `newLine` - sends a new line to the text proxy
* `shift` - can be used to change the char casing of a keyboard
* `space` - sends an empty space to the text proxy
* `switchKeyboard` - changes keyboard on tap and shows keyboard picker on long press
* `none`- use this for empty "placeholder" keys that do nothing

Each keyboard view controller has a `keyboardActionHandler` that can handle any actions that are triggered by the user. By default, `StandardKeyboardActionHandler` is used, but you can replace it with any `KeyboardActionHandler` you like.


### View Controllers

`KeyboardKit` lets you create keyboard extensions by inheriting any of these classes instead of `UIInputViewController`:

* Inherit `KeyboardViewController` and use a `xib`
* Inherit `KeyboardViewController` and set it up with code
* Inherit `CollectionKeyboardViewController` to create a collection view-based keyboard
* Inherit `GridKeyboardViewController` to create a collection view-based keyboard with an even-sized grid

`GridKeyboardViewController` is the most powerful option so far, but also the least flexible. The other options give you more flexibility, but requires more work.

#### `xib`-based keyboards

You can inherit any of the view controllers above and create `xib`-based instances where you setup the keybpard in Interface Builder. When you do, you don't have to use the `keyboard` property, since you only have to bind the xib's buttons to actions that you then send to the action handler.

#### Code-based keyboards

If you don't want to use xib files, you can inherit any of the view controllers above and set them up entirely in code.

#### CollectionKeyboardViewController

This class inherits `KeyboardViewController` and extends it with a collection view that can present keyboard actions as cells. You have to subclass it and override `collectionView(cellForItemAt:)` to customize which cells to use. You also have to apply the layout you'd like to use, handle paging etc.

#### GridKeyboardViewController

This class inherits `CollectionKeyboardViewController` and extends it with a lot of logic that will render the keyboard actions in an even-sized grid. It automatically enables
horizontal scrolling and displays a page control if needed. It also lets you add system buttons below the collection view, that will stick if the user scrolls horizontally.

You create a `GridKeyboardViewController` instance by providing a keyboard, a height (not counting the optional system row), how many rows to display on each page and how many buttons to have on each row. This can be changed at any time, e.g. when the device is rotated.

`GridKeyboardViewController` will automatically display system buttons below the keyboard, if any of these criterias are met:

 * `leftSystemButtons` contains at least one button
 * `rightSystemButtons` contains at least one button
 * there are more keyboard actions than fits one screen (displays a page control)
 * the device does not display a system keyboard switcher (which iPhone X does)

The system button area height is then added to the total height. By default, it's as tall as the keyboard item size.


### Settings

Each keyboard view controller has a `settings` property that can be persist settings between app sessions. By default, `StandardKeyboardSettings` is used, but you can replace it with any `KeyboardSettings` implementation.


### Alerts

Since keyboard extensions can't display `UIAlertController`s, `KeyboardKit` has custom alerts that can be displayed on top of the keyboard. You can either use `ToastAlert` or build a custom alert that implements `KeyboardAlert`.


### Haptic Feedback

If you want the user's device to give haptic feedback as you type, you can use `HapticFeedback`, which wraps the various native iOS feedback types.


### Buttons

If you want to animate the keyboard buttons as the user types, you can let your views implement `KeyboardButton`, which has extensions for animating default presses, releases and taps.


### Extension height

The height of the extension will automatically change to the constraints of the views you add to it.


### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with this kind of keyboard extensions. Most are internal and only used within the library, but some are public and can e.g. be used to handle, save and export images. Have a look at the example app for more information.


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