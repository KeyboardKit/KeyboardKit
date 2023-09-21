# Understanding Feedback

This article describes the KeyboardKit feedback engine.

In KeyboardKit, keyboards can trigger audio and haptic feedback as the user interacts with the keyboard, for instance when typing, deleting backwards, long pressing space, etc. 

Feedback can be triggered with a ``KeyboardActionHandler``, or by triggering the ``AudioFeedback`` and ``HapticFeedback`` feedback types directly.



## Audio feedback

KeyboardKit has an ``AudioFeedback`` enum that defines various audio feedback types. 

You can trigger audio feedback types directly, using ``AudioFeedback/trigger()``:

```swift
AudioFeedback.input.trigger()
```

This enum also serves as a namespace for types like ``AudioFeedback/Configuration`` and ``AudioFeedback/Engine``.



## Haptic feedback

KeyboardKit has an ``HapticFeedback`` enum that defines various haptic feedback types. 

You can trigger haptic feedback types directly, using ``HapticFeedback/trigger()``:

```swift
HapticFeedback.lightImpact.trigger()
```

This enum also serves as a namespace for types like ``HapticFeedback/Configuration`` and ``HapticFeedback/Engine``.



## How to configure feedback

KeyboardKit has an observable ``KeyboardFeedbackSettings`` class that can be used to configure the feedback for various actions. KeyboardKit will by default create a settings instance and bind it to the input controller's ``KeyboardInputViewController/keyboardFeedbackSettings``. 

You can use this settings instance to customize the feedback configuration:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardFeedbackSettings.audioConfiguration = .disabled
        keyboardFeedbackSettings.audioConfiguration.input = .custom(id: 1329)
        keyboardFeedbackSettings.hapticConfiguration = .enabled
    }
}
```

Since the settings class is observable, any changes to it will automatically cause the keyboard view to update, e.g. if you have toggles for audio and haptic feedback.



## How to define custom audio feedback

The ``AudioFeedback`` enum has predefined sounds for various keyboard-specific types. It uses `AudioServices`, which means that you can use any system audio as audio feedback, for instance:

```swift
extension AudioFeedback {

    static let sentMessage = .custom(id: 1004)
}
```

For a full reference of system audio IDs, see [this website](https://iphonedev.wiki/index.php/AudioServices).
