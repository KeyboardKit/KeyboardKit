# Understanding Appearances

This article describes the KeyboardKit appearance engine and how to use it. 


## Keyboard appearances

In KeyboardKit, keyboard appearances are dynamic styles that be used to define the look of an entire keyboard. They can adapt depending on context, actions etc. which means that you can configure an appearance based on any information you provide it with.

Keyboard appearances can be implemented with ``KeyboardAppearance``, which is a protocol that describes the look, style, texts etc. of different parts of the keyboard. 

KeyboardKit will by default create a ``StandardKeyboardAppearance`` and bind it to the input controller's ``KeyboardInputViewController/keyboardAppearance``. You can replace it with a custom appearance to customize how your keyboard looks.



## Resources & Assets

KeyboardKit comes with colors and images that make it easy to create native-looking keyboards.

* `Image` has a bunch of static, keyboard-specific images, e.g. `Image.keyboardBackspace`.
* `Color` has a bunch of static, keyboard-specific colors, e.g. `Color.standardButtonBackgroundColor(for:)`.
* Some types have standard images, texts and colors, e.g. ``KeyboardAction``. 

Have a look at the `Sources/Resources` and `Sources/Appearance` folders for more information.



## Keyboard appearances vs styles

Keyboard appearances are dynamic, while styles are simple structs that carry styling information for specific views. Some views, such as the ``SystemKeyboard``, need the dynamic capabilities of an appearance, while other views only need a style.    



## How to create a custom keyboard appearance

You can create a custom keyboard apperance to change the style of buttons or callouts, the texts and/or images of various buttons etc.

You can create a custom appearance by inheriting the ``StandardKeyboardAppearance`` base class (which gives you a lot for free) or by implementing the ``KeyboardAppearance`` protocol from scratch.

For instance, here's a custom apperance that inherits ``StandardKeyboardAppearance`` and makes all input action buttons red:

```swift
class MyKeyboardAppearance: StandardKeyboardAppearance {
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardButtonStyle {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        if !action.isInputAction { return style }
        style.backgroundColor = .red
        return style
    }
}
```

To use this appearance instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardAppearance`` like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardAppearance = MyKeyboardAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
