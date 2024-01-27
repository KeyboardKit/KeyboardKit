# Feedback

This article describes the KeyboardKit feedback engine.

Feedback is an important part of the typing experience, where the keyboard can play audio and trigger haptic feedback when a user taps on a key or performs an action.

In KeyboardKit, feedback can be triggered with a ``KeyboardActionHandler``, or by using the ``AudioFeedback`` and ``HapticFeedback`` types directly.



## Audio feedback

KeyboardKit has an ``AudioFeedback`` enum that defines various audio feedback types, like **.input**, **.system**, and **.delete**.

You can trigger audio feedback with ``AudioFeedback/trigger()``:

```swift
AudioFeedback.input.trigger()
```

This enum also serves as a namespace for types like ``AudioFeedback/Configuration`` and ``AudioFeedback/Engine``.



## Haptic feedback

KeyboardKit has an ``HapticFeedback`` enum that defines various haptic feedback types, like **.error**, **.success**, and **.warning**. 

You can trigger haptic feedback with ``HapticFeedback/trigger()``:

```swift
HapticFeedback.lightImpact.trigger()
```

This enum also serves as a namespace for types like ``HapticFeedback/Configuration`` and ``HapticFeedback/Engine``.



## How to configure feedback

KeyboardKit has an observable ``FeedbackConfiguration`` that can be used to configure feedback for various actions. 

KeyboardKit automatically creates an instance of this class and injects it into ``KeyboardInputViewController/state``. You can use this instance to customize the feedback configuration:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = state.feedbackConfiguration 
        config.audioConfiguration = .disabled
        config.audioConfiguration.input = .custom(id: 1329)
        config.hapticConfiguration = .enabled
    }
}
```

Since the settings class is observable, any changes to it will automatically cause the keyboard view to update, e.g. if you have toggles for audio and haptic feedback.



## How to define custom audio feedback

Since ``AudioFeedback`` uses **AudioServices** to play audio, you can use any system audio ID as feedback. For instance, this is a way to define a custom sound:

```swift
extension AudioFeedback {

    static let sentMessage = .custom(id: 1004)
}
```

If you don't want to use **AudioServices**, you can implement a custom action handler, and play sound from it. See the <doc:Actions-Article> article for more information.

For a full reference of system audio IDs, see [this website](https://iphonedev.wiki/index.php/AudioServices).
