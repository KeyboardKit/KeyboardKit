# Appearance

This article describes the KeyboardKit appearance engine and how to use it. 

In KeyboardKit, a ``KeyboardAppearance`` is a dynamic style that describes the style, texts, icons etc. of different parts of the keyboard. It can adapt to a ``KeyboardContext``, ``KeyboardAction`` etc., which means that they give you a lot of flexibility.


## Keyboard appearances

KeyboardKit will by default create a ``StandardKeyboardAppearance`` and apply it to the input controller's ``KeyboardInputViewController/keyboardAppearance``. You can replace it with a custom appearance to customize how your keyboard looks.



## Resources & Assets

KeyboardKit comes with colors and images assets that make it easy to create native-looking keyboards.

* `Image` has a bunch of static, keyboard-specific images, e.g. `.keyboardBackspace`.
* `Color` has a bunch of static, keyboard-specific colors, e.g. `.standardButtonBackgroundColor(for:)`.
* Some types have standard images, texts and colors, e.g. ``KeyboardAction``:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // Localized "space"
```

Have a look at the `Sources/Resources` and `Sources/Appearance` folders for more information.



## Keyboard appearances vs styles

Keyboard appearances are dynamic, while styles are simple structs that carry styling information for specific views. Some views, such as the ``SystemKeyboard``, need the dynamic capabilities of an appearance, while other views only need a style.    



## How to create a custom keyboard appearance

You can create a custom ``KeyboardAppearance`` to customize the style of various buttons or callouts, as well as texts, images etc.

You can create a custom appearance by inheriting the ``StandardKeyboardAppearance`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardAppearance`` from scratch.

For instance, here's a custom appearance that inherits ``StandardKeyboardAppearance`` and makes all input buttons red:

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

To use this appearance instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardAppearance`` to the new appearance:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardAppearance = MyKeyboardAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
