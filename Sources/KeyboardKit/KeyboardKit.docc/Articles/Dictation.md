# Dictation (BETA)

This article describes the KeyboardKit dictation engine and how to use it.

In KeyboardKit, a ``DictationService`` can be used to perform dictation where microphone access is available, like an app, while a ``KeyboardDictationService`` can be used to perform dictation where microphone access is *not* available, such as in a keyboard extension.

KeyboardKit will use the ``KeyboardInputViewController`` ``KeyboardInputViewController/dictationService`` as the standard dictation service, which may use the ``KeyboardInputViewController/dictationContext`` to manage shared data. 

KeyboardKit doesn't have any standard dictations services as it has for most other services. Instead, it will use disabled services until you register real ones.

[KeyboardKit Pro][Pro] unlocks a ``StandardDictationService`` and a ``StandardKeyboardDictationService``. These features are described at the end of this document.



## How to perform dictation

You can use a ``DictationService`` to perform dictation where microphone access is available, such as in an app.

You can start dictating with ``DictationService/startDictation(with:)`` and stop with ``DictationService/stopDictation()``. Since dictation may stop at any time, for instance by silence, a dictation service must describe how to access the result when the operation completes.

For instance, the ``StandardDictationService`` will continously update a ``DictationContext`` to let you observe and display the current dictation state.

A dictation service can call ``DictationService/requestDictationAuthorization()`` to ask the user for the required permissions before starting a dictation operation. You can call this function manually as well, to avoid interrupting the first dictation operation with alerts.



## How to perform dictation from a keyboard extension

You can use a ``KeyboardDictationService`` to perform dictation where microphone access is *not* available, such as in a keyboard extension. 

A keyboard dictation service should open the app and make it perform dictation, then write the text to shared storage and return to the keyboard extension to let it process the result.

This can be tricky to set up, but KeyboardKit Pro lets you do it in a few simple steps.



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a ``StandardDictationService`` and a ``StandardKeyboardDictationService`` when you register a valid license. 

These services implement the keyboard dictation flow described above with a few simple steps and minimum action required from your side.

This is all you have to do to get keyboard dictation working in your app.


### 1. Set up permissions in the app

Before you can perform dictation in the app, you must add these keys to your `Info.plist`, otherwise the app will crash:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```

This only has to be added to the main app target, since dictation will be performed in the app and not in the kyboard.


### 2. Set up an App Group to share data

To share data between the app and the keyboard, you must create an app group and enable it for both the app and the keyboard: 

![Set up an App Group for the app](dictation-appgroup-app.jpg)

![Set up an App Group for the keyboard](dictation-appgroup-keyboard.jpg)

The app and keyboard will now be able to exchange data, for instance with a `UserDefaults(suiteName:)` instance. 


### 3. Set up a deep link for the app

To make it possible for the keyboard to open the app, you must register a custom URL scheme in your app target:

![Set up a URL Scheme for the app](dictation-url-scheme.jpg)

The keyboard extension will now be able to open the app by opening a url with the form `<YOUR-URL-SCHEME>://<PATH>`.


### 4. Set up a dictation configuration

To be able to perform dictation, you must create an app-specific ``KeyboardDictationConfiguration``.

This configuration only has to define your app-specific App Group ID and Deep Link, for instance:

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.my-app"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```

Make sure to make this configuration available to both the app and the keyboard, since they both need it.


### 5. Trigger dictation from the keyboard

KeyboardKit Pro will automatically register a dictation service when you register a valid license, otherwise you have to register a custom service to handle dictation.

You can then start dictation from the keyboard extension by calling the service like this:

```swift
dictationService.startDictationFromKeyboard(with: .app)
```

However, a much cleaner alternative is to call ``DictationContext/setup(with:)`` with your app-specific configuration, to set up dictation for your entire extension. The standard action handler will then use this information when handling the ``KeyboardAction/dictation`` action, which means that you can add dictation buttons to your keyboard, and automatically have them start dictation.

If you have set everything up correctly, your keyboard will now open the main app and try to get it to start dictation.


### 6. Perform dictation in the app

To make your app automatically perform dictation, you must register a pro license when the app starts, then apply a `.keyboardDictation` view modifier to the application's root view:

```swift
import SwiftUI

@main
struct MyApp: App {

    init() {
        _ = try? License.register(licenseKey: "LICENSE-KEY")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {

    @StateObject
    var context = DictationContext()

    var body: some View {
        NavigationStack(path: $path) {
            ...
        }
        .keyboardDictation(
            context: context, 
            config: .app, 
            speechRecognizer: recognizer,   // See further down
            overlay: overlay
        )
    }

    func overlay() -> some View {
        DictationOverlay(
            dictationContext: context,
            titleView: { EmptyView() },
            indicator: { DictationEqualizer(isAnimating: $0) }
        )
    } 
}
```

You can customize the standard dictation overlay view or provide a completely custom view.

The modifier will automatically detect when the app is launched with the dictation deep link, and if so use the speech recognizer to set up a standard keyboard dictation service and start dictating using it.

Once the app stops dictating, the service will return the user to the keyboard.


### 7. Wrap up dictation in the keyboard

When the service returns the user to the keyboard, the keyboard will automatically try to finish dictation by reading the dictated text and send it to the document.

If you want to customize how the controller performs dictation, you can override ``KeyboardInputViewController/viewWillPerformDictation()`` and inject your custom logic to the mix.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
