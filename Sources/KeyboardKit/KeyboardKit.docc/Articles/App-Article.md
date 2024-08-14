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



## KeyboardApp namespace

KeyboardKit has a ``KeyboardApp`` namespace that contains app-related types, that are meant to be used in the main app. It currently only contains utilities when it's part of a KeyboardKit Pro build.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks views in the ``KeyboardApp`` namespace, that let you quickly add keyboard-related features to your main app.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@TabNavigator {
    
    @Tab("HomeScreen") {
        The ``KeyboardApp``.``KeyboardApp/HomeScreen`` can be used as the main home screen of a keyboard app. It renders an app icon, keyboard status, and a list of links and options that can be hidden, styled and localized to fit your needs. 
    
        ![KeyboardApp.HomeScreen](keyboardapp-homescreen)
    }
    
    @Tab("SettingsScreen") {
        The ``KeyboardApp``.``KeyboardApp/SettingsScreen`` can be used as the main settings screen of your keyboard app. It renders a list of links and options, that can be hidden, styled and localized to fit your needs.
    
        ![KeyboardApp.SettingsScreen](keyboardapp-settingsscreen)
    }
}

Check out the type documentation in the KeyboardKit Pro documentation, or the demo app for some examples on how to use this view.

> Important: Note that for settings to sync between the main app and the keyboard extension, you must replace ``KeyboardSettings/store`` with an App Group-based store. You can use ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` to easily do this on app and keyboard launch. 
