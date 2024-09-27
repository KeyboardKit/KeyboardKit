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

KeyboardKit has a ``KeyboardSettings`` class that has a ``KeyboardSettings/store`` that is used to persist all persisted properties in all contexts. 

When you set up KeyboardKit with a ``KeyboardApp`` that defines an App Group, the store will automatically be set up to sync data between your app and its keyboard extension.

> Important: `@AppStorage` properties use the store that's available when they're first accessed. Make sure to set up a custom store BEFORE accessing any of these settings properties.



## How to sync settings between the app and the keyboard

To sync data between the main app target and its keyboard extension, you have to create an App Group and link it to both the app and the keyboard.

You can then add the App Group ID to your ``KeyboardApp`` and use that app to set up your main app and keyboard extension, as described in <doc:App-Article>.

You can also use ``KeyboardSettings/setupStore(forAppGroup:keyPrefix:)`` to set up a the settings store for an App Group, without having to use a ``KeyboardApp``.

> Important: The main app will always write data to an App Group in a way that is instantly available to the keyboard. A keyboard must however have Full Access enabled for changes to be immediately synced to the app. When Full Access is disabled, the sync will be less reliable.



## How to open System Settings

KeyboardKit defines a ``Foundation/URL/systemSettings`` URL that can be used to open your app's settings screen in System Settings, where users can enable your keyboard, enable Full Access, etc. 

You can use a standard SwiftUI `Link` to open this URL from both your app and its keyboard extension:

```swift
if let url = URL.systemSettings {
    Link("Open System Settings", destination: url)
}
```

You can also open System Settings with a ``KeyboardActionHandler``, by triggering ``KeyboardActionHandler/handle(_:)-35vwk`` with a ``KeyboardAction/url(_:id:)`` action and the ``Foundation/URL/keyboardSettings`` URL.

> Note: If your app randomly navigates to the Settings root instead of your app, try adding an empty settings bundle to your app.



## How to access System Settings values

A common feature request is to be able to access various settings from System Settings, for instance autocapitalization & autocorrect preferences that the user has configured.

This is not possible, at least not with the public APIs. This is most probably due to privacy concerns, and unfortunately means that your app must provide its own keyboard settings.
