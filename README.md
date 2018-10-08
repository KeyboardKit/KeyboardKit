<p align="center">
    <img src ="Resources/Logo.png" width=400 />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/KeyboardKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FKeyboardKit.svg?style=flat" alt="Version" />
    </a>
    <img src="https://api.travis-ci.org/danielsaidi/KeyboardKit.svg" alt="Build Status" />
    <a href="https://cocoapods.org/pods/KeyboardKit">
        <img src="https://img.shields.io/cocoapods/v/KeyboardKit.svg?style=flat" alt="CocoaPods" />
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/carthage-supported-green.svg?style=flat" alt="Carthage" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" alt="Swift 4.2" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

`KeyboardKit` is a Swift library that lets you create custom keyboard extensions
for iOS. It supports several keyboard actions and lets you create keyboards with
text inputs, emojis, system actions and custom images.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>


## Installation

### CocoaPods

Add this to your `Podfile`, run `pod install` then remember to use the generated
workspace afterwards:

```
pod 'KeyboardKit'
```

### Carthage

Add this to your `Cartfile`, run `carthage update` then add the framework to the
app from `Carthage/Build`:

```
github "danielsaidi/KeyboardKit"
```

### Manual installation

To add `KeyboardKit` to your app without using Carthage or CocoaPods, clone this
repository and place it anywhere within your project folder. After that, add the
`KeyboardKit.xcodeproj` project to your project, select your app target then add
the `KeyboardKit` framework as an embedded binary (under `General`) and a target
dependency (under `Build Phases`).


## Features

### Keyboard actions

`KeyboardKit` comes with the following keyboard actions:

* `none`- used as empty placeholders
* `backspace` - sends a backspace to the text proxy
* `character` - a plain text character, system emoji or symbol
* `image` - custom images with a description, keyboard image and original image
* `newLine` - inserts a new line into the text proxy
* `nextKeyboard` - changes keyboard on tap and show the picker on long press
* `shift` - can be used to change the char casing of a keyboard
* `space` - inserts an empty space into the text proxy

`KeyboardKit` will handle all actions except `image` automatically with optional
overrides, if you want to customize the handling of one or several actions.

### `UIInputViewController` subclasses

`KeyboardKit` lets you create custom keyboard extensions in seveal ways, instead
of inheriting `UIInputViewController`:

* Inherit `KeyboardInputViewController` and use `xibs`
* Inherit `KeyboardInputViewController` and use the `Keyboard` class
* Inherit `GridKeyboardInputViewController` to create a grid-based keyboard
* Inherit `CollectionKeyboardInputViewController` to create a collection-based keyboard

The `GridKeyboardInputViewController` option is currently most powerful, but the
other options will give you basic functionality as well.

When you have your input view controller all setup, you just have to handle taps
and long presses by overriding `handleTap(on:)` and `handleLongPress(on:)`. Most
options will be automatically handled (with optional overrides), but images must
be manually handled, since there's no way to handle images natively in input vcs.

`KeyboardKit` also provides you with a `setHeight` function, that lets you set a
custom height to your keyboard extension.

#### `xib`-based keyboards

When you use `xib`s, inherit `KeyboardInputViewController` instead of the system `UIInputViewController` class. Then, you can just bind the buttons in your `xib`
to the desired keyboard actions.

#### `Keyboard`-based keyboards

When you use the `Keyboard` class, inherit `KeyboardInputViewController` instead
of the system `UIInputViewController` class. Then, you must layout your keyboard
manually with code. This is the least powerful option, but I will not judge.

#### `GridKeyboardInputViewController`-based keyboards

If you inherit `GridKeyboardInputViewController`, you will get a collection view
that distributes the actions in an even-sized grid. It will automatically enable
`horizontal scrolling` and display a page control if there are more buttons than
fits the screen. It also lets you setup `left` and `right` system buttons, which
are displayed below the collection view. 

You setup a `GridKeyboardInputViewController` by providing it with a keyboard, a
height (excluding a possible system row), how may button rows to display on each
page, and how many buttons to have on each row. This setup can be changed at any
time, e.g. when the device is rotated.

`GridKeyboardInputViewController` will automatically display a system button row
below the keyboard, if any of these criterias are met:

* `leftSystemButtons` contains at least one button
* `rightSystemButtons` contains at least one button
* there are more keyboard actions than fits one screen (displays a page control)
* the device does not display a system keyboard switcher (which iPhone X does)

The system button area height is added to the total height. By default, it is as
tall as the keyboard item size.

#### Need more features?

So far, `GridKeyboardInputViewController` is the only class I use in my own apps,
which means that it has much functionality that the others lack. This means that
you get much for free when you inherit it, but it also forces you to go with the
grid layout, which may not be for everyone.

If you use `KeyboardKit` and need these features elsewhere, we must extract them
out of `GridKeyboardInputViewController`.

### Keyboards

In `KeyboardKit`, a `Keyboard` is basically just a list of `KeyboardAction`s. It
is presented as is specified by the selected input view controller base class. A
xib-based approach is fully customizable, while the grid-based approach will use
a collection view with even-sized cells.

### Keyboard alerts

Since keyboard extensions cannot display `UIAlertController` alerts, KeyboardKit
comes with custom alerters that can display alerts ontop of the keyboard.

### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with this
kind of keyboard extensions. Most are internal and only used within the library,
but some are public and can e.g. be used to handle, save and export images. Have
a look at the example app for more information.


## Example Application

The easiest way to learn how to use `KeyboardKit` is to open the example app and
have a look at how it is implemented. It uses a couple of regular strings, a few
emojis, some images and a couple of system buttons.

The app uses a built-in `GridKeyboardInputViewController` base class, which uses
a collection view to distribute the keyboard buttons evenly in a grid. It can be
used in any keyboard extension. It uses custom cells, which means that it can be
entirely tailored to your needs.


## `IMPORTANT` - How to adding `KeyboardKit` to your extension

When you create your own keyboard extension and want to use `KeyboardKit` to get
up and running, you **have to** do the following:

* Create a new `Custom Keyboard Extension` target
* In the hosting app: Add KeyboardKit to Embedded Binaries
* In the extension: Add KeyboardKit to Linked Frameworks And Binaries
* Enable full access in the `Info.plist`, if your keyboard needs it


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