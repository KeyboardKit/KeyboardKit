# Keyboard Types

`KeyboardKit` comes with a set of keyboard types:

* `alphabetic(uppercased/lowercased/capsLocked)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `images`
* `custom(name)` - a custom type if no other types fit your needs

`KeyboardInputViewController` has a `keyboardType` property and functions for changing the keyboard type. 

However, these types have no universal meaning. You have to implement each type yourself, depending on what your app means with a "symbolic" keyboard.
