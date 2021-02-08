# SwiftUI

KeyboardKit comes with a bunch of built-in view and components that help you build `SwiftUI`-based keyboard extensions.


To build a keyboard extension with KeyboardKit, you just have to import `KeyboardKit` and [KeyboardKitSwiftUI][KeyboardKitSwiftUI] and call `setup<Content: View>(with view: Content)` in your `KeyboardViewController`. It takes a custom `SwiftUI` view and sets up the environment with an `ObservableKeyboardContext` and a standard keyboard style. You can then add any views you want to the keyboard view and use the rich set of extensions and utilities that this library provides.

`SwiftUI` is the main focus moving forward. SwiftUI support will be improved over time in 3.x. KeyboardKit 4.0 will then drop support for iOS 11 and 12 and move everything from [KeyboardKitSwiftUI][KeyboardKitSwiftUI] into this library.


## Utilities

KeyboardKit has a bunch of built-in views, components, extensions and utilities that help you build keyboard extensions.

The root folder contains a bunch of general keyboard tools. [KeyboardKitSwiftUI][KeyboardKitSwiftUI] then adds a bunch of SwiftUI-specific tools on top of this general set.


## Demo

Have a look at the SwiftUI demo to see how to build a SwiftUI-based keyboard extension with KeyboardKit. 


## Ongoing work

The SwiftUI support is very much a work in progress, but my goal is to have great SwiftUI support in KeyboardKit 4.0. So far, the support is pretty basic.


[Bug]: https://forums.swift.org/t/weak-linking-of-frameworks-with-greater-deployment-targets/26017/24
[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI
[Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI-Tutorial.md
[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit.md
