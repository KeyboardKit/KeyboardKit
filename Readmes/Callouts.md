# Callouts

KeyboardKit lets you show input callouts as users type, as well as action callouts for the currently pressed key.


## Input callouts

An input callout shows the currently typed character in a callout bubble. 

Input callouts are automatically triggered by providing an `InputCalloutContext` with the character to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `InputCalloutContext` and bind it to its `inputCalloutContext` property when the extension is started.

The context will by default only work for `iPhone`, since iPads don't have these callouts. You can enable them for iPads or disable them altogether by changing the context's `isEnabled`.


## Action callouts

An action callout shows alternate actions to the pressed key in a callout bubble. 

Action callouts are automatically triggered by providing an `ActionCalloutContext` with the actions to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `ActionCalloutContext` and bind it to its `actionCalloutContext` property when the extension is started.

It will also create a `CalloutActionProvider` and bind it to its `calloutActionProvider`. You can use it as is or replace it with a custom provider.


## Callout action provider

KeyboardKit has a `CalloutActionProvider` protocol that can be implemented to provide actions to an action callout.

Implementing a callout action provider is easy. You can inherit `BaseCalloutActionProvider` to get started and see the `EnglishCalloutActionProvider` for inspiration.


## Binding callouts to views

To enable input callouts for custom views, follow these steps:

* Apply the `.inputCallout(context:keyboardContext:style:)` view modifier to the keyboard view (see `SystemKeyboard`).
* Update the `InputCalloutContext` environment object with the characters you want to show (see `KeyboardGestures`). 

To enable action callouts for custom views, follow these steps:

* Apply the `.actionCallout(context:style:)` view modifier to the keyboard view (see `SystemKeyboard`).
* Update the `ActionCalloutContext` environment object with the actions you want to show (see `KeyboardGestures`).

Have a look at `SystemKeyboard` for examples on how this can be done.


## Locale-specific callouts

While an input callout just shows the currently pressed character, an action callout requires actions to be provided, as described above.

For system keyboards, callout actions depend on the current locale and may vary a lot between different locales.

KeyboardKit makes it easy to support multiple locales, where the `StandardCalloutActionProvider` is designed to accept a list of locale-specific providers.  

KeyboardKit will setup the standard provider with support for `English`, but you can inject any provider that implements `LocalizedCalloutActionProvider` into this provider.


## KeyboardKit Pro

KeyboardKit Pro defines locale-specific callout actions for all keyboard locales.

[Read more here][Pro].  



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
