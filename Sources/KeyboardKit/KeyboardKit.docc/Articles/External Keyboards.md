# External Keyboards

This article describes the KeyboardKit external keyboard engine and how to use it.

KeyboardKit lets you detect whether or not an external keyboard is used, including snap-on Smart Folio iPad keyboards, the Magic Keyboard, Bluetooth keyboards etc.


## How to detect an external keyboard

KeyboardKit has an ``ExternalKeyboardContext`` that lets you detect whether or not an external keyboard is connected to the device. To use it, just set it up as an observed object in your keyboard controller. 

Since this context requires iOS 14, this is not setup by the ``KeyboardInputViewController``.


## Current limitations

The ``ExternalKeyboardContext`` will currently only detect if a keyboard is connected or not. For a folio keyboard, which can be inactive (folded back) while connected, it currently can't tell if the keyboard is active or not, only if it's connected, which it always is.

If you know how to differ between being connected and active, please send a PR.
