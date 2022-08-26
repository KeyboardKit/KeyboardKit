# Callouts

KeyboardKit lets you show input callouts as users type, as well as action callouts for the currently pressed key.


## Action callouts

An action callout shows alternate actions to the pressed key in a callout bubble. 

Action callouts can be presented by providing an `ActionCalloutContext` with the actions to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `ActionCalloutContext` and bind it to its `actionCalloutContext` property and create a `CalloutActionProvider` and bind it to its `calloutActionProvider`.


## Input callouts

An input callout shows the currently typed character in a callout bubble. 

Input callouts can be presented by providing an `InputCalloutContext` with the character to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `InputCalloutContext` and bind it to its `inputCalloutContext` property when the extension is started.


## Binding callouts to views

To enable input callouts for custom views, follow these steps:

* Apply the `.inputCallout(context:keyboardContext:style:)` view modifier to the keyboard view (see `SystemKeyboard`).
* Update the `InputCalloutContext` environment object with the characters you want to show (see `KeyboardGestures`). 

To enable action callouts for custom views, follow these steps:

* Apply the `.actionCallout(context:style:)` view modifier to the keyboard view (see `SystemKeyboard`).
* Update the `ActionCalloutContext` environment object with the actions you want to show (see `KeyboardGestures`).

Have a look at `SystemKeyboard` for examples on how this can be done.


## Locale-specific callouts

While an input callout just shows the currently pressed character, an action callout requires actions to be provided. For system keyboards, these actions depend on the current locale and may vary a lot between different locales.

KeyboardKit makes it easy to support multiple locales, where the `StandardCalloutActionProvider` accepts a list of locale-specific providers. KeyboardKit will setup a standard provider with support for `English`, but you can inject any `LocalizedCalloutActionProvider`s into this provider.


## KeyboardKit Pro

[KeyboardKit Pro][Pro] defines locale-specific callout action for all keyboard locales.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on callouts.



[Documentation]: https://keyboardkit.github.io/KeyboardKit/documentation/keyboardkit/
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
