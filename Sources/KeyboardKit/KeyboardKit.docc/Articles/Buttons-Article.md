# Buttons

This article describes various KeyboardKit buttons.

KeyboardKit has some general buttons that can be used to mimic native keyboard buttons. You don't have to use the views & buttons, but it can help to speed up development.



## Keyboard Button

The ``KeyboardButton`` namespace defines a set of keyboard button types that can help you mimic native keyboard buttons (or keys):

- ``KeyboardButton/Button`` renders the entire button for a ``KeyboardAction`` or view.
- ``KeyboardButton/Content`` renders the button content for a ``KeyboardAction``.
- ``KeyboardButton/Key`` renders the shape of a native keyboard button.
- ``KeyboardButton/Shadow`` renders the bottom shadow of a native keyboard button.
- ``KeyboardButton/SpaceContent`` renders the content of a native space content.
- ``KeyboardButton/Title`` renders the title content of a native keyboard button.

Most of the views can be styled with a ``KeyboardButton/ButtonStyle``, which can be applied with the ``SwiftUI/View/keyboardButtonStyle(_:)`` view modifier:

```swift
KeyboardButton.Key()
    .keyboardButtonStyle(.standard)
```

This is however not yet true for some views, that use a ``KeyboardStyleProvider`` to support more complex styling. See the <doc:Styling-Article> article for more information about how styling is handled in KeyboardKit.


## Next Keyboard Button

A ``NextKeyboardButton`` can be used to integrate with the system keyboard switcher, which selects the next keyboard when tapped and shows a keyboard menu when long pressed.

![NextKeyboardButton](nextkeyboardbutton-250.jpg)

This button requires a ``KeyboardInputViewController`` to function. KeyboardKit will by default register the current controller when the keyboard launches.

KeyboardKit will by default map ``KeyboardAction/nextKeyboard`` to this view when rendering the action.
