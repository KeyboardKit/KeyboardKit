# Settings

This article describes the KeyboardKit settings engine.

Great keyboard apps use the main app to show the user the current state of the keyboard, if it's enabled in System Settings, if Full Access is enabled, etc.

To provide a great user experience, the app can also navigate the user to System Settings if needed, to enable the keyboard extension, enable full access etc.

KeyboardKit adds utilities to make this easier, such as URL extensions and navigation links.



## How to open System Settings

KeyboardKit has a **URL.keyboardSettings** URL extension that can be used to open your app's keyboard settings in System Settings.

You can use a standard SwiftUI **Link** to open this URL from your app or your keyboard:

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

> Note: If your keyboard randomly navigates to the System Settings root instead of your app, try adding an empty settings bundle to your app.



## How to share settings between the app and the keyboard

Many keyboard extensions open the main app to let users configure the keyboard. The larger UI makes for a great alternative for app and keyboard settings.

See the <doc:Navigation-Article> article for information on how to open the main app from the keyboard.

To share data between the app and the keyboard, you must use an **App Group** to persist data in a way that allows it to be accessed by both the app and the keyboard.

The main app will always write data to an App Group, in a way that makes it instantly available to the keyboard.

A keyboard extension must however have **Full Access** for data to be immediately synced to the app. If **Full Access** is disabled, the data sync will be less reliable and may require an app restart.



## How to access System Settings

A common request is to be able to access various settings from System Settings, for instance the user's autocapitalization and autocorrect preferences.

This is not possible, at least not with the public APIs. This unfortunately means that your app must provide its own keyboard settings.
