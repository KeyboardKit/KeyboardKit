# Essentials

This article describes some essential types in KeyboardKit.

KeyboardKit separates its functionality into groups, where the `_Keyboard` group (prefixed with underscore to be listed first) contains essential keyboard types.



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with essential types, like ``Keyboard/AutocapitalizationType``, ``Keyboard/Case``, ``Keyboard/ReturnKeyType``, and much more.

The namespace doesn't contain protocols or open classes, or types that are meant to be top-level ones. It's meant to be a container for types used by top-level types, to make the library easier to overview.



## Keyboard input view controller

KeyboardKit's ``KeyboardInputViewController`` is the most essential type in the library. Make your `KeyboardController` inherit this base class instead of `UIInputViewController`, to get access to a bunch of additional capabilities.

KeyboardKit also has an abstract ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully formalized yet.



## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard, a reference to the current ``KeyboardContext/textDocumentProxy``, the current ``KeyboardContext/keyboardType``, etc.

KeyboardKit will by default create a context and bind it to ``KeyboardInputViewController/keyboardContext``, then sync it with the controller whenever needed.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/locale`` will cause a ``SystemKeyboard`` to render in that locale, provided that it's supported by the keyboard.



## Keyboard text context

KeyboardKit also has an observable ``KeyboardTextContext`` that provides observable text properties. The reason for having this separate type is to avoid re-rendering the keyboard whenever the text changes.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that describes the behavior of a keyboard. KeyboardKit will bind a ``StandardKeyboardBehavior`` to ``KeyboardInputViewController/keyboardBehavior`` when the keyboard is loaded. You can replace it with a custom behavior at any time.
