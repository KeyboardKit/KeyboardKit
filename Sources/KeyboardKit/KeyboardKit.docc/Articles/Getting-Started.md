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


This article describes how to get started with [KeyboardKit][KeyboardKit] and [KeyboardKit Pro][KeyboardKitPro].



## How to use KeyboardKit

Keyboard extensions can use KeyboardKit to create custom keyboards, while the main app can use it to check keyboard state, provide keyboard-specific settings, link to System Settings, etc.



## How to define app-specific information

The easiest way to set up KeyboardKit is to use a ``KeyboardApp``, which can define ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, a ``KeyboardApp/licenseKey`` and ``KeyboardApp/locales`` for KeyboardKit Pro, ``KeyboardApp/deepLinks-swift.property``, etc.

If you define your app in a file that you add to both your app target and keyboard extension, you can easily refer to it from both targets:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            licenseKey: "keyboardkitpro-license-key",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo",
            deepLinks: .init(app: "kkdemo://")
        )
    }
}
```  

You can read more about app-specific utilities in the <doc:App-Article> article.



## How to set up KeyboardKit

You need to set up KeybordKit a bit differently for a keyboard extension, a main app target, and as a dependency to another library.


### How to set up KeyboardKit for a Keyboard extension

To set up KeyboardKit in a keyboard, first inherit ``KeyboardInputViewController`` instead of `UIInputViewController`:

```swift
class KeyboardController: KeyboardInputViewController {}
```

This gives you access to lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboardView()``, observable ``KeyboardInputViewController/state``, keyboard ``KeyboardInputViewController/services``, etc.

To set up the keyboard for your app, just override ``KeyboardInputViewController/viewDidLoad()`` and call ``KeyboardInputViewController/setup(for:)`` (or ``KeyboardInputViewController/setupPro(for:completion:)`` if you use [KeyboardKit Pro][KeyboardKitPro]) with your ``KeyboardApp`` value:


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro


@TabNavigator {
    
    @Tab("KeyboardKit") {
    ```swift
    class KeyboardViewController: KeyboardInputViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            setup(for: .keyboardKitDemo)
        }
    }
    ```
    }
    
    @Tab("👑 KeyboardKit Pro") {
    ```swift
    class KeyboardViewController: KeyboardInputViewController {
    
        // ✨ NEW - Using a KeyboardApp
        override func viewDidLoad() {
            super.viewDidLoad()
            setup(for: .keyboardKitDemo) { result in
                // This is called when the license registration completes
            }
        }
        
        // 🗑️ OLD - Using individual parameters
        override func viewWillSetupKeyboardView() {
            super.viewWillSetupKeyboardView()
            setupPro(
                withLicenseKey: "your-license-key", // Purchased via the web site.
                locales: [...], // Define which locales to use (for Basic & Silver)  
                licenseError: { error in } // Called if the license validation fails.
                licenseConfiguration: { license in }, // Called if the license validation succeeds.
                view: { controller in
                    // Return a customized KeyboardView or a custom view here
                }
            }
        }
    }
    ```
    }
}

This will make the ``KeyboardSettings`` ``KeyboardSettings/store`` sync data between the app and its keyboard if an ``KeyboardApp/appGroupId`` is defined, register a KeyboardKit Pro license if a ``KeyboardApp/licenseKey`` is defined, and set up dictation, deep links, etc.

To replace or customize the standard, English ``KeyboardView``, just override ``KeyboardInputViewController/viewWillSetupKeyboardView()`` and call ``KeyboardInputViewController/setupKeyboardView(_:)-1b18j`` with the view you want to use:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboardView() {
        super.viewWillSetupKeyboardView()
        setupKeyboardView { [weak self] controller in // <-- Use weak or unknowned if you need to use self!
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in CustomToolbar() }
            )
        }
    }
}
```

> Warning: The ``KeyboardInputViewController/setupKeyboardView(_:)-qfea`` view builder provides you with an unowned controller reference, since referring to self may cause memory leaks. However, since it's a ``KeyboardInputViewController`` you still need self to refer to your specific controller. If so, you MUST use `[weak self]` or `[unowned self]`, otherwise the self reference will cause a memory leak.



### How to set up KeyboardKit for the main app target

You can use KeyboardKit in your main app, to manage the enabled and Full Access status of a keyboard, provide keyboard settings, link to System Settings, etc. It's a great place for app settings, since it has more space.

The easiest way to set up an app is to use a ``KeyboardAppView`` root view, which uses a ``KeyboardApp`` to set up everything it needs:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .keyboardKitDemo) {
                ContentView()
            }
            ContentView()
                .task { setupKeyboardKitPro() }
        }
    }
}
```

This will make the ``KeyboardSettings`` ``KeyboardSettings/store`` sync data between the app and its keyboard if an ``KeyboardApp/appGroupId`` is defined, register a KeyboardKit Pro license if a ``KeyboardApp/licenseKey`` is defined, and set up dictation, deep links, etc.

#### Setting up KeyboardKit Pro before 8.9

If you have not yet started using the new ``KeyboardApp`` approach, you must manually register your KeyboardKit Pro license key:

```swift
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

KeyboardKit 9 will exclusively use the ``KeyboardApp`` approach, since it is easier and sets up all you need with a single line of code.



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

KeyboardKit injects observable state into the view hierarchy as environment objects, which lets you access various state types like this:

```swift
struct CustomKeyboard: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: some View {
        ...
    }
}
```

The various state types provide you with observable properties and settings that you can set to update the keyboard view. Settings will auto-persist, and sync between the main app and its keyboard extension if you define an ``KeyboardApp/appGroupId`` for your app. 

### Services

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services.

You can replace any services with custom implementations. For instance, here we replace the standard ``KeyboardActionHandler``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        services.actionHandler = CustomActionHandler(controller: self)
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

Since services are lazy and resolved when they're used for the first time, you should set up any custom services as early as possible.



## Going further

You should now have a basic understanding of how to set up KeyboardKit and KeyboardKit Pro. For more information & examples, see the <doc:Essentials> article, as well as the other articles. Also, take a look at the demo app.



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
