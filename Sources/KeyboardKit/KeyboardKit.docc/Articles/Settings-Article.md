# Settings

This article describes the KeyboardKit settings engine.

Great keyboard apps use the main app to show the current state of the keyboard, if the keyboard is enabled in System Settings, if Full Access is enabled, etc.

To provide a great user experience, apps can also navigate to System Settings to enable the keyboard extension, enable full access etc.

KeyboardKit provides tools to make this easier, such as ``Foundation/URL`` extensions and custom navigation links.



## How to open System Settings

KeyboardKit defines a ``Foundation/URL/keyboardSettings`` URL that can be used to open your app's keyboard settings in System Settings. You can use a standard SwiftUI link to open this URL from your app or your keyboard:

```swift
if let url = URL.keyboardSettings {
    Link("Open System Settings", destination: url)
}
```

You can also use the convenient, configurable ``KeyboardSettingsLink``:

```swift
KeyboardSettingsLink {
    Text("Open System Settings")
}
```

To trigger a URL from the keyboard, you can trigger a ``KeyboardAction/url(_:id:)`` action to make the ``KeyboardActionHandler`` open the URL.

> Note: If your app randomly navigates to the System Settings root instead of your app, try adding an empty settings bundle to your app.



## How to share settings between the app and the keyboard

Many keyboard extensions open the main app to let users configure the keyboard. The larger UI is great for app and keyboard settings.
See the <doc:Navigation-Article> article for information on how to open the main app from the keyboard.

To share data between the app and the keyboard, you can use an **App Group** to persist data in a way that allows it to be shared by the app and its keyboard extension.

The app will always write data to the App Group, in a way that makes it instantly available to the keyboard. The keyboard must however have **Full Access** enabled for changes to be immediately synced to the app. 

> Important: When Full Access is disabled, any shared data that your keyboard modifies will sync less reliably, and may require an app restart for the app to see the updated result.



## How to access System Settings

A common feature request is to be able to access various settings from System Settings, for instance autocapitalization & autocorrect preferences that the user has configured.

This is not possible, at least not with the public APIs. This is most probably due to privacy concerns, and unfortunately means that your app must provide its own keyboard settings.
