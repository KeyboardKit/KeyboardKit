# Dictation

This article describes the KeyboardKit dictation engine.

Dictation can be used to let users enter text by speaking instead of typing. This can be hard to implement in a keyboard extension, where microphone access is unavailable.

KeyboardKit therefore provides dictation-specific tools that you can use to add dictation to both your keyboard extension and main app.

[KeyboardKit Pro][Pro] unlocks dictation services that can be used to perform app- and keyboard-based dictation. Information about Pro features can be found at the end of this article.



## Dictation namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types.

This namespace doesn't contain protocols, open classes or types of higher importance.


## Dictation context

KeyboardKit has an observable ``DictationContext`` class that handles dictation state, such as the currently dictated text, in which application dictation was started, etc.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then updates it during dictation.



## Dictation services

In KeyboardKit, a ``DictationService`` can perform dictation where microphone access is available, while a ``KeyboardDictationService`` can do it from a keyboard extension.

KeyboardKit doesn't have a standard dictation service. Instead, it injects a disabled service into ``KeyboardInputViewController/services`` until you register a custom instance or register a KeyboardKit Pro license key.



## How to perform dictation

Dictation works differently in applications, where microphone access is available, and in keyboards.


### How to perform dictation in an app

You can use a ``DictationService`` to perform dictation if microphone access is available.

To start dictation within an application, just call ``DictationService/startDictation(with:)`` and observe the ``KeyboardContext`` to see if dictation is started, to get the dictated text, fetch any errors, etc.

A ``DictationService`` can call ``DictationService/requestDictationAuthorization()`` to ask for user permissions. You can call it manually as well, before starting the operation, to avoid interruption.

Since dictation may stop at any time, for instance due to silence, every ``DictationService`` should describe how to access the dictated result.


### How to perform dictation in a keyboard extension

You can use a ``KeyboardDictationService`` to perform dictation in a keyboard extension.

Keyboard-based dictation must open the app to start dictation or open an audio bridge, then write the dictated text to shared storage and return to the keyboard to process the result. 

This can be tricky to set up, but KeyboardKit Pro lets you configure this in a few, simple steps.

> Important: iOS 17 made a previously working way of returning to the keyboard stop working. There is another way to achieve this, but Apple rejects any apps that uses it. Until a workaround is found, you must instruct your users to tap the back arrow to return to the keyboard.



## Views

KeyboardKit Pro unlocks dictation-related views, that let you inspect the dictation progress.

A **Dictation.Screen** can be used to overlay the app to show an ongoing dictation operation. It can use any visualizer, like a **Dictation.BarVisualizer**.

![DictationScreen](dictationscreen-350.jpg)

The **Dictation.BarVisualizer** can be styled to great extent. You can change the number of bars, the colors and thickness of the bars, etc. 



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks services that let you setup and perform dictation with very little code.


### Services

KeyboardKit Pro unlocks a **ProDictationService** service that can be used within the main app, and a **ProKeyboardDictationService** that can be used to trigger dictation from the keyboard.


### Supported languages

The speech recognizer that is used by KeyboardKit Pro supports the following languages:

English, Arabic, Catalan, Croatian, Czech, Danish, Dutch, Finnish, French, German, Greek, Hebrew, Hungarian, Indonesian, Italian, Malay, Norwegian, Polish, Portuguese, Romanian, Russian, Slovak, Spanish, Swedish, Turkish, Ukrainian

If you want to use dictation with other languages, you must implement a custom recognizer.


### Dictation views

KeyboardKit Pro unlocks dictation-specific views, as mentioned above.



## How to perform dictation with KeyboardKit Pro

KeyboardKit Pro dictation requires some basic configuration. The following text describes how to setup dictation that starts from a keyboard and performs it in the main app.


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

To share data between an app and its keyboard extension, you must setup a shared app group:

![Set up an App Group for the app](dictation-appgroup-app.jpg)

![Set up an App Group for the keyboard](dictation-appgroup-keyboard.jpg)

> Important: While the keyboard will immediately see data written by the app, the app may experience delays in seeing data written by the keyboard, if Full Access isn't enabled.


#### Step 3. Create a deep link

To make it possible for the keyboard to open the app, you must set up a deep link URL scheme:

![Set up a URL Scheme for the app](dictation-url-scheme.jpg)


#### Step 4. Create a keyboard dictation configuration

To configure the dictation, create an app-specific ``Dictation/KeyboardConfiguration`` with the App Group ID and deep link that we just set up.

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.your-app-name"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```

Make sure to add this configuration file to both the main app target and the keyboard extension.


#### Step 5. Set up dictation in the keyboard extension

To configure dictation for the keyboard extension, set up the **dictationContext** with the config:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        let keyboardSettings = keyboardSettings
        setupPro(withLicenseKey: "...") { license in
            state.dictationContext.setup(with: .app) <-- Here
        } view: { controller in
            // Return your keyboard view here
        }
    }
} 
```


#### Step 6. Set up dictation in the main application

To configure dictation for the app, first register your KeyboardKit Pro license key:

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
            try? await License.register(licenseKey: "YOUR-KEY")
        }
    }
}
```

Then create a ``DictationContext`` with the **.app** config and apply it to the app's root view:

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

The **.keyboardDictation** modifier has an **overlay** parameter that defines the view that should overlay the app while dictation is active. 

You can use KeyboardKit Pro's **Dictation.Screen** with any of the built-in dictation visualizers to easily visualize the dictation.


#### 7. Create a speech recognizer

KeyboardKit Pro doesn't contain a `SpeechRecognizer`, since the `Speech` framework would force all apps to specify permissions for dictation, even when not using dictation.

Instead, just copy the code below and use the **StandardSpeechRecognizer** in your dictation.

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

If everything is correctly configured, the keyboard should open the app to start dictation. When the user returns to the keyboard, it will automatically send the dictated text to the text field.

You can override ``KeyboardInputViewController/viewWillHandleDictationResult()`` to customize how the keyboard handles the dictated text. 

> Important: In a DocumentGroup, the .keyboardDictation modifier only works if a document is open. To work around this, check if isDictationStartedByKeyboard is true. If so, present a sheet or modal and add .keyboardDictationOnAppear to its root view.


#### 9. Return to the keyboard

Once dictation is done, the app should return to the keyboard to let it handle the dictated text.

KeyboardKit Pro used to have a **PreviousAppNavigator** that was used to navigate back to the keyboard, but it stopped working in iOS 17. A new implementation was then rejected by Apple.

Since KeyboardKit can't add this to the library, you have to implement the return operation, or instruct your users to tap the back button to return to the keyboard. 

To implement it, inherit **ProKeyboardDictationService** and override **tryToReturnToKeyboard**:

```swift
class CustomDictationService: ProKeyboardDictationService {

    override func tryToReturnToKeyboard() {
        // Add your code here
    }
}
```

You can then inject your custom service into the **keyboardDictation** modifier.


#### 10. Rejected back navigation implementations

See the <doc:Navigation-Article> for the two implementations that were previously used by the library. Although they may be rejected by Apple, they may give you some inspiration.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
