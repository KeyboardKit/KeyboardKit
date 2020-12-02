# Input Sets

KeyboardKit has a `KeyboardInputSet` struct that represents rows of input characters for a keyboard.

`KeyboardInputSet` is then divided into three separate groups:

* `AlphabeticKeyboardInputSet` for alphabetic keyboards.
* `NumericKeyboardInputSet` for numeric keyboards.
* `SymbolicKeyboardInputSet` for symbolic keyboards.


## Input set vs. keyboard layout

A *keyboard input set* is the set of characters that make up the input part of a keyboard.

A *keyboard layout* is the total number of actions that make up the complete keyboard.

A keyboard layout can thus be constructed with an input set and additional surrounding actions. 


## Locale-specific input sets

`KeyboardInputSet+Locale` contains locale-specific input sets.

The following locales are currently implemented:

* English (US)
* German
* Italian
* Swedish
* (read more below regarding adding more locales)

You can get locale-speific input with the `KeyboardInputSet.<type>_<locale>` properties, for instance `KeyboardInputSet.alphabetic_it`.


## Input set providers

The `KeyboardInputProvider` protocol can be used to resolve input sets in a more dynamic way. 

There are two built-in implementations:

* `StaticKeyboardInputProvider` is manually created with three input sets.
* `StandardKeyboardInputProvider` tries to resolve input sets for the current locale, with fallback to English if the locale isn't supported.

KeyboardKit will by default inject a `StandardKeyboardInputProvider` into the current context. 

You can use this provider if you want to (for custom keyboards, you don't have to) and replace it with a custom implementation at anytime.


## Adding more locales

Support for new locales can be added to KeyboardKit like this:

* Add new locale-specific sets to `KeyboardInputSet+Locale`.
* Add new locale-specific dictionary keys to `StandardKeyboardInputProvider`.

I will gladly accept PRs that bring additional locale support to this library. 👍
