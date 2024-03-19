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

You can also use the **.keyboardButton** view modifier to convert any view to a keyboard button.

These button components can be styled with ``KeyboardButton/ButtonStyle``, and the other button-specific styles.



## Next Keyboard Button

The ``NextKeyboardButton`` can be used to trigger the system keyboard switcher, which selects the next keyboard when tapped and shows a keyboard menu when long pressed.

@Row {
    @Column {
        ![NextKeyboardButton](nextkeyboardbutton-250.jpg)        
    }
    @Column(size: 3) {
        This button requires a ``KeyboardInputViewController`` to function. KeyboardKit will by default use the current controller.

        KeyboardKit will by default map the ``KeyboardAction/nextKeyboard`` action to this view when rendering the action.
       
    }
}
