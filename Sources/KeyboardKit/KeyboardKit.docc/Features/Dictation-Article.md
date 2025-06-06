# Dictation

This article describes the KeyboardKit dictation engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Dictation can be used to let users enter text by speaking instead of typing on the keyboard. Since keyboard extensions have no access to the microphone, KeyboardKit lets you trigger dictation from a keyboard extension and perform it in the main app.

In KeyboardKit, a ``DictationService`` can start dictation from the keyboard by opening the main app, perform dictation in that app, then return to the keyboard and apply the dictated text when dictation completes.

Unlike most other service types, the open-source project doesn't include a dictation service. You have to upgrade to KeyboardKit Pro or implement a custom dictation service to be able to use dictation in your keyboard.

👑 [KeyboardKit Pro][Pro] unlocks a ``Dictation/StandardDictationService`` that can be used to perform dictation from the keyboard. Information about Pro features can be found further down.



## Namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types, like ``Dictation/AuthorizationStatus``, as well as views that are unlocked by KeyboardKit Pro, like ``Dictation/Screen`` & ``Dictation/BarVisualizer``. 



## Context

KeyboardKit has a ``DictationContext`` that has observable dictation state, as well as auto-persisted ``DictationContext/settings-swift.property`` that can be used to configure the dictation behavior.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever dictation is performed.



## Services

In KeyboardKit, a ``DictationService`` can start autocomplete from a keyboard by opening the main app and let it perform dictation, then return to the keyboard and apply the dictated text.

Unlike most other service types, the open-source project doesn't include a dictation service. Instead, it injects a ``DictationService/disabled`` dictation service into ``KeyboardInputViewController/services`` until you register [KeyboardKit Pro][pro] or inject your own service implementation.



## Settings

KeyboardKit has a ``DictationSettings`` type with dictation-related state and settings. The context ``DictationContext/settings-swift.property`` is used by default.



## Speech Recognizer

The ``Dictation/StandardDictationService`` requires that you provide a ``DictationSpeechRecognizer`` implementation. You can copy the source code for a standard recognizer below.

The standard dictation speech recognizer supports the following locales: 

Arabic (ar-SA), Cantonese (yue-CN), Catalan (ca-ES), Chinese (zh-CN), Chinese (zh-HK), Chinese (zh-TW), Croatian (hr-HR), Czech (cs-CZ), Danish (da-DK), Dutch (nl-BE), Dutch (nl-NL), English (en-AE), English (en-AU), English (en-CA), English (en-GB), English (en-ID), English (en-IE), English (en-IN), English (en-NZ), English (en-PH), English (en-SA), English (en-SG), English (en-US), English (en-ZA), Finnish (fi-FI), French (fr-BE), French (fr-CA), French (fr-CH), French (fr-FR), German (de-AT), German (de-CH), German (de-DE), Greek (el-GR), Hebrew (he-IL), Hindi (hi-IN), Hindi (hi-IN-translit), Hindi (hi-Latn), Hungarian (hu-HU), Indonesian (id-ID), Italian (it-CH), Italian (it-IT), Japanese (ja-JP), Korean (ko-KR), Malay (ms-MY), Norwegian Bokmål (nb-NO), Polish (pl-PL), Portuguese (pt-BR), Portuguese (pt-PT), Romanian (ro-RO), Russian (ru-RU), Shanghainese (wuu-CN), Slovak (sk-SK), Spanish (es-419), Spanish (es-CL), Spanish (es-CO), Spanish (es-ES), Spanish (es-MX), Spanish (es-US), Swedish (sv-SE), Thai (th-TH), Turkish (tr-TR), Ukrainian (uk-UA), Vietnamese (vi-VN)

> Note: The reason why the standard speech recognizer isn't part of the SDK, is that it requires the **Speech** framework, which requires that apps add certain permission information to the Info.plist, even if they don't use speech recognition.


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks services that let you setup and perform dictation in your app and from your keyboard, with very little code.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Important Information!

When you start dictation from the keyboard, the keyboard will by default open the main app and perform dictation there, after which it will try to return to the keyboard. The reason for this is that the keyboard doesn't have access to the microphone.

Due to Apple's major restrictions on how apps can interact with eachother, the main app will only be able to return to the keyboard if it knows how to open the app in which the keyboard was used. 

KeyboardKit Pro will use its ``KeyboardHostApplication`` capabilities to try to identify the app, and navigate back to it using a deep link. If successful, the keyboard will then read the persisted result and send the text to the host app.

If the host application isn't known or can't be opened, the user can still tap the top leading back arrow to navigate back to the app. You can check the ``KeyboardContext``'s or ``DictationContext``'s optional `keyboardHostApplication`, which is unlocked by Pro.

If the keyboardHostApplication property is nil, this either means that the App Group data sync between the keyboard and the main app doesn't work (see the <doc:Getting-Started-Article> article), or the keyboard application bundle ID is unknown to KeyboardKit Pro. If it's not nil, but its properties say that it can't be opened, then its deep link information may be broken. In that case, please reach out so that we can fix it.

Regardless of the reason why the keyboard can't navigate back, you should adjust the UI to point to the manual navigate back arrow to guide your users if needed.

See the <doc:Host-Article> for more information on which apps that are currently supported, and how to add more apps to this database.



### Services

KeyboardKit Pro unlocks a ``Dictation/StandardDictationService`` that can be used to start dictation from a keyboard extension, by opening the main app and perform dictation there, then return to the keyboard (if possible) to apply the result.


### Views

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

Dictation works differently in apps, where microphone access is available, and in keyboard extensions, where mic access is unavailable. You can use a ``DictationService`` to perform dictation from both a keyboard extension, as well as in the main app.

> Important: Before you can perform dictation, you must configure your app to require the correct permissions. This is described further down.

To make your keyboard extension start dictation, just call ``DictationService/startDictationFromKeyboard()`` or trigger a ``KeyboardAction/dictation`` action. This will open the main app, perform dictation, then (try to) return to the keyboard once it's is done.

To make an app perform dictation that is started by the keyboard, just apply a `.keyboardDictation` modifier to the root view. You can also call ``DictationService/startDictationInApp()`` to perform dictation directly within the app.



### ...configure your app to handle dictation

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

KeyboardKit uses a ``DictationSpeechRecognizer`` protocol to decouple KeyboardKit from the Speech framework, to avoid having to specify dictation permissions in apps that don't use speech recognition.

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

To set up dictation for your keyboard extension, just set up your app and keyboard as described in the <doc:Getting-Started-Article> guide, using a ``KeyboardApp`` that defines a ``KeyboardApp/DeepLinks-swift.struct/dictation`` deep link, or an ``KeyboardApp/DeepLinks-swift.struct/app`` deep link with the standard dictation pattern.


#### Step 6 - Set up dictation in your main application

To even be able to start dictation in the main app from the keyboard, make sure to set up the ``KeyboardApp/DeepLinks-swift.struct/dictation`` deep link in your application. 

Next, wrap your app in a  ``KeyboardAppView`` as described in <doc:Getting-Started-Article>, then apply the **.keyboardDictation** view modifier to it:

```swift
struct ContentView: View {

    @Environment(\.openURL)
    var openURL
    
    @EnvironmentObject
    private var dictationContext: DictationContext

    @EnvironmentObject
    private var keyboardContext: KeyboardContext

    var body: some View {
        KeyboardAppView(for: .keyboardKitDemo) {
            ...
        }
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

If everything is correctly configured, the keyboard extension should open its main app to start dictation. Once dictation is done, the app should return to the keyboard to handle the dictated text, as long as the host application is known (as described above).

You can override ``KeyboardInputViewController/viewWillHandleDictationResult()`` to customize how the keyboard controller handles the dictation result. If not, the keyboard will automatically send the dictated text to the host application. 
