# Understanding Buttons

This article describes some general KeyboardKit buttons.

KeyboardKit doesn't require you to use the views and buttons in the library, but it can help speed up development.


## Keyboard button

The ``KeyboardButton`` namespace defines a couple of button types that help you mimic native keyboard buttons:

- ``KeyboardButton/Button`` renders actions and custom view as a keyboard button.
- ``KeyboardButton/Content`` renders the keyboard button content for an action.
- ``KeyboardButton/Key`` renders a keyboard button key shape.
- ``KeyboardButton/Shadow`` renders a keyboard button bottom shadow.
- ``KeyboardButton/SpaceContent`` renders space-specific keyboard button content.
- ``KeyboardButton/Title`` renders a keyboard button title.

You can also use the `.keyboardButton` view modifier to convert any view to a keyboard button.


## Next keyboard button

The ``NextKeyboardButton`` can be used to trigger the system keyboard switch function. 

This button requires a ``KeyboardInputViewController``. KeyboardKit will by default use the current controller, but you can provide a custom one.  

KeyboardKit will by default map the ``KeyboardAction/nextKeyboard`` action to this button type.
