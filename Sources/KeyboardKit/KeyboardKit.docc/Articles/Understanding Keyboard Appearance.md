# Understanding Keyboard Appearance

This article describes the KeyboardKit appearance model and how to use it. 


## Keyboard appearance

KeyboardKit has a ``KeyboardAppearance`` protocol that describes styles and appearances for different parts of a keyboard.

Many views in the library use an appearance if they have to be able to generate different styles. This is true for e.g. ``SystemKeyboard``, which renders many different components and buttons. Views that only need to be styled in a certain way can just ask for a fixed style instead of an appearance.

KeyboardKit will create a ``StandardKeyboardAppearance`` as the keyboard extension is started, then apply this instance to ``KeyboardInputViewController/keyboardAppearance``. This instance will then be used by default to determine how your appearance-based views will look.


## How to create a custom appearance

If you want to change the style of some buttons or callouts or change the the text or image to use for buttons, you can implement a custom keyboard appearance.

You can create a custom appearance by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

For instance, here is a custom appearance that extend ``StandardKeyboardAppearance`` and makes all input actions and callouts red:


```swift
class MyAppearance: StandardKeyboardAppearance {
    
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
        keyboardAppearance = MyAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.
