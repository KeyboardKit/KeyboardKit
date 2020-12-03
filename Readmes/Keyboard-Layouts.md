# Keyboard Layouts

KeyboardKit has a `KeyboardLayout` struct that represents a complete set of actions on a keyboard.

Native keyboard layouts like alphabetic, numeric and symbolic keyboards, are made up of a base input set, surrounded by system buttons.


## Input set vs. keyboard layout

A *keyboard input set* is the set of characters that make up the input part of a keyboard.

A *keyboard layout* is the total number of actions that make up the complete keyboard.

A keyboard layout can thus be constructed with an input set and additional surrounding actions, but doesn't have to


## Keyboard layout providers

The `KeyboardLayoutProvider` protocol can be used to resolve layouts in a dynamic way. 

There are two built-in implementations:

* `StaticKeyboardLayoutProvider` is manually created with three input sets.
* `StandardKeyboardLayoutProvider` tries to resolve input sets for the current locale, device and orientation.

KeyboardKit will by default inject a `StandardKeyboardLayoutProvider` into the current context. 

You can use this provider if you want to (for custom keyboards, you don't have to) and replace it with a custom implementation at anytime.


## What about button sizes, row insets, margins etc.?

When you hear "keyboard layout", you'd think that this also covers how the buttons are actually layed out on the keyboard.

That is however not the case, at least not yet. Sizing and margins are so triky to get absolutely right, that KeyboardKit so far doesn't support it.

If you have an idea on how to best inlude this in the library, I will gladly accept PRs that bring this support to this library. 👍
