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

In KeyboardKit, audio and haptic feedback can be triggered with a ``KeyboardActionHandler`` or by using the ``Feedback/Audio`` and ``Feedback/Haptic`` ``Feedback/Audio/trigger()`` functions directly.

👑 [KeyboardKit Pro][Pro] unlocks a convenient feedback toggle view, that lets you toggle between the last enabled feedback and a disabled configuration. Information about Pro features can be found at the end of this article.



## Feedback Namespace

KeyboardKit has a ``Feedback`` namespace with feedback-related types, like ``Feedback/Audio``, ``Feedback/Haptic``, etc.



## Feedback Context

KeyboardKit has an observable ``FeedbackContext`` class that can be used to configure feedback for various actions, such as which configuration to use for audio and haptic feedback. 

The context also has persistent, observable settings, such as  ``FeedbackContext/isAudioFeedbackEnabled``, ``FeedbackContext/isHapticFeedbackEnabled``, etc. You can read more about how settings are handled in the <doc:Essentials> and <doc:Settings-Article> articles.

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to configure feedback.



## Feedback Services

In KeyboardKit, a ``FeedbackService`` can be used to trigger audio and haptic feedback as the user interacts with the keyboard.

KeyboardKit automatically creates a ``Feedback/StandardService``  instance and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, to customize how feedback is triggered.



## Feedback Types

KeyboardKit supports audio & haptic feedback that can be triggered with a ``FeedbackService`` or a ``KeyboardActionHandler``.

The ``Feedback/Audio`` enum defines audio feedback types, like ``Feedback/Audio/input``, ``Feedback/Audio/system``, ``Feedback/Audio/delete``, etc. The ``Feedback`` namespace also has other audio-related types like ``Feedback/AudioConfiguration``, which can be used to define many different types of audio feedback.

The ``Feedback/Haptic`` enum defines haptic feedback types, like ``Feedback/Haptic/success``, ``Feedback/Haptic/warning``, etc. The ``Feedback`` namespace also has other haptic-related types like ``Feedback/HapticConfiguration``, which can be used to define many different types of haptic feedback.



## How to trigger feedback

You can trigger any ``Feedback/Audio`` and ``Feedback/Haptic`` feedback with a ``FeedbackService`` or with a ``KeyboardActionHandler``. The standard action handler uses a nested feedback service by default.



## How to configure feedback

You can configure the ``Keyboard/State/dictationContext``  in the main ``KeyboardInputViewController/state`` to configure the global feedback behavior. For instance, this would enable and customize audio feedback, then disable haptic feedback:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        state.feedbackContext.audioConfiguration = .enabled
        state.feedbackContext.audioConfiguration.input = .custom(id: 1329)
        state.feedbackContext.isHapticFeedbackEnabled = false
    }
}
```

You can also use use the context to register custom feedback for any gesture on any action.

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedback = state.feedbackContext
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
    }
}
```

Since the configuration is observable, any changes will automatically cause the keyboard to update, e.g. if you have feedback toggles.



## How to define custom audio feedback

Since ``Feedback/Audio`` uses **AudioServices** to play audio, you can use any system audio ID (see [this website](https://iphonedev.wiki/index.php/AudioServices) for info) as feedback. For instance, this is a way to define a custom sound, which can then be triggered with the ``Feedback/Audio/trigger()`` function:

```swift
extension Feedback.Audio {

    static let sentMessage = .custom(id: 1004)
}

Feedback.Audio.sentMessage.trigger()
```

You can also use the ``Feedback/Audio/customUrl(_:)`` enum case to define custom audio feedback that loads the sound effect from an audio file.

You can also implement a custom action handler to trigger feedback in a different ways. See the <doc:Actions-Article> article for more information.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a convenient feedback toggle that can be added to a keyboard toolbar to toggle audio or haptic feedback.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

### Views

KeyboardKit Pro unlocks views in the ``FeedbackConfiguration`` namespace, that let you easily toggle audio and haptic feedback:

@TabNavigator {
    
    @Tab("Toggle") {
        
        The feedback ``Feedback/Toggle`` can be used to toggle audio & haptic feedback on and off. It can be added to a toolbar, or anywhere you want it.
        
        ![FeedbackToggle](feedbackconfigurationtoggle)
        
        The view can be customized with other icons, and be further styled with native accent colors, fonts, etc. It's currently not style-based.
        
        Note that this toggle will use ``FeedbackContext/toggleIsAudioFeedbackEnabled()`` and ``FeedbackContext/toggleIsHapticFeedbackEnabled()``, which will toggle between a disabled configuration and the *last enabled* configuration. Haptic feedback uses a minimal configuration by default. 
    }
}
