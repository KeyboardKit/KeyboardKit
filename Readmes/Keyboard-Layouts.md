# Keyboard Layouts

KeyboardKit comes with a layout engine that makes it easy to create specific keyboard layouts for various devices, orientations and locales.


## Keyboard layout

KeyboardKit has a `KeyboardLayout` struct that represents the complete set of actions on a keyboard.

Native keyboards like alphabetic, numeric and symbolic keyboards, are made up of a basic `input set`, surrounded by system buttons. All these actions, together with their sizes, insets and positions, make up the total `keyboard layout`.


## Keyboard layout cs. input set 

While an *input set* is the characters that make up the input part of a keyboard, a *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Keyboard layout providers

KeyboardKit has a `KeyboardLayoutProvider` protocol that can be used to provide keyboard layouts. Using a layout provider instead of creating layouts manually gives you a dynamic way of working with layouts.


## Supporting more devices, orientations etc.

The `StandardKeyboardLayoutProvider` is initialized with a few device-specific providers that are included in this library. At the time of writing, this gives you basic support for `iPhone` and `iPad`-specific layouts.

However, `iPhoneKeyboardLayoutProvider` and `iPadKeyboardLayoutProvider` may not be perfect for all use-cases. For instance the iPad layout currently doesn't support iPad Pro-specific layouts. You may therefore have to customize the existing layouts, which may involve:

* Replace the view controller's `keyboardLayoutProvider` with a custom provider, as described above.
* Subclass `StandardKeyboardLayoutProvider` and override  `keyboardLayout(for:)`.
* Replace `StandardKeyboardLayoutProvider`'s `iPadProvider` with a custom provider.
* Replace `StandardKeyboardLayoutProvider`'s `iPhoneProvider` with a custom provider.
* Subclass `iPhoneKeyboardLayoutProvider` and override any parts you'd like to change.
* Subclass `iPadKeyboardLayoutProvider` and override any parts you'd like to change.  

I will gladly accept any PRs that improve the layout providers in this library. 👍


## KeyboardKit Pro

[KeyboardKit Pro][Pro] defines locale-specific layouts for all keyboard locales.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on keyboard layouts.



[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
