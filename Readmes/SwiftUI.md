# SwiftUI

KeyboardKit supports building keyboard extensions in `SwiftUI`. This currently requires a second library called [KeyboardKitSwiftUI][KeyboardKitSwiftUI]. 


## Overview

`SwiftUI` makes it a lot easier to create custom keyboard extensions, since it doesn't require constraints, stack views etc. Instead, you just provide a root view and the keyboard extension will resize itself to fit that view.

You can use any views you like, both as root view and to build your keyboard. You can then use any of the built-in views and extensions to add keyboard functionality to your views.

[KeyboardKitSwiftUI][KeyboardKitSwiftUI] currently lacks some of the functionality that you have for [UIKit][UIKit], but you can still build everything yourself.

From KeyboardKit 3.0, `SwiftUI` will be the main focus moving forward. SwiftUI support will be improved over time in 3.x. KeyboardKit 4.0, will then drop support for iOS 11 and 12 and move everything from [KeyboardKitSwiftUI][KeyboardKitSwiftUI] into this library.     


## Getting started

To setup a keyboard extension with SwiftUI, import [KeyboardKitSwiftUI][KeyboardKitSwiftUI] and call `setup<Content: View>(with view: Content)` in your `KeyboardViewController`. It takes a custom `SwiftUI` view and sets up the environment with an `ObservableKeyboardContext` and a standard keyboard style.

You can then add any views you want to the keyboard view and use the rich set of extensions and utilities that this library provides.

[KeyboardKitSwiftUI][KeyboardKitSwiftUI] contains the following namespaces:

* `Autocomplete` contains SwiftUI-specific autocomplete utilities.
* `Context` contains SwiftUI-specific observable contexts and extensions.
* `Extensions` contains SwiftUI-specific extensions.
* `Gestures` contains SwiftUI-specific keyboard gestures. 
* `Settings` contains SwiftUI-specific settings extensions.
* `System` contains views and extensions that helps you create keyboard that mimic native iOS system keyboards.
* `Toast` contains SwiftUI-specific components to show a toast on top of a keyboard extension.
* `Views` contains SwiftUI-specific keyboard views.

`IMPORTANT` Note that the `System` namespace is used to create keyboards that mimic native iOS system keyboards. They provide very little customization options and should not be used to create custom keyboards. 


## Views

[KeyboardKitSwiftUI][KeyboardKitSwiftUI] has many views that can be composed into keyboards. For instance:

* `KeyboardGrid` can be used to list actions in a grid with a certain number of `columns`. 
* `KeyboardImageButton` shows an image with a tap and long press action.
* `NextKeyboardButton` switches to the next system keyboard when it is tapped and opens a system keyboard menu when it is pressed.

The library also contains views that can be used to mimic system keyboards, for instance:

* `SystemKeyboardBottomRow` mimicks the bottom row in alphabetic, numeric and symbolic system keyboards.
* `SystemKeyboardButton` mimicks the system keyboard buttons that are used in all system keyboards.
* `SystemKeyboardButtonRow` mimicks a button row in alphabetic, numeric and symbolic system keyboards.
* `AlphabeticSystemKeyboard` mimics an alphabetical system keyboard.
* `NumericSystemKeyboard` mimics a numeric system keyboard.
* `SymbolicSystemKeyboard` mimics a symbolic system keyboard.

Since these views are regular views, you can use them in your hosting application as well, provided that is also supports SwiftUI.

Take a look at the [KeyboardKitSwiftUI][KeyboardKitSwiftUI] source code for a complete list of views and components.


## Environment data

When you setup a SwiftUI view to be used with KeyboardKit, the view gets access to environent data:

* `@EnvironmentObject var context: ObservableKeyboardContext`
* `@EnvironmentObject var style: SystemKeyboardStyle`

You can use these environment objects to trigger keyboard actions, get the current style etc.


## Connecting your views with KeyboardKit

There is no magic involved in using this library with SwiftUI. You can use any views you like, and just let them trigger actions when they are tapped, pressed etc. [KeyboardKitSwiftUI][KeyboardKitSwiftUI] has a collection of views and utilities that simplifies this.  

Basically, you can create SwiftUI-based keyboards in a wide variety of ways, for instance:

* Use any views and call the action handler when they are tapped, pressed etc.
* Use any views and use `View+KeyboardGestures` to trigger any functions when they are tapped, pressed etc.
* Use any views and use `View+KeyboardAction` to apply a certain keyboard action to standard gestures that are applied the view.
* Use any views and use `View+System` to apply a system look and feel to them, e.g. `systemKeyboardButtonStyle`.
* Use `SystemKeyboardButton` to create buttons that try to mimic the native look and feel for the provided keyboard action.
* Use any of the many views in the `Views` namespace to create more complex keyboards.

Note that the `System` namespace is intended to build keyboards that resemble system keyboards. They currently provide little customizations.


## Ongoing work

The SwiftUI support is very much a work in progress, but my goal is to have great SwiftUI support in KeyboardKit 4.0. So far, the support is pretty basic.


[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI
[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit.md
