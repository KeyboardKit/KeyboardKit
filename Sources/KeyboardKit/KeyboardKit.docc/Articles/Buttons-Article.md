# Buttons

This article describes various KeyboardKit buttons.

KeyboardKit has some general buttons that can be used to mimic native keyboard buttons.

KeyboardKit doesn't require you to use the views and buttons in the library, but it can help speed up development.



## Keyboard Button

The ``KeyboardButton`` namespace defines a couple of general button types that can help you mimic native keyboard buttons (or keys):

- ``KeyboardButton/Button`` renders the entire button for a ``KeyboardAction`` or view.
- ``KeyboardButton/Content`` renders the button content for a ``KeyboardAction``.
- ``KeyboardButton/Key`` renders the shape of a native keyboard button.
- ``KeyboardButton/Shadow`` renders the bottom shadow of a native keyboard button.
- ``KeyboardButton/SpaceContent`` renders the content of a native space content.
- ``KeyboardButton/Title`` renders the title content of a native keyboard button.

You can also use the **.keyboardButton** view modifier to convert any view to a keyboard button.

These button components can be styled with the ``KeyboardStyle/Button`` style, and the other button-specific styles.



## Next Keyboard Button

The ``NextKeyboardButton`` can be used to trigger the system keyboard switcher function, which selects the next keyboard when tapped and shows a keyboard menu when long pressed. 

![NextKeyboardButton](nextkeyboardbutton-250.jpg)

This button requires a ``KeyboardInputViewController`` to function. KeyboardKit will by default use the current controller, but you can use any controller.

KeyboardKit will by default map ``KeyboardAction/nextKeyboard`` to this button view.
