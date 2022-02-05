# Understanding Keyboard Feedback

This article describes the KeyboardKit feedback model and how to use it. 


## Keyboard feedback

KeyboardKit has a ``KeyboardAppearance`` protocol can be used to trigger audio and haptic feedback to the user.

Various parts of the library use a feedback handler to give audio and haptic feedback to the user, when it's applicable. For instance, ``StandardKeyboardActionHandler`` uses one to give feedback when it performs keyboard actions.

KeyboardKit will create a ``StandardKeyboardFeedbackHandler`` instance when the keyboard extension is started, then apply it to ``KeyboardInputViewController/keyboardFeedbackHandler``. It will then use this instance by default to give feedback.


## How to create a custom appearance

Many keyboard actions have standard feedbacks, while others don't and require custom handling. To customize how actions give feedback, you can implement a custom feedback handler.

You can create a custom implementation of this protocol, by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

For instance, here is a custom handler that extend ``StandardKeyboardFeedbackHandler`` and plays system audio when the return button is tapped:

```swift
class MyKeyboardFeedbackHandler: StandardKeyboardFeedbackHandler {
    
    override func actionCalloutStyle() -> ActionCalloutStyle {
        let style = super.actionCalloutStyle()
        style.callout.backgroundColor = .red
        return style
    }

    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool) -> KeyboardButtonStyle {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        if !action.isInputAction { return style }
        style.backgroundColor = .red
        return style
    }

    override func inputCalloutStyle() -> InputCalloutStyle {
        let style = super.inputCalloutStyle()
        style.callout.backgroundColor = .red
        return style
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
