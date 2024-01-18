# Getting Started

This article describes how to get started with KeyboardKit and KeyboardKit Pro.


## How to install KeyboardKit

See the root page for information on how to install KeyboardKit and KeyboardKit Pro.

> Important: Unlike KeyboardKit, KeyboardKit Pro is a binary target and must ONLY be added to the app target. If you add it to any other target, it may crash at runtime.



## How to setup KeyboardKit

KeyboardKit is setup differently when you use it in an app, in a keyboard extension, or as a transient package dependency.

Make sure that you `import KeyboardKit` (or `import KeyboardKitPro` for KeyboardKit Pro) in any file where you intend to use it.



## How to setup KeyboardKit for a keyboard extension

The most common use-case is to use KeyboardKit in a keyboard extension, to create a custom keyboard that is powered by the library.

After installing KeyboardKit, just make your `KeyboardViewController` inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
class KeyboardController: KeyboardInputViewController {}
```

This gives your controller access to new lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable ``KeyboardInputViewController/state``, keyboard-specific ``KeyboardInputViewController/services``, and much more.

KeyboardKit will by use a standard ``SystemKeyboard`` as the default keyboard view. To customize or replace it, override **viewWillSetupKeyboard()** and call any **setup** function with the view you want to use:

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

You don't have to call `setup` if you want to use the standard keyboard view.

You can find more information on how to customize the ``SystemKeyboard`` in <doc:Essentials>.

> Important: The view builder provides you with an unowned controller, to help avoiding memory leaks. Use it to access state and services, and avoid passing it around. If you do, make sure to keep it unowned.



## How to setup KeyboardKit Pro for a keyboard extension

Unlike KeyboardKit, KeyboardKit Pro has **setupPro** functions that let you register a license key, select locales, use the license to configure the keyboard, etc.

To use KeyboardKit Pro with the default keyboard view, just override **viewDidLoad** and call **setupPro** without a view builder:

```swift
func viewDidLoad() {
    super.viewDidLoad()
    setupPro(
        withLicenseKey: "your-key",
        locales: [...], // Define which locales to use
    ) { license in
        // Make any license-based configurations here 
    }
}
```

To use KeyboardKit Pro with a custom keyboard view, override **viewWillSetupKeyboard** and use a **setupPro** function with a view builder:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setupPro(
            withLicenseKey: "your-key",
            locales: [...], // Define which locales to use
            licenseConfiguration: { license in
                // Make any license-based configurations here
            },
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

The `locales` will be capped to the number of locales that your license includes. You don't have to provide locales if you have a Gold license.

You can use any Pro features from your license once the license configuration is called. The view builder is called after the configuration is applied.

> Important: Most Pro features will throw a LicenseError if anything goes wrong, for instance when trying to register an invalid license key, when using a license in an app or on a platform that it doesn't include, when trying to access pro features that it doesn't include, etc.
 



## How to setup KeyboardKit for an app

You can use KeyboardKit in an app, to provide keyboard settings, show keyboard and full access state, link to system settings, etc.

You don't have to setup KeyboardKit in any way. Just import KeyboardKit in any file where you want to use it, and you're good to go.



## How to setup KeyboardKit Pro for an app

To setup KeyboardKit Pro in an app, or any target where you don't have an input controller, just call `License.register(licenseKey:locales:)` to register your license key and activate KeyboardKit Pro.

In an app, you can do this in the main `App` initializer: 

```swift
import SwiftUI
import KeyboardKitPro

@main
struct MyApp: App {

    init() {
        Task {
            do {
                let license = try await License.register(
                    licenseKey: "...",
                    locales: [...]
                )
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

You'll be able to use your license once `register` completes. If you need to use pro features on the root screen, just set some observed state to force a view update when the registration completes.



## How to setup KeyboardKit as a package dependency

To use KeyboardKit as a package dependency, just add it to the package dependencies and link it to any target that needs it.



## How to setup KeyboardKit Pro as a package dependency

Unlike KeyboardKit, KeyboardKit Pro is a binary target that requires some special handling to be used as a transient package dependency.

To use KeyboardKit Pro as a transient dependency, you must configure any app that uses it slightly:

* You don't have to link KeyboardKit Pro in any target.
* You *must* update `runpath search paths` under `Build Settings`.
    * For the main app, set it to `@executable_path/Frameworks`.
    * For the keyboard, set it to `@executable_path/../../Frameworks`.

Failing to set the search paths will cause a runtime crash when the app or keyboard tries to use KeyboardKit Pro.  



## How to use the standard keyboard configuration

``KeyboardInputViewController`` will by default be configured with ``KeyboardInputViewController/services`` and observable ``KeyboardInputViewController/state``.

KeyboardKit will inject all state as environment objects into the view hierarchy, to let you access them like this:

```swift
struct CustomKeyboard: View {

    let actionHandler: KeyboardActionHandler

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

KeyboardKit itself uses init parameters to clearly communicate the dependencies of every view in the library.



## How to customize the standard configuration

You can easily customize the standard configuration by replacing any service with a custom implementation or change any observable state.

For instance, here we replace the default keyboard action handler with a custom one, and disable autocomplete:

```swift
class CustomActionHandler: StandardActionHandler {

    open override func handle(
        _ gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) {
        // Wow, what a useless action handler! 
    }
}

class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(
            inputViewController: self
        )
        super.viewDidLoad()
        state.autocompleteContext.isAutocompleteEnabled = false
    }
}
```

Since service instances are lazy, you should customize them as early as possible to make sure that all other services link to your custom types. 



## Going further

You should now have a basic understanding of how to set up KeyboardKit, how to use the various services and state and how to customize the standard configuration.

For more information and examples, see the various articles and take a look at the demo apps, which replace many services with demo-specific implementations.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
