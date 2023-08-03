# Settings

This article describes the KeyboardKit settings engine and how to use them.


## Getting the URL to your app's System Settings screen

KeyboardKit has a ``KeyboardSettingsUrlProvider`` protocol that provides any type that implements it with a static `.keyboardSettings` URL that leads to your app's System Settings screen.

```swift
let url: URL = .keyboardSettings
```

This protocol is implemented by `URL`, which means that you can use `URL.keyboardSettings` to get the URL.


## Keyboard settings link

KeyboardKit also has a ``KeyboardSettingsLink`` that will navigate the user to the settings url when tapped.

The link supports using a custom title, image and even url, although it will by default use values that make sense.

> Note: To avoid navigating the user to the System Settings root, just add an empty `Settings Bundle` to your app. After that, your app should navigate the user to the app's System Settings, instead of the root screen.
