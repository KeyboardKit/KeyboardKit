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

👑 [KeyboardKit Pro][Pro] unlocks app screens for the main app target. Information about Pro features can be found at the end of this article.



## Keyboard App Namespace

KeyboardKit has a ``KeyboardApp`` struct that is also a namespace for app-related types and views, like the ``KeyboardApp/HomeScreen``, ``KeyboardApp/SettingsScreen`` and ``KeyboardApp/LocaleScreen`` views that are unlocked with KeyboardKit Pro.



## Keyboard App

The ``KeyboardApp`` type can be used to define important app properties, such as ``KeyboardApp/name``, ``KeyboardApp/licenseKey`` (for KeyboardKit Pro), ``KeyboardApp/bundleId`` (for keyboard status inspection), ``KeyboardApp/appGroupId`` (sync data between the app and keyboard), deep links, etc.

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

The app value can also resolve other properties that you may need, such as a ``dictationConfiguration``.

> Important: The ``KeyboardApp/locales`` collection is only meant to describe which locales you *want* to use in your app and keyboard. It will be capped to the number of locales that your KeyboardKit Pro license includes.


## Keyboard App View

The ``KeyboardAppView`` view can be used as the root view of a keyboard app target, to set up everything it needs to use KeyboardKit.

To use this view, just create a ``KeyboardApp`` value as above and pass it into the initializer with your root view:

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

This will inject all ``Keyboard/State`` types into the view hierarchy, setup App Group synced settings with ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` (if you have an ``KeyboardApp/appGroupId``) and register your KeyboardKit Pro license key (if any) to unlock all included pro features.

This means that you will be able resolve any state value like this, without having to set up anything else:

```swift
struct MyView: View {

    @EnvironmentObject
    var keyboardContext: KeyboardContext

    var body: View {
        ...
    }
}
```

You can then change any states from any view within your app, to customize them to fit your need.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks screens in the ``KeyboardApp`` namespace, to let you quickly add keyboard-related features to the main app.

These apps currently require you to either use a ``KeyboardAppView`` to set up your app, as above, or to pass in a properly configured ``Keyboard/State`` value into the various screens to override the environment. If neither is passed in, the views will crash. 

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
