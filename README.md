# KeyboardKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/KeyboardKit">
        <img src="https://badge.fury.io/gh/danielsaidi%2FKeyboardKit.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

`KeyboardKit` is a helps you create custom keyboard extensions for `iOS` and `ipadOS`. It provides you with a rich set of keyboard-specific `tools` and `actions`, `haptic` and `audio` feedback support and lets you create keyboards with `characters`, `emojis`, `images` etc.

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

If you're new to iOS keyboard extensions, [this great guide][Guide] can help you get started. You can also have a look at the demo apps for examples on how to use this library. 


## Installation

### Swift Package Manager

```
https://github.com/danielsaidi/KeyboardKit.git
```

### CocoaPods

```ruby
target 'MyApp' do
  pod 'KeyboardKit'
end

target 'MyKeyboard' do
  pod 'KeyboardKit'
end
```


## Getting Started

When you use `KeyboardKit`, you should inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides you with many tools that helps you build custom keyboard extension.

KeyboardKit supports both `UIKit` and `SwiftUI`, so you can pick the option that suits your needs best. 


## UIKit

[Read more here][UIKit] about creating `UIKit`-based keyboard extensions.

You can also follow [this tutorial][UIKit-Tutorial].

`SwiftUI` is the main focus going forward, but UIKit support will still be around and improved if needed.


## SwiftUI

[Read more here][SwiftUI] about creating `SwiftUI`-based keyboard extensions.

You can also follow [this tutorial][SwiftUI-Tutorial].

`SwiftUI` is the main focus going forward, but the support is currently limited.


## Actions

KeyboardKit supports many different keyboard actions, like `character` inputs, `emoji` inputs, `backspace`, `newline`, `space`, `image` etc. You can even create your own, custom actions.

[Read more here][Actions]


## Input Sets

KeyboardKit provides you with locale-specific input sets, which makes it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in many languages.

[Read more here][Input-Sets]


## Keyboard Types

KeyboardKit supports many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own, custom keyboard types.

[Read more here][Keyboard-Types]


## Autocomplete

KeyboardKit supports autocomplete and can present autocomplete suggestions to users as they type. 

[Read more here][Autocomplete]


## Haptic Feedback

KeyboardKit supports haptic feedback and can give users haptic feedback as they type. 

[Read more here][Haptic-Feedback].


## Audio Feedback

KeyboardKit supports audio feedback and can give users audio feedback as they type. 

[Read more here][Audio-Feedback].


## Extensions

KeyboardKit comes with many keyboard-specific extensions. Check out the demo apps and source code for examples and more information.


## Demo Applications

This repository contains two demo apps that demonstrate different keyboard types, like `alphabetical` (lower/uppercased and caps locked), `numerical`, `symbols`, `emojis` and `images`.

* `KeyboardKitDemoKeyboard` uses `UIKit` to implement various keyboards that mimics system keyboards. 
* `KeyboardKitDemoKeyboard_SwiftUI` uses `SwiftUI` to implement various keyboards that mimics system keyboards.

Since [KeyboardKitSwiftUI][KeyboardKitSwiftUI] is still under development, the `SwiftUI` demo app lacks a lot of functionality that the `UIKit` app has.

To run the demo app, open and run the `KeyboardKit.xcodeproj` project then enable the keyboards under system settings. Don't forget to enable full access.

`IMPORTANT` Audio feedback, haptic feedback and image actions require full access.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Clients

KeyboardKit is proudly supported by:

[![Anomaly Software](Resources/logos/anomaly.png "Anomaly Software")](http://anomaly.net.au/)

Your company can support KeyboardKit by either sponsoring the project on GitHub Sponsors or by paying for consultation. I'ld be happy to help you out with your keyboard needs.


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Actions.md
[Audio-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Haptic-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Input-Sets]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Types]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[SwiftUI]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI.md
[SwiftUI-Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI-Tutorial.md
[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit.md
[UIKit-Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit-Tutorial.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide
