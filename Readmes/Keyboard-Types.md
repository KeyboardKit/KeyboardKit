# Keyboard Types

KeyboardKit comes with many different keyboard types, like `alphabetic`, `numeric`, `symbolic` etc. You can even create your own types.


## Keyboard Type

KeyboardKit has a `KeyboardType` enum with a bunch of keyboard types, such as:

* `alphabetic(uppercased/lowercased/capsLocked)` - represents alphabetic input keyboards.
* `numeric` - represents numeric input keyboards.
* `symbolic` - represents symbolic input keyboards.
* `emojis` - represents emoji category keyboards.

* `custom(name)` - a custom type if no other types fit your needs

Note that some keyboard types require custom handling.   


## Changing keyboard type

`KeyboardContext` has a `keyboardType` that can be used to get and set the current keyboard type. However, this will not have any effect unless you actually use the type to create a keyboard view that you present to the user. 

You can observe the `KeyboardContext` environment object and use its `keyboardType` to render the correct keyboard view. This will automatically change the UI when the `keyboardType` value changes.   


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on keyboard types.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
