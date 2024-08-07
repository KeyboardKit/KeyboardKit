# Settings

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit settings engine.

Great keyboard apps use the main app to show the current state of the keyboard, if the keyboard is enabled in System Settings, if Full Access is enabled, etc.

Apps and keyboards can also navigate to System Settings to enable the keyboard extension, enable full access etc. Reading settings from the system is however strictly limited by iOS, due to privacy reasons.

KeyboardKit provides tools to make this easier, such as ``Foundation/URL`` extensions and custom navigation links.



## Keyboard settings

KeyboardKit has an observable ``KeyboardSettings`` class that defines common keyboard settings, as well as ways to define which ``KeyboardSettings/store`` and ``KeyboardSettings/storeKeyPrefix`` to use when persisting settings within the library.

Other namespaces have their own settings types, like ``AutocompleteSettings``, ``DictationSettings``, ``FeedbackSettings``, etc. These types will automatically persist changes and can sync changes between the app and keyboard (see further down).

The ``KeyboardInputViewController`` has a ``KeyboardInputViewController/settings`` property for shared settings and will automatically sync its ``KeyboardInputViewController/state`` with ``KeyboardInputViewController/settings`` when the keyboard is launched, and when any settings changes are made.



## How to sync settings between the app and the keyboard

You can use the ``KeyboardSettings/registerKeyboardSettingsStore(_:keyPrefix:)`` function to register a custom settings store, for instance to sync user settings between the main app and the keyboard using an App Group:

```swift
KeyboardSettings.registerKeyboardSettingsStore(.init(suiteName: "group.com.myapp"))
```

You can access this shared store with the static ``KeyboardSettings/store`` property, or use the computed user defaults ``Foundation/UserDefaults/keyboardSettings`` property.

Apps will always write data to an App Group, in a way that is instantly available to the keyboard. The keyboard must however have Full Access for changes to be immediately synced to the app. When Full Access is disabled, your keyboard will sync changes less reliably.

> Important: Since `@AppStorage` properties will use the store instance that is available when they are first called, you must register a custom store as soon as possible, before setting up KeyboardKit or reading these values. 



## How to open System Settings

KeyboardKit defines a ``Foundation/URL/keyboardSettings`` URL that can be used to open your app's keyboard settings screen in System Settings, where users can enable your keyboard, enable Full Access, etc. 

You can use a standard SwiftUI `Link` to open this URL from both your app and its keyboard extension:

```swift
if let url = URL.keyboardSettings {
    Link("Open System Settings", destination: url)
}
```

You can also open System Settings with a ``KeyboardActionHandler``, by triggering ``KeyboardActionHandler/handle(_:)-35vwk`` with a ``KeyboardAction/url(_:id:)`` action and the ``Foundation/URL/keyboardSettings`` URL.

> Note: If your app randomly navigates to the Settings root instead of your app, try adding an empty settings bundle to your app.



## How to access System Settings

A common feature request is to be able to access various settings from System Settings, for instance autocapitalization & autocorrect preferences that the user has configured.

This is not possible, at least not with the public APIs. This is most probably due to privacy concerns, and unfortunately means that your app must provide its own keyboard settings.
