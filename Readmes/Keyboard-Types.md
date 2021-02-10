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

With SwiftUI, you can observe the `ObservableKeyboardContext` environment object and use its `keyboardType` to create a keyboard view. This will automatically change the UI when the `keyboardType` value changes.   

Have a look at the demo application for some inspiration. It supports a couple of different keyboard views and uses the observable context as described above.


## Not required

It's woth mentioning that the concept of keyboard types is just a convenience for you to use if you want. KeyboardKit doesn't force you to stick with specific types or views. You can use any views you want in your keyboard extension.
