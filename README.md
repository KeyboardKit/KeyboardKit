# KeyboardKit

<p align="center">
    <img src ="Resources/Logo.png" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/KeyboardKit?color=%2300550&sort=semver" alt="Version" />
    <img src="https://img.shields.io/cocoapods/p/KeyboardKit.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.3-orange.svg" alt="Swift 5.3" />
    <img src="https://img.shields.io/github/license/danielsaidi/KeyboardKit" alt="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About KeyboardKit

KeyboardKit helps you create custom keyboard extensions for `iOS` and `ipadOS`.

KeyboardKit provides you with a rich set of `tools` and `actions`, `haptic` and `audio` feedback, `input sets`, `keyboard layouts`, `autocomplete` etc. and It you create keyboards with `characters`, `numbers`, `symbols`, `emojis`, `images` or entirely custom keyboards that make use of the vast extensions to the native framework.

The end result can look something like this, or entirely different:

<p align="center">
    <img src ="Resources/Demo.gif" width="300" />
</p>

If you're new to iOS keyboard extensions, [this great guide][Guide] can help you get started. You can also have a look at the demo apps for inspiration. 


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

post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
      end
   end
end
```


## Getting Started

With `KeyboardKit`, you should inherit `KeyboardInputViewController` instead of `UIInputViewController`. It provides you with many tools that helps you build custom keyboard extension.

KeyboardKit supports both `UIKit` and `SwiftUI`, so you can pick the option that suits your needs best. 


### UIKit

KeyboardKit contains a rich set of tools to create `UIKit`-based keyboards. 

[Read more here][UIKit] and see [this tutorial][UIKit-Tutorial] for some examples. You can also checkout the UIKit demo for inspiration.


### SwiftUI

KeyboardKit can be extended with [KeyboardKitSwiftUI][KeyboardKitSwiftUI] to create `SwiftUI`-based keyboards. 

[Read more here][SwiftUI] and see [this tutorial][SwiftUI-Tutorial] for some examples. You can also checkout the SwiftUI demo for inspiration.


### SwiftUI is the future

`SwiftUI` is the main focus going forward, and will be the main technology from version `4.0`. UIKit-specific functionality will then be removed. [Read more about this decision here.][UIKit-Removal-post]


## Actions

KeyboardKit supports many different keyboard actions, like `character` inputs, `emoji` inputs, `backspace`, `newline`, `space`, `image` etc. You can even create your own, custom actions.

[Read more here][Actions]


## Keyboard Types

KeyboardKit supports many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own, custom keyboard types.

[Read more here][Keyboard-Types]


## Input Sets

KeyboardKit provides you with locale-specific input sets, which makes it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in many languages.

[Read more here][Input-Sets]


## Keyboard Layouts

KeyboardKit can combine an input set with surrounding actions to create a keyboard layout, which is the total set of actions on a keyboard.

[Read more here][Keyboard-Layouts]


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
* `KeyboardKitDemoKeyboard_SwiftUI` uses `SwiftUI` to implement the same keyboards in another way.

The demo apps are not intended to be production ready keyboards, but rather to give you inspiration to how you can build your own keyboards.

To run the demo app, open and run the `KeyboardKit.xcodeproj` project, then enable the keyboards under system settings. Don't forget to enable full access to support all features, like audio and haptic feedback.


## Contact me

Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## Sponsors and Clients

This project is proudly sponsored by the following individuals and companies:

* [@booch](https://github.com/booch)

<a href="http://anomaly.net.au">
    <img src="Resources/logos/anomaly.png" alt="Anomaly Software Logo" title="Anomaly Software" width=150 />
</a>
<a href="https://www.milocreative.com">
    <img src="Resources/logos/milo.png" alt="Milo Creative Logo" title="Milo Creative" width=150 />
</a>

You can support my work by sponsoring the project on [GitHub Sponsors][Sponsors] or hiring me for consultation. I'd be happy to help you out in any way that I can.


## License

KeyboardKit is available under the MIT license. See LICENSE file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com
[Sponsors]: https://github.com/sponsors/danielsaidi

[KeyboardKitSwiftUI]: https://github.com/danielsaidi/KeyboardKitSwiftUI

[Actions]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Actions.md
[Audio-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Audio-Feedback.md
[Autocomplete]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Autocomplete.md
[Haptic-Feedback]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Haptic-Feedback.md
[Input-Sets]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Input-Sets.md
[Keyboard-Layouts]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Layouts.md
[Keyboard-Types]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Keyboard-Types.md
[SwiftUI]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI.md
[SwiftUI-Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/SwiftUI-Tutorial.md
[UIKit]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit.md
[UIKit-Removal-post]: https://danielsaidi.com/blog/2021/01/15/removing-uikit-support-in-keyboardkit
[UIKit-Tutorial]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/UIKit-Tutorial.md

[Guide]: https://shyngys.com/ios-custom-keyboard-guide

[Anomaly]: http://anomaly.net.au
[Milo]: https://www.milocreative.com
