# KeyboardKit

[![CI Status](http://img.shields.io/travis/danielsaidi/KeyboardKit.svg?style=flat)](https://travis-ci.org/danielsaidi/KeyboardKit)
[![Version](https://img.shields.io/cocoapods/v/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)
[![License](https://img.shields.io/cocoapods/l/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)


KeyboardKit is a Swift library for iOS keyboard extension apps. It is currently
limited to the functionality I need in my own two emoji keyboard extension apps,
but I will extend it as I add more stuff to these apps.



## Getting started

I have currently not had time to setup a demo that shows how you build a custom
keyboard extension app on top of this library. For now, have a look at the code
and try to make sense of these instructions.

To create a custom keyboard, either inherit the `EmojiKeyboard` class (the only
one that I currently use) or create one that implements the `Keyboard` protocol,
then implement all keyboard functionality you need. Keyboards should be able to
setup themselves in a view, and for now (since I don't have the design all done
yet) a keyboard must also implement functionality for saving and copying images,
but these functions should really just be needed for emoji keyboards. This will
no doubt change in future versions of KeyboardKit.

To present your keyboard in an iOS keyboard extension, add a keyboard extension
project to your app. Let the input view controller of the extension inherit the 
`KeyboardInputViewController` class. Your subclass should as a minimum override 
`createKeyboard()`, so that the base class knows which keyboard to use, and use
the keyboard delegate functions to detect user action on the keyboard.

KeyboardKit also contains functionality for creating a wrapper app, that can be
used to select emojis from a collection view. This is nice to have, if the user
doesn't want to give the keyboard extension full access.

To add such a collection view to your keyboard extension's wrapper app, inherit
the `EmojiCollectionViewController` class, override `createKeyboard()` and bind
the collection view outlet.



## Example

To run the demo project, clone the repo, and run `pod install` from the Example
directory first. The project is currently empty and is only used to verify that
the pod will compile properly. Feel free to contribute. :)



## Requirements

KeyboardKit requires iOS 8 or later.



## CocoaPods

KeyboardKit is available through [CocoaPods](http://cocoapods.org). Add it to a 
project by adding the following line to the Podfile:

```ruby
pod "KeyboardKit"
```



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

KeyboardKit is available under the MIT license. See the LICENSE file for more info.
