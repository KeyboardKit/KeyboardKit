#  Appearance

KeyboardKit lets you use any views you like to build your extensions. However, it comes with a bunch of appearance tools to simplify styling your keyboards and even lets you create keyboards that mimic native iOS keyboards.


## Style vs layout

A *keyboard appearance/style* determines the colors, fonts, shadows etc.

A *keyboard layout* determines how big the buttons are.


## Keyboard appearance

KeyboardKit has a `KeyboardAppearance` struct that describes how keyboards should be styled. Using an appearance instead of styling views manually gives you a much more dynamic and flexible way of working with styling.

`KeyboardInputViewController` will automatically create a standard `keyboardAppearance` when the extension is started. You can use this appearance as is or replace it with a custom one.

`StandardKeyboardAppearance` can be used together with a `SystemKeyboard` to create keyboard views that mimic the natie iOS keyboards. This makes it easy to style system keyboards and their buttons in any way you want.


## Resources & Assets

KeyboardKit comes with colors and images that makes it easy to create native-looking keyboards.

* `Image` has a bunch of static extensions with keyboard-specific images, e.g. `.backspace`.
* `Color` has a bunch of static extensions with keyboard-specific colors, e.g. `.standardButton(for:)`.
* Some keyboard types have standard image and color information as well, e.g. `KeyboardAction`. 

Have a look at the `Appearance` and `Resources` folders for more information.


## Not required

It's woth repeating that the concept of keyboard appearances is just a convenience for you to use if you want. KeyboardKit doesn't force you to stick with a specific look or layout. You can use any views you want in your keyboard extension.
