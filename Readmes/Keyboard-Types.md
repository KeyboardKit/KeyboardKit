# Keyboard Types

KeyboardKit comes with many different keyboard types, like `alphabetic`, `numeric`, `symbolic`, `emoji` etc. You can even create your own types.


## Keyboard Type

KeyboardKit has a `KeyboardType` enum with these types:

* `alphabetic(uppercased/lowercased/capsLocked)` - represents alphabetic input keyboards.
* `numeric` - represents numeric input keyboards.
* `symbolic` - represents symbolic input keyboards.
* `email` - represents email keyboards (not implemented).
* `emojis` - represents emoji category keyboards.
* `images` - represents custom image keyboards (not implemented).

* `custom(name)` - a custom type if no other types fit your needs

Note that the e-mail, image and custom keyboards require custom handling.   


## Changing keyboard type

`KeyboardContext` has a `keyboardType` that can be used to get and set the current keyboard type. However, this will not have any effect unless you actually use the type to create a keyboard view that you present to the user. 

You can observe the `KeyboardContext` environment object and use its `keyboardType` to render the correct keyboard view. This will automatically change the UI when the `keyboardType` value changes.   

Have a look at the demo application for some inspiration. It supports a couple of different keyboard views and uses the observable context as described above.


## Optional

It's worth mentioning that the concept of keyboard types is just a convenience. KeyboardKit doesn't force you to use keyboard types. Your keyboard extensions can look and behave however you want.
