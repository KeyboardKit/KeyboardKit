# Styling

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

This article describes the KeyboardKit styling engine.

While native iOS keyboards provide few ways to customize the look and feel, KeyboardKit keyboards can be customized to great extent.

[KeyboardKit Pro][Pro] unlocks a theme engine and many themes. Information about Pro features can be found at the end of this article.



## Terminology

KeyboardKit uses different names for different ways to style keyboards. 

* A ``KeyboardStyle`` style is *static* and can be applied to certain views, using view modifiers with the same name prefix as the view.
* A ``KeyboardStyleProvider`` is *dynamic* and provides context-based styles, which is currently required for more complex views.
* A ``KeyboardTheme`` is a *static* style provider that can define, reuse and share styles.



## KeyboardStyle namespace

KeyboardKit has a ``KeyboardStyle`` namespace that contains style-related types.



## Resources & Assets

KeyboardKit comes with colors and assets that can be used to create native-looking keyboards.

* ``SwiftUI/Color`` has a bunch of keyboard-specific colors, like ``SwiftUI/Color/keyboardBackground``.
* ``SwiftUI/Image`` has a bunch of keyboard-specific images, like ``SwiftUI/Image/keyboard``.

Many types in the library define standard images, texts & colors. For instance you can get the standard image and text for a ``KeyboardAction`` with the ``KeyboardAction/standardButtonImage(for:)`` and ``KeyboardAction/standardButtonText(for:)``:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // KKL10n.space
```

Have a look at the <doc:Colors-Article> and <doc:Images-Article> articles for more information about colors and images.



## Keyboard appearance

A keyboard appearance is used to determine if a keyboard is light or dark. This is not the same thing as the *color scheme*. A keyboard can be defined as "dark" even in light mode, and will render slightly darker than the default keyboard.

KeyboardKit has a ``Styling/KeyboardAppearanceViewModifier`` that can be used to apply a keyboard appearance to a view, using the ``SwiftUI/View/keyboardAppearance(_:)`` view modifier:

```
TextField("Enter text", text: $text)
    .keyboardAppearance(.dark)
```

Note that applying a dark appearances will make iOS tell the extension that the *color scheme* is dark, while this may in fact not be true. This will lead to visual bugs, that require certain workarounds. See the <doc:Colors-Article> article for more information.



## View styles

KeyboardKit defines custom styles for its various view. For instance, the ``Keyboard`` ``Keyboard/Button`` view has a ``Keyboard/ButtonStyle`` that can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier.

Most views have static, standard styles that can be replaced by custom styles to change the global default style for that particular view. 



## Style providers

In KeyboardKit, a ``KeyboardStyleProvider`` is used to return dynamic styles for different parts of the keyboard. Unlike static styles, a style provider can vary styles depending on ``KeyboardContext``, ``KeyboardAction``, etc. 

More complex components, like ``SystemKeyboard``, does not yet use view modifiers, but instead use a ``KeyboardStyleProvider`` to apply dynamic, contextual, styles based on internal and external state.

KeyboardKit injects a ``StandardKeyboardStyleProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time.

> Important: Views like ``SystemKeyboard`` will apply style provider-based view modifiers to any view that it renders. This means that you can't apply these view modifiers to the ``SystemKeyboard``. You can however add custom styles to the views you provide in the various view builders, so use this approach if you want to style individual parts of these more complex views.  



## How to create a custom style provider

You can create a custom style provider to customize any style in any way you want. You can implement ``KeyboardStyleProvider`` from scratch, or inherit and customize ``StandardKeyboardStyleProvider``.

For instance, here's a custom provider that inherits ``StandardKeyboardStyleProvider`` and makes all input buttons red:

```swift
class CustomKeyboardStyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> Keyboard.ButtonStyle {
        let style = super.buttonStyle(for: action, isPressed: isPressed)
        if !action.isInputAction { return style }
        style.backgroundColor = .red
        return style
    }
}
```

To use this provider instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardStyleProvider = CustomKeyboardStyleProvider()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks a theme engine and a ``KeyboardTheme`` type, that makes it a lot easier to style your keyboard with themes.

See the <doc:Themes-Article> article for more information.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
