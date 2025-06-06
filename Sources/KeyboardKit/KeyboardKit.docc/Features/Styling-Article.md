# Styling

This article describes the KeyboardKit styling engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

KeyboardKit's various views can be customized to great extent. Most have a corresponding view modifier that lets you apply a custom style or style builder. You can also use a ``KeyboardStyleService`` for more complex styling.

👑 [KeyboardKit Pro][Pro] unlocks a theme engine and many pre-defined themes. Information about Pro features can be found further down.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro



## Namespace

KeyboardKit has a ``KeyboardStyle`` namespace that contains style-related types. However, most styles are defined next to their type, like the ``KeyboardView``'s ``KeyboardViewStyle`` and the ``Keyboard`` namespace's ``Keyboard/Button`` and ``Keyboard/ButtonStyle``.



## Services

In KeyboardKit, a ``KeyboardStyleService`` can provide dynamic styles for different parts of a keyboard. Unlike static styles, a style service can vary styles depending on ``KeyboardContext``, ``KeyboardAction``, etc.

KeyboardKit injects a ``KeyboardStyle/StandardStyleService`` into ``KeyboardInputViewController/services`` when the keyboard is launched. You can replace it at any time, as described further down.

> Info: KeyboardKit 9.5 introduced new style view modifiers that will replace this service if they prove to be easier to use than services.



## Color & Image Extensions 

KeyboardKit defines additional, keyboard-specific ``SwiftUICore/Color`` and ``SwiftUICore/Image`` extensions, like ``SwiftUICore/Color/keyboardBackground``, ``SwiftUICore/Image/keyboard``, etc. to make it easy to create keyboards that look like a native iOS keyboard.

@Row {
    @Column {
        ![Image Extensions](styling-images)
    }
    @Column {
        ![Color Extensions](styling-colors)
    }
}

KeyboardKit defines contextual colors that take a ``KeyboardContext``, like ``SwiftUICore/Color/keyboardBackground(for:)``. These colors vary the color result based on the context. Prefer these context-based colors whenever possible.

KeyboardKit defines variable-based icons like ``SwiftUICore/Image/keyboardNewline``, which make it easy to use them as toggles and indicators.

> Important: Some keyboard colors are semi-transparent to work around a system bug in iOS, where iOS defines an invalid color scheme when a keyboard is used with a dark appearance text field in light mode. iOS will say that the color scheme is `.dark`, even if the system color scheme is light. Since dark appearance keyboards in light mode look quite different from keyboards in dark mode, this makes it impossible to apply the correct style. This has been [reported to Apple][Bug], but until it's fixes, thse colors will stay semi-transparent.

[Bug]: https://github.com/KeyboardKit/KeyboardKit/issues/305



## Type Extensions

Many types in the library define standard images, texts & colors. You can for instance get the standard image and text for a ``KeyboardAction`` with the ``KeyboardAction/standardButtonImage(for:)`` and ``KeyboardAction/standardButtonText(for:)``:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // KKL10n.space
```

These values can be overridden at any time, e.g. with the various view styles, by defining a custom ``KeyboardStyleService``, etc.



## Style Modifiers

KeyboardKit defines styles for its various view, which can be applied with style view modifiers. For instance, the ``KeyboardView`` has a ``KeyboardViewStyle`` that can be applied with the ``SwiftUICore/View/keyboardViewStyle(_:)`` modifier.

Most views have static, standard styles that can be replaced by custom styles to change the global default style for that particular view. Some views have dynamic view modifiers, that provide you with a parameter object for contextual values.


---


## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] unlocks additional image assets, and a ``KeyboardTheme`` engine that makes easier to style keyboards with themes.

[Pro]: https://github.com/KeyboardKit/KeyboardKitPro


### Emoji Icons

@Row {
    @Column {
        ![Asset-based Images](images-emojis)
    }
    @Column {
        KeyboardKit Pro unlocks vectorized emoji assets for all ``EmojiCategory``s, e.g. ``SwiftUICore/Image/keyboardEmoji`` & ``SwiftUICore/Image/emojiCategory(_:)``:
        
        Since these images are vectorized, they scale well when they are resized. They however do not support different font weights, so do not render them alongside SF Symbols that support such features.
    }
}

### Themes

KeyboardKit Pro unlocks a ``KeyboardTheme`` engine that makes easier to style keyboards with themes, as well as a bunch of themes:

@Row {
    @Column { ![Standard Green Theme](standard-green) }
    @Column { ![Swifty Blue Theme](swifty-blue) }
    @Column { ![Cotton Candy Theme](candyshop-cottoncandy) }
}

You can apply themes with a style-specific ``KeyboardStyleService``. Future versions of KeyboardKit will also let you apply themes with a view modifier. See the <doc:Themes-Article> article for more information.


---


## How to...


### ...create a custom style service

You can create a custom style service to customize styles in any way you want. You can implement ``KeyboardStyleService`` from scratch, or inherit and customize ``KeyboardStyle/StandardStyleService``:

```swift
class CustomKeyboardStyleService: KeyboardStyle.StandardStyleService {
    
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
