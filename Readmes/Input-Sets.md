# Input Sets

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in different languages.


## Keyboard Input Set

KeyboardKit has a `KeyboardInputSet` struct that represents rows of input characters.

An input set is divided into three sub-groups:

* `AlphabeticKeyboardInputSet` for alphabetic keyboards.
* `NumericKeyboardInputSet` for numeric keyboards.
* `SymbolicKeyboardInputSet` for symbolic keyboards.

You can provide KeyboardKit with input sets by implementing an input set provider.


## Input set providers

KeyboardKit has a `KeyboardInputSetProvider` protocol that can be used to provide input sets to the extension. 

Using an input set provider instead of creating input sets manually gives you a dynamic way of working with inputs.

`KeyboardInputViewController` will automatically create a `StandardKeyboardInputSetProvider` when the extension is started. You can use it as is or replace it with a custom provider.


## Input set vs. keyboard layout

A *keyboard input set* is the characters that make up the input part of a keyboard.

A *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Supporting more locales

The `StandardKeyboardInputSetProvider` is initialized with a list of locale-specific providers.

KeyboardKit will setup the standard provider with support for `English`, but you can inject any provider that implements `KeyboardInputSetProvider` and `LocalizedService` into this provider.

You can implement a custom provider by inheriting `DeviceSpecificInputSetProvider` or create a completely custom one by implementing `InputSetProvider` from scratch.


## KeyboardKit Pro

KeyboardKit Pro defines locale-specific input sets for all keyboard locales.

[Read more here][Pro]. 


## Optional

It's worth mentioning that the concept of input sets is just a convenience. KeyboardKit doesn't force you to use input sets. Your keyboard extensions can look and behave however you want.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
