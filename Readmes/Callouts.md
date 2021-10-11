# Callouts

KeyboardKit lets you show input callouts as users type, as well as secondary action callouts with secondary input actions.


## Input callouts

An input callout shows the currently typed character in a callout bubble. 

Input callouts are automatically triggered by providing an `InputCalloutContext` with the character to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create an `InputCalloutContext` and bind it to its `keyboardInputCalloutContext` property when the extension is started.

The context will by default only work for `iPhone`, since iPads don't have these callouts. You can enable them for iPads or disable them altogether by changing the context's `isEnabled`.


## Secondary action callouts

A secondary action callout can be used to show secondary input actions in a callout bubble. 

Ssecondary action callouts are automatically triggered by providing a `SecondaryInputCalloutContext` with the actions to display. This is automatically enabled if you use a `SystemKeyboard`.

`KeyboardInputViewController` will automatically create a `SecondaryInputCalloutContext` and bind it to its `keyboardSecondaryInputCalloutContext` property when the extension is started.

It will also create a `SecondaryCalloutActionProvider` and bind it to its `keyboardSecondaryCalloutActionProvider`. You can use it as is or replace it with a custom provider.

Implementing a secondary action provider is easy. You can inherit `BaseSecondaryCalloutActionProvider` to get started.


## Binding callouts to views

To enable input callouts for custom views, follow these steps:

* Apply the `.inputCallout(style:)` view modifier to the keyboard view (as done by `SystemKeyboard`).
* Update the `InputCalloutContext` environment object with the characters you want to show (as done by `KeyboardGestures`). 

To enable secondary action callouts for custom views, follow these steps:

* Apply the `.secondaryInputCallout(style:)` view modifier to the keyboard view (as done in `SystemKeyboard`).
* Update the `SecondarInputCalloutContext` environment object with the actions you want to show (as done by `KeyboardGestures`).

Have a look at `SystemKeyboard` for examples on how this can be done.


## Supporting more locales

The `StandardSecondaryCalloutActionProvider` is initialized with a list of locale-specific providers.  

KeyboardKit will setup the standard provider with support for `English`, but you can inject any provider that implements `SecondaryCalloutActionProvider` and `LocalizedService` into this provider.

You can implement a custom provider by inheriting `BaseSecondaryCalloutActionProvider` or create a completely custom one by implementing `SecondaryCalloutActionProvider` from scratch.


## KeyboardKit Pro

KeyboardKit Pro defines secondary action providers for all keyboard locales.

[Read more here][Pro] regarding how to obtain a KeyboardKit Pro license. 


## Demo

The demo also registers a KeyboardKit Pro license, to demonstrate how the different locales provide different secondary actions. 



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
