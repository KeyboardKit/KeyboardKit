# Getting Started

This article describes how to get started with KeyboardKit.


This article describes how to get started with both KeyboardKit and KeyboardKit Pro, which extends KeyboardKit with Pro features. 

Since KeyboardKit Pro requires a license key, it has a slightly different setup than KeyboardKit. Every section will first show you how to do it for KeyboardKit, then for KeyboardKit Pro. 



## How to install KeyboardKit

See the start page for information on how to install KeyboardKit and KeyboardKit Pro.

Make sure to **import KeyboardKit** (or **import KeyboardKitPro** for KeyboardKit Pro) in any file where you want to use the library.



## How to use KeyboardKit

Keyboard extensions can use KeyboardKit to create custom keyboards, while the main app target can use it to check keyboard state, provide shared settings, link to System Settings, etc. 

KeyboardKit requires slightly different setup depending on the target type and use-case.



## How to set up KeyboardKit for a keyboard extension

To set up KeyboardKit for a keyboard extension, first let your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
class KeyboardController: KeyboardInputViewController {}
```

This extends your controller with new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable ``KeyboardInputViewController/state``, keyboard-specific ``KeyboardInputViewController/services``, and much more.

KeyboardKit will use a ``SystemKeyboard`` as the default keyboard view. To customize or replace it, override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any of the `setup` functions.


### KeyboardKit

With KeyboardKit, you can customize or replace the default keyboard view by calling **setup(with:)** and provide a modified system keyboard, or a completely custom view:

```swift
class KeyboardViewController: KeyboardInputViewController {

    func viewWillSetupKeyboard() {
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

You can use the view builder controller parameter to access controller ``KeyboardInputViewController/state``, ``KeyboardInputViewController/services``, and any other controller properties and functions.

You can find more information on how to customize the ``SystemKeyboard`` in <doc:Essentials>.

> Important: The view builder provides you with an unowned controller, to help avoiding memory leaks. If you pass it to other views, make sure to keep it unowned.


### KeyboardKit Pro

Unlike KeyboardKit, KeyboardKit Pro has a **setupPro** function, that lets you register your license key, after which KeyboardKit Pro automatically set up all locales and features in your license.

To use KeyboardKit Pro with the default view, just call **setupPro** without a view in **viewDidLoad**:

```swift
func viewDidLoad() {
    super.viewDidLoad()
    setupPro(
        withLicenseKey: "your-key",
        locales: [...], // Define which locales to use
        licenseConfiguration: { license in ... }  // Customize the license
    )
}
```

To use KeyboardKit Pro with a custom view, just call **setupPro** and provide it with any custom view in ``KeyboardInputViewController/viewWillSetupKeyboard()``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setupPro(
            withLicenseKey: "your-key",
            locales: [...], // Define which locales to use
            licenseConfiguration: { license in ... }  // Customize the license,
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

You can use any Pro features from your license once `licenseConfiguration` is called. You don't have to provide locales if you have a Gold license, since Gold licenses include all locales.
 



## How to set up KeyboardKit for an app

You can use KeyboardKit in your main app target, to check keyboard and Full Access state, provide shared settings, link to System Settings, etc.


### KeyboardKit

You don't have to set up KeyboardKit in any way in the main app target. Just import KeyboardKit in any file where you want to use it, and you're good to go.


### KeyboardKit Pro

To set up KeyboardKit Pro for your main app target (or any target where you don't have an input controller) just call **License.register(licenseKey:locales:)** to register your license key: 

```swift
@main
struct MyApp: App {

    init() {
        Task {
            do {
                let license = try await License.register(...)
                // KeyboardKit Pro is now activated.
            } catch {
                // Handle the error in any way you want.
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

You'll be able to use your license once **License.register** completes. If you need to use any Pro features on the root screen, just use some observed state to force a view update.



## How to set up KeyboardKit as a package dependency

To set up KeyboardKit as a package dependency, just add it to the package dependencies and link it to any target that needs it.


### KeyboardKit Pro

Since KeyboardKit Pro is a binary target, it requires some special handling to be used as a transient package dependency:

* You don't have to link to KeyboardKit Pro from any target.
* You *must* update **runpath search paths** under **Build Settings**.
    * For the main app, set it to **@executable_path/Frameworks**.
    * For the keyboard, set it to **@executable_path/../../Frameworks**.

Failing to set the search paths will cause a runtime crash when you try to use KeyboardKit Pro.  



## How to use KeyboardKit state and services

``KeyboardInputViewController`` has shared observable ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``. It will inject all state as environment objects into the view hierarchy, to let you access them like this:

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

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services, to clearly communicate the dependencies of all views.



## How to register custom state and services

You can easily modify any observable ``KeyboardInputViewController/state`` and replace any standard service in ``KeyboardInputViewController/services``.

For instance, here we disable autocomplete, using the shared ``AutocompleteContext``, and replace the default ``StandardKeyboardActionHandler`` with a custom action handler:

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

Since services are lazy and resolved when they're used for the first time, you should set up any custom services as early as possible.



## Going further

You should now have a basic understanding of how to set up KeyboardKit and KeyboardKit Pro, and how to use and customize the shared state and services.

For more information and examples, see the various articles and take a look at the demo apps.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
