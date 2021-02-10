# Callouts

KeyboardKit has support for various callouts, that are presented as the user types.


## Input callouts

An input callout can be used to show the currently typed character in a callout bubble. It's triggered by providing an observable context with the character to display. 

This callout type will automatically be enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create a `keyboardInputCalloutContext` when the extension is started. You can either use this context as is or replace it with a custom one.

The standard callout context will only work for `iPhone`, since that is the standard iOS behavior.

You can enable input callouts for iPad or disable input callouts altogether by creating a custom context and registering it as described above.

To enable input callouts for custom views, follow these steps:

* Use the `.inputCallout(style:)` view modifier on the keyboard container view (as done by `SystemKeyboard`).
* Update the `InputCalloutContext` environment object with the characters you want to show (as done by `KeyboardGestures`). 


## Secondary action callouts

A secondary input callout can be used to show secondary keyboard actions in a callout bubble. It's triggered by providing an observable context with the actions to display.

This callout type will automatically be enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create a `keyboardSecondaryCalloutActionProvider` and a `keyboardSecondaryInputCalloutContext` when the extension is started. You can either use these as is or replace them with custom ones.

The action provider determines which secondary actions to show for a certain keyboard action.  

To enable secondary action callouts for custom views, follow these steps:

* Use the `.secondaryInputCallout(style:)` view modifier on the keyboard container view (as done by `SystemKeyboard`).
* Update the `SecondarInputCalloutContext` environment object with the characters you want to show (as done by `KeyboardGestures`).


## Supporting more locales

The `StandardKeyboardInputSetProvider` is initialized with a list of locale-specific providers that are included in this library. 

At the time of writing, this gives you support for `English` and `Swedish` out of the box.

You can however use any custom provider that implements `SecondaryCalloutActionProvider` and `LocalizedService` with the standard provider, so it's easy to add your own locales to the existing solution.  

I will gladly accept any PRs that add more locale-specific providers to this library. 👍

