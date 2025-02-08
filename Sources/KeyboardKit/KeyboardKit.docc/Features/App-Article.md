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

👑 [KeyboardKit Pro][Pro] unlocks a ``KeyboardAppView`` that can be used to set up the main app, as well as app-specific screen templates that let you set up a complete main app with just a few lines of code.



## Keyboard App

You can create an app-specific ``KeyboardApp`` value to define and set up your app and keyboard. See the <doc:Getting-Started-Article> & <doc:Essentials-Article> articles for more information.

The ``KeyboardApp`` is also a namespace for app-related types & views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen``, ``KeyboardApp/LocaleScreen``, and ``KeyboardApp/ThemeScreen`` screens that are unlocked by KeyboardKit Pro.




## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of a main app target, to set up KeyboardKit for a certain ``KeyboardApp``:

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

This will set up keyboard features, make the ``KeyboardSettings`` ``KeyboardSettings/store`` sync data between the app and its keyboard, register your KeyboardKit Pro license, etc. It will also inject keyboard ``Keyboard/State`` into the environment, to let you access any context like this:

```swift
struct ContentView: View {

    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: View {
        ...
    }
}
```

The ``KeyboardAppView`` will also inject a ``KeyboardStatusContext`` into the environment, to provide you with keyboard status.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks ``KeyboardApp``-specific screens that let you quickly add keyboard-related features to your main app target.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        @Row {
            @Column {
                ![KeyboardApp.HomeScreen](app-homescreen)
            }
            @Column {
                A ``KeyboardApp/HomeScreen`` can be used as the main screen of a keyboard app, to let you quickly get your main app up and running. 
                
                The screen shows the main app icon, a keyboard status section, links to settings screens, custom header and footer views, etc.
            }
        }
    }
    
    @Tab("SettingsScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](app-settingsscreen)
            }
            @Column {
                A ``KeyboardApp/SettingsScreen`` can be used as the main settings screen of a keyboard app, or in a keyboard extension. 
                
                The screen lists various keyboard settings, grouped by type. All changes are automatically persisted and synced to the keyboard.
            }
        }
    }
    
    @Tab("LocaleScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](app-localescreen)
            }
            @Column {
                A ``KeyboardApp/LocaleScreen`` can be used as the language settings screen in a keyboard app, or in a keyboard extension. 
                
                The screen lists all added and all available locales, and lets users add and reorganize locales, change keyboard layouts, etc.
            }
        }
    }
    
    @Tab("ThemeScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](app-themescreen)
            }
            @Column {
                A ``KeyboardApp/ThemeScreen`` can be used as a main theme picker screen of a keyboard app, or in a keyboard extension.
                
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

> Important: You must use an App Group for settings to sync between your app and its keyboard. See the <doc:Settings-Article> article for more information.
