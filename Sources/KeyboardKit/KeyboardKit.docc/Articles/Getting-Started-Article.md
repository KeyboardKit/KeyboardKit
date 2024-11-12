# Getting Started

This article describes how to get started with KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}


KeyboardKit is a Swift SDK that lets you create fully customizable keyboard extensions in a few lines of code, using SwiftUI. It extends Apple's limited keyboard APIs and provides you with a lot more functionality.

Keyboard extensions can use KeyboardKit to create custom keyboards, while the main app can use it to show keyboard status, provide keyboard-specific settings screens, link to System Settings, etc.

This guide goes through the steps of adding [KeyboardKit][KeyboardKit] or [KeyboardKit Pro][Pro] to your project and setting up the main app and keyboard. 



## Step 1. Add KeyboardKit to your project

The easiest way to add KeyboardKit to your app or package is with the Swift Package Manager. You can either install [KeyboardKit][KeyboardKit] to use the open-source library, or [KeyboardKit Pro][Pro] to use the more capable, commercially licensed product:


```
https://github.com/KeyboardKit/KeyboardKit.git      // or...
https://github.com/KeyboardKit/KeyboardKitPro.git
```

After adding the package to your project, you must link it correctly to be able to use it. KeyboardKit must be added to both the main app target and its keyboard extension, while KeyboardKit Pro must *only* be added to the main app target. 

> Tip: You only have to add KeyboardKit to the main app target if you want to use the library in it, for instance to show keyboard settings. 


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Step 2. Define app-specific information

The easiest way to set up KeyboardKit is to use a ``KeyboardApp``, which can define ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, a ``KeyboardApp/licenseKey`` and ``KeyboardApp/locales`` for KeyboardKit Pro, ``KeyboardApp/deepLinks-swift.property``, etc. See the <doc:App-Article> article for more information.

```swift
import KeyboardKit (or KeyboardKitPro)

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

If you define this info in a file that you add to both the main app and its keyboard extension, you can easily refer to it from both targets.



## Step 3. Set up the keyboard extension

To set up a keyboard to use KeyboardKit, first inherit ``KeyboardInputViewController`` instead of ``UIKit/UIInputViewController``:

```swift
import KeyboardKit (or KeyboardKitPro)

class KeyboardController: KeyboardInputViewController {}
```

This gives you access to lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboardView()``, observable ``KeyboardInputViewController/state``, keyboard ``KeyboardInputViewController/services``, etc.

To set up the keyboard for your app, just override ``KeyboardInputViewController/viewDidLoad()`` and call ``KeyboardInputViewController/setup(for:)`` (or ``KeyboardInputViewController/setupPro(for:errorDisplay:completion:)`` if you use [KeyboardKit Pro][Pro]) with your ``KeyboardApp`` value:

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
    
    @Tab("KeyboardKit Pro 👑") {
    ```swift
    class KeyboardViewController: KeyboardInputViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setup(for: .keyboardKitDemo) { result in
                // This is called when the license registration completes
            }
        }
    }
    ```
    }
}

This will make keyboard ``Keyboard/Settings`` sync data between the app and its keyboard extension if you define a valid ``KeyboardApp/appGroupId``, set up your KeyboardKit Pro license if you define a ``KeyboardApp/licenseKey``, set up dictation, deep links, etc.

This is all you have to do if you want to use the standard ``KeyboardView`` with a standard configuration. Upgrade to KeyboardKit Pro to unlock more locales and features, like autocomplete and an emoji keyboard.

> Important: KeyboardKit Pro has an ``EmojiKeyboard`` that uses high-resolution emojis on iPad. This consumes memory as you scroll through categories, which can become a problem if your keyboard uses memory intense resources, since extensions are memory capped at ~70 MB. If you notice memory-related crashes, consider applying an ``Emoji/KeyboardStyle/optimized(for:)`` emoji style (see below).



## Step 4. Customize the keyboard extension (optional)

You can customize the keyboard and its behavior by customizing its ``KeyboardController/services``, adjusting it's ``KeyboardController/state`` and their settings, customizing the standard ``KeyboardView`` or use a completely custom view, etc.


Just override ``KeyboardInputViewController/viewWillSetupKeyboardView()`` and call ``KeyboardInputViewController/setupKeyboardView(_:)`` to replace or customize ``KeyboardView``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboardView() {
        super.viewWillSetupKeyboardView()
        setupKeyboardView { [weak self] controller in // <-- Use weak or unknowned if you must use self!
            CustomKeyboardView( 
                services: controller.services
            )
        }
    }
}

// Use a custom view if you need to observe some state, like
// the many context classes that KeyboardKit injects.
struct CustomKeyboardView: View {

    // These are not used here, but perhaps you need them.
    var services: Keyboard.Services

    // Keyboard state can be accessed from the enviroment.
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        if keyboardContext.keyboardType == .email {
            // Insert your GPT-powered email client here :)
        } else {
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },        // Use $0.view to use the standard view
                buttonView: { $0.view },           // Each view provides additional parameters than $0.view             
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },        
                toolbar: { _ in CustomToolbar() }  // This ignores the params and uses a custom view
            )
        }
    }
}
```

> Warning: ``KeyboardInputViewController/setupKeyboardView(_:)`` provides you with an unowned controller, to help you avoid memory leaks. If you must refer to your specific controller type, you MUST use `[weak self]` or `[unowned self]`, or the self reference will cause a memory leak!



## Step 5. Set up the main app (optional)

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
        }
    }
}
```

This will make keyboard ``Keyboard/Settings`` sync data between the app and its keyboard extension if you define a valid ``KeyboardApp/appGroupId``, set up your KeyboardKit Pro license if you define a ``KeyboardApp/licenseKey``, set up dictation, deep links, etc.

You can use the KeyboardKit Pro ``KeyboardApp/HomeScreen`` to easily set up a start screen for the app, or link to the individual ``KeyboardApp/SettingsScreen``, ``KeyboardApp/LocaleScreen``, and ``KeyboardApp/ThemeScreen`` screens from any screen. You can also use a status ``KeyboardStatus/Section`` to show keyboard status.


## Step 6. Customize state & services (optional)

The main ``KeyboardInputViewController`` provides you with keyboard ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``, to let you build great keyboards. 

KeyboardKit injects observable state into the view hierarchy as environment objects, which lets you access various state types like this:

```swift
struct CustomKeyboardView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: some View {
        VStack { 
            Button("Show Numeric Keyboard") {
                keyboardContext.keyboardType = .numeric 
            }
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in CustomToolbar() }
            )
        }
    }
}
```

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services.

You can replace any services with custom implementations. For instance, here we replace the standard ``KeyboardActionHandler``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(for: .keyboardKitDemo)
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



## That's it!

You should now have a fully functional keyboard extension and companion app, which you can customize even further to fit your needs. For more information, see the <doc:Essentials-Article> article, as well as the other articles in this documentation.




---


## Advanced

This section contains information for more advanced configurations.

### Set up KeyboardKit as a package dependency

@TabNavigator {
    
    @Tab("KeyboardKit") {
    To set up KeyboardKit as a transient package dependency, just add it to package dependencies and link it to any target that needs it.
    
    ```swift
    ...
    dependencies: [
        .package(
            url: "https://github.com/KeyboardKit/KeyboardKit.git",
            .upToNextMajor(from: "9.0.0")
        )
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["KeyboardKit"]
        )
    ]
    ```
    }
    
    @Tab("KeyboardKit Pro 👑") {
    To set up KeyboardKit Pro as a package dependency, just add it to package dependencies and link it to any target that needs it.
    
    ```swift
    ...
    dependencies: [
        .package(
            url: "https://github.com/KeyboardKit/KeyboardKitPro.git",
            .upToNextMajor(from: "9.0.0")
        )
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["KeyboardKit"]
        )
    ]
    ```
    
    > Important: The KeyboardKit Pro binary may require some special handling to be used as a dependency. You don't have to link to KeyboardKit Pro from any target that adds *your* package, but the target *must* update **runpath search paths** under **Build Settings**. For an app, set it to **@executable_path/Frameworks**. For a keyboard, set it to **@executable_path/../../Frameworks**. Failing to set the search paths will cause a runtime crash when you try to use KeyboardKit Pro.
    }
}



[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
