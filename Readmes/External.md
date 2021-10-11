#  External Keyboards

KeyboardKit lets you detect whether or not an external keyboard is used.

This include snap-on Smart Folio iPad keyboards, the Magic Keyboard, Bluetooth keyboards etc.


## Detect an external keyboard

KeyboardKit has an iOS 14+ specific `ExternalKeyboardContext` that lets you detect whether or not an external keyboard is connected to the device.

Since this type requires iOS 14 or later, it's not setup by default. To use it, just set it up as an observed object in your own input controller. 

Note that this context will currently only detect if a keyboard is connected or not. For a folio keyboard, which can be inactive (folder back) while being connected, we currently can't tell if the keyboard is active or not.

If you know how to differ between connected and active, please send a PR. 
