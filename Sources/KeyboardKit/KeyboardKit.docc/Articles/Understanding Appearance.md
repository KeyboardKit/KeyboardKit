# Understanding Appearance

This article describes the KeyboardKit appearance model and how to use it. 


## Keyboard appearance

KeyboardKit has a ``KeyboardAppearance`` protocol that describes styles and appearances for different parts of a keyboard.

Keyboard appearances are dynamic, and can change the resulting syöes depending on the context, the rendered action etc. Views that need this dynamic behavior, such as ``SystemKeyboard`` will require an appearance to render properly, while views that only need to be styled in a certain just need a style.

KeyboardKit will by default create a ``StandardKeyboardAppearance`` and apply it to ``KeyboardInputViewController/keyboardAppearance``, which is then used by default. You can replace this standard instance with a custom one.


## How to create a custom appearance

If you want to change the style of some buttons or callouts or change the the text or image to use for buttons, you can implement a custom keyboard appearance.

You can create a custom appearance by either inheriting and customizing the ``StandardKeyboardAppearance`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardAppearance`` protocol from scratch.

For instance, here is a custom implementation that inherits the base class and makes all input actions and callouts red:

```swift
class MyKeyboardAppearance: StandardKeyboardAppearance {
    
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
        keyboardAppearance = MyKeyboardAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.
