# Essentials

This article describes some KeyboardKit essentials.

KeyboardKit separates its functionality into groups, where the `_Keyboard` group (prefixed with underscore to be listed first) contains essential types.



## Keyboard namespace

KeyboardKit has a ``Keyboard`` namespace with essential types, like ``Keyboard/AutocapitalizationType``, ``Keyboard/Case``, ``Keyboard/ReturnKeyType``, and much more.

The namespace doesn't contain protocols, open classes or types that are meant to be top-level ones. It's meant to contain types used by top-level types, to make the library easier to overview.



## Keyboard input view controller

The ``KeyboardInputViewController`` is the most essential type in the library. Make your **KeyboardController** inherit this base class instead of **UIInputViewController**, to get access to a bunch of additional capabilities.

KeyboardKit also has an abstract ``KeyboardController`` protocol that aims to make it easier to use KeyboardKit in platforms that don't support UIKit. This is however not fully implemented yet.



## Keyboard context

KeyboardKit has an observable ``KeyboardContext`` class that provides information about the keyboard, a reference to the current ``KeyboardContext/textDocumentProxy``, the current ``KeyboardContext/keyboardType``, etc.

You can use the context to affect the keyboard. For instance, setting the ``KeyboardContext/locale`` will cause a ``SystemKeyboard`` to render in that locale, provided that it's supported by the keyboard.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/state``, then syncs it with the controller whenever needed.



## Keyboard behavior

KeyboardKit has a ``KeyboardBehavior`` protocol that can be used to determine certain keyboard behaviors. It's used by e.g. the ``StandardKeyboardActionHandler`` to make some decisions.

KeyboardKit automatically creates an instance of this class and binds it to ``KeyboardInputViewController/services``. You can modify or replace this behavior at any time.
