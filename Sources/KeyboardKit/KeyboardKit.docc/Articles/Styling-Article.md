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

In KeyboardKit, a ``KeyboardStyleService`` is used to return dynamic styles for different parts of the keyboard. Unlike static styles, a style provider can vary styles depending on ``KeyboardContext``, ``KeyboardAction``, etc.

KeyboardKit automatically creates an instance of ``KeyboardStyle/StandardProvider`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.



## Color Extensions

KeyboardKit defines additional colors that aim to match native iOS system colors, like ``SwiftUI/Color/keyboardBackground``. See ``SwiftUI/Color`` for a full list of additional colors that are provided by the library.

KeyboardKit also has contextual color functions like ``SwiftUI/Color/keyboardBackground(for:)``, which vary the result on the context. Use these functions instead of the raw color values whenever possible.

> Important: Some keyboard colors are semi-transparent to work around a system bug in iOS, where iOS defines an invalid color scheme when a keyboard is used with a dark appearance text field in light mode. iOS will say that the color scheme is `.dark`, even if the system color scheme is light. Since dark appearance keyboards in light mode look quite different from keyboards in dark mode, this makes it impossible to apply the correct style. This has been [reported to Apple][Bug], but until it's fixes, thse colors will stay semi-transparent.


[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305



## Image Extensions

KeyboardKit provides additional image extensions that mimic system keyboard icons, and [KeyboardKit Pro][Pro] provides vectorized assets for e.g. ``EmojiCategory``. Information about Pro features can be found at the end of this article.

KeyboardKit has additional images that aim to match native iOS system images, like ``SwiftUI/Image/keyboard``. See ``SwiftUI/Image`` for a full list of images that are provided by the library.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro

@Row {
    @Column {}
    @Column(size: 3) {
        ![SF Symbol Images](images)
    }
    @Column {}
}

These images are prefixed with **keyboard** to make them easy to find, and scale well when resized with the **.frame** and **.font** modifiers.



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
