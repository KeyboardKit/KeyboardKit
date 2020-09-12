# Keyboard Types

`KeyboardKit` comes with a `KeyboardType` enum with these keyboard types:

* `alphabetic(uppercased/lowercased/capsLocked)`
* `numeric`
* `symbolic`
* `email`
* `emojis`
* `images`
* `custom(name)` - a custom type if no other types fit your needs

`KeyboardContext` has a `keyboardType` property that can be used to get and set the current keyboard type. 

`IMPORTANT` Note that changing `keyboardType` will not achieve anything in itself. You must actively use the property in your extension, e.g. to switch over it to determine which keyboard to display. 
