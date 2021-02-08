# KeyboardKit - UIKit


## UIKit support

KeyboardKit 4.0 shifts focus from `UIKit` to `SwiftUI`.   UIKit is still supported, but I will not be working on these parts of the library anymore.

The UIKit-specific parts of the library can be found under `Sources/UIKit`.


## Overview

When you use `KeyboardKit`, you should inherit `KeyboardInputViewController` instead of `UIInputViewController`. It extends your keyboard extension with many convenient tools.

`UIKit` requires you to use constraints to resize the extension to fit the keyboard content. KeyboardKit simplifies this by providing a vertical `keyboardStackView` that resizes the extension depending on what you put into it. You don't have to use it, but it's there if you want to. 

KeyboardKit also has a bunch of built-in views, components, extensions and utilities that help you build keyboard extensions with UIKit.


## Tutorial

If you're new to KeyboardKit, [this short UIKit tutorial][Tutorial] can help you get started.


## Demo

The `UIKit/Demo` folder contains a demo app that uses UIKit to create a keyboard that resembles a native, English keyboard. To give it a try, run it then activate the keyboard under system settings. You must give the keyboard full access for features like sound and haptics to work. 


## Contribute

I will not develop the UIKit-specific parts of the library further from now on, but I will gladly accept UIKit-specific pull requests, as long as they don't have side-effects on the foundation.

When contributing, make sure to add any new UIKit-specific features to `Sources/UIKit` and to run `swiftlint` and the unit tests before you create the PR.  


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/UIKit/Tutorial.md
