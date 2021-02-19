# Keyboard Types

KeyboardKit has a `KeyboardType` enum with these types:

* `alphabetic(uppercased/lowercased/capsLocked)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `images`

* `custom(name)` - a custom type if no other types fit your needs  


## Changing keyboard type

`KeyboardContext` has a `keyboardType` that can be used to get and set the current keyboard type. However, this will not have any effect unless you actually use the type to create a keyboard view that you present to the user. 

With SwiftUI, you can observe the `KeyboardContext` environment object and use its `keyboardType` to create a keyboard view. This will automatically change the UI when the `keyboardType` value changes.   

Have a look at the demo application for some inspiration. It supports a couple of different keyboard views and uses the observable context as described above.


## Optional

It's woth mentioning that the concept of keyboard types is just a convenience. KeyboardKit doesn't force you to use keyboard types. Your keyboard extensions can look and behave however you want.
