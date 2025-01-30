# App Utilities

This article describes the KeyboardKit app-specific utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit has app-specific utilities to help you build a great main app for your keyboard, like setting that automatically setting up your keyboard and app with a ``KeyboardApp``, syncing settings between the app and its keyboard, and much more.   

👑 [KeyboardKit Pro][Pro] unlocks app-specific screens, like a home screen template, and various settings screens, to help you get your main app up and running in minutes. Information about Pro features can be found further down.



## Keyboard App

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` that are unlocked by KeyboardKit Pro.

You can create an app-specific ``KeyboardApp`` value to define and set up your app & keyboard, by defining your app's  ``KeyboardApp/name``, ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, ``KeyboardApp/licenseKey``, ``KeyboardApp/deepLinks-swift.property``, etc.

You can create a static app value and add it to both the main app and its keyboard extension, to easily refer to it from both, for instance:

```swift
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

Your ``KeyboardApp`` can specify other properties you may need. See <doc:Dictation-Article> and <doc:Autocomplete-Article> and <doc:AI-Article> for more information. 

> Important: The ``KeyboardApp``'s ``KeyboardApp/locales`` collection is only meant to describe which locales you *want* to use in your app and keyboard. It will be capped to the number of locales that your KeyboardKit Pro license includes.


## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of a keyboard app target, to set up everything needed to use KeyboardKit for a certain ``KeyboardApp``:

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

This will set up things that are defined by the ``KeyboardApp``, like making keyboard setting use an App Group to sync between the app and its keyboard, register a KeyboardKit Pro license key, set up dictation, etc. It will also inject all keyboard ``Keyboard/State`` into the environment:

```swift
struct ContentView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: View {
        ...
    }
}
```

The injected state will also be used by the KeyboardKit Pro screens that are described below.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks screens in the ``KeyboardApp`` namespace, that let you quickly add keyboard-related features to the main app.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        @Row {
            @Column {
                ![KeyboardApp.HomeScreen](keyboardapp-homescreen)
            }
            @Column {
                A ``KeyboardApp/HomeScreen`` can be used as the main screen of a keyboard app, to let you quickly get your main app up and running. 
                
                The screen shows the main app icon, a keyboard status section, links to settings screens, custom header & footer content, etc.
            }
        }
    }
    
    @Tab("SettingsScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
            }
            @Column {
                A ``KeyboardApp/SettingsScreen`` can be used as the main settings screen of a keyboard app or in a keyboard extension. 
                
                The screen lists various keyboard settings, grouped by type. All changes are automatically synced to the various context types.
            }
        }
    }
    
    @Tab("LocaleScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-localescreen)
            }
            @Column {
                A ``KeyboardApp/LocaleScreen`` can be used as the language settings screen in a keyboard app or in a keyboard extension. 
                
                The screen lists all added and all available locales, and lets users add and reorganize locales that are used by the keyboard.
            }
        }
    }
    
    @Tab("ThemeScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-themescreen)
            }
            @Column {
                A ``KeyboardApp/ThemeScreen`` can be used as a main theme picker screen of a keyboard app or in a keyboard extension.
                
                The screen list available themes in shelves, and will by default set the main, persisted ``KeyboardTheme/Settings/theme`` when a theme is tapped.
                
                Since you may not want to support themes in your keyboard, this screen is opt-in when using a ``KeyboardApp/HomeScreen``.
            }
        }
    }
}

All screens have view modifiers to let you toggle the visibility of certain parts of the screen, and style and localize them to fit your needs:

```swift
NavigationView {
    KeyboardApp.HomeScreen(
        app: .myApp,
        appIcon: Image(.icon),
        header: {},
        footer: textFieldSection
    )
    .navigationTitle("KeyboardKit")
}
.keyboardAppHomeScreenLocalization(
    .init(keyboardSectionFooter: "Here's a custom footer text.")
)
.keyboardAppHomeScreenStyle(
    .init(appIconSize: 150)
)
.keyboardAppHomeScreenVisibility(
    .init(keyboardSection: true)
)
.navigationViewStyle(.stack)
```

Check out the type documentation in the KeyboardKit Pro documentation, or the demo app for some examples on how to use this view.

> Important: For settings to sync between the main app and its keyboard extension, you must replace the main keyboard settings ``Keyboard/Settings/store`` with an App Group-synced store. You can use the ``KeyboardAppView`` to do this in the main app, and call  ``Keyboard/Settings/setupStore(forAppGroup:keyPrefix:)`` in the keyboard extension's `viewDidLoad()` function.
