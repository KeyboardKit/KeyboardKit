# Settings

This article describes the KeyboardKit settings utilities and how to use them.

KeyboardKit has a ``KeyboardSettingsUrlProvider`` protocol that can be implemented by any type that should be able to resolve a url to the app's settings page in System Settings. This protocol is implemented by `URL`, which means that you can do this:

```swift
let url: URL = .keyboardSettings
```

KeyboardKit also has a ``KeyboardSettingsLink`` that will navigate the user to the settings url when tapped.
