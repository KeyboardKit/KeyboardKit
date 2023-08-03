# Keyboard

This article describes the KeyboardKit keyboard types and how to use them.

Overall, KeyboardKit tries to separate its parts into descriptive namespaces, but in the `Keyboard` case, the types in this namespace are tightly coupled with the keyboard in particular, which means that `Keyboard` is its own namespace.


## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard extension, such as a reference to the current ``KeyboardContext/textDocumentProxy``, the current ``KeyboardContext/keyboardType`` and ``KeyboardContext/locale`` etc.

KeyboardKit will by default create a context instance and apply it to the input controller's ``KeyboardInputViewController/keyboardContext``. You can configure this instance to change the keyboard behavior. It will also sync with the input controller whenever needed.



## Keyboard enabled state

KeyboardKit has a few types that can be used to inspect the enabled and active state of a keyboard:

- ``KeyboardEnabledContext`` is an observable class that keeps itself in sync when the keyboard state changes.
- ``KeyboardEnabledLabel`` is a basic view that can display all these states in the same way.
- ``KeyboardEnabledStateInspector`` is a protocol that can be implemented by any type that should be able to inspect the state of a keyboard extension, such as if it's enabled in System Settings, if it is being used, if Full Access is enabled etc.



## Keyboard types

KeyboardKit has a ``KeyboardType`` enum that defines many different keyboard types, such as:

- ``KeyboardType/alphabetic(_:)`` - represents an alphabetic keyboard.
- ``KeyboardType/numeric`` - represents a numeric keyboard.
- ``KeyboardType/symbolic`` - represents a symbolic keyboard.

- ``KeyboardType/email`` - represents an e-mail keyboard.
- ``KeyboardType/emojis`` - represents an emoji keyboard.
- ``KeyboardType/images`` - represents an image keyboard.

- ``KeyboardType/custom(named:)`` - a custom type if no other types fit your needs

Note that some keyboard types require custom handling.



## How to change keyboard type

To change the current keyboard type, just set ``KeyboardContext``'s ``KeyboardContext/keyboardType``. However, this will not have any effect unless you actually use the type to create a keyboard view that you present to the user. 

If you do use the context's keyboard type, changing it will automatically update the UI.   



## Views

Besides the ``KeyboardEnabledLabel``, there is also a ``NextKeyboardButton`` that can be used to switch to the next keyboard, which corresponds to tapping the 🌐 button.
