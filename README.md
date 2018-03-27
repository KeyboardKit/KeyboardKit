<p align="center">
    <img src ="Resources/Logo.png" width=400 />
</p>

<p align="center">
    <a href="https://github.com/ellerbrock/open-source-badge/">
        <img src="https://badges.frapsoft.com/os/mit/mit.svg?v=102" alt="MIT License" />
    </a>
    <a href="http://badge.fury.io/gh/danielsaidi%2FSheeeeeeeeet">
        <img src="https://badge.fury.io/gh/danielsaidi%2FSheeeeeeeeet.svg" alt="Current Version" />
    </a>
    <a href="https://travis-ci.org/danielsaidi/Sheeeeeeeeet">
        <img src="https://api.travis-ci.org/danielsaidi/Sheeeeeeeeet.svg" alt="Build Status" />
    </a>
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>


Welcome to `KeyboardKit` - a Swift library that helps you create custom keyboard
extensions for iOS. It supports a wide range of keyboard actions, which lets you
create rich keyboards with text inputs, emojis, system actions...and even images.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>


## Features

### Keyboard actions

`KeyboardKit` comes with support for the following keyboard actions:

* `none`- used as empty placeholders
* `backspace` - sends a backspace to the text proxy
* `character` - a plain text character, system emoji or symbol
* `emoji` - custom (image-based) emojis
* `newLine` - inserts a new line into the text proxy
* `nextKeyboard` - changes keyboard on tap and show the picker on long press
* `shift` - can be used to change the char casing of a keyboard
* `space` - inserts an empty space into the text proxy

The `emoji` action should probably be called something else, since it isn't real
emojis, but rather custom image-based ones.

### Improved `UIInputViewController`s

`KeyboardKit` lets you create custom keyboard extensions in seveal ways, instead
of inheriting `UIInputViewController`:

* Use a xib to layout your keyboard, then bind the buttons to the desired actions.
* Inherit `GridKeyboardInputViewController` to create a grid-based keyboard.
* Inherit `CollectionKeyboardInputViewController` to create a collection-based keyboard.
* Inherit `KeyboardInputViewController` to get a basic set of keyboard logic and features.

After you setup an input view controller as it requires, you just have to handle
taps and long presses by overriding `handleTap(on:)` and `handleLongPress(on:)`.
The base classes will take care of most actions, but emojis must be handled in a
way that is specific to your app.

The base classes also provides a `setHeight` function that lets you set a custom
height to your keyboard extension.

You can override most functions in these base classes if you have to. Please see
the example app for more information and an example on how to use `KeyboardKit`.

#### `xib`-based keyboards

When you design your custom keyboard extension with a `xib`, you can inherit the `KeyboardInputViewController` class instead of the basic `UIInputViewController`.
You will then get basic action and gesture handling, but without any extra stuff.

#### `GridKeyboardInputViewController`

If you inherit `GridKeyboardInputViewController`, you will get a collection view
that distributes the actions in an even-sized grid. It will automatically enable
`horizontal scrolling` and a `page control` if there are more buttons than fit a
screen. This vc also lets you setup `left` and `right` system buttons, which are
displayed below the collection view. 

You setup a `GridKeyboardInputViewController` by giving it a keyboard, then tell
it how tall you want the extension to be, how may button rows to display on each
page, and how many buttons to display on each row:

```swift
open func setup(
    withKeyboard keyboard: Keyboard, 
    height: CGFloat, 
    rowsPerPage: Int, 
    buttonsPerRow: Int) 
```

Sometimes, an additional button row can be presented below the keyboard. This is
a `system button row`, and is displayed if any of these criterias are met:

* `leftSystemButtons` contains at least one button OR
* `rightSystemButtons` contains at least one button OR
* there are more keyboard actions than fits one screen
* the device doesn't display a system keyboard switcher (iPhone X does)

The system area height is added to the desired height. By default, it is as tall
as a keyboard button.

So far, `GridKeyboardInputViewController` is the only class I use in my own apps,
which means that it has much functionality that the others lack. This means that
you get much for free when you inherit it, but it also forces you to go with the
grid layout. If you use `KeyboardKit` and need these features elsewhere, we must
extract them out of `GridKeyboardInputViewController`.

### Keyboards

In `KeyboardKit`, a `Keyboard` is basically just a list of `KeyboardAction`s. It
can be created as such:

```swift
let keyboard = Keyboard(actions: [
    .backspace,
    .character("a"),
    .emoji(emojiName: "flower", keyboardImageName: "ic-flower", imageName: "ic-flower-large"),
    .newLine,
    .nextKeyboard,
    .shift,
    .space
])
```

How a keyboard is later presented is up to the input view controller. If you use
xibs, you will probably not even need to create a `Keyboard` instance, since all
you'll probably want then is to bind xib buttons to a certain action. If you use
the collection-based view controllers, however, you have to pass a keyboard into
them. Their layout then determines how the keyboard is rendered.

### Keyboard alerts

Since keyboard extensions cannot display `UIAlertController` alerts, KeyboardKit
comes with custom alerters that can display alerts ontop of the keyboard.

### Extensions

`KeyboardKit` comes with a bunch of extensions that simplifies working with this
kind of keyboard extensions. Most are internal and only used within the library,
but some are public and can e.g. be used to handle, save and export images. Have
a look at the example app for more information.


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