# Appearance

KeyboardKit comes with an appearance engine that lets you easily style your keyboards.


## Keyboard appearance

KeyboardKit has a `KeyboardAppearance` protocol that describes how a keyboard should be styled. Using an appearance gives you a flexible way of styling your keyboards, where you can change the look or an entire keyboard by just replacing the appearance.


## Appearance vs. style

The difference between appearances and styles, is that appearances are dynamic while styles are fixed. In KeyboardKit, views use an appearance if they need dynamic styling or generate views that need to be styled, while basic views just use a style.    


## Appearance vs layout

In KeyboardKit, an `appearance` determines the look of a keyboard, while a `layout` determines its keys, button sizes, insets etc.


## Resources & Assets

KeyboardKit comes with colors and images that makes it easy to create native-looking keyboards.

* `Image` has a bunch of static extensions with keyboard-specific images, e.g. `.keyboardBackspace`.
* `Color` has a bunch of static extensions with keyboard-specific colors, e.g. `.standardButtonBackgroundColor(for:)`.
* Some KeyboardKit types have standard image, text and color information, e.g. `KeyboardAction`. 

Have a look at the `Sources/Resources` and `Sources/Appearance` folders for more information.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on keyboard appearance and styling.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
