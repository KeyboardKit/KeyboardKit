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

While native iOS keyboards provide few ways to customize the look and feel, KeyboardKit keyboards can be to great extent.

Most KeyboardKit views have a corresponding ``SwiftUI/View`` extension that lets you apply a custom style. This is however not yet supported by ``KeyboardView``, since its styles need to be dynamic. KeyboardKit 9. will aim to fix this, to make styling easier.

👑 [KeyboardKit Pro][Pro] unlocks a theme engine and many themes. Information about Pro features can be found at the end of this article.



## Keyboard Style Namespace

KeyboardKit has a ``KeyboardStyle`` namespace that contains style-related types.

This namespace will probably be removed in KeyboardKit 9.0, together with the ``KeyboardStyleService``. Keyboard styles will then be applied with SwiftUI view modifiers.



## Keyboard Style Services

In KeyboardKit, a ``KeyboardStyleService`` can provide dynamic styles for different parts of a keyboard. Unlike static styles, a style service can vary styles depending on ``KeyboardContext``, ``KeyboardAction``, etc.

KeyboardKit automatically creates an instance of ``KeyboardStyle/StandardProvider`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.



## Color & Image Extensions 

KeyboardKit defines additional, keyboard-specific ``SwiftUI/Color`` and ``SwiftUI/Image`` extensions, like ``SwiftUI/Color/keyboardBackground``, ``SwiftUI/Image/keyboard``, etc. to make it easy to create keyboards that look like a native iOS keyboard.

@Row {
    @Column {
        ![Image Extensions](styling-images)
    }
    @Column {
        ![Color Extensions](styling-colors)
    }
}

KeyboardKit defines contextual colors that take a ``KeyboardContext``, like ``SwiftUI/Color/keyboardBackground(for:)``, and then vary the color result based on the context. Prefer these context-based colors whenever possible.

KeyboardKit defines variable-based icons like ``SwiftUI/Image/keyboardNewline(for:)-4a8j6``, which make it easy to use them as toggles and indicators.

> Important: Some keyboard colors are semi-transparent to work around a system bug in iOS, where iOS defines an invalid color scheme when a keyboard is used with a dark appearance text field in light mode. iOS will say that the color scheme is `.dark`, even if the system color scheme is light. Since dark appearance keyboards in light mode look quite different from keyboards in dark mode, this makes it impossible to apply the correct style. This has been [reported to Apple][Bug], but until it's fixes, thse colors will stay semi-transparent.

[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305



## Type Extensions

Many types in the library define standard images, texts & colors. For instance you can get the standard image and text for a ``KeyboardAction`` with the ``KeyboardAction/standardButtonImage(for:)`` and ``KeyboardAction/standardButtonText(for:)``:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // KKL10n.space
```

These values can be overridden at any time, e.g. with the various view styles, by defining a custom ``KeyboardStyleService``, etc.



## View styles

KeyboardKit defines custom styles for its various view. For instance, the ``Keyboard`` ``Keyboard/Button`` view has a ``Keyboard/ButtonStyle`` that can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier.

Most views have static, standard styles that can be replaced by custom styles to change the global default style for that particular view. 



## How to create a custom style provider

You can create a custom style provider to customize any style in any way you want. You can implement ``KeyboardStyleService`` from scratch, or inherit and customize ``KeyboardStyle/StandardProvider``.

For instance, here's a custom provider that inherits ``KeyboardStyle/StandardProvider`` and makes all input buttons red:

```swift
class CustomKeyboardStyleService: KeyboardStyle.StandardProvider {
    
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

To use your custom service instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/styleService`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardStyleService = CustomKeyboardStyleService()
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional image assets, and a ``KeyboardTheme`` engine that makes easier to style keyboards with themes.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Emoji Icons

KeyboardKit Pro unlocks vectorized emoji assets for all ``EmojiCategory``s, for instance ``SwiftUI/Image/keyboardEmoji`` & ``SwiftUI/Image/emojiCategory(_:)``:

@Row {
    @Column {}
    @Column(size: 3) {
        ![Asset-based Images](images-emojis)
    }
    @Column {}
}

Since these images are vectorized, they scale well when they are resized. They however do not support different font weights, so do not render them alongside SF Symbols that support such features.

### Themes

KeyboardKit Pro unlocks a ``KeyboardTheme`` engine that makes easier to style keyboards with themes, as well as a bunch of themes:

@Row {
    @Column { ![Standard Green Theme](standard-green) }
    @Column { ![Swifty Blue Theme](swifty-blue) }
    @Column { ![Cotton Candy Theme](candyshop-cottoncandy) }
}

See the <doc:Themes-Article> article for more information.
