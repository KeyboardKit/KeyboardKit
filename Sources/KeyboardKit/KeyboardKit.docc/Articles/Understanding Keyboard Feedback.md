# Understanding Keyboard Feedback

This article describes the KeyboardKit feedback model and how to use it. 


## Keyboard feedback

KeyboardKit has a ``KeyboardAppearance`` protocol that can be used to trigger audio and haptic feedback to the user.

Various parts of the library use a feedback handler to give audio and haptic feedback to the user, when it's applicable. For instance, ``StandardKeyboardActionHandler`` uses one to give feedback when it performs keyboard actions.

KeyboardKit will create a ``StandardKeyboardFeedbackHandler`` instance when the keyboard extension is started, then apply it to ``KeyboardInputViewController/keyboardFeedbackHandler``. It will then use this instance by default to give feedback.


## Keyboard feedback settings

KeyboardKit has an observable ``KeyboardFeedbackSettings`` class that can be used to easily configure the the audio and haptic feedback that should be given for various keyboard actions.

KeyboardKit will create an observable setting instance when the keyboard extension is started, then apply this instance to ``KeyboardInputViewController/keyboardFeedbackSettings``. It will then use this instance by default to determine what feedback that should be given for a certain action. 

This instance is used by ``StandardKeyboardFeedbackHandler``, which means that you can change the basic feedback behavior without having to create a custom feedback handler. However, more complex changes require a custom feedback handler.


## How to create a custom handler

Many keyboard actions have standard feedbacks, while others don't and require custom handling. If your custom logic is more complicated than just configuring the settings as described above, you can implement a custom feedback handler.

You can create a custom handler by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

For instance, here is a custom feedback handler that extends ``StandardKeyboardFeedbackHandler`` and trigger a string haptic feedback when the return button is long pressed:

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

