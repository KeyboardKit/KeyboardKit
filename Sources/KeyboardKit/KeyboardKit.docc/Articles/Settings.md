# Settings

This article describes the KeyboardKit settings engine.


## Getting the URL to your app's System Settings screen

KeyboardKit has a ``KeyboardSettingsUrlProvider`` that provides a static `.keyboardSettings` URL that leads to your app's System Settings screen.

The protocol is implemented by `URL`, which means that you can use `URL.keyboardSettings` to get the URL.

```swift
let url = URL.keyboardSettings
```

> Note: This URL may occasionally navigate users to the System Settings root instead of your app's settings. To avoid this, just add an empty Settings Bundle to your app.



## Views

The ``KeyboardSettingsLink`` can be used to navigate users to your app's System Settings screen. It supports using a custom title, image and even url.
