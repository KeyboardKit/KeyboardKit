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

In KeyboardKit, a ``DictationService`` can start autocomplete from a keyboard extension, by opening the main app and let it perform the dictation operation, then return to the keyboard and apply the dictated text once dictation completes.

👑 [KeyboardKit Pro][Pro] unlocks a ``Dictation/StandardService`` to handle dictation. Information about Pro features can be found further down.



## Namespace

KeyboardKit has a ``Dictation`` namespace that contains dictation-related types, like ``Dictation/AuthorizationStatus`` & ``Dictation/ServiceError``, as well as views that are unlocked by KeyboardKit Pro, like ``Dictation/Screen`` & ``Dictation/BarVisualizer``. 



## Context

KeyboardKit has a ``DictationContext`` that provides observable dictation state that is kept up to date as dictation is performed. It also has auto-persisted ``AutocompleteContext/settings-swift.property`` that can be used to configure the dictation behavior.

KeyboardKit automatically creates an instance of this class, injects it into ``KeyboardInputViewController/state`` and updates it whenever dictation is performed.



## Services

In KeyboardKit, a ``DictationService`` can start autocomplete from a keyboard by opening the main app and let it perform dictation, then let the main app try to return to the keyboard and apply the dictated text.

KeyboardKit doesn't have a standard dictation service, as it has for other services. Instead, it injects a ``DictationService/disabled`` dictation service into ``KeyboardInputViewController/services`` until you register [KeyboardKit Pro][pro] or inject your own service implementation.


---

## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks services that let you setup and perform dictation in your app and from your keyboard, with very little code.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Services

KeyboardKit Pro unlocks a ``Dictation/StandardService`` that can be used to perform dictation from a keyboard extension and in its main app.

The service's speech recognizer supports: **english, english_gb, english_us, arabic, catalan, croatian, czech, danish, dutch, dutch_belgium, finnish, french, french_belgium, french_switzerland, german, german_austria, german_switzerland, greek, hebrew, hungarian, indonesian, italian, malay, norwegian, polish, portuguese, portuguese_brazil, romanian, russian, slovak, spanish, swedish, turkish, ukrainian**.


### Views

KeyboardKit Pro adds views to the ``Dictation`` namespace, that let you quickly add dictation visualization views to your main app:

@TabNavigator {
    
    @Tab("Screen") {
        
        @Row {
            @Column {
                ![DictationScreen](dictationscreen)
            }
            @Column {
                KeyboardKit Pro unlocks a dictation ``Dictation/Screen`` that lets you overlay your app with a custom dictation view while dictation is active. 
                
                The screen will automatically fade in when dictation is started, if you use the Pro keyboard dictation view modifiers.
                
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
                KeyboardKit Pro unlocks a ``Dictation/BarVisualizer`` that can be used to visualize ongoing dictations with a set of animated bars. You can change the number of bars, the colors & thickness of each bar, etc.
                
                This view can be styled with a ``Dictation/BarVisualizerStyle``, which can be applied with a ``SwiftUICore/View/dictationScreenStyle(_:)`` modifier.
            }
        }
    }
}


---


## How to...

### Perform dictation

Dictation works differently in apps, where microphone access is available, and in keyboard extensions, where mic access is unavailable. You can use a ``DictationService`` to perform dictation from both a keyboard extension, as well as in the main app.

Before your app can perform dictation, you must configure your app to require the correct permissions. This is described further down.

To make your keyboard extension start dictation, just trigger ``DictationService/startDictationFromKeyboard()`` or a ``KeyboardAction/dictation`` action. This will make the keyboard open the main app to perform dictation, then (try to) return to the keyboard once it's is done.

To make your main app perform dictation that is started by its keyboard, just apply a `.keyboardDictation` view modifier to its root view. You dont have to do this when you use a ``KeyboardAppView``, since it does this automatically.

To make your main app perform dictation without keyboard integration, just trigger ``DictationService/startDictationInApp()``. Since a dictation operation may stop at any time, a ``DictationService`` should describe how to access the dictated result.

> Important: iOS 17 caused keyboard back navigation to stop working. KeyboardKit Pro uses a list of known host applications to fix this, but this may fail at any time. You can override ``DictationService/returnToKeyboardFromApp()`` to customize the behavior and observe the ``DictationContext/returnToKeyboardFromAppError`` to show a custom UI that tells the user how to return to the keyboard with the top-leading system back arrow.


### Configure your app to handle dictation

This article describes how to set up an app to start dictation from its keyboard extension and perform the dictation in the main app.


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

To make it possible for the keyboard to open the app, you must set up a deep link URL scheme for the app target:

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

To set up dictation for your keyboard extension, just call ``KeyboardInputViewController/setup(for:)`` with a properly configured ``KeyboardApp``, as described in the <doc:Getting-Started-Article> article. Your ``KeyboardApp`` must define a ``KeyboardApp/DeepLinks-swift.struct/dictation`` deep link, or at least an ``KeyboardApp/DeepLinks-swift.struct/app`` deep link to use the standard link.


#### Step 6 - Set up dictation in your main application

To set up dictation for your main app, just wrap its root view in a  ``KeyboardAppView``, as described in the <doc:Getting-Started-Article> article, then apply any of the available `keyboardDictation` view modifiers to make the app trigger dictation:

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

If everything is correctly configured, the keyboard extension should open its main app to start dictation. Once dictation is done, the app should return to the keyboard to handle the dictated text.

You can override ``KeyboardInputViewController/viewWillHandleDictationResult()`` to customize how the keyboard controller handles the dictation result.

KeyboardKit Pro tries to work around the native back navigation limitations by using the ``DictationContext``'s ``KeyboardHostApplicationProvider/hostApplication`` to identify and open the previous app. Since this approach only supports the most popular apps, it may fail in many cases.

If back navigation fails, your dictation screen must inform the user how to return to the keyboard, which can be done by swiping back or tapping the top-trailing back arrow. You can observe ``DictationContext/returnToKeyboardFromAppError`` to know when this happens. 
