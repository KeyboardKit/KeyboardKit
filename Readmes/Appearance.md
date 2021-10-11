# Appearance

KeyboardKit comes with an appearance engine that lets you easily style your keyboards.


## Keyboard appearance

KeyboardKit has a `KeyboardAppearance` protocol that describes how keyboards should be styled. 

Using an appearance instead of styling views manually gives you a very flexible way of styling your keyboards, where you can change the look or an entire keyboard by just replacing the appearance.

`KeyboardInputViewController` will automatically create a `StandardKeyboardAppearance` when the extension is started. You can use this appearance as is or replace it with a custom appearance.

You can subclass the `StandardKeyboardAppearance` and replace the parts you want or create an entirely custom appearance.


## Appearance vs. Style

In KeyboardKit, some views are styled with an `appearance`, while some are styled with a `style`.

The difference between appearances and styles, are that appearances are dynamic, while styles are fixed.

Dynamic views use appearances, since their look can change depending on their context, while basic views use fixed styles.    


## Appearance vs layout

In KeyboardKit, an `appearance` determines the look of a keyboard, while a `layout` determines its keys, button sizes, insets etc.


## Resources & Assets

KeyboardKit comes with colors and images that makes it easy to create native-looking keyboards.

* `Image` has a bunch of static extensions with keyboard-specific images, e.g. `.keyboardBackspace`.
* `Color` has a bunch of static extensions with keyboard-specific colors, e.g. `.standardButtonBackgroundColor(for:)`.
* Some keyboard types have standard image, text and color information, e.g. `KeyboardAction`. 

Have a look at the `Sources/Resources` folder for more information.


## Optional

It's woth repeating that the appearance concept is just a convenience. KeyboardKit doesn't force you to stick with a specific look or layout. Your keyboard extensions can look and behave however you want.
