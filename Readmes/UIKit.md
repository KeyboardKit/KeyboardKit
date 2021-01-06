# UIKit

KeyboardKit comes with a bunch of built-in view and components that help you build `UIKit`-based keyboard extensions.


## Tutorial

If you're new to KeyboardKit, [this short UIKit tutorial][Tutorial] can help you get started.


## Overview

`UIKit` is the standard way of building custom keyboard extensions. It requires you to setup constraints to automatically resize the extension to fit the keyboard content.  

KeyboardKit simplifies this setup by providing a vertical `keyboardStackView` that resizes the extension depending on what you put into it. You don't have to use it, but it's there if you want to. 

`SwiftUI` is the main focus moving forward. KeyboardKit 4.0 will then drop support for iOS 11 and 12 and move everything from [KeyboardKitSwiftUI][KeyboardKitSwiftUI] into this library.


## Utilities

KeyboardKit has a bunch of built-in views, components, extensions and utilities that help you build keyboard extensions.

The root folder contains a bunch of general keyboard tools. The `UIKit` folder then adds a bunch of UIKit-specific tools on top of this general set.


## Demo

Have a look at the UIKit demo to see how to build a UIKit-based keyboard extension with KeyboardKit. 


[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI
[Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit-Tutorial.md

