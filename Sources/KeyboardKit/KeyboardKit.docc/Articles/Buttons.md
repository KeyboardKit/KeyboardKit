# Buttons

This article describes various KeyboardKit button types.

KeyboardKit doesn't require you to use the views and buttons in the library, but it can help speed up development.


## Keyboard button

There are a couple of keyboard button types that help you mimic native keyboard buttons:

- ``KeyboardButton`` can turn any custom content into a keyboard button.
- ``KeyboardButtonBody`` can be used to render the shape of a keyboard button.
- ``KeyboardButtonContent`` can be used to render the content of a keyboard button.
- ``KeyboardButtonSpaceContent`` can be used to render the space key content of a keyboard button.
- ``KeyboardButtonText`` can be used to render the text content of a keyboard button.

You can also use the `.keyboardButton` view modifier to convert any view to a keyboard button.


## Next keyboard button

The ``NextKeyboardButton`` can be used to trigger the system keyboard switch function. 

This button requires a keyboard input view controller to function. KeyboardKit will by default use the current controller, but you can provide a custom one.  

KeyboardKit will by default map the ``KeyboardAction/nextKeyboard`` action to this button type.
