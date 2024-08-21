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

KeyboardKit provides many utilities for the main app target, that simplify building a great keyboard app, like setting up settings that sync between the app and the keyboard, auto-registering your KeyboardKit Pro license, and much more.   

👑 [KeyboardKit Pro][Pro] unlocks app screens for the main app target. Information about Pro features can be found at the end of this article.



## Keyboard App Namespace

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` screens that are unlocked with KeyboardKit Pro.



## Keyboard App

The ``KeyboardApp`` type can be used to define important properties for your app, such as ``KeyboardApp/name``, ``KeyboardApp/licenseKey`` (for KeyboardKit Pro), ``KeyboardApp/bundleId`` (for keyboard status inspection), ``KeyboardApp/appGroupId`` (sync data between the app and keyboard), deep links, etc.

You can create a static app value and add it to both the main app target and its keyboard extension target, to easily refer to it from both:

```swift
static var keyboardKitDemo: Self {
    .init(
        name: "KeyboardKit",
        licenseKey: "abc123",
        bundleId: "com.keyboardkit.demo",
        appGroupId: "group.com.keyboardkit.demo",
        locales: [.english, .swedish, .persian],
        dictationDeepLink: "keyboardkit://dictation"
    )
}
```

Your app-specific ``KeyboardApp`` can also resolve other properties that you may need, such as a ``KeyboardApp/dictationConfiguration``. It will be even more used in future versions of KeyboardKit, so make sure to start using it today.

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

[KeyboardKit Pro][Pro] unlocks screens in the ``KeyboardApp`` namespace, to let you quickly add keyboard-related features to your main app.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        The ``KeyboardApp``.``KeyboardApp/HomeScreen`` can be used as the home screen of a keyboard app. It can render an app icon, the keyboard status, settings links, and any custom header and footer. All links and options can be hidden, styled and localized to fit your needs. 
    
        ![KeyboardApp.HomeScreen](keyboardapp-homescreen)
    }
    
    @Tab("LocaleScreen") {
        The ``KeyboardApp``.``KeyboardApp/LocaleScreen`` can be used as the main language settings screen in the app. It lists added and available locales, and let users add and reorganize the locales that should be used by the keyboard. It automatically syncs with the ``KeyboardContext``.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-localescreen)
    }
    
    @Tab("SettingsScreen") {
        The ``KeyboardApp``.``KeyboardApp/SettingsScreen`` can be used as the main keyboard settings screen in the app. It renders a list options that let user configure the keyboard, and automatically syncs with all injected contexts.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
    }
}

Check out the type documentation in the KeyboardKit Pro documentation, or the demo app for some examples on how to use this view.

> Important: Note that for settings to sync between the main app and the keyboard extension, you must replace ``KeyboardSettings/store`` with an App Group-based store. You can use the ``KeyboardAppView`` to do this in the main app, and call  ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` when the keyboard launches.
