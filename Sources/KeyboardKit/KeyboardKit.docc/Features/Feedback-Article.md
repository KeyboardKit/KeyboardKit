# Feedback

This article describes the KeyboardKit feedback engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

Feedback is an important part of the typing experience, where a keyboard can trigger audio and haptic feedback when a user taps on a key or performs certain actions.

In KeyboardKit, feedback can be triggered with a ``FeedbackService``, a ``KeyboardActionHandler``, or with the underlying ``Feedback/AudioEngine`` and ``Feedback/HapticEngine`` engines directly.



## Namespace

KeyboardKit has a ``Feedback`` namespace that contains feedback-related types, like ``Feedback/Audio`` & ``Feedback/Haptic`` enums that define supported feedback types, ``Feedback/AudioEngine`` & ``Feedback/HapticEngine``, etc. 



## Audio & Haptic Feedback

The ``Feedback/Audio`` enum defines audio feedback types, like ``Feedback/Audio/input``, ``Feedback/Audio/system``, ``Feedback/Audio/delete``, etc, and The ``Feedback/Haptic`` enum defines haptic feedback types, like ``Feedback/Haptic/success``, ``Feedback/Haptic/warning``, ``Feedback/Haptic/error`` etc. 

The ``Feedback`` namespace also has ``Feedback/AudioConfiguration`` and ``Feedback/HapticConfiguration`` types that can be used to define more complex feedback behavior.



## Context

KeyboardKit has an observable ``FeedbackContext`` class that can be used to configure feedback for various gestures and actions. It also has auto-persisted ``FeedbackContext/settings-swift.property`` that can be used to customize the feedback behavior and toggle it on and off.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback.



## Services

A ``FeedbackService`` can be used to trigger audio & haptic feedback as users interacts with the keyboard. The ``KeyboardActionHandler`` protocol also implements this protocol, and will trigger feedback as actions are triggered.

KeyboardKit injects a ``Feedback/StandardFeedbackService``  instance into ``KeyboardInputViewController/services``. You can replace it at any time, to customize how the keyboard triggers feedback.



## Settings

KeyboardKit has a ``FeedbackSettings`` with auto-persisted feedback-related settings. The context ``FeedbackContext/settings-swift.property`` is used by default.



---


## How to...


### ...trigger keyboard feedback

You can trigger ``Feedback/Audio`` & ``Feedback/Haptic`` feedback with a ``FeedbackService`` or by using an ``KeyboardActionHandler``. The standard action handler will implicitly trigger feedback for all actions that it handles, in accordance to the main ``Keyboard/State/feedbackContext`` ``FeedbackContext/settings-swift.property``.


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

The ``Feedback/Audio`` feedback type uses **AudioServices**, which means that you can use any system audio (see [this site](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback:

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
