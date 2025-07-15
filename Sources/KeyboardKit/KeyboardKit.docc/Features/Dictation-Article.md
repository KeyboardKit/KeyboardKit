# Dictation

This article describes the KeyboardKit dictation engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Dictation can be used to enter text by speaking instead of typing. This can be complicated to set up for a keyboard extension, since a keyboard extensions can't access the microphone, but KeyboardKit makes it easy.

In KeyboardKit, a ``DictationService`` can start dictation from the keyboard extension by opening the main app, perform dictation in the app, then return to the keyboard and apply the dictated text when dictation completes.

👑 [KeyboardKit Pro][Pro] unlocks a ``Dictation/StandardDictationService`` that can be used to perform dictation from the keyboard, as well as dictation-specific views and styles.



## Namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types, like ``Dictation/AuthorizationStatus``, as well as views that are unlocked by KeyboardKit Pro, like ``Dictation/Screen`` & ``Dictation/BarVisualizer``. 



## Context

KeyboardKit has a ``DictationContext`` that has observable dictation state, as well as auto-persisted, dictation-specific ``DictationContext/settings-swift.property``.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever dictation is performed.



## Services

In KeyboardKit, a ``DictationService`` can start autocomplete from a keyboard by opening the main app and let it perform dictation, then return to the keyboard and apply the dictated text.

The open-source project doesn't include a dictation service. Instead, it injects a ``DictationService/disabled`` dictation service into ``KeyboardInputViewController/services`` until you register KeyboardKit Pro or inject your own service implementation.

👑 [KeyboardKit Pro][Pro] unlocks a ``Dictation/StandardDictationService`` that can be used to perform dictation from a keyboard extension, by opening the main app and perform dictation there, then (if possible) return to the keyboard to apply the result.

KeyboardKit Pro will automatically register a standard dictation service as the main ``Keyboard/Services/dictationService`` when a license is registered.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Speech Recognizer

The ``Dictation/StandardDictationService`` requires that you pass in a ``DictationSpeechRecognizer``. You can copy the source code for a standard speech recognizer implementation further down, that supports the following locales: 

Arabic (ar-SA), Cantonese (yue-CN), Catalan (ca-ES), Chinese (zh-CN), Chinese (zh-HK), Chinese (zh-TW), Croatian (hr-HR), Czech (cs-CZ), Danish (da-DK), Dutch (nl-BE), Dutch (nl-NL), English (en-AE), English (en-AU), English (en-CA), English (en-GB), English (en-ID), English (en-IE), English (en-IN), English (en-NZ), English (en-PH), English (en-SA), English (en-SG), English (en-US), English (en-ZA), Finnish (fi-FI), French (fr-BE), French (fr-CA), French (fr-CH), French (fr-FR), German (de-AT), German (de-CH), German (de-DE), Greek (el-GR), Hebrew (he-IL), Hindi (hi-IN), Hindi (hi-IN-translit), Hindi (hi-Latn), Hungarian (hu-HU), Indonesian (id-ID), Italian (it-CH), Italian (it-IT), Japanese (ja-JP), Korean (ko-KR), Malay (ms-MY), Norwegian Bokmål (nb-NO), Polish (pl-PL), Portuguese (pt-BR), Portuguese (pt-PT), Romanian (ro-RO), Russian (ru-RU), Shanghainese (wuu-CN), Slovak (sk-SK), Spanish (es-419), Spanish (es-CL), Spanish (es-CO), Spanish (es-ES), Spanish (es-MX), Spanish (es-US), Swedish (sv-SE), Thai (th-TH), Turkish (tr-TR), Ukrainian (uk-UA), Vietnamese (vi-VN)


## Views

KeyboardKit Pro adds dictation-related views to the ``Dictation`` namespace, to let you quickly add dictation visualization to your app:

@TabNavigator {
    
    @Tab("Screen") {
        
        @Row {
            @Column {
                ![DictationScreen](dictationscreen)
            }
            @Column {
                KeyboardKit Pro unlocks a ``Dictation``.``Dictation/Screen`` that overlays your app with a dictation view when dictation is active.
                
                This view can be styled with a ``Dictation/ScreenStyle``, which can be applied with a ``SwiftUICore/View/dictationScreenStyle(_:)`` modifier.
            }
        }
    }
    
    @Tab("BarVisualizer") {
        
        @Row {
            @Column {
                ![DictationScreen](dictationscreen)
            }
            @Column {
                KeyboardKit Pro unlocks a ``Dictation/BarVisualizer`` that renders a set of animated bars. You can change the number of bars, colors, etc.
                
                This view can be styled with a ``Dictation/BarVisualizerStyle``, which can be applied with a ``SwiftUICore/View/dictationScreenStyle(_:)`` modifier.
            }
        }
    }
}


---


## How to...


### ...perform dictation

Dictation works differently in an app, where microphone access is available, and in a keyboard extension, where it's not. You can use a ``DictationService`` to perform dictation from both your keyboard extension and the main app.

To make your keyboard extension start dictation, just call ``DictationService/startDictationFromKeyboard()`` or trigger a ``KeyboardAction/dictation`` action. This will open the main app, perform dictation, then (try to) return to the keyboard and apply the result.

Dictation will work automatically if you set up KeyboardKit with a ``KeyboardApp``, as is described in <doc:Getting-Started-Article>, and set up the app to handle dictation, as described further down.


### ...manage keyboard/app navigation

Due to Apple's restrictions on how apps can interact with eachother, KeyboardKit Pro will use ``KeyboardHostApplication`` to *try* to identify the keyboard host application, then navigate back to it using a deep link. 

If the host application is *not* known or can't be opened, the user can still tap the top leading back arrow to navigate back to the last app. If the ``DictationContext`` `keyboardHostApplication` is nil, your app should point your users to that back arrow.

See the <doc:Host-Article> for more information on which apps that are currently supported, and how to add more apps to this database.



### ... set up dictation

This section describes how to set up an app to start dictation from its keyboard extension and perform the dictation in the main app.


#### Step 1 - Set up the required permissions

Before you can start dictation, you must add these keys to your app's `Info.plist`, otherwise the app will crash at runtime:

```
<key>NSMicrophoneUsageDescription</key>
<string>Describe why you need microphone access.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Describe why you need speech recognition.</string>
```


#### Step 2 - Create an App Group

To share data between your app and keyboard extension, you must setup a shared app group for both targets:

@Row {
    @Column {
        ![Set up an App Group for the app](dictation-appgroup-app)        
    }
    @Column {
        ![Set up an App Group for the keyboard](dictation-appgroup-keyboard)       
    }
}

Add this App Group ID to your ``KeyboardApp``'s ``KeyboardApp/appGroupId`` property, to properly set up dictation for the keyboard and its main app.


#### Step 3 - Create a deep link

To make it possible for the keyboard to open the app and start dictation, you must set up a deep link URL scheme for the app target:

![Set up a URL Scheme for the app](dictation-url-scheme)

Add this deep link to your ``KeyboardApp``'s ``KeyboardApp/deepLinks-swift.property`` property, to properly set up deep linking for the keyboard and its main app.


#### Step 4 - Create a speech recognizer

KeyboardKit uses a ``DictationSpeechRecognizer`` protocol to decouple KeyboardKit from the Speech framework, to avoid having to specify dictation permissions in apps that don't use dictation.

Here's a standard speech recognizer implementation that you can add to your app and inject into the keyboard dictation view modifier:

```swift
import KeyboardKitPro
import Speech

public extension DictationSpeechRecognizer where Self == StandardSpeechRecognizer {

    static var standard: Self { .init() }
} 

public class StandardSpeechRecognizer: DictationSpeechRecognizer {

    public init() {}

    private var recognizer: SFSpeechRecognizer?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognizerTask: SFSpeechRecognitionTask?

    private typealias Err = Dictation.ServiceError

    public var authorizationStatus: Dictation.AuthorizationStatus {
        SFSpeechRecognizer.authorizationStatus().keyboardDictationStatus
    }

    public var supportedLocales: [Locale] {
        Array(SFSpeechRecognizer.supportedLocales())
    }

    public func requestDictationAuthorization() async throws -> Dictation.AuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status.keyboardDictationStatus)
            }
        }
    }

    public func resetDictationResult() async throws {}

    public func startDictation(
        with locale: Locale
    ) async throws {
        try await startDictation(
            with: locale,
            resultHandler: nil
        )
    }

    public func startDictation(
        with locale: Locale,
        resultHandler: ((Dictation.SpeechRecognizerResult) -> Void)?
    ) async throws {
        recognizer = SFSpeechRecognizer(locale: locale)
        guard let recognizer else { throw Err.missingSpeechRecognizer }
        request = SFSpeechAudioBufferRecognitionRequest()
        request?.shouldReportPartialResults = true
        guard let request else { throw Err.missingSpeechRecognitionRequest }
        speechRecognizerTask = recognizer.recognitionTask(with: request) {
            let result = Dictation.SpeechRecognizerResult(
                dictatedText: $0?.bestTranscription.formattedString,
                error: $1,
                isFinal: $0?.isFinal ?? true)
            resultHandler?(result)
        }
    }

    public func stopDictation() async throws {
        request?.endAudio()
        request = nil
        speechRecognizerTask?.cancel()
        speechRecognizerTask = nil
    }

    public func setupAudioEngineBuffer(_ buffer: AVAudioPCMBuffer) {
        request?.append(buffer)
    }
}
```


#### Step 5 - Set up dictation in your keyboard extension

To set up dictation for your keyboard extension, just set up your keyboard with a ``KeyboardApp`` that defines a ``KeyboardApp/DeepLinks-swift.struct/dictation`` deep link, or an ``KeyboardApp/DeepLinks-swift.struct/app`` deep link with the standard dictation pattern. See the <doc:Getting-Started-Article> article for more information.


#### Step 6 - Set up dictation in your main application

To even be able to start dictation in the main app from the keyboard, make sure to set up the ``KeyboardApp/DeepLinks-swift.struct/dictation`` deep link in your application. 

Next, wrap your app in a  ``KeyboardAppView`` as described in <doc:Getting-Started-Article>, then apply the **.keyboardDictation** view modifier to it:

```swift
struct ContentView: View {

    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var dictationContext: DictationContext
    @EnvironmentObject var keyboardContext: KeyboardContext

    var body: some View {
        ...
        .keyboardDictation(
            dictationContext: dictationContext,
            keyboardContext: keyboardContext,
            openUrl: openURL,
            speechRecognizer: .standard,         // As defined earlier
            overlay: dictationOverlay            // You can use any view
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

#### Step 7 - Perform dictation

You can now start dictation in your keyboard by triggering a ``KeyboardAction/dictation`` action or by calling ``DictationService/startDictationFromKeyboard()``. 

You can override ``KeyboardInputViewController/viewWillHandleDictationResult()`` to customize how the keyboard controller handles the dictation result. If not, the keyboard will automatically send the dictated text to the host application. 
