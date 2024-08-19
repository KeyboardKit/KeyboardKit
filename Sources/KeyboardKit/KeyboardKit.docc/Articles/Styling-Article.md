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

👑 [KeyboardKit Pro][Pro] unlocks a theme engine and many themes. Information about Pro features can be found at the end of this article.

> Important: The ``KeyboardStyle`` namespace will probably be removed in KeyboardKit 9.0, together with the ``KeyboardStyleProvider``. Keyboard styles will then be applied with SwiftUI view modifiers.



## Terminology

KeyboardKit uses different names for different ways to style keyboards. 

* A ``KeyboardStyle`` style is *static* and can be applied to certain views, using view modifiers with the same name prefix as the view.
* A ``KeyboardStyleProvider`` is *dynamic* and provides context-based styles, which is currently required for more complex views.
* A ``KeyboardTheme`` is a *static* style provider that can define, reuse and share styles.



## Keyboard Style Namespace

KeyboardKit has a ``KeyboardStyle`` namespace that contains style-related types.



## Keyboard Style Providers

In KeyboardKit, a ``KeyboardStyleProvider`` is used to return dynamic styles for different parts of the keyboard. Unlike static styles, a style provider can vary styles depending on ``KeyboardContext``, ``KeyboardAction``, etc. 

More complex components, like ``KeyboardView``, does not yet use view modifiers, but instead use a ``KeyboardStyleProvider`` to apply dynamic, contextual, styles based on internal and external state.

KeyboardKit automatically creates an instance of ``KeyboardStyle/StandardProvider`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.

> Important: Views like ``KeyboardView`` will apply style modifiers to any view that it renders. This means that you can't apply these view modifiers to the ``KeyboardView``. You can however apply style modifiers to views that you create in view builders.



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



## View styles

KeyboardKit defines custom styles for its various view. For instance, the ``Keyboard`` ``Keyboard/Button`` view has a ``Keyboard/ButtonStyle`` that can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier.

Most views have static, standard styles that can be replaced by custom styles to change the global default style for that particular view. 



## How to create a custom style provider

You can create a custom style provider to customize any style in any way you want. You can implement ``KeyboardStyleProvider`` from scratch, or inherit and customize ``KeyboardStyle/StandardProvider``.

For instance, here's a custom provider that inherits ``KeyboardStyle/StandardProvider`` and makes all input buttons red:

```swift
class CustomKeyboardStyleProvider: KeyboardStyle.StandardProvider {
    
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

To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/styleProvider`` property:

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

[KeyboardKit Pro][Pro] unlocks a theme engine and a ``KeyboardTheme``, that makes it a lot easier to style your keyboard with themes.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@Row {
    @Column { ![Standard Green Theme](standard-green) }
    @Column { ![Swifty Blue Theme](swifty-blue) }
    @Column { ![Cotton Candy Theme](candyshop-cottoncandy) }
}

See the <doc:Themes-Article> article for more information.
