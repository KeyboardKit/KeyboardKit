# App Utilities

This article describes the KeyboardKit app-specific utilities.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

KeyboardKit has utilities that simplify building a great main app for your keyboard, like setting that automatically sync between the app and its keyboard, auto-registering your KeyboardKit Pro license, and much more.   

👑 [KeyboardKit Pro][Pro] unlocks app screens for the main app target. Information about Pro features can be found at the end of this article.



## Namespace

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` screens that are unlocked by KeyboardKit Pro.



## Keyboard App

You can create a ``KeyboardApp`` to define and set up your app and keyboard, by defining the app's  ``KeyboardApp/name``, ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, ``KeyboardApp/licenseKey``, ``KeyboardApp/deepLinks-swift.property``, etc.

You can create a static app value and add it to both the main app target and its keyboard extension target, to easily refer to it from both:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            licenseKey: "keyboardkit-pro-license-key",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo"
        )
    }
}
```

Your app-specific ``KeyboardApp`` can also resolve other properties that you may need, e.g. to perform keyboard-based dictation.

> Important: The ``KeyboardApp``'s ``KeyboardApp/locales`` collection is only meant to describe which locales you *want* to use in your app and keyboard. It will be capped to the number of locales that your KeyboardKit Pro license includes.


## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of a keyboard app target, to set up everything needed to use KeyboardKit.

To use it, just wrap your app's root view in a  ``KeyboardAppView`` and pass in your app-specific ``KeyboardApp`` value:

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

This will set up everything that is defined by the ``KeyboardApp``, like setting up ``KeyboardSettings`` to use an App Group, register a KeyboardKit Pro license key, set up dictation, etc. It will also inject keyboard ``Keyboard/State`` into the view, to let you access state values like this:

```swift
struct MyView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: View {
        ...
    }
}
```

The injected state will also be used by the KeyboardKit Pro screens that are described below.



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
                A ``KeyboardApp/HomeScreen`` can be used as the main screen of a keyboard app. It shows the main app icon, a keyboard status section, links to settings screens, custom header & footer content, etc.
            }
        }
    }
    
    @Tab("SettingsScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
            }
            @Column {
                A ``KeyboardApp/SettingsScreen`` can be used as the main settings screen of a keyboard app or extension. It lists various keyboard settings that are grouped by type.
            }
        }
    }
    
    @Tab("LocaleScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-localescreen)
            }
            @Column {
                A ``KeyboardApp/LocaleScreen`` can be used as the language settings screen in a keyboard app or extension. It lists added and available locales and lets users reorganize locales that are added to the keyboard.
            }
        }
    }
    
    @Tab("ThemeScreen") {
        @Row {
            @Column {
                ![KeyboardApp.SettingsScreen](keyboardapp-themescreen)
            }
            @Column {
                A ``KeyboardApp/ThemeScreen`` can be used as a main theme picker screen of a keyboard app or extension. It list available themes in shelves, and will by default set the main ``KeyboardThemeContext/theme``.
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

> Important: For settings to sync between the main app and its keyboard extension, you must replace the main keyboard settings ``KeyboardSettings/store`` with an App Group-synced store. You can use the ``KeyboardAppView`` to do this in the main app, and call  ``KeyboardSettings/setupStore(forAppGroup:keyPrefix:)`` in the keyboard extension's `viewDidLoad()` function.
