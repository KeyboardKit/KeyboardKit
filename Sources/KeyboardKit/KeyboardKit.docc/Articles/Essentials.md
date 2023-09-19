# Keyboard

This article describes the essential KeyboardKit types.

KeyboardKit separate its parts into namespaces, where the `Keyboard` namespace contains the essential foundation types.

[TODO] Cover more types!

## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard, like a reference to the ``KeyboardContext/textDocumentProxy``, the current ``KeyboardContext/keyboardType``, etc.

KeyboardKit will by default create a context instance and apply it to the controller's ``KeyboardInputViewController/keyboardContext``, then sync it with the controller whenever needed.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/locale`` will cause a ``SystemKeyboard`` to render in that locale, provided that it's supported by the keyboard.



## Keyboard types

KeyboardKit has a ``Keyboard/KeyboardType`` enum that defines many different keyboard types, such as:

- ``Keyboard/KeyboardType/alphabetic(_:)`` - represents an alphabetic keyboard.
- ``Keyboard/KeyboardType/numeric`` - represents a numeric keyboard.
- ``Keyboard/KeyboardType/symbolic`` - represents a symbolic keyboard.

- ``Keyboard/KeyboardType/email`` - represents an e-mail keyboard.
- ``Keyboard/KeyboardType/emojis`` - represents an emoji keyboard.
- ``Keyboard/KeyboardType/images`` - represents an image keyboard.

- ``Keyboard/KeyboardType/custom(named:)`` - a custom type if no other types fit your needs

To change keyboard type, just set the context's ``KeyboardContext/keyboardType`` to the type you want to use. ``SystemKeyboard`` supports alphabetic, numeric, symbolic and emoji keyboards.
