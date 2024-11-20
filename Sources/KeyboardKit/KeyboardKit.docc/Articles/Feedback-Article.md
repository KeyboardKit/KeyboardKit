# Feedback

This article describes the KeyboardKit feedback engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

Feedback is an important part of the typing experience, where a keyboard can trigger audio and haptic feedback when a user taps on a key or performs certain actions.

In KeyboardKit, audio & haptic feedback can be triggered with a ``FeedbackService``, a ``KeyboardActionHandler`` or by using the ``Feedback/AudioEngine`` and ``Feedback/HapticEngine`` engines directly.



## Namespace

KeyboardKit has a ``Feedback`` namespace that contains feedback-related types, like ``Feedback/Audio`` and ``Feedback/Haptic`` enums that define available feedback types, ``Feedback/AudioEngine`` and ``Feedback/HapticEngine`` services that can trigger feedback, etc. 



## Audio & Haptic Feedback

KeyboardKit defines audio and haptic feedback that can be triggered with a ``FeedbackService`` or a ``KeyboardActionHandler``.

The ``Feedback/Audio`` enum defines audio feedback types, like ``Feedback/Audio/input``, ``Feedback/Audio/system``, ``Feedback/Audio/delete``, etc. The ``Feedback`` namespace also has other audio-related types like ``Feedback/AudioConfiguration``, which can be used to define many different types of audio feedback.

The ``Feedback/Haptic`` enum defines haptic feedback types, like ``Feedback/Haptic/success``, ``Feedback/Haptic/warning``, etc. The ``Feedback`` namespace also has other haptic-related types like ``Feedback/HapticConfiguration``, which can be used to define many different types of haptic feedback.



## Context

KeyboardKit has an observable ``FeedbackContext`` class that can be used to configure feedback for various actions. It also has auto-persisted ``FeedbackContext/settings-swift.property`` that can be used to customize the feedback behavior.

You can use the ``FeedbackContext/audioConfiguration`` and ``FeedbackContext/hapticConfiguration`` to configure which feedback to trigger when feedback is enabled in ``FeedbackContext/settings-swift.property``.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback.



## Services

In KeyboardKit, a ``FeedbackService`` can be used to trigger audio and haptic feedback as the user interacts with the keyboard. The ``KeyboardActionHandler`` protocol also implements this protocol.

KeyboardKit automatically creates a ``Feedback/StandardService``  instance and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, to customize how feedback is triggered.



---


## How to...


### Trigger feedback

You can trigger any ``Feedback/Audio`` and ``Feedback/Haptic`` feedback with a ``FeedbackService`` or with a ``KeyboardActionHandler``. The standard action handler uses a nested feedback service by default.

To trigger feedback, just use ``FeedbackService/triggerAudioFeedback(_:)`` and ``FeedbackService/triggerHapticFeedback(_:)``. The standard action handler has even more ways to customize which feedback to trigger for a specific ``KeyboardAction``.


### Configure feedback

You can configure the ``Keyboard/State/dictationContext``  in the main ``KeyboardInputViewController/state`` to configure the global feedback behavior. For instance, this would enable and customize audio feedback, then disable haptic feedback:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = state.feedbackContext
        context.audioConfiguration = .enabled
        context.audioConfiguration.input = .custom(id: 1329)
        context.isHapticFeedbackEnabled = false
    }
}
```

You can also use use the context to register custom feedback for any gesture on any action.

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = state.feedbackContext
        context.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        context.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
        context.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
    }
}
```

Since the configuration is observable, any changes will automatically cause the keyboard to update, e.g. if you have feedback toggles.


### Define custom feedback

The ``Feedback/Audio`` feedback type uses **AudioServices** to play audio, which means that you can use any system audio ID (see [this website](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback. For instance, this is how to define a custom sound:

```swift
extension Feedback.Audio {

    static let sentMessage = .custom(id: 1004)
}
```

You can also use the ``Feedback/Audio/customUrl(_:)`` feedback type to define a custom audio feedback that loads a sound effect from an audio file:

```swift
extension Feedback.Audio {

    static let sentMessage = .customUrl(
        Bundle.main.url(forResource: "sent", withExtension: "mp3")
    )
}
```

You can also implement a custom action handler to trigger feedback in a different ways. See the <doc:Actions-Article> article for more information.
