# Input Sets

KeyboardKit comes with an input set engine that make it easy to create `alphabetic`, `numeric` and `symbolic` system keyboards.


## Input set

KeyboardKit has an `InputSet` struct that represents rows of input characters.

An input set is divided into three sub-groups:

* `AlphabeticInputSet` for alphabetic keyboards.
* `NumericInputSet` for numeric keyboards.
* `SymbolicInputSet` for symbolic keyboards.

You can create your own input sets and provide them with a custom input set provider.


## Input set vs. keyboard layout

While an *input set* is the characters that make up the input part of a keyboard, a *keyboard layout* is the actions that make up the complete keyboard, together with layout-specific information.


## Input set providers

KeyboardKit has an `InputSetProvider` protocol that can be used to provide input sets. Using an input set provider instead of passing around input sets gives you a more dynamic way of working with input sets.


## Locale-specific input sets

For system keyboards, the input set depends on the current device and locale and may vary a lot between different locales.

KeyboardKit makes it easy to support multiple locales, where the `StandardInputSetProvider` accepts a list of locale-specific providers. KeyboardKit will setup a provider with support for `English`, but you can inject any `LocalizedInputSetProvider`s into this provider.


## KeyboardKit Pro

[KeyboardKit Pro][Pro] defines locale-specific input sets for all keyboard locales.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on input sets.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
