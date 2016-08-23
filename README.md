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
one that I currently use) or create a custom one that implements the `Keyboard`
protocol, then implement all keyboard functionality you need. A keyboard should
be able to setup itself in a view and (if you have multiple pages) handle pages.
Set its `delegate` property to handle any keyboard actions. 

To present your keyboard in an iOS keyboard extension, add a keyboard extension
project to your app. Let the input view controller of the extension inherit the 
`KeyboardInputViewController` class. Your subclass should as a minimum override 
`createKeyboard()`, so that the base class knows which keyboard to use, and use
the keyboard delegate functions to detect user action on the keyboard.



## Emoji collection view

KeyboardKit also provides an emoji collection view, that can be used to display
your keyboard emojis in the main app as well. This is a nice feature to provide
as a compliment to the keyboard extension, since users may not want to give the
keyboard extension full access (which is required to copy and save emojis).

To use the collection view in your app, just add a collection view to your view
and let it inherit the `EmojiCollectionView` class. Then, all you have to do is
to set the `keyboard` property to your custom keyboard, then set `emojiDelegate`
to handle taps and long presses.



## Alert messages

To show message to the user, e.g. when an emoji has been saved, you can use the
`Toast` class or implement your own message alert by implementing `MessageAlert`. 



## Additional functionality

If you have a look at the source code you'll find additional functionality that
you can use in your app. The `Extensions` folder contains image extensions that
helps you copying, saving, resizing and styling images. The `System` folder has
some system urls that you can use, e.g. to take a user to keyboard settings. In
the `Threading` folder, you have an amazing threading operator, that simplifies
pushing operations to a background thread, then popping back to the main thread.

Enjoy!



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

### IMPORTANT

Using CocoaPods in an keyboard extensions may currently cause problems when the
app is submitted to iTunes Connect.

If you get an error that your extension contains unallowed frameworks, open the
build settings for the extension. `Embedded Content Contains Swift Code` should
be `false` for the extension and `true` (default) for the app. 

After this, you must add a new run script build phase to the keyboard extension.
Place it at the very end and paste this script into it:

```
cd "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/"
if [[ -d "Frameworks" ]]; then
rm -fr Frameworks
fi
```

This will remove any frameworks from the keyboard extension and should make the
app submit correctly to iTunes Connect.




## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

KeyboardKit is available under the MIT license. See the LICENSE file for more info.
