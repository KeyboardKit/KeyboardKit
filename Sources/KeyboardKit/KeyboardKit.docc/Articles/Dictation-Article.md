# Dictation

This article describes the KeyboardKit dictation engine.

Dictation can be used to let users enter text by speaking instead of typing on the keyboard.

Dictation can be hard to implement in keyboards, where no microphone access is available. KeyboardKit therefore provides dictation-specific tools that lets you perform dictation in both the app and keyboard extension.

In KeyboardKit, a ``KeyboardDictationService`` can be used to perform autocomplete from the keyboard. Unlike other service types, there is no open-source implementation of this protocol.

👑 [KeyboardKit Pro][Pro] unlocks dictation services for app- and keyboard-based dictation. Information about Pro features can be found at the end of this article.



## Dictation namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types.


## Dictation context

KeyboardKit has an observable ``DictationContext`` class that handles dictation state, such as the currently dictated text, in which application dictation was started, etc. as well as observable properties to visualize an ongoing dictation.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``, then keeps the context updated during dictation.



## Dictation services

In KeyboardKit, a ``DictationService`` can perform dictation where microphone access is available, while a ``KeyboardDictationService`` can initialize a dictation operation from a keyboard extension, by opening the main app.

KeyboardKit doesn't have standard service  implementations. Instead, it injects a disabled service into ``KeyboardInputViewController/services`` until you replace it with a custom service or activate KeyboardKit Pro.



## How to perform dictation

Dictation works differently in apps, where microphone access is available, and in keyboard extensions, where mic access is unavailable.


### How to perform dictation in an app

You can use a ``DictationService`` to perform dictation where microphone access is available.

To start dictation in an app, just call ``DictationService/startDictation(with:)`` and observe the ``KeyboardContext`` to see if dictation is started, to get and show the dictated text, to detect any errors, etc.

A ``DictationService`` can call ``DictationService/requestDictationAuthorization()`` to ask for user permissions. You can call it manually as well, before starting the operation, to avoid interruption.

Since dictation may stop at any time, e.g. due to silence, a ``DictationService`` should describe how to access the dictated result.


### How to perform dictation in a keyboard extension

You can use a ``KeyboardDictationService`` to perform dictation in a keyboard extension, where the microphone is unavailable.

Keyboard-based dictation must open the app to start dictation or open an audio bridge, then write the dictated text to shared storage and return to the keyboard to process the result. 

This can be tricky to set up, but KeyboardKit Pro lets you configure this in a few, simple steps.

> Important: iOS 17 caused a way to return to the keyboard from the main app to stop working. There's another way to achieve this, but Apple rejects any apps that use it. Until a workaround is found, you must ask your users to tap the back arrow to return to the keyboard.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks services that let you setup and perform dictation in your app and from your keyboard, with very little code.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Views

KeyboardKit Pro unlocks views in the ``Dictation`` namespace, that let you quickly add dictation visualization views to your main app:

@TabNavigator {
    
    @Tab("Screen") {
        KeyboardKit Pro unlocks a dictation ``Dictation/Screen`` that lets you overlay your main app with a custom dictation view while dictation is active:

        @Row {
            @Column {}
            @Column(size: 2) {
                ![DictationScreen](dictationscreen)
            }
            @Column {}
        }
        
        This screen will automatically fade in when a dictation is started, if you use the Pro keyboard dictation view modifiers. It can be styled with a ``Dictation/ScreenStyle``, which can be applied with the ``SwiftUI/View/dictationScreenStyle(_:)`` view modifier.
    }
    
    @Tab("BarVisualizer") {
        KeyboardKit Pro unlocks a ``Dictation/BarVisualizer`` that can be used to visualize an ongoing dictation with a collection of animating bars.

        @Row {
            @Column {}
            @Column(size: 2) {
                ![DictationScreen](dictationscreen)
            }
            @Column {}
        }
        
        You can change the number of bars, the colors & thickness of the bars, etc. The view can be styled with a ``Dictation/BarVisualizerStyle``, which can be applied with a ``SwiftUI/View/dictationScreenStyle(_:)`` view modifier.
    }
}


### Services

KeyboardKit Pro unlocks a ``Dictation/ProService`` that can be used in the main app, and a ``Dictation/ProKeyboardService`` that can initialize dictation from a keyboard extension, perform it in the main app, then return to the keyboard to handle the result.


### Supported languages

The speech recognizer that is used by KeyboardKit Pro supports the following languages:

``KeyboardLocale/english``, ``KeyboardLocale/english_gb``, ``KeyboardLocale/english_us``, ``KeyboardLocale/arabic``, ``KeyboardLocale/catalan``, ``KeyboardLocale/croatian``, ``KeyboardLocale/czech``, ``KeyboardLocale/danish``, ``KeyboardLocale/dutch``, ``KeyboardLocale/dutch_belgium``, ``KeyboardLocale/finnish``, ``KeyboardLocale/french``, ``KeyboardLocale/french_belgium``, ``KeyboardLocale/french_switzerland``, ``KeyboardLocale/german``, ``KeyboardLocale/german_austria``, ``KeyboardLocale/german_switzerland``, ``KeyboardLocale/greek``, ``KeyboardLocale/hebrew``, ``KeyboardLocale/hungarian``, ``KeyboardLocale/indonesian``, ``KeyboardLocale/italian``, ``KeyboardLocale/malay``, ``KeyboardLocale/norwegian``, ``KeyboardLocale/polish``, ``KeyboardLocale/portuguese``, ``KeyboardLocale/portuguese_brazil``, ``KeyboardLocale/romanian``, ``KeyboardLocale/russian``, ``KeyboardLocale/slovak``, ``KeyboardLocale/spanish``, ``KeyboardLocale/swedish``, ``KeyboardLocale/turkish``, ``KeyboardLocale/ukrainian``.

If you want to use dictation with other languages, you must implement a custom recognizer.



## How to perform dictation

This article describes how to set up a dictation that starts in a keyboard extension and is performed in the app, using KeyboardKit Pro.


#### Step 1. Set up required permissions

Before you can start dictation, you must add these keys to your app's `Info.plist`, otherwise the app will crash at runtime:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```


#### Step 2. Create an App Group

To share data between your app and keyboard extension, you must setup a shared app group for both targets:

@Row {
    @Column {
        ![Set up an App Group for the app](dictation-appgroup-app)        
    }
    @Column {
        ![Set up an App Group for the keyboard](dictation-appgroup-keyboard)       
    }
}

> Important: While a keyboard will immediately see data from the app, the app may experience delays if Full Access is disabled for the keyboard.


#### Step 3. Create a deep link

To make it possible for the keyboard to open the app, you must set up a deep link URL scheme for the app target:

![Set up a URL Scheme for the app](dictation-url-scheme)


#### Step 4. Create a keyboard dictation configuration

The next step is to create an app-specific ``Dictation/KeyboardConfiguration``, using the App Group ID and deep link that we just set up.

```swift
extension KeyboardDictationConfiguration {

    static let app = .init(
        appGroupId: "group.com.your-app-name"    
        appDeepLink: "YOUR-URL-SCHEME://dictation"
    )
}
```

Make sure to add this configuration file to both the main app target and the keyboard extension, so that both targets can use it.


#### Step 5. Set up dictation in the keyboard extension

To configure dictation for the *keyboard extension*, set up the global ``Keyboard/State/dictationConfig`` with the app-specific config we just set up:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        let keyboardSettings = keyboardSettings
        setupPro(withLicenseKey: "...") { license in
            state.dictationContext.setup(with: .app)   // <-- Here
        } view: { controller in
            // Return your keyboard view here
        }
    }
} 
```


#### Step 6. Set up dictation in the main application

To configure dictation for the *main app*, first register your KeyboardKit Pro license key, as described in the <doc:Getting-Started> article, then create a ``DictationContext`` with the app-specific config and apply it to the app's root view:

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

The keyboard dictation view modifier has an overlay parameter that defines the view to show while dictation is active. You can use the Pro dictation ``Dictation/Screen`` with any of the built-in dictation visualizers, or a completely custom view.


#### 7. Create a speech recognizer

The Pro keyboard dictation view modifier requires a ``SpeechRecognizer``, which is a protocol that decouples KeyboardKit from the Speech framework, to avoid apps from having to specify dictation permissions when not using speech recognition.

Instead, just add this speech recognizer code to your app, then inject an instance of the class into the keyboard dictation view modifier.

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

You can now start dictation in your keyboard by triggering ``KeyboardAction/dictation`` or by calling ``KeyboardDictationService/startDictationFromKeyboard(with:)``. 

If everything is correctly configured, the keyboard should open the app to start dictation. When the user returns to the keyboard, it will automatically send the dictated text to the text field.

You can override the controller ``KeyboardInputViewController/viewWillHandleDictationResult()`` to customize how the keyboard handles the dictated text. 

> Important: In a DocumentGroup-based app, the .keyboardDictation modifier only works when a document is open. Instead, check if isDictationStartedByKeyboard. If it's true, present a sheet or modal and add .keyboardDictationOnAppear to its root view.


#### 9. Return to the keyboard

Once dictation is done, the app should return to the keyboard to let it handle the dictated text.

KeyboardKit Pro used to have a `PreviousAppNavigator` to automatically navigate back to the keyboard, but this stopped working in iOS 17. A new implementation that worked great was then rejected by Apple, due to using private APIs.

KeyboardKit can't add this code, since it would cause *all* apps to be rejected. To add a custom back navigation implementation, you can inherit ``Dictation/ProKeyboardService`` and override ``Dictation/ProKeyboardService/tryToReturnToKeyboard()``:

```swift
class CustomDictationService: Dictation.ProKeyboardService {

    override func tryToReturnToKeyboard() {
        // Add your code here
    }
}
```

See the <doc:Navigation-Article> for the implementations that were previously used. Although they may be rejected, they may give some inspiration.
