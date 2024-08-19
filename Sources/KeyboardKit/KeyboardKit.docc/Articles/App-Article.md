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

KeyboardKit provides many utilities for the main app target, that simplifies building a great keyboard app.

👑 [KeyboardKit Pro][Pro] unlocks app views for the main app target. Information about Pro features can be found at the end of this article.



## Keyboard App namespace

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` views that are unlocked with KeyboardKit Pro.



## Keyboard App

The ``KeyboardApp`` type can be used to define important properties for your app, such as bundle ID, App Group ID (which can be used to sync data between the app and keyboard), dictation configurations, etc.

You can create a static ``KeyboardApp`` value in a file that you add to both the main app target and the keyboard extension target, to be able to easily refer to your app from both targets:

```swift
extension KeyboardApp {
    static var keyboardKitDemo: Self {
        .init(
            name: "KeyboardKit",
            bundleId: "com.keyboardkit.demo",
            appGroupId: "group.com.keyboardkit.demo"
            dictationDeepLink: "keyboardkit://dictation"
        )
    }
}
```

The ``KeyboardApp`` can also provide other information, like a ``KeyboardApp/dictationConfiguration``, if you pass in all required information. This makes it easy to keep all app-specific information in a single place.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks views in the ``KeyboardApp`` namespace, that let you quickly add keyboard-related features to your main app.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        The ``KeyboardApp``.``KeyboardApp/HomeScreen`` can be used as the main home screen in a keyboard app. It can renders an app icon, keyboard statuses, settings links, and any  and a list of links and options that can be hidden, styled and localized to fit your needs. 
    
        ![KeyboardApp.HomeScreen](keyboardapp-homescreen)
    }
    
    @Tab("LocaleScreen") {
        The ``KeyboardApp``.``KeyboardApp/LocaleScreen`` can be used as the main language screen in your keyboard app. It renders a list of all added and available locales, and automatically syncs with the keyboard context's ``KeyboardContext/locale`` and ``KeyboardContext/addedLocales`` properties.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-localescreen)
    }
    
    @Tab("SettingsScreen") {
        The ``KeyboardApp``.``KeyboardApp/SettingsScreen`` can be used as the main settings screen in your keyboard app. It renders a list of links and options, that can be hidden, styled and localized to fit your needs.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
    }
}

Check out the type documentation in the KeyboardKit Pro documentation, or the demo app for some examples on how to use this view.

> Important: Note that for settings to sync between the main app and the keyboard extension, you must replace ``KeyboardSettings/store`` with an App Group-based store. You can use ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` to easily do this on app and keyboard launch. 
