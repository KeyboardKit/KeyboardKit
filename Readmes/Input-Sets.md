# Input Sets

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic`  keyboards in different languages.


## Keyboard Input Set

KeyboardKit has an `InputSet` struct that represents rows of input characters.

An input set is divided into three sub-groups:

* `AlphabeticInputSet` for alphabetic keyboards.
* `NumericInputSet` for numeric keyboards.
* `SymbolicInputSet` for symbolic keyboards.

You can provide KeyboardKit with input sets by implementing an input set provider.


## Input set providers

KeyboardKit has an `InputSetProvider` protocol that can be used to provide input sets. 

Using an input set provider instead of creating input sets manually gives you a more dynamic way of working with inputs.

`KeyboardInputViewController` will automatically create a `StandardInputSetProvider` when the extension is started. You can use it as is or replace it with a custom provider.


## Input set vs. keyboard layout

A *keyboard input set* is the characters that make up the input part of a keyboard.

A *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Locale-specific callouts

For system keyboards, the input set depend on the current locale and may vary a lot between different locales.

KeyboardKit makes it easy to support multiple locales, where the `StandardInputSetProvider` is designed to accept a list of locale-specific providers.  

KeyboardKit will setup the standard provider with support for `English`, but you can inject any provider that implements `LocalizedInputSetProvider` into this provider.

The `DeviceSpecificInputSetProvider` base class makes it easier to or create custom providers.


## KeyboardKit Pro

KeyboardKit Pro defines locale-specific input sets for all keyboard locales.

[Read more here][Pro]. 


## Optional

It's worth mentioning that the concept of input sets is just a convenience. Your keyboard extensions can look and behave however you want.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
