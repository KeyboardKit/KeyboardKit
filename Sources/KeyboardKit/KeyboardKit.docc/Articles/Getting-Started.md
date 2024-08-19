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


This article describes how to get started with KeyboardKit and KeyboardKit Pro. Each section will first show you how to do something for KeyboardKit, then for KeyboardKit Pro.



## How to use KeyboardKit

Keyboard extensions can use KeyboardKit to create custom keyboards, while the main app can use it to check keyboard state, provide keyboard-specific settings, link to System Settings, etc.



## How to define app-specific information

KeyboardKit has a ``KeyboardApp`` type can be used to define properties for your app, such as name, bundle ID, App Group ID (which can be used to sync data between the app and keyboard), your KeyboardKit Pro license, deep links, etc:

You can create a static ``KeyboardApp`` value in a file that you add to both your main app target and keyboard extension, to be able to easily refer to your app information from both targets:

```swift
static var keyboardKitDemo: Self {
    .init(
        name: "KeyboardKit",
        bundleId: "com.keyboardkit.demo",
        appGroupId: "group.com.keyboardkit.demo",
        licenseKey: "299-061C-4285-8189-90525BC",
        dictationDeepLink: "keyboardkit://dictation"
    )
}
```  

You can read more about app-specific utilities in the <doc:App-Article> article.



## How to set up KeyboardKit

You need to set up KeybordKit a bit differently when you intend to use it within a keyboard extension, where it will be used to manage typing, than from within the main app target, where it will be used for settings and configurations.


### Keyboard extension

To set up KeyboardKit for a keyboard extension, import `KeyboardKit` and let `KeyboardViewController` inherit the ``KeyboardInputViewController`` base class instead of ``UIInputViewController``:

```swift
import KeyboardKit // or KeyboardKitPro

class KeyboardController: KeyboardInputViewController {}
```

This gives you access to lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboard()``, observable ``KeyboardInputViewController/state``, keyboard ``KeyboardInputViewController/services``, and more.

To use the standard ``KeyboardView``, which mimics a native iOS keyboard, you don't have to do anything else. KeyboardKit will set up everything for you. To customize it or replace it, just override ``KeyboardInputViewController/viewWillSetupKeyboard()`` and call any setup function, for instance:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setup { [weak self] controller in // <-- Use [weak self] or [unowned self] if you need self here.
            KeyboardView(
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

> Warning: A VERY important thing to consider, is that the setup function's view builder provides you with an `unowned` controller reference, since referring to `self` can otherwise cause memory leaks. However, since that is a ``KeyboardInputViewController``, you still need to use `self` to refer to your specific controller. If so, you MUST use `[weak self]` or `[unowned self]`, otherwise the `self` reference will cause a memory leak.


#### 👑 KeyboardKit Pro

KeyboardKit Pro has a `setupPro` function that lets you pass in your KeyboardKit license key. After validating the license, KeyboardKit Pro automatically sets up your license and unlocks all included locales and features.

To use KeyboardKit Pro with a standard ``KeyboardView``, just call `setupPro` without a view in `viewDidLoad`:

```swift
import KeyboardKitPro

class KeyboardViewController: KeyboardInputViewController {

    func viewDidLoad() {
        super.viewDidLoad()
        setupPro(
            withLicenseKey: "your-license-key",
            locales: [...], // Define which locales to use (for Basic & Silver)  
            licenseError: { error in } // Called if the license validation fails.
            licenseConfiguration: { license in } // Called if the license validation succeeds.
        )
    }
}
```

To customize the ``KeyboardView`` or to use a custom view, just call `setupPro` with a view in ``KeyboardInputViewController/viewWillSetupKeyboard()``:

```swift
import KeyboardKitPro

class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        setupPro(
            withLicenseKey: "your-license-key",
            locales: [...], // Define which locales to use (for Basic & Silver)  
            licenseError: { error in } // Called if the license validation fails.
            licenseConfiguration: { license in }, // Called if the license validation succeeds.
            view: { controller in
                // Return a customized KeyboardView or a custom view here
            }
        )
    }
}
```

> Important: Since Basic, Silver, & monthly Gold licenses validate licenses over the Internet, your keyboard extension must enable Full Access to be able to make network requests. This is not needed for yearly Gold and custom licenses, which are validated on-device.  


### How to set up KeyboardKit for an app

You can use KeyboardKit in your main app, to check the enabled and Full Access status of a keyboard, provide keyboard settings, link to System Settings, etc. It's a great place for app settings, since it has more space.

Make sure to call ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` in ``KeyboardSettings`` as early as possible in both your app and your keyboard extension, if you want the persisted properties in the various context to automatically sync between all targets.   


#### 👑 KeyboardKit Pro

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



## How to use State & Services

The main ``KeyboardInputViewController`` provides you with keyboard ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``, to let you build great keyboards. 

### State

KeyboardKit injects all the observable state into the view hierarchy as environment objects when you set it up, which lets you access the various state types like this:

```swift
struct CustomKeyboard: View {

    @EnvironmentObject
    private var context: KeyboardContext

    var body: some View {
        ...
    }
}
```

The observable state types lets you configure the keyboard and its various features. They provide both observable properties and auto-persisted ones, based on how each property should work.

### Services

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services. Examples of services are the ``KeyboardActionHandler`` which handles ``KeyboardAction``s, ``FeedbackService``, etc.

You can replace any services with custom implementations. For instance, here we replace the standard ``KeyboardActionHandler``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(
            inputViewController: self
        )
        super.viewDidLoad()
    }
}

class CustomActionHandler: StandardActionHandler {

    open override func handle(_ action: KeyboardAction) {
        if action == .space {
            print("Pressed space!")
        }
        super.handle(gesture, on: action) 
    }
}
```

Since services are lazy and resolved when they're used for the first time, you should set up any custom services as early as possible, to ensure that the dependency graph is properly resolved.



## Going further

You should now have a basic understanding of how to set up KeyboardKit and KeyboardKit Pro. For more information & examples, see the <doc:Essentials> article, as well as the other articles. Also, take a look at the demo app.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
