# Callouts

KeyboardKit has support for various callouts, that are presented as bubbles when the user types on system keyboards.


## Input callouts

An input callout can be used to show the currently typed character in a callout bubble. It's triggered by providing an observable context with the character to display. This callout type will automatically be enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `InputCalloutContext` and bind it to its `keyboardInputCalloutContext` property when the extension is started. You can use it as is or replace it with a custom one.

The standard callout context will only work for `iPhone`, since iPads don't have these callouts by default. You can enable them for iPads or disable them altogether by creating a custom context and replace the standard one.

To enable input callouts for custom views, follow these steps:

* Apply the `.inputCallout(style:)` view modifier to the keyboard view (as done by `SystemKeyboard`).
* Update the `InputCalloutContext` environment object with the characters you want to show (as done by `KeyboardGestures`). 


## Secondary action callouts

A secondary input callout can be used to show secondary keyboard actions in a callout bubble. It's triggered by providing an observable context with the actions to display. This callout type will automatically be enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create a `SecondaryCalloutActionProvider` and a `SecondaryInputCalloutContext` and bind them to its `keyboardSecondaryCalloutActionProvider` and `keyboardSecondaryInputCalloutContext` properties when the extension is started. You can use them as they are or replace them with custom ones.

The action provider determines which secondary actions to show for certain keyboard actions. The standard provider has support for multiple locales and can be extended with custom locales.

To enable secondary action callouts for custom views, follow these steps:

* Apply the `.secondaryInputCallout(style:)` view modifier to the keyboard view (as done by `SystemKeyboard`).
* Update the `SecondarInputCalloutContext` environment object with the actions you want to show (as done by `KeyboardGestures`).


## Supporting more locales

The `StandardSecondaryCalloutActionProvider` is initialized with a list of locale-specific providers.  

KeyboardKit will setup the standard provider with support `English`, but you can inject any provider that implements `SecondaryCalloutActionProvider` and `LocalizedService` into this provider.

Have a look at the demo app, which extends the standard provider with support for Swedish.

I will gladly accept any PRs that add more locale-specific providers to this library. 👍

