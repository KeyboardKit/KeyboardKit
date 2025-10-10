<p align="center">
    <img src="Resources/Icon.png" alt="KeyboardKit Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/KeyboardKit/KeyboardKit?color=forestgreen&sort=semver" alt="Version" />
    <img src="https://img.shields.io/badge/swift-5.9-orange.svg" alt="Swift 5.9" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <a href="https://keyboardkit.github.io/KeyboardKit"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <img src="https://img.shields.io/github/license/KeyboardKit/KeyboardKit" alt="MIT License" />
</p>

# KeyboardKit

KeyboardKit lets you create amazing [custom keyboard extensions][About] with a few lines of code, using Swift & SwiftUI.

<p align="center">
    <img src="Resources/Demo.gif" alt="KeyboardKit Demo" width=450 />
</p>

KeyboardKit extends Apple's limited keyboard APIs with more capabilities. It can be extended with [KeyboardKit Pro][Pro], which unlocks localized keyboards, autocomplete, an emoji keyboard, AI support, themes, and much more.


## Installation

KeyboardKit can be installed with the Swift Package Manager:

```
https://github.com/KeyboardKit/KeyboardKit.git
```

KeyboardKit must then be linked to all targets that will use it.



## Getting Started

The easiest way to set up KeyboardKit is to first create a `KeyboardApp` value for your app:

```swift
import KeyboardKit

extension KeyboardApp {

    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit",
            licenseKey: "your-key-here",                // Needed for KeyboardKit Pro!
            appGroupId: "group.com.keyboardkit.demo",   // Sets up App Group data sync
            locales: .keyboardKitSupported,             // Sets up the enabled locales
            autocomplete: .init(                        // Sets up custom autocomplete  
                nextWordPredictionRequest: .claude(...) // Sets up AI-based prediction
            ),
            deepLinks: .init(app: "kkdemo://", ...)     // Defines how to open the app
        )
    }
}
```  

Next, let your `KeyboardController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
class KeyboardController: KeyboardInputViewController {}
```

This unlocks additional functions and capabilities, and adds `services` and observable `state` to the controller. 

Next, override `viewDidLoad()` and call `setup(for:)` to set up the keyboard extension for your app:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the keyboard with the app we created above
        setup(for: .keyboardKitDemo) { result in
            // If `result` is `.success`, the setup did succeed.
            // This is where you can setup custom services, etc.
        }
    }
}
```

This will make keyboard settings sync data between the main app and its keyboard if the `KeyboardApp` defines an ``appGroupId``, set up KeyboardKit Pro if it defines a ``licenseKey``, set up dictation and deep links, etc.

To replace or customize the standard ``KeyboardView``, just override `viewWillSetupKeyboardView()` and let it call `setupKeyboardView(_:)` with the view that you want to use:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboardView() {
        setupKeyboardView { [weak self] controller in // <-- Use weak or unknowned self!
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
        }
    }
}
```

To set up your main app with the same keyboard configuration, just wrap the content view in a `KeyboardAppView`:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
        
            // Here we use the keyboard app we created above
            KeyboardAppView(for: .keyboardKitDemo) {
                ContentView()
            }
        }
    }
}
```

For more information, see the [getting started guide][Getting-Started] and [essentials][Essentials] articles.



## Localization

KeyboardKit supports [75 locales][Localization]:

🇺🇸 🇦🇱 🇦🇪 🇦🇲 🇦🇿 🇧🇾 🇧🇩 🇧🇬 🇦🇩 🏳️ <br />
🏳️ 🇭🇷 🇨🇿 🇩🇰 🇳🇱 🇧🇪 🇦🇺 🇨🇦 🇬🇧 🇺🇸 <br />
🇪🇪 🇫🇴 🇵🇭 🇫🇮 🇫🇷 🇨🇦 🇧🇪 🇨🇭 🇬🇪 🇩🇪 <br />
🇦🇹 🇨🇭 🇬🇷 🇺🇸 🇮🇱 🇭🇺 🇮🇸 🏳️ 🇮🇩 🇮🇪 <br />
🇮🇹 🇰🇿 🇹🇯 🇹🇯 🇹🇯 🇱🇻 🇱🇹 🇲🇰 🇲🇾 🇲🇹 <br />
🇲🇳 🏳️ 🇳🇴 🇳🇴 🇮🇷 🇵🇱 🇵🇹 🇧🇷 🇷🇴 🇷🇺 <br />
🇷🇸 🇷🇸 🇹🇯 🇸🇰 🇸🇮 🇪🇸 🇦🇷 🇲🇽 🇸🇪 🇰🇪 <br />
🇹🇷 🇺🇦 🇺🇿 🇻🇳 🏴󠁧󠁢󠁷󠁬󠁳󠁿 <br />

KeyboardKit only includes localized strings, while [KeyboardKit Pro][Pro] unlocks localized keyboards, layouts, callouts and behaviors for all supported locales.



## Features

KeyboardKit provides a free, open-source keyboard engine. [KeyboardKit Pro][Pro] unlocks more powerful pro features.

* 🌱 [Essentials][Essentials] - Essential models, services, utilities & views.
* ⌨️ [Essentials-KeyboardView][Essentials-KeyboardView] - A native-looking, customizable keyboard.
* 💥 [Actions][Actions] - Trigger & handle keyboard-related actions.
* 📱 [App][App] - Set up your app, keyboard, sync settings, etc.
* 🗯 [Callouts][Callouts] - Show input & secondary action callouts.
* 🖥️ [Device][Device] - Identify device type, capabilities, etc.
* 😀 [Emojis][Emojis] - Emojis, categories, versions, skin tones, etc.
* 🔉 [Feedback][Feedback] - Trigger audio & haptic feedback.
* 👆 [Gestures][Gestures] - Handle a rich set of gestures on any key.
* 🔣 [Layout][Layout] - Define and customize dynamic keyboard layouts.
* 🌐 [Localization][Localization] - Additional locale-related utilities.
* 🗺️ [Navigation][Navigation] - Open urls and other apps from the keyboard.
* 👁 [Previews][Previews] - Extensive SwiftUI preview support.
* 📄 [Proxy][Proxy] - Extend the text document proxy with more capabilities.
* ⚙️ [Settings][Settings] - Provide keyboard settings & link to System Settings.
* 🩺 [Status][Status] - Detect if a keyboard is enabled, has full access, etc.
* 🎨 [Styling][Styling] - Style your keyboard to great extent.



## Documentation

The [online documentation][Documentation] has a thorough getting-started guide, a detailed article for each feature, code samples, etc. You can also build it from the source code to get better formatting.



## Demo App

The `Demo` folder has a demo app that shows how to set up the main keyboard app, show keyboard status, provide in-app settings, link to system settings, apply custom styles, etc. 

The app has two keyboards - a `Keyboard` that uses KeyboardKit and a `KeyboardPro` that uses KeyboardKit Pro.

> [!IMPORTANT]
> The demo isn't code signed and can therefore not use an App Group to sync settings between the app and its keyboards. As such, the `KeyboardPro` keyboard has keyboard settings in the keyboard as well.



## KeyboardKit App

Download the [KeyboardKit app][KeyboardKit-App] from the App Store to try KeyboardKit without having to write any code or build the demo app from Xcode.



## Support This Project

KeyboardKit is open-source and completely free, but you can support the project by becoming a [GitHub Sponsor][Sponsors], upgrading to [KeyboardKit Pro][Pro] or [get in touch][Email] for freelance work, paid support etc.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [keyboardkit.com][Website]
* E-mail: [info@keyboardkit.com][Email]
* Bluesky: [@keyboardkit.bsky.social][Bluesky]
* Mastodon: [@keyboardkit@techhub.social][Mastodon]



## License

KeyboardKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:info@keyboardkit.com
[Website]: https://keyboardkit.com
[Bluesky]: https://bsky.app/profile/keyboardkit.bsky.social
[Mastodon]: https://techhub.social/@keyboardkit
[Sponsors]: https://github.com/sponsors/danielsaidi

[About]: https://keyboardkit.com/about
[Gumroad]: https://kankoda.gumroad.com
[KeyboardKit-App]: https://keyboardkit.com/app

[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
[Documentation]: https://keyboardkit.github.io/KeyboardKit/
[License]: https://github.com/KeyboardKit/KeyboardKit/blob/master/LICENSE

[Getting-Started]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/getting-started-article
[Essentials]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials-article
[Essentials-KeyboardView]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials-keyboardview
[Essentials-Memory-Management]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/essentials-memory-management

[Actions]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/actions-article
[AI]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/ai-article
[App]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/app-article
[Autocomplete]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/autocomplete-article
[Buttons]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/buttons-article
[Callouts]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/callouts-article
[Device]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/device-article
[Dictation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/dictation-article
[Emojis]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/emojis-article
[External]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/external-keyboards-article
[Feedback]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/feedback-article
[Gestures]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/gestures-article
[Host]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/host-article
[Input]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/input-article
[Layout]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/layout-article
[Localization]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/localization-article
[Navigation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/navigation-article
[Previews]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/previews-article
[Proxy]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/proxy-article
[Settings]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/settings-article
[Status]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/status-article
[Styling]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/styling-article
[Themes]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/themes-article
