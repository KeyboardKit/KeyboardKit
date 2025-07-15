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

KeyboardKit must be linked to the main app target *and* its keyboard extension, while KeyboardKit Pro must *only* be added to the app. 


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Step 2. Define app-specific information

The easiest way to set up KeyboardKit is with a ``KeyboardApp`` that can define a ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, a ``KeyboardApp/licenseKey``, etc.

```swift
import KeyboardKit (or KeyboardKitPro)

extension KeyboardApp {

    static var keyboardKitDemo: KeyboardApp {
        .init(
            name: "KeyboardKit",
            licenseKey: "your-key-here",                // Required by KeyboardKit Pro!
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

Define this in a file that you add to the app *and* its keyboard extension, to be able to use it in both targets. See <doc:App-Article> for more info.



## Step 3. Set up the keyboard extension

To use KeyboardKit, first make your controller inherit ``KeyboardInputViewController`` instead of ``UIKit/UIInputViewController``:

```swift
import KeyboardKit (or KeyboardKitPro)

class KeyboardController: KeyboardInputViewController {}
```

This adds tons of capabilities to the controller, new lifecycle functions, as well as keyboard-specific ``KeyboardInputViewController/services`` and observable ``KeyboardInputViewController/state``.

You can now set up KeyboardKit for the ``KeyboardApp`` we created, by calling ``KeyboardInputViewController/setup(for:completion:)`` in ``KeyboardInputViewController/viewDidLoad()``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the keyboard with the app we created above
        setup(for: .keyboardKitDemo) { result in
            // If the result is `.success`, the setup succeeded.
            // This is where you can setup custom services, etc.
        }
    }
}
```

This will set up ``KeyboardSettings`` to automatically sync data between the app and the keyboard if the ``KeyboardApp`` defines an ``KeyboardApp/appGroupId``, set up KeyboardKit Pro if it defines a ``KeyboardApp/licenseKey``, register deep links, set up dictation, etc.



## Step 4. Customize the keyboard view (optional)

To replace or customize the default ``KeyboardView``, just override ``KeyboardInputViewController/viewWillSetupKeyboardView()`` and call ``KeyboardInputViewController/setupKeyboardView(_:)`` with the view that you want to use:

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

    // These properties are provided when creating the custom keyboard view.
    var state: Keyboard.State
    var services: Keyboard.Services

    // All observable keyboard state can be accessed from the enviroment.
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        if keyboardContext.keyboardType == .email {
            // You can customize your keyboard view for any observable state
        } else {
            KeyboardView(
                state: state,
                services: services,
                buttonContent: { $0.view },        // Use $0.view to use the standard view
                buttonView: { $0.view },           // The $0 arg has additional properties             
                collapsedView: { params in params.view },   // This is the same as $0.view
                emojiKeyboard: { $0.view },        
                toolbar: { _ in CustomToolbar() }  // This code ignores the input parameters
            )
        }
    }
}
```

> Important: Passing in the controller into a keyboard view can easily result in a memory leak, if you forget to make the controller reference weak or unowned. The ``KeyboardInputViewController/setupKeyboardView(_:)`` view builder therefore provides you with an unowned controller reference, to avoid memory leaks. If you must refer to your specific controller type, you MUST use `[weak self]` or `[unowned self]` as you can see above! Also make sure to define your custom view in a separate struct, since this helps avoiding controller misuse.



## Step 5. Set up the main app (optional)

The main app target can be used to display the enabled and Full Access status of your keyboard, link to Settings, etc. It's a great place for keyboard settings, since it has more space than the keyboard extension.

The easiest way to set up an app target is to use ``KeyboardAppView`` as the root view, with the same ``KeyboardApp`` as the keyboard:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .keyboardKitDemo) {
                ContentView() // <-- The "real" app root
            }
        }
    }
}
```

This will set up the app in the same way as the keyboard, register your Pro license before rendering the content view, etc. You can use any view as content view, and use any Pro features you want, since the app view will redraw the content view after registering a license.  

See <doc:App-Article> for more information about how to easily set up a full-blown keyboard app with KeyboardKit Pro's various app utilities.



## Step 6. Customize state & services (optional)

The main ``KeyboardInputViewController`` provides you with keyboard ``KeyboardInputViewController/state`` and ``KeyboardInputViewController/services``, to let you build great keyboards. 

You can change any observable state at any time, to affect the keyboard. For instance, changing the ``Keyboard/State/keyboardContext`` ``KeyboardContext/keyboardType`` will automatically change which keyboard that is rendered. Each observable context also has its own auto-persisted ``KeyboardContext/settings-swift.property``.

KeyboardKit will inject all observable context types into the environment. This means that you can access them from anywhere, like this:

```swift
struct CustomView: View {

    @EnvironmentObject var keyboardContext: KeyboardContext
    
    ...
}
```

Services are not injected into the view hierarchy, and must be passed around. KeyboardKit uses init injection for both state and services.

You can replace any services with custom implementations. For instance, here we replace the standard ``KeyboardActionHandler``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(for: .keyboardKitDemo) { [weak self] _ in
            guard let self else { return }
            self.services.actionHandler = CustomActionHandler(controller: self)    
        }
    }
}

class CustomActionHandler: KeyboardAction.StandardActionHandler {

    open override func handle(_ action: KeyboardAction) {
        if action == .space {
            print("Pressed space!")
        }
        super.handle(action) 
    }
}
```

Since services are lazy and resolved when they're used for the first time, you should set up any custom services as early as possible.

> Important: Any keyboard customizations that rely on Pro features must be made within the ``KeyboardInputViewController/setup(for:completion:)`` completion block.



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
            dependencies: ["KeyboardKitPro"]
        )
    ]
    ```
    
    > Important: You don't have to link KeyboardKit Pro to any target that adds *your* package, but the target *must* update its **runpath search paths** under **Build Settings**. Use **@executable_path/Frameworks** for an app and **@executable_path/../../Frameworks** for its keyboard. Failing to set the search paths will cause a runtime crash when you try to use KeyboardKit Pro.
    }
}



## That's it!

You should now have a fully functional keyboard extension and companion app, which you can customize even further to fit your needs. For more information, see the <doc:Essentials-Article> article, as well as the other articles in this documentation.


---


[KeyboardKit]: https://github.com/KeyboardKit/KeyboardKit
[KeyboardKitPro]: https://github.com/KeyboardKit/KeyboardKitPro
