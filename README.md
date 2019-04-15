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

`KeyboardKit` is a Swift library that lets you create custom keyboard extensions
for iOS. It supports several keyboard actions and lets you create keyboards with
text inputs, emojis, system actions and images.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>


## Features


### Keyboard actions

When you build custom keyboards with `KeyboardKit`, your keys can have different
actions. `KeyboardKit` comes with the following actions:

* `character` - sends a character, system emoji or symbol to the text proxy
* `backspace` - sends a backspace to the text proxy
* `newLine` - sends a new line to the text proxy
* `space` - sends an empty space to the text proxy
* `nextKeyboard` - changes keyboard on tap and shows keyboard picker on long press
* `shift` - can be used to change the char casing of a keyboard
* `image` - custom images with a description, keyboard image and original image
* `none`- use this for empty "placeholder" keys that do nothing

`KeyboardKit` handles all actions except `image`, which you must handle manually.
You can also override the default handling of one or all of the other actions.


### `UIInputViewController` subclasses

`KeyboardKit` lets you create custom keyboard extensions in seveal ways. Instead
of inheriting the standard `UIInputViewController`, you can:

* Inherit `KeyboardViewController` and use `xibs`
* Inherit `KeyboardViewController` and use the `Keyboard` class
* Inherit `CollectionKeyboardViewController` to create collection view-based keyboards
* Inherit `GridKeyboardViewController` to create grid-based keyboards

`GridKeyboardViewController` is most powerful, but the other view controllers do
give you more flexibility.

When you have a keyboard view controller all setup, you can handle taps and long
presses by overriding `handleTap(on:)` and `handleLongPress(on:)`. Most keyboard
options will be automatically handled (with optional overrides), but images must
be manually handled, since there's no way to send images to the text proxy.

`KeyboardKit` also provides you with a `setHeight` function, that lets you set a
custom height for the keyboard extension.

#### `xib`-based keyboards

To use a xib file to create keyboards, inherit `KeyboardsViewController` instead
of `UIInputViewController`, then bind the xib buttons to any desired actions.

#### `Keyboard`-based keyboards

To use the `Keyboard` class to create keyboards, inherit `KeyboardViewController`
instead of `UIInputViewController`, then layout your keyboard manually with code.

#### `GridKeyboardViewController`-based keyboards

If you inherit `GridKeyboardViewController`, you will get a collection view that
distributes the keyboard buttons in an even-sized grid. It automatically enables
horizontal scrolling and displays a page control if needed. It also lets you add
`left` and `right` system buttons below the collection view. 

You create a `GridKeyboardViewController` by providing a keyboard, a height (not
counting the optional system row), how many rows to display on each page and how
many buttons to have on each row. This can be changed at any time, e.g. when the
device is rotated.

`GridKeyboardViewController` will automatically display system buttons below the
keyboard, if any of these criterias are met:

 * `leftSystemButtons` contains at least one button
 * `rightSystemButtons` contains at least one button
 * there are more keyboard actions than fits one screen (displays a page control)
 * the device does not display a system keyboard switcher (which iPhone X does)

The system button area height is added to the total height. By default, it is as
tall as the keyboard item size.

#### Need more features?

So far, I only use `GridKeyboardViewController` in my own apps, which means that
it has much functionality that the others lack. This means that you get much for
free when you inherit it, but it also forces you to go with the grid layout.

If you use `KeyboardKit` and need these features elsewhere, we must extract them
out of `GridKeyboardViewController`.


### Keyboards

In `KeyboardKit`, a `Keyboard` is just a list of `KeyboardAction`s. The way it's
presented depends on the keyboard view controller. A xib-based approach is fully
customizable, while the grid-based uses a collection view with even-sized cells.


### Keyboard alerts

Since keyboard extensions can't display `UIAlertController` alerts, `KeyboardKit`
comes with custom alerts that can display alerts on top of the keyboard.


### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with this
kind of keyboard extensions. Most are internal and only used within the library,
but some are public and can e.g. be used to handle, save and export images. Have
a look at the example app for more information.


## Installation

### CocoaPods

Add this to your `Podfile`, run `pod install` then use the generated workspace:
```
pod 'KeyboardKit'
```
Then follow [these instructions](#add) on how to add it to your project.

### Carthage

Add this to your `Cartfile`, run `carthage update` then add the framework to the
app from `Carthage/Build`:
```
github "danielsaidi/KeyboardKit"
```
Then follow [these instructions](#add) on how to add it to your project.

### Manual installation

To manually add `KeyboardKit` to your app, clone this repository and place it in
your project folder, then add `KeyboardKit.xcodeproj` to the project, select the
app target, add the `KeyboardKit` framework as an embedded binary (in `General`)
and as a target dependency (in `Build Phases`).

Then follow [these instructions](#add) on how to add it to your project.

<a name="add"></a>
### Important - How to add KeyboardKit to your extension

When you create your own keyboard extension and want to use `KeyboardKit` to get
up and running, you **have to** do the following:

* Create a new `Custom Keyboard Extension` target
* In the hosting app: Add `KeyboardKit.framework` to `Embedded Binaries`
* In the extension: Add `KeyboardKit.framework` to `Linked Frameworks And Binaries`
* You must also enable full access in your `Info.plist`, if your keyboard needs it


## Example Application

The easiest way to learn how to use `KeyboardKit` is to open the example app and
have a look at how it is implemented. It uses a couple of regular strings, a few
emojis, some images and a couple of system buttons.

This app uses the built-in `GridKeyboardViewController`, which uses a collection
view to distribute the keyboard buttons evenly in a grid. It can be used in your
keyboard extensions as well, since it is fully customizable.


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