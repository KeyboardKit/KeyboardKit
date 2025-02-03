# App Utilities

This article describes the KeyboardKit app-specific utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit has app-specific utilities to help you build a great main app for your keyboard, sync data between the app & keyboard, etc. 

👑 [KeyboardKit Pro][Pro] unlocks app-specific screens, like a home screen template, and various settings screens, to help you get your main app up and running in minutes. Information about Pro features can be found further down.



## Keyboard App

You can create an app-specific ``KeyboardApp`` value to define and set up your app & keyboard, by defining your app's  ``KeyboardApp/name``, ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, ``KeyboardApp/licenseKey``, ``KeyboardApp/deepLinks-swift.property``, etc. See the <doc:Getting-Started> and <doc:Essentials> articles for more information.

The ``KeyboardApp`` type is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen``, ``KeyboardApp/LocaleScreen``, and ``KeyboardApp/ThemeScreen`` that are unlocked by KeyboardKit Pro.




## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of the main app, to set up KeyboardKit for your specific ``KeyboardApp``:

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

This will set up KeyboardKit features and App Group data sync, register your KeyboardKit Pro license, etc. It will also inject all keyboard ``Keyboard/State`` into the environment, which means that you can access any context like this:

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
                ![KeyboardApp.HomeScreen](app-homescreen)
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
                ![KeyboardApp.SettingsScreen](app-settingsscreen)
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
                ![KeyboardApp.SettingsScreen](app-localescreen)
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
                ![KeyboardApp.SettingsScreen](app-themescreen)
            }
            @Column {
                A ``KeyboardApp/ThemeScreen`` can be used as a main theme picker screen of a keyboard app or in a keyboard extension.
                
                The screen list available themes in shelves, and will by default set the main, persisted ``KeyboardThemeSettings/theme`` when a theme is tapped.
                
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

> Important: For settings to sync between the main app and its keyboard extension, you must replace the main ``KeyboardSettings`` ``KeyboardSettings/store`` with an App Group-synced store. This is easily done by adding an ``KeyboardApp/appGroupId`` to your ``KeyboardApp`` value.
