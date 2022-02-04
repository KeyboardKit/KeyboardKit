# Understanding Keyboard Appearance

This article describes what keyboard appearance is and how to use it. 


## Keyboard appearance

KeyboardKit has a ``KeyboardAppearance`` protocol that describes keyboard appearance-specific things like styles, texts and images.

KeyboardKit sets up a ``StandardKeyboardAppearance`` instance by default when a ``KeyboardInputViewController`` is initalized. The library will use this appearance to dynamically determine how a keyboard and its components should look.

Library views take an appearance instance when dynamic appearance capabilities are needed, while other views just take a style. Let's discuss the difference between appearances and styles.



## Keyboard appearance vs. styles

While styles are static structs that describe the style of a specific component, keyboard appearances are classes that can resolve styles dynamically, e.g. based on action.

Views should use an appearance when they have to be able to generate many different styles (think ``SystemKeyboard`` with all its buttons) and a style if it only relies on the style.



## Creating a custom keyboard appearance

To create a custom keyboard appearance, you can either inherit and customize ``StandardKeyboardAppearance`` or implement a brand new ``KeyboardAppearance`` from scratch.

Inheriting and customizing ``StandardKeyboardAppearance`` is highly recommended, since you get access to a bunch of already implemented logic and can add your own custom logic to the mix.

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

To use this appearance instead of the standard one, you can inject it in ``KeyboardInputViewController/viewDidLoad()``:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardAppearance = MyAppearance()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom appearance everywhere and generate a red keyboard.
