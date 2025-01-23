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

In KeyboardKit, keyboard feedback can be triggered with a ``KeyboardFeedbackService``, a ``KeyboardActionHandler``, or using the underlying ``KeyboardFeedback/AudioEngine`` and ``KeyboardFeedback/HapticEngine`` engines directly.



## Namespace

KeyboardKit has a ``KeyboardFeedback`` namespace that contains feedback-related types, like ``KeyboardFeedback/Audio`` & ``KeyboardFeedback/Haptic`` enums that define available feedback types, ``KeyboardFeedback/AudioEngine`` & ``KeyboardFeedback/HapticEngine``, etc. 



## Audio & Haptic Feedback

The ``KeyboardFeedback/Audio`` enum defines audio feedback types, like ``KeyboardFeedback/Audio/input``, ``KeyboardFeedback/Audio/system``, ``KeyboardFeedback/Audio/delete``, etc. The ``KeyboardFeedback`` namespace also has other audio-related types like ``KeyboardFeedback/AudioConfiguration``, which can be used to define complex audio feedback behavior.

The ``KeyboardFeedback/Haptic`` enum defines haptic feedback types, like ``KeyboardFeedback/Haptic/success``, ``KeyboardFeedback/Haptic/warning``, ``KeyboardFeedback/Haptic/error`` etc. The ``KeyboardFeedback`` namespace also has other haptic-related types like ``KeyboardFeedback/HapticConfiguration``, which can be used to define complex haptic feedback behavior.



## Context

KeyboardKit has an observable ``KeyboardFeedbackContext`` class that can be used to configure feedback for various gestures and actions. It also has auto-persisted ``KeyboardFeedbackContext/settings-swift.property`` that can be used to customize the feedback behavior and toggle it on and off.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback.



## Services

In KeyboardKit, a ``KeyboardFeedbackService`` can be used to trigger audio & haptic feedback as users interacts with the keyboard. The ``KeyboardActionHandler`` protocol also implements this protocol.

KeyboardKit injects a ``KeyboardFeedback/StandardFeedbackService``  instance into ``KeyboardInputViewController/services``. You can replace it at any time, to customize it to affect how the keyboard triggers feedback.



## Settings

KeyboardKit has an ``KeyboardFeedback``-specific ``KeyboardFeedback/Settings`` type with auto-persisted settings. ``KeyboardFeedbackContext`` ``KeyboardFeedbackContext/settings-swift.property`` is used by default within KeyboardKit.



---


## How to...


### ...trigger keyboard feedback

You can trigger ``KeyboardFeedback/Audio`` & ``KeyboardFeedback/Haptic`` feedback with a ``KeyboardFeedbackService`` or a ``KeyboardActionHandler``. The standard action handler uses a nested feedback service by default.

To trigger feedback, just use ``KeyboardFeedbackService/triggerAudioFeedback(_:)`` and ``KeyboardFeedbackService/triggerHapticFeedback(_:)``. The standard action handler has more ways to customize which feedback to trigger for specific ``KeyboardAction`` gestures.


### ...customize keyboard feedback

You can configure the ``Keyboard/State/feedbackContext``  in the main ``KeyboardInputViewController/state`` to configure the feedback behavior. For instance, this would customize the audio feedback for input keys, then disable haptic feedback:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let context = state.feedbackContext
        context.audioConfiguration.input = .custom(id: 1329)
        context.settings.isHapticFeedbackEnabled = false
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


### ...define custom audio feedback

The ``KeyboardFeedback/Audio`` feedback type uses **AudioServices**, which means that you can use any system audio (see [this site](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback:

```swift
extension Feedback.Audio {

    static let sentMessage = .custom(id: 1004)
}
```

You can also use the ``KeyboardFeedback/Audio/customUrl(_:)`` feedback type to define a custom audio feedback that loads a sound effect from an audio file:

```swift
extension Feedback.Audio {

    static let sentMessage = .customUrl(
        Bundle.main.url(forResource: "sent", withExtension: "mp3")
    )
}
```

You can also implement a custom action handler to trigger feedback in a different ways. See the <doc:Actions-Article> article for more information.
