# Appearance

This article describes the KeyboardKit appearance engine and how to use it. 

In KeyboardKit, a ``KeyboardAppearance`` defines the style, texts, icons etc. of different parts of the keyboard. It can adapt to a ``KeyboardContext``, ``KeyboardAction`` etc., which means that it gives you a lot of flexibility.

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


## Styles

The `Appearance` namespace defines general styles, such as ``KeyboardButtonStyle``, while other namespaces define more contextual-bound styles, such as how the `Emojis` namespace defines an ``EmojiKeyboardStyle``.

Styles are mutable structs, so any style can be modified as long as it's a  `var`. For instance, here we adjust the standard ``CalloutStyle`` to use a red background:

```swift
var style = CalloutStyle.standard
style.backgroundColor = .red
CalloutStyle.standard = style
```

Almost all styles have a `.standard` style that you can replace with a custom style to change the global style of that component. 



## How to create a custom appearance

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
