# Input Sets

KeyboardKit has a `KeyboardInputSet` struct, which represents rows of input characters.

An input set is divided into three sub-groups:

* `AlphabeticKeyboardInputSet` for alphabetic keyboards.
* `NumericKeyboardInputSet` for numeric keyboards.
* `SymbolicKeyboardInputSet` for symbolic keyboards.


## Input set vs. keyboard layout

A *keyboard input set* is the characters that make up the input part of a keyboard.

A *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Input set providers

KeyboardKit has a `KeyboardInputSetProvider` protocol that can be used to provide input sets to the extension. 

Using an input set provider instead of creating input sets manually gives you a dynamic way of working with inputs.

`KeyboardInputViewController` will automatically create a standard `keyboardInputSetProvider` when the extension is started. You can use it as is or replace it with a custom one.


## Supporting more locales

The `StandardKeyboardInputSetProvider` is initialized with a list of locale-specific providers.

KeyboardKit will setup the standard provider with support `English`, but you can inject any provider that implements `KeyboardInputSetProvider` and `LocalizedService` into this provider.

Have a look at the demo app, which extends the standard provider with support for Swedish.  

I will gladly accept any PRs that add more locale-specific providers to this library. 👍


## Optional

It's woth mentioning that the concept of input sets is just a convenience. KeyboardKit doesn't force you to use input sets. Your keyboard extensions can look and behave however you want.
