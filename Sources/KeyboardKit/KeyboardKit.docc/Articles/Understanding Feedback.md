# Understanding Haptic & Audio Feedback

This article describes the KeyboardKit feedback model and how to use it. 


## Keyboard feedback

KeyboardKit has a ``KeyboardAppearance`` protocol that can be used to trigger audio and haptic feedback as the user types.

Various parts of the library use a feedback handler to give audio and haptic feedback to the user, when it's applicable.

KeyboardKit will by default create a ``StandardKeyboardFeedbackHandler`` instance and apply it to ``KeyboardInputViewController/keyboardFeedbackHandler``, which is then used by default. You can replace this standard instance with a custom one.


## Keyboard feedback settings

KeyboardKit has an observable ``KeyboardFeedbackSettings`` class that can be used to configure the the audio and haptic feedback to use for various actions.

KeyboardKit will create an instance and apply this instance to ``KeyboardInputViewController/keyboardFeedbackSettings``, which is then used by default. You can replace this standard instance with a custom one. 

The standard settings instance is by default used by ``StandardKeyboardFeedbackHandler``, which means that you can change the basic feedback behavior without having to create a custom feedback handler.


## How to create a custom handler

Many keyboard actions have standard feedbacks, while others require custom handling. To customize how keyboard feedback is handled, or to trigger feedback for actions that have no default feedback, you can implement a custom feedback handler.

You can create a custom feedback handler by either inheriting and customizing the ``StandardKeyboardFeedbackHandler`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardFeedbackHandler`` protocol from scratch.

For instance, here is a custom implementation that inherits the base class and trigger haptic feedback when the return button is long pressed:

```swift
class MyKeyboardFeedbackHandler: StandardKeyboardFeedbackHandler {
    
    override func triggerFeedback(for gesture: KeyboardGesture, on action: KeyboardAction) {
        if gesture == .longPress && action == .return {
            return HapticFeedback.heavyImpact.trigger()
        }
        super.triggerFeedback(for: gesture, on: action)
    }
}
```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardFeedbackHandler = MyKeyboardFeedbackHandler()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.


## How to trigger feedback without a handler

You don't need to use a feedback handler to trigger audio and haptic feedback, although that is the most flexible approach. 

If you just want to trigger audio or haptic feedback, KeyboardKit has other, more straightforward types as well: 

### System audio

KeyboardKit has a ``SystemAudio`` enum that describes various system audio sounds.

You can play any system audio sound with ``SystemAudio/play()``. You can also inject a new global ``SystemAudio/player`` to customize how system audio is played.

### Haptic feedback

KeyboardKit has a ``HapticFeedback`` enum that describes various types of haptic feedback.

You can trigger any haptic feedback with ``HapticFeedback/trigger()``. You can also inject a new global ``HapticFeedback/player`` to customize how haptic feedback is triggered.

