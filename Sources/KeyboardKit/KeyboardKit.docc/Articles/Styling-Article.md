# Styling

This article describes the KeyboardKit styling engine.

While native iOS keyboards provide few ways to customize the look and feel of the keyboard, KeyboardKit-based keyboards can be styled and customized to great extent.

KeyboardKit uses ``KeyboardStyle`` types to style its views. For instance, a ``KeyboardStyle/InputCallout`` style can be used to style a ``Callouts/InputCallout`` view.

[KeyboardKit Pro][Pro] unlocks a powerful theme engine and many themes. More information about Pro features can be found at the end of this article.



## Terminology

KeyboardKit uses different names for different ways to style keyboards. 

* A ``KeyboardStyle`` style is *static* and can be applied to certain views.
* A ``KeyboardStyleProvider`` is *dynamic* and provides context-based styles.
* A (Pro) **KeyboardTheme** is a *static* style provider that can define, reuse and share styles.

You can mix and match these concepts as you see fit.



## Resources & Assets

KeyboardKit comes with colors and assets that can be used to create native-looking keyboards.

* **Image** has a bunch of keyboard-specific images, e.g. **.keyboardBackspace**.
* **Color** has a bunch of keyboard-specific colors, e.g. **.keyboardButtonBackground**.
* ``KeyboardAction``, and many other types, have standard images, texts and colors.

For instance, to get the standard button image and text for an action, you can do this:

```swift
let context = KeyboardContext()
let image = KeyboardAction.command.standardButtonImage(for: context) // Command icon
let text = KeyboardAction.space.standardButtonText(for: context)     // Localized "space"
```

Have a look at the <doc:Colors-Article> and <doc:Images-Article> articles for more information about colors and images.



## Styling namespace

KeyboardKit has a ``Styling`` namespace that contains styling-related types.

This namespace doesn't contain protocols, open classes, or types that are meant to be top-level.



## Keyboard appearance

A keyboard appearance determines whether or not the keyboard will be light or dark. It's not the same as a *color scheme*. This means that a keyboard can be dark(er) while in light mode.

KeyboardKit has a ``Styling/KeyboardAppearanceViewModifier`` that can be used to apply a keyboard appearance to a view:

```
TextField("Enter text", text: $text)
    .keyboardAppearance(.dark)
```

Note that applying a dark appearances will make iOS tell the extension that the *color scheme* is dark, while this may in fact not be true. See the <doc:Colors-Article> article for more information.



## Keyboard styles

The ``KeyboardStyle`` namespace contains many styles, like ``KeyboardStyle/Button``, ``KeyboardStyle/Callout`` and ``KeyboardStyle/EmojiKeyboard``.

All styles can be modified, including most standard values. For instance, here we apply a red background to the standard ``KeyboardStyle/Callout`` style:

```swift
var style = KeyboardStyle.Callout.standard
style.backgroundColor = .red
KeyboardStyle.Callout.standard = style
```

Most styles have a **.standard** style that serves as a global default. These standard styles can be overwritten to change the global default style of that component.



## Keyboard style providers

In KeyboardKit, a ``KeyboardStyleProvider`` is used to return dynamic styles for different parts of the keyboard. 

Unlike static styles, a style provider can vary styles depending on the ``KeyboardContext``, ``KeyboardAction``, etc.

Views like the ``SystemKeyboard`` use a style provider to get a button style for each keyboard button, based on the button action, current device, etc. 

KeyboardKit injects a ``StandardKeyboardStyleProvider`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time. 



## Keyboard button styles

Most view that support styling let you pass in a style in the initializer. For instance, here we apply a custom ``KeyboardStyle/AutocompleteToolbar`` style that makes the item title font bold:

```swift
var style = KeyboardStyle.AutocompleteToolbar.standard
style.item.titleFont = .body.weight(.bold)

let bar = AutocompleteToolbar(
    suggestions: [...],
    style: style
)
```

The ``KeyboardStyle/Button`` style is different from other styles, since it can style any view to look like a keyboard button, using the **.keyboardButtonStyle(...)** modifier. 

The ``KeyboardStyle/Button`` style also doesn't have a **.standard** style, since button styles depend on many factors, like button type, device, keyboard appearance, color scheme, etc.



## How to create a custom style provider

You can create a custom style provider to customize any keyboard component style in any way you want. You can also change the **.standard** styles directly.

You can implement ``KeyboardStyleProvider`` from scratch, or inherit and customize ``StandardKeyboardStyleProvider``.

For instance, here's a custom provider that inherits ``StandardKeyboardStyleProvider`` and makes all input buttons red:

```swift
class CustomKeyboardStyleProvider: StandardKeyboardStyleProvider {
    
    override func buttonStyle(
        for action: KeyboardAction,
        isPressed: Bool
    ) -> KeyboardStyle.Button {
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



## 👑 Pro features

[KeyboardKit Pro][Pro] unlocks a theme engine that makes it a lot easier to style your keyboard.

Information about themes can be found in the <doc:Themes-Article> article.


[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
