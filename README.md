# KeyboardKit

[![CI Status](http://img.shields.io/travis/Daniel Saidi/KeyboardKit.svg?style=flat)](https://travis-ci.org/Daniel Saidi/KeyboardKit)
[![Version](https://img.shields.io/cocoapods/v/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)
[![License](https://img.shields.io/cocoapods/l/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat)](http://cocoapods.org/pods/KeyboardKit)


KeyboardKit is a Swift library for iOS keyboard extension apps. It is currently
limited to the functionality I need in my own keyboard extension apps, but will
be extended as those apps become more sophisticated over time.



## Getting started

I have currently not had time to setup a demo that shows how you build a custom
keyboard extension app on top of this library. For now, have a look at the code.

You must create a keyboard class, that for now either inherits EmojiKeyboard or
implements Keyboard (I only use emoji keyboards in my app, so far).

Then create a subclass of KeyboardInputViewController. This class should at the
very least override createKeyboard(), so the base class knows which keyboard it
should use. Use this subclass as the view controller of your keyboard extension. 

KeyboardKit also contains functionality for creating a wrapper app, that can be
used to select emojis from a collection view. This is nice to have, if the user
doesn't want to give the keyboard extension full access. To handle this, create
a subclass of EmojiCollectionViewController. This class should also at the very
least override createKeyboard(). Make sure to wire up a collection view, so the
emojis have some place to show up.

Feel free to create a demo project for this project, that demonstrates how this
library can be used to create an emoji app.



## Example

To run the demo project, clone the repo, and run `pod install` from the Example
directory first. Note that the demo project is empty and only verifies that the
pod compiles properly.



## Requirements

KeyboardKit requires iOS 8 or later.



## CocoaPods

KeyboardKit will be added to CocoaPods as soon as it is used by emoji apps that
are live on the app store.



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

KeyboardKit is available under the MIT license. See the LICENSE file for more info.
