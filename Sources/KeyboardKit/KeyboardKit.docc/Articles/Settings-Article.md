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

Apps and keyboards can also navigate to System Settings to enable the keyboard extension, enable full access etc. Reading settings from the system is however strictly restricted by iOS, due to privacy reasons.

KeyboardKit provides tools to make this easier, such as ``Foundation/URL`` extensions and custom navigation links.



## Keyboard Settings

KeyboardKit has an observable ``KeyboardSettings`` class that defines common keyboard settings, as well as ways to define which ``KeyboardSettings/store`` and ``KeyboardSettings/storeKeyPrefix`` to use when persisting settings within the library.

Other namespaces have their own settings types, like ``AutocompleteSettings``, ``DictationSettings``, ``FeedbackSettings``, etc. These types will automatically persist changes and can sync changes between the app and keyboard (see further down).

The ``KeyboardInputViewController`` has a ``KeyboardInputViewController/settings`` property for shared settings and will automatically sync its ``KeyboardInputViewController/state`` with ``KeyboardInputViewController/settings`` when the keyboard is launched, and when any settings changes are made.

> Important: Since `@AppStorage` will use the store that is available when it's first called, you must register a custom store as soon as possible, before reading any values. Use ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` to sync settings across an App Group. 



## How to sync settings between the app and the keyboard

You can use ``KeyboardSettings/setupStore(_:keyPrefix:)`` to set up a custom settings store, or ``KeyboardSettings/setupStore(withAppGroup:keyPrefix:)`` to set up a store that automatically syncs settings between the main app and its keyboard extension.

The main app will always write data to an App Group in a way that is instantly available to the keyboard. A keyboard must however have Full Access enabled for changes to be immediately synced to the app. When Full Access is disabled, the sync will be less reliable.



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



## How to access System Settings values

A common feature request is to be able to access various settings from System Settings, for instance autocapitalization & autocorrect preferences that the user has configured.

This is not possible, at least not with the public APIs. This is most probably due to privacy concerns, and unfortunately means that your app must provide its own keyboard settings.
