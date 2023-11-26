# Understanding Dictation [BETA]

This article describes the KeyboardKit dictation engine.

Dictation can be used to let users enter text by speaking into the microphone, instead of typing. It can however be hard to implement, since keyboard extensions can't access the microphone.

KeyboardKit defines dictation-specific types that you can use to implement dictation for either your keyboard extension or main app.

[KeyboardKit Pro][Pro] unlocks and registers dictation service implementations that can be easily configured to perform dictionary in either your keyboard extension or main application. Information about Pro features can be found at the end of this article.



## Dictation namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types.

For instance, the ``DictationService`` protocol describes how to perform dictation where microphone access is available, while ``KeyboardDictationService`` describes how to perform dictation in a keyboard, where microphone access is *not* available.

KeyboardKit doesn't have standard dictation services, as it has for other kind of services. Instead, it binds a disabled service instance to ``KeyboardInputViewController/services`` until you replace it with a custom instance or activate KeyboardKit Pro.

The namespace doesn't contain protocols, open classes, or types that are meant to be exposed at the top-level.



## Dictation context

KeyboardKit has an observable ``DictationContext`` class that is used to handle dictation state, such as the currently dictated text, in which application dictation was started, etc.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then updates it during dictation.



## How to perform dictation

Dictation works differently in applications, where microphone access is available, and in keyboard extensions, where it's not available.


### How to perform dictation in an app

You can use a ``DictationService`` to perform dictation where microphone access is available.

To start dictation within an application, just call ``DictationService/startDictation(with:)`` and observe the ``KeyboardContext`` to see if dictation is started, to get the dictated text, fetch any errors, etc.

A ``DictationService`` can call ``DictationService/requestDictationAuthorization()`` to ask for user permissions. You can call it manually as well, to avoid interrupting the first dictation operation with alerts.

Since dictation may stop at any time, for instance due to silence, a dictation service must describe how to access the result. For instance, KeyboardKit Pro's **ProDictationService** will continously update a ``DictationContext`` to let you observe the dictated text.


### How to perform dictation in a keyboard extension

You can use a ``KeyboardDictationService`` to perform dictation in keyboard extensions, where microphone access isn't available.

While in-app dictation works right away, keyboard dictation must open the app to start dictation, then write the dictated text to shared storage and return to the keyboard to let it process the result. 

This can be tricky to set up, but KeyboardKit Pro lets you configure this in a few simple steps.


### How to visualize the dictation progress

KeyboardKit Pro unlocks a bunch of addictation-related views, like **Dictation.BarVisualizer**, **Dictation.Screen**, etc. which can be used to visualize the ongoing dictation progress.




## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks services and tools that let you setup and perform dictation with a few simple steps, with very little coding.


### Services

KeyboardKit Pro unlocks a **ProDictationService** service that can be used within the main app, and a **ProKeybpardDictationService** that can be used to trigger dictation from the keyboard extension.


### Supported languages

By default, the speech recognizer that is used by KeyboardKit Pro supports the following languages:

English, Arabic, Catalan, Croatian, Czech, Danish, Dutch, Finnish, French, German, Greek, Hebrew, Hungarian, Indonesian, Italian, Malay, Norwegian, Polish, Portuguese, Romanian, Russian, Slovak, Spanish, Swedish, Turkish, Ukrainian

If you want to use dictation with other languages, you must implement a custom speech recognizer.


### Additional views

KeyboardKit Pro also unlocks dictation-specific views like overlays and visualizers, that you can use to build a nice dictation experience for your users.



## How to perform dictation with KeyboardKit Pro

Dictation requires some configuration, but KeyboardKit Pro makes it easy to do. 


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

To share data between the app and its keyboard, you must create an app group and enable it for both the main app and the keyboard: 

![Set up an App Group for the app](dictation-appgroup-app.jpg)

![Set up an App Group for the keyboard](dictation-appgroup-keyboard.jpg)


#### Step 3. Create a deep link

To make it possible for your keyboard extension to open your main app, you must set up a custom URL scheme:

![Set up a URL Scheme for the app](dictation-url-scheme.jpg)


#### Step 4. Create a keyboard dictation configuration

Create an app-specific ``Dictation/KeyboardConfiguration`` that uses the App Group ID and deep link that we just set up:

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.my-app"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```


#### Step 5. Configure dictation in the keyboard extension

To configure dictation for a keyboard extension, just set up the **dictationContext** with the app-specific config we just created:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        let keyboardSettings = keyboardSettings
        setupPro(
            withLicenseKey: "your license key",
            licenseConfiguration: { license in
                state.dictationContext.setup(with: .app)
            },
            view: { $0.view }
        )
    }
} 
```


#### Step 6. Configure dictation in the main application

To configure keyboard dictation for an app, first register your KeyboardKit Pro license key:

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

Then create a ``DictationContext`` with the app configuration and apply it to the root view with `.keyboardDictation(...)`:

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




[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
