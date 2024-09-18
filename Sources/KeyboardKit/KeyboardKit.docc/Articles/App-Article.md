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

KeyboardKit has utilities that simplify building a great main app for your keyboard, like setting settings to sync between the app and the keyboard, auto-registering your KeyboardKit Pro license, and much more.   

👑 [KeyboardKit Pro][Pro] unlocks app screens for the main app target. Information about Pro features can be found at the end of this article.



## Keyboard App Namespace

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` screens that are unlocked with KeyboardKit Pro.



## Keyboard App

The easiest way to set up KeyboardKit is to use a ``KeyboardApp``, which can be used to define things like ``KeyboardApp/name``, ``KeyboardApp/bundleId``, ``KeyboardApp/appGroupId``, a ``KeyboardApp/licenseKey`` and ``KeyboardApp/locales`` for KeyboardKit Pro, ``KeyboardApp/deepLinks-swift.property``, etc.

You can create a static app value and add it to both the main app target and its keyboard extension target, to easily refer to it from both:

```swift
extension KeyboardApp {

    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            licenseKey: "abc123",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo"
        )
    }
}
```

Your app-specific ``KeyboardApp`` can also resolve other properties that you may need, such as a ``KeyboardApp/dictationConfiguration``. This will be used even more in future versions of KeyboardKit, so make sure to start using it today.

> Important: The ``KeyboardApp``'s ``KeyboardApp/locales`` collection is only meant to describe which locales you *want* to use in your app and keyboard. It will be capped to the number of locales that your KeyboardKit Pro license includes.


## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of a keyboard app target, to set up everything it needs to use KeyboardKit.

To use it, just create a ``KeyboardApp`` value as described above, then pass it into the ``KeyboardAppView`` with your app content view:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .myApp) {
                ContentView()
            }
        }
    }
}
```

This view will set up ``KeyboardSettings`` to use an App Group, register your KeyboardKit Pro license key, if any, and inject ``Keyboard/State`` types into the view, which means that you can access any state value like this:

```swift
struct MyView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: View {
        ...
    }
}
```

You can then change any states from any view within your app, to customize them to fit your need. These contexts will also be used by the KeyboardKit Pro screens that are described below.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks screens in the ``KeyboardApp`` namespace, that let you quickly add keyboard-related features to the main app.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        The ``KeyboardApp/HomeScreen`` can be used as the main screen of a keyboard app. It shows an app icon, a keyboard status section, links to settings screens, and custom header and footer content.
    
        ![KeyboardApp.HomeScreen](keyboardapp-homescreen)
    }
    
    @Tab("LocaleScreen") {
        The ``KeyboardApp/LocaleScreen`` can be used as the main language settings screen in a keyboard app or keyboard extension. It lists all added and available locales and lets users add and reorganize locales that are used by the keyboard.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-localescreen)
    }
    
    @Tab("SettingsScreen") {
        The ``KeyboardApp/SettingsScreen`` can be used as the main settings screen a keyboard app or keyboard extension. It lists options that let the user configure the keyboard, grouped by type.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
    }
    
    @Tab("ThemeScreen") {
        The ``KeyboardApp/ThemeScreen`` can be used as the main theme picker screen of a keyboard app or keyboard extension. It list all available themes in shelves and will by default set the main ``KeyboardThemeContext/theme``, which can be applied with a   ``KeyboardStyle/ThemeBasedService`` style service.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-themescreen)
    }
}

All screens have view modifiers to let you toggle the visibility of certain parts of the screen, and style and localize them to fit your needs. For instance, this is how you set up and customize a home screen:

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

> Important: For settings to sync between the main app and its keyboard extension, you must replace the main keyboard settings ``KeyboardSettings/store`` with an App Group-synced store. You can use the ``KeyboardAppView`` to do this in the main app, and call  ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` in the keyboard extension's `viewDidLoad()` function.
