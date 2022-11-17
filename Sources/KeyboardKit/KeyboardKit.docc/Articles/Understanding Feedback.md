# Understanding Feedback

This article describes the KeyboardKit feedback engine and how to use it to get audio and haptic feedback. 



## Keyboard feedback

In KeyboardKit, keyboard feedback is a way to trigger audio and haptic feedback as the user types. 

Keyboard feedback can be handled with a ``KeyboardFeedbackHandler``, which is a protocol that can be implemented by any class that can be used to handle keyboard feedback.

KeyboardKit will by default create a ``StandardKeyboardFeedbackHandler`` and bind it to the input controller's ``KeyboardInputViewController/keyboardFeedbackHandler``. You can replace it with a custom handler to customize how audio and haptic feedback is handled.



## Keyboard feedback settings

KeyboardKit also has an observable ``KeyboardFeedbackSettings`` class that can be used to configure the the audio and haptic feedback to use for various actions.

KeyboardKit will by default create a settings instance and apply it to the input controller's ``KeyboardInputViewController/keyboardFeedbackSettings``. You can then configure this instance to change the audio and haptic feedback behavior without having to create a custom feedback handler.



## How to create a custom keyboard feedback handler

You can create a custom keyboard feedback handler if you want to customize how feedback is handled, or to handle various feedback types that have no default behavior.

You can create a custom feedback handler by inheriting the ``StandardKeyboardFeedbackHandler`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardFeedbackHandler`` protocol from scratch.

For instance, here is a custom handler that inherits the base class and triggers haptic feedback when the return button is long pressed:

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

To use this feedback handler instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardFeedbackHandler`` like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardFeedbackHandler = MyKeyboardFeedbackHandler()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## How to trigger feedback without a handler

You don't need to use a feedback handler to trigger audio and haptic feedback, although that is the most flexible approach for doing so. 

To just trigger audio or haptic feedback, the ``AudioFeedback`` and ``HapticFeedback`` enums have a `trigger` function that will trigger the feedback using a static `engine`.

You can replace ``AudioFeedback/engine`` and ``HapticFeedback/engine`` with custom engines to change the global behavior of how audio and haptic feedback is handled.

Note that your keyboard extension needs full access to be able to trigger haptic feedback. Full access must be enabled by the user, under `System Settings > General > Keyboards > Your Keyboard`.
