# Feedback

This article describes the KeyboardKit feedback engine.

In KeyboardKit, keyboards can trigger audio and haptic feedback as the user interacts with the keyboard, for instance when typing, deleting backwards, long pressing space, etc. 

Feedback can be triggered with a ``KeyboardActionHandler``, or by triggering the ``AudioFeedback`` and ``HapticFeedback`` types directly.



## How to configure audio and haptic feedback

KeyboardKit has an observable ``KeyboardFeedbackSettings`` class that can be used to configure the feedback for various actions.

KeyboardKit will by default create a settings instance and bind it to the input controller's ``KeyboardInputViewController/keyboardFeedbackSettings``. 

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



## How to trigger feedback

You can trigger audio and haptic feedback by calling ``KeyboardActionHandler/triggerFeedback(for:on:)``.

You can also just call ``AudioFeedback`` ``AudioFeedback/trigger()`` and ``HapticFeedback``  ``HapticFeedback/trigger()`` directly, but using an action handler is the most dynamic and configurable alternative.



## How to define custom audio feedback

The ``AudioFeedback`` enum has predefined sounds for various keyboard-specific types. It uses `AudioServices`, which means that you can use any system audio as audio feedback, for instance:

```swift
extension AudioFeedback {

    static let sentMessage = .custom(id: 1004)
}
```

For a full reference of system audio IDs, see [this website](https://iphonedev.wiki/index.php/AudioServices).
