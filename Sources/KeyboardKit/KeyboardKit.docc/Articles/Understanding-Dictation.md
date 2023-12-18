# Understanding Dictation [BETA]

This article describes the KeyboardKit dictation engine.

Dictation can be used to let users enter text by speaking instead of typing. This can however be hard to implement, since keyboard extensions can't access the microphone.

KeyboardKit therefore defines dictation-specific types that you can use to implement dictation for either your keyboard extension or main app.

[KeyboardKit Pro][Pro] unlocks dictation services that can be easily configured to perform dictionary in your app as well as in your keyboard extension. Information about Pro features can be found at the end of this article.



## Dictation namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types.

For instance, the ``DictationService`` protocol describes how to perform dictation where microphone access is available, while the ``KeyboardDictationService`` protocol describes how to perform it in a keyboard, where microphone access is *not* available.

KeyboardKit doesn't have a standard dictation service as it has for other services. Instead, it adds a disabled service to ``KeyboardInputViewController/services`` until you register a custom instance or register a KeyboardKit Pro license key.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level of the library.



## Dictation context

KeyboardKit has an observable ``DictationContext`` class that can be used to handle dictation state, such as the currently dictated text, in which application dictation was started, etc.

KeyboardKit automatically creates an instance of this class and registers it with ``KeyboardInputViewController/state``, then updates it during dictation.



## How to perform dictation

Dictation works differently in applications, where microphone access is available, and in keyboard extensions, where it's not available.


### How to perform dictation in an app

You can use a ``DictationService`` to perform dictation where microphone access is available.

To start dictation within an application, just call ``DictationService/startDictation(with:)`` and observe the ``KeyboardContext`` to see if dictation is started, to get the dictated text, fetch any errors, etc.

A ``DictationService`` can call ``DictationService/requestDictationAuthorization()`` to ask for user permissions. You can call it manually as well, before starting the operation, to avoid interrupting the first dictation with an alert.

Since dictation may stop at any time, for instance due to silence, a ``DictationService`` should describe how to access the result. For instance, KeyboardKit Pro's **ProDictationService** will continously update a ``DictationContext`` to let you observe the dictated text.


### How to perform dictation in a keyboard extension

You can use a ``KeyboardDictationService`` to perform dictation in keyboard extensions, where microphone access isn't available.

While in-app dictation works right away, keyboard dictation must open the app to start dictation or open an audio bridge, then write the dictated text to shared storage and return to the keyboard to let it process the result. 

This can be tricky to set up, but KeyboardKit Pro lets you configure this in a few, simple steps.


### How to visualize the dictation progress

KeyboardKit Pro unlocks a bunch of dictation-related views, like **Dictation.BarVisualizer**, **Dictation.Screen**, etc. which can be used to visualize an ongoing dictation progress.




## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks services and tools that let you setup and perform dictation with a few simple steps, with very little coding.


### Services

KeyboardKit Pro unlocks a **ProDictationService** service that can be used within the main app, and a **ProKeybpardDictationService** that can be used to trigger dictation from the keyboard extension.


### Supported languages

By default, the speech recognizer that is used by KeyboardKit Pro supports the following languages:

English, Arabic, Catalan, Croatian, Czech, Danish, Dutch, Finnish, French, German, Greek, Hebrew, Hungarian, Indonesian, Italian, Malay, Norwegian, Polish, Portuguese, Romanian, Russian, Slovak, Spanish, Swedish, Turkish, Ukrainian

If you want to use dictation with other languages, you must implement a custom speech recognizer.


### Dictation views

KeyboardKit Pro unlocks dictation-specific views, like **Dictation.Screen** and **Dictation.BarVisualizer**, that you can use to build a nice dictation experience in your app or keyboard.



## How to perform dictation with KeyboardKit Pro

Dictation requires some configuration, but KeyboardKit Pro makes it easy to do. The following information describes how to setup a keyboard dictation that starts dictation from a keyboard and performs it in the app. 


#### Step 1. Set up required permissions

Before you can use dictation, you must add these keys to your app's `Info.plist`:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```

If you don't add these keys, your app will crash when you try to start dictation.


#### Step 2. Create an App Group

To share data between an app and its keyboard, you must create an app group and enable it for both the app and the keyboard: 

![Set up an App Group for the app](dictation-appgroup-app.jpg)

![Set up an App Group for the keyboard](dictation-appgroup-keyboard.jpg)


#### Step 3. Create a deep link

To make it possible for the keyboard extension to open the app, you must set up a custom deep link URL scheme:

![Set up a URL Scheme for the app](dictation-url-scheme.jpg)


#### Step 4. Create a keyboard dictation configuration

Next, create an app-specific ``Dictation/KeyboardConfiguration`` with the App Group ID and deep link that we just set up, then add it to both the main app target and the keyboard extension:

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.my-app"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```


#### Step 5. Add dictation to the keyboard extension

To configure dictation for the keyboard extension, set up the **dictationContext** with the app-specific config we just created:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        let keyboardSettings = keyboardSettings
        setupPro(withLicenseKey: "...") { license in
            state.dictationContext.setup(with: .app)
        } view: { controller in
            // Return your keyboard view here
        }
    }
} 
```


#### Step 6. Add dictation to the main application

To configure keyboard dictation for the app, first register your KeyboardKit Pro license key:

```swift
@main
struct MyApp: App {

    init() {
        registerProLicense()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func registerProLicense() {
        Task {
            try? await License.register(
                licenseKey: "your license key",
            )
        }
    }
}
```

Then create a ``DictationContext`` with the same config and apply it to the app's root view with a **.keyboardDictation(...)** modifier:

```swift
struct ContentView: View {

    @StateObject
    var context = DictationContext(config: .app)

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
        Dictation.Screen(
            dictationContext: context,
            titleView: { EmptyView() },
            indicator: { Dictation.BarVisualizer(isAnimating: $0) }
        )
    } 
}
```

Use the `overlay` parameter to specify the view that will overlay the root view while dictation is active. You can use KeyboardKit Pro's **Dictation.Screen** with any of the built-in visualizers to easily visualize the dictation.


#### 7. Create a speech recognizer

KeyboardKit Pro doesn't contain a `SpeechRecognizer`, since the `Speech` framework would force all apps to specify permissions for dictation, even if they aren't using dictation.

Instead, just copy the code below and pass in a `StandardSpeechRecognizer()` in the modifier above:

```swift
import Speech
import KeyboardKitPro

public class StandardSpeechRecognizer: SpeechRecognizer {

    public init() {}

    public var supportedLocales: [KeyboardLocale] {
        [
            .english, .arabic, .catalan, .croatian, .czech,
            .danish, .dutch, .dutch_belgium, .english_gb,
            .english_us, .finnish, .french, .french_belgium,
            .french_switzerland, .german, .german_austria,
            .german_switzerland, .greek, .hebrew, .hungarian,
            .indonesian, .italian, .malay, .norwegian, .polish,
            .portuguese, .portuguese_brazil, .romanian, .russian,
            .slovak, .spanish, .swedish, .turkish, .ukrainian
        ]
    }

    private var resultHandler: ResultHandler?
    private var speechRecognizer: SFSpeechRecognizer?
    private var speechRecognizerRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognizerTask: SFSpeechRecognitionTask?
}

public extension StandardSpeechRecognizer {

    var authorizationStatus: Dictation.AuthorizationStatus {
        SFSpeechRecognizer.authorizationStatus().keyboardDictationStatus
    }

    func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status.keyboardDictationStatus)
            }
        }
    }

    func resetDictationResult() async throws {}

    func startDictation(
        with config: Dictation.Configuration
    ) async throws {
        try await startDictation(with: config, resultHandler: nil)
    }

    func startDictation(
        with config: Dictation.Configuration,
        resultHandler: ResultHandler?
    ) async throws {
        guard let recognizer = setupSpeechRecognizer(for: config) else { throw Dictation.ServiceError.missingSpeechRecognizer }
        guard let request = setupSpeechRecognizerRequest() else { throw Dictation.ServiceError.missingSpeechRecognitionRequest }
        self.resultHandler = resultHandler
        setupSpeechRecognizerTask(for: recognizer, and: request)
    }

    func stopDictation() async throws {
        speechRecognizerRequest?.endAudio()
        speechRecognizerRequest = nil
        speechRecognizerTask?.cancel()
        speechRecognizerTask = nil
    }

    func setupAudioEngineBuffer(_ buffer: AVAudioPCMBuffer) {
        speechRecognizerRequest?.append(buffer)
    }
}

private extension StandardSpeechRecognizer {

    func setupSpeechRecognizer(for config: Dictation.Configuration) -> SFSpeechRecognizer? {
        let locale = Locale(identifier: config.localeId)
        speechRecognizer = SFSpeechRecognizer(locale: locale)
        return speechRecognizer
    }

    func setupSpeechRecognizerRequest() -> SFSpeechAudioBufferRecognitionRequest? {
        speechRecognizerRequest = SFSpeechAudioBufferRecognitionRequest()
        speechRecognizerRequest?.shouldReportPartialResults = true
        return speechRecognizerRequest
    }

    func setupSpeechRecognizerTask(
        for recognizer: SFSpeechRecognizer,
        and request: SFSpeechRecognitionRequest
    ) {
        speechRecognizerTask = recognizer.recognitionTask(with: request) { [weak self] in
            self?.handleTaskResult($0, error: $1)
        }
    }

    func handleTaskResult(_ result: SFSpeechRecognitionResult?, error: Error?) {
        let result = SpeechRecognizerResult(
            dictatedText: result?.bestTranscription.formattedString,
            error: error,
            isFinal: result?.isFinal ?? true)
        resultHandler?(result)
    }
}
```

#### 8. Perform dictation

You can now start dictation in your keyboard by triggering a ``KeyboardAction/dictation`` action or calling ``KeyboardDictationService/startDictationFromKeyboard(with:)``. 

If everything is correctly configured, the keyboard should open your app to start dictation, then return to the keyboard when dictation finishes. The keyboard will then automatically read the dictated text and send it to the document.

Override ``KeyboardInputViewController/viewWillHandleDictationResult()`` if you want to customize how your keyboard handles the dictation result. 

> Important: In a DocumentGroup, the .keyboardDictation modifier only works if a document is open. To work around this, you can instead check if isDictationStartedByKeyboard is true. If so, present a sheet or modal and add .keyboardDictationOnAppear to its root view.


#### 9. Return to the keyboard

Once dictation is done, the app should return to the keyboard to let it handle the dictated text.

KeyboardKit Pro used to have a **PreviousAppNavigator** that was used to navigate back to the previous app, but it stopped working in iOS 17. When the updated code was rejected by Apple, this functionality has been removed.

Since KeyboardKit can't add these implementations to the library, you have to implement the return operation yourself. To do so, inherit **ProKeyboardDictationService**, override **tryToReturnToKeyboard** and inject your service into the **keyboardDictation** modifier:

```swift
class CustomDictationService: ProKeyboardDictationService {

    override func tryToReturnToKeyboard() {
        // Add your code here
    }
}
```

See <doc:Understanding-Navigation> for the two previous implementations that were previously used by the library. Although they will both be rejected by Apple, perhaps they can give you some inspiration.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
