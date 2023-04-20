# Dictation (BETA)

This article describes the KeyboardKit dictation engine and how to use it.

In KeyboardKit, a ``DictationService`` can be used to perform dictation where microphone access is available, like an app, while a ``KeyboardDictationService`` can be used from a keyboard extension, where microphone access is *not* available.

KeyboardKit will use the ``KeyboardInputViewController`` ``KeyboardInputViewController/dictationService`` as the standard dictation service, which may use the ``KeyboardInputViewController/dictationContext`` to manage shared data. 

KeyboardKit doesn't have any standard dictations services as it has for most other services. Instead, it will use disabled services until you register real ones.

[KeyboardKit Pro][Pro] unlocks a ``StandardDictationService`` and a ``StandardKeyboardDictationService``. These features are described at the end of this document.



## How to perform dictation

You can use a ``DictationService`` to perform dictation where microphone access is available, such as in an app.

Before you can perform dictation, you must add these keys to your `Info.plist`, otherwise the app will crash:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```

You can then start dictating with ``DictationService/startDictation(with:)`` and stop it with ``DictationService/stopDictation()``. Since dictation may stop at any time, for instance by silence, services must describe how to access the result when the operation completes.

For instance, the ``StandardDictationService`` will continously update the observable ``DictationContext`` to let you observe and display the current dictation state.

A dictation service should call ``DictationService/requestDictationAuthorization()`` to ask the user for the required permissions before starting a dictation operation. You can call this function manually as well, to avoid interrupting the first dictation operation.



## How to perform dictation from a keyboard extension

You can use a ``KeyboardDictationService`` to dictate from a keyboard extension, where microphone access is *not* available. The service should open the app and perform dictation, write the text to shared storage then return to the keyboard extension and wrap up.

This can be tricky to set up, but KeyboardKit Pro lets you do it in a few simple steps.


## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a ``StandardDictationService`` and a ``StandardKeyboardDictationService`` when you register a valid license. The services implement the keyboard dictation flow described above with just a few simple steps. 


### 1. Set up permissions in the app

Before you can perform dictation in the app, you must add these keys to your `Info.plist`, otherwise the app will crash:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```

This does not need to be added to the keyboard extension, since dictation will be performed in the app.


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

To be able to perform dictation, you must create a ``KeyboardDictationConfiguration`` that defines which App Group ID and Deep Link that should be used for your specific app, for instance:

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.my-app"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```

Make sure to make this configuration available to both the app and the keyboard.


### 5. Trigger dictation from the keyboard

KeyboardKit Pro will automatically register a dictation service when you register a valid license, otherwise you have to register a custom service to handle dictation. You can then trigger dictation with the service:

```swift
dictationService.startDictationFromKeyboard(with: .app)
```

If you have set everything up correctly, the keyboard will now open the app. Future versions will make this even easier, but now you must call this function yourself.


### 6. Perform dictation in the app

You can automatically let your app perform dictation by registering your license in the app and adding the `.keyboardDictation` view modifier to the root view. This will automatically show a configurable overlay when the dictation starts, for instance:

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
        }.keyboardDictation(context: context, config: .app) {
            DictationOverlay(
                dictationContext: context,
                titleView: { EmptyView() },
                indicator: { DictationIndicator(isDictating: $0) }
            )
        }
    }
}
```

You can customize the standard dictation overlay view or provide a completely custom view.


### 7. Wrap up dictation in the keyboard

Once the app stops dictating, the service will return the user to the keyboard, where the keyboard extension will automatically try to finish dictation by reading the dictated text and send it to the document.

If you want to customize how the controller performs dictation, you can override ``KeyboardInputViewController/viewWillPerformDictation()`` and inject your custom logic to the mix.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
