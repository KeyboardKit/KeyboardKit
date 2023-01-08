# Feedback

This article describes the KeyboardKit feedback engine and how to use it to trigger audio and haptic feedback.

In KeyboardKit, keyboard feedback is a way to trigger audio and haptic feedback as the user types and interacts with the keyboard. 

Note that keyboard extensions need full access to be able to trigger haptic feedback. Full access must be enabled under `System Settings > General > Keyboards > Your Keyboard`.



## Keyboard feedback

Keyboard feedback can be handled with a ``KeyboardFeedbackHandler``, which is a protocol that can be implemented by any class that can be used to handle keyboard feedback.

KeyboardKit will by default create a ``StandardKeyboardFeedbackHandler`` and applies it to the input controller's ``KeyboardInputViewController/keyboardFeedbackHandler``. You can replace it with a custom handler to customize how feedback is handled.



## Keyboard feedback settings

KeyboardKit also has an observable ``KeyboardFeedbackSettings`` class that can be used to configure the the audio and haptic feedback to use for various actions.

KeyboardKit will by default create a settings instance and apply it to the input controller's ``KeyboardInputViewController/keyboardFeedbackSettings``. You can then configure this instance to change the audio and haptic feedback behavior without having to create a custom feedback handler.



## How to trigger feedback without a handler

You don't need to use a feedback handler to trigger audio and haptic feedback, although that is the most flexible way. Instead, you can just use the ``AudioFeedback`` ``AudioFeedback/trigger()`` and the ``HapticFeedback``'s  ``HapticFeedback/trigger()`` functions directly.

You can also replace the ``AudioFeedback``'s ``AudioFeedback/engine`` and the ``HapticFeedback``'s ``HapticFeedback/engine`` to change the global behavior of how audio and haptic feedback is handled.



## How to create a custom keyboard feedback handler

You can create a custom keyboard feedback handler to customize how feedback is handled, or to handle feedback types that have no default behavior.

You can create a custom feedback handler by inheriting the ``StandardKeyboardFeedbackHandler`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardFeedbackHandler`` from scratch.

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

To use this handler instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardFeedbackHandler`` to the new handler:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardFeedbackHandler = MyKeyboardFeedbackHandler()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
