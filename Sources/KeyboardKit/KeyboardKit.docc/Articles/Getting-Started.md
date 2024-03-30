# Getting Started

This article describes how to get started with KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}


This article describes how to get started with both KeyboardKit & KeyboardKit Pro. Each section will first show you how to do something for KeyboardKit, then for KeyboardKit Pro.



## How to use KeyboardKit

Keyboard extensions can use KeyboardKit to create custom keyboards, while the main app can use it to check keyboard state, provide keyboard-specific settings, link to System Settings, etc. 

KeyboardKit requires slightly different setup depending on if you set it up for a keyboard extension or an app.



## How to set up KeyboardKit for a keyboard extension

To set up KeyboardKit for a keyboard extension, import KeyboardKit and let `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
import KeyboardKit // or KeyboardKitPro

class KeyboardController: KeyboardInputViewController {}
```

This gives you access to lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable ``KeyboardInputViewController/state``, keyboard ``KeyboardInputViewController/services``, and more.

If you just want to use the default ``SystemKeyboard`` view, which mimics a native iOS keyboard and updates whenever the observable state changes, you don't have to do anything else. KeyboardKit will set up everything.

To replace or customize the default ``SystemKeyboard``, just override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any setup function:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { controller in
            SystemKeyboard(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in MyCustomToolbar() }
            )
        }
    }
}
```

You can use the view builder `controller` parameter to access ``KeyboardInputViewController/state``, ``KeyboardInputViewController/services`` and any other properties and functions you need.

> Important: The view builder provides you with an unowned controller, to avoid memory leaks. If you pass it on, make sure to keep it unowned!


### 👑 KeyboardKit Pro

Unlike KeyboardKit, KeyboardKit Pro has a setup function that lets you register a license key, after which KeyboardKit Pro automatically sets up your license and unlocks all included features.

To use KeyboardKit Pro with the default ``SystemKeyboard`` view, just call **setupPro** without a view in **viewDidLoad**:

```swift
import KeyboardKitPro

class KeyboardViewController: KeyboardInputViewController {

    func viewDidLoad() {
        super.viewDidLoad()
        setupPro(
            withLicenseKey: "your-license-key",
            locales: [...], // Define which locales to use for Basic & Silver licenses
            licenseConfiguration: { license in ... }  // Customize the keyboard for the license
        )
    }
}
```

To use KeyboardKit Pro with a custom view, just call **setupPro** and provide it with any custom view in ``KeyboardInputViewController/viewWillSetupKeyboard()``:

```swift
import KeyboardKitPro

class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setupPro(
            withLicenseKey: "your-license-key",
            locales: [...], // Define which locales to use for Basic & Silver licenses
            licenseConfiguration: { license in ... }  // Customize the keyboard for the license
            view: { controller in
                SystemKeyboard(
                    state: controller.state,
                    services: controller.services,
                    buttonContent: { $0.view },
                    buttonView: { $0.view },
                    emojiKeyboard: { $0.view },
                    toolbar: { _ in MyCustomToolbar() }
                )
            }
        )
    }
}
```

Since Basic, Silver, and monthly Gold licenses validate licenses over the Internet, your keyboard extension must enable Full Access to be able to make network requests. This is not needed for yearly Gold and custom licenses, which are validated on-device.  

> Important: A Basic license unlocks 1 locale, Silver unlocks 5 and Gold unlocks all supported locales. You can change which locales to use for each new version of your app, after which the locales will be persisted for that particular app version.
 



## How to set up KeyboardKit for an app

You can use KeyboardKit in your main app, to check the enabled and Full Access status of a keyboard, provide keyboard settings, link to System Settings, etc. It's a great place to provide app settings, since it has more available space than the keyboard extension.

You don't have to set up KeyboardKit in your app. Just import KeyboardKit in any file where you want to use it, and you're good to go.


### 👑 KeyboardKit Pro

To set up KeyboardKit Pro in your main app, just register your license key as soon as the the application launches: 

```swift
import KeyboardKitPro

@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .task { setupKeyboardKitPro() }
        }
    }
}

extension MyApp {

    func setupKeyboardKitPro() async throws {
        do {
            let license = try await License.register(...)
            // KeyboardKit Pro is now activated.
        } catch {
            print(error)
            // Handle the license error in any way you want.
        }
    }
}
```

If you need to use Pro features on the root screen, just set some observed state when the license is registered to force a view update.



## How to set up KeyboardKit as a package dependency

To set up KeyboardKit as a transient package dependency, just add it to package dependencies and link it to any target that needs it.


### 👑 KeyboardKit Pro

Since KeyboardKit Pro is a binary target, it requires some special handling to be used as a transient package dependency:

* You don't have to link to KeyboardKit Pro from any target.
* You *must* update **runpath search paths** under **Build Settings**.
    * For the main app, set it to **@executable_path/Frameworks**.
    * For the keyboard, set it to **@executable_path/../../Frameworks**.

Failing to set the search paths will cause a runtime crash when you try to use KeyboardKit Pro.  



## How to use KeyboardKit state & services

The KeyboardKit ``KeyboardInputViewController`` provides you with keyboard-specific observable ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``, that let you build powerful keyboards.

KeyboardKit injects all these observable state types into the view hierarchy as environment objects, to let you access them like this:

```swift
struct CustomKeyboard: View {

    init(
        actionHandler: KeyboardActionHandler
    ) {
        self.actionHandler = actionHandler
    }

    let actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services.


You can easily modify any state and replace any service with custom implementations. For instance, here we disable autocomplete with the shared ``AutocompleteContext`` and replace the standard ``KeyboardActionHandler`` with a custom one:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(
            inputViewController: self
        )
        super.viewDidLoad()
        state.autocompleteContext.isAutocompleteEnabled = false
    }
}

class CustomActionHandler: StandardActionHandler {

    open override func handle(
        _ gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) {
        if gesture == .press && action == .space {
            print("Pressed space!")
        }
        super.handle(gesture, on: action) 
    }
}
```

Since services are lazy and resolved when they're used for the first time, you should set up any custom services as early as possible, to ensure that the dependency graph is properly resolved.



## Going further

You should now have a basic understanding of how to set up KeyboardKit and KeyboardKit Pro. For more information & examples, see the various articles and take a look at the demo app.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
