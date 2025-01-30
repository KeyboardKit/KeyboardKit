# Getting Started

This guide describes how to get started with KeyboardKit.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

This guide goes through the steps of adding [KeyboardKit][KeyboardKit] or [KeyboardKit Pro][Pro] to your project and setting up the main app and keyboard.



## Step 1. Add KeyboardKit to your project

The easiest way to add KeyboardKit to your app or package is with the Swift Package Manager. You can either use [KeyboardKit][KeyboardKit] or the more capable, commercially licensed [KeyboardKit Pro][Pro]:


```
https://github.com/KeyboardKit/KeyboardKit.git      // or...
https://github.com/KeyboardKit/KeyboardKitPro.git
```

KeyboardKit must be linked to the main app target *and* its keyboard extension, while KeyboardKit Pro must only be added to the app. 


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Step 2. Define app-specific information

The easiest way to set up KeyboardKit is with a ``KeyboardApp``, which can define ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, a ``KeyboardApp/licenseKey``, etc.

```swift
import KeyboardKit (or KeyboardKitPro)

extension KeyboardApp {

    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit",
            licenseKey: "your-key-here",                // Sets up KeyboardKit Pro!
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

Define this in a file that you add to both the app and its keyboard extension, to easily refer to it from both. See <doc:App-Article> for more info.



## Step 3. Set up the keyboard extension

To set up a keyboard to use KeyboardKit, first inherit ``KeyboardInputViewController`` instead of ``UIKit/UIInputViewController``:

```swift
import KeyboardKit (or KeyboardKitPro)

class KeyboardController: KeyboardInputViewController {}
```

This gives you access to lifecycle functions like ``KeyboardInputViewController/viewWillSetupKeyboardView()``, observable ``KeyboardInputViewController/state``, keyboard ``KeyboardInputViewController/services``, etc.

Override ``KeyboardInputViewController/viewDidLoad()`` and call ``KeyboardInputViewController/setup(for:)`` (or ``KeyboardInputViewController/setupPro(for:errorDisplay:completion:)`` if you use [KeyboardKit Pro][Pro]) to set up the keyboard extension for your app:

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
            setupPro(for: .keyboardKitDemo) { result in
                // This is called when the license registration completes
            }
        }
    }
    ```
    }
}

This will make the keyboard ``Keyboard/Settings`` sync data between the keyboard extension and its main app if you define a valid ``KeyboardApp/appGroupId``, set up your KeyboardKit Pro license if you define a ``KeyboardApp/licenseKey``, set up dictation, deep links, etc.

This also makes the keyboard use a standard ``KeyboardView`` that is configured for your app. Override ``KeyboardInputViewController/viewWillSetupKeyboardView()`` and call ``KeyboardInputViewController/setupKeyboardView(_:)`` to replace or customize the ``KeyboardView``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboardView() {
        setupKeyboardView { [weak self] controller in // <-- Use weak or unknowned if you must use self!
            CustomKeyboardView( 
                state: controller.state
                services: controller.services
            )
        }
    }
}

// Defining a custom view in a separate file keeps your controller clean.
struct CustomKeyboardView: View {

    var state: Keyboard.State
    var services: Keyboard.Services

    // State can also be accessed from the enviroment.
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        if keyboardContext.keyboardType == .email {
            // Insert your GPT-powered email client here :)
        } else {
            KeyboardView(
                state: state,
                services: services,
                buttonContent: { $0.view },        // Use $0.view to use the standard view
                buttonView: { $0.view },           // The $0 has additional parameter data             
                collapsedView: { params in params.view },   // This is the same as $0.view
                emojiKeyboard: { $0.view },        
                toolbar: { _ in CustomToolbar() }  // Ignores the params and returns a view
            )
        }
    }
}
```

> Warning: ``KeyboardInputViewController/setupKeyboardView(_:)`` provides you with an unowned controller, to help you avoid memory leaks. If you must refer to your specific controller type, you MUST use `[weak self]` or `[unowned self]`, or the self reference will cause a memory leak!



## Step 4. Set up the main app (optional)

You can use KeyboardKit in your main app, to display the enabled and Full Access status of your keyboard, link to System Settings, etc. It's a great place for app and keyboard settings, since it has more space than in the keyboard extension.

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

You can use the KeyboardKit Pro ``KeyboardApp/HomeScreen`` to easily set up a start screen for the app, or link to the individual ``KeyboardApp/SettingsScreen``, ``KeyboardApp/LocaleScreen``, and ``KeyboardApp/ThemeScreen`` screens from any screen. You can also use a status ``KeyboardStatus/Section`` to show keyboard status.


## Step 5. Customize state & services (optional)

The main ``KeyboardInputViewController`` provides you with keyboard ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``, to let you build great keyboards. 

KeyboardKit injects observable state into the view hierarchy as environment objects, which lets you access various state types like this:

```swift
struct CustomView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: some View {
        ...
    }
}
```

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services.

You can replace any services with custom implementations. For instance, here we replace the standard ``KeyboardActionHandler``:

@TabNavigator {
    
    @Tab("KeyboardKit") {
    ```swift
    class KeyboardViewController: KeyboardInputViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            setup(for: .keyboardKitDemo)
            services.actionHandler = CustomActionHandler(controller: self)
        }
    }
    ```
    }
    
    @Tab("KeyboardKit Pro 👑") {
    ```swift
    class KeyboardViewController: KeyboardInputViewController {
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupPro(for: .keyboardKitDemo) { _ in 
                services.actionHandler = CustomActionHandler(controller: self)
            }
        }
    }
    ```
    }
}

```swift
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



## Bonus - Set up KeyboardKit as a package dependency

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
    
    > Important: You don't have to link to KeyboardKit Pro from any target that adds *your* package, but the target *must* update its **runpath search paths** under **Build Settings**. Use **@executable_path/Frameworks** for the main app and **@executable_path/../../Frameworks** for the keyboard. Failing to set the search paths will cause a runtime crash when you try to use KeyboardKit Pro.
    }
}



## That's it!

You should now have a fully functional keyboard extension and companion app, which you can customize even further to fit your needs. For more information, see the <doc:Essentials> article, as well as the other articles in this documentation.


---


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
