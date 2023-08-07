# Keyboard

This article describes the KeyboardKit keyboard types.

KeyboardKit separate its parts into namespaces, where the `Keyboard` namespace contains the essential foundation types.



## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard, like a reference to the ``KeyboardContext/textDocumentProxy``, the current ``KeyboardContext/keyboardType``, etc.

KeyboardKit will by default create a context instance and apply it to the controller's ``KeyboardInputViewController/keyboardContext``, then sync it with the controller whenever needed.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/locale`` will cause a ``SystemKeyboard`` to render in that locale, provided that it's supported by the keyboard.



## Keyboard enabled state

KeyboardKit has a few types that can be used to inspect the state of a keyboard, e.g. if it's enabled in System Settings, if Full Access is enabled, etc.:

- ``KeyboardEnabledContext`` is an observable class that reads the state of a keyboard.
- ``KeyboardEnabledLabel`` is a view that can display the state of a keyboard.

The ``KeyboardEnabledStateInspector`` protocol can be implemented by any type that should be able to inspect the state of a keyboard extension.



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



## Next keyboard

KeyboardKit has a ``NextKeyboardButton`` that can be used to switch to the next keyboard, which corresponds to tapping the 🌐 button.
