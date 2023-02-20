# Settings

This article describes the KeyboardKit settings utilities and how to use them.


## Getting the URL to your app's System Settings screen

KeyboardKit has a ``KeyboardSettingsUrlProvider`` protocol that provides any type that implements it with a static `.keyboardSettings` URL that leads to your app's System Settings screen.

```swift
let url: URL = .keyboardSettings
```

This protocol is implemented by `URL`, which means that you can use `URL.keyboardSettings` to get the URL.


## Keyboard settings link

KeyboardKit also has a ``KeyboardSettingsLink`` that will navigate the user to the settings url when tapped.

The link supports using a custom title, image and even url, although it will by default use values that make sense.


## Random behavior

If you have used the url above, you may have noticed that it sometimes leads to your app’s System Settings screen, as expected, while at other times it just takes you to the System Settings root.

This random behavior makes for a bad user experience, since it may be hard for users to find your app in System Settings, if they have to navigate to it from the root screen…if they even know that it exists. This can lead to users not being able to enable or configure your keyboard.

Although this random behavior is bad, fixing it is actually very easy. All you have to do is just to add an empty Settings Bundle to your app, after which the app will consistently take you to the correct place in System Settings, instead of randomly taking you to the settings root.
