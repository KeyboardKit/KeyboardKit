# Actions

KeyboardKit has a `KeyboardAction` enum with these actions:

* `backspace` - sends a backspace to the text proxy when `tapped` and repeats this action until the button is releasd
* `capsLock` - changes the keyboard type to `.alphabetic(.capsLocked)` when `tapped`
* `character` - sends a text character to the text proxy when `tapped`
* `command` - represents the macOS `command` key
* `control` - represents the macOS `control` key
* `custom(name:)` - a custom action if no other actions fit your needs
* `dismissKeyboard` - dismisses the keyboard when `tapped`
* `emoji`  - alias for `.character` and can be used to distict emojis
* `emojiCategory(category:)` - can be used to show a specific emoji category
* `escape` - represents the macOS `esc` key
* `function` - represents the macOS `fn` key
* `image` - represents an image, with a description, keyboard image name and image name
* `keyboardType(type)` - changes the keyboard type to `.alphabetic(type)` when `tapped`
* `moveCursorBackward` - moves the cursor back one position when `tapped`
* `moveCursorForward` - moves the cursor forward one position when `tapped`
* `newLine` - sends a new line character to the text proxy when `tapped`
* `nextKeyboard` - triggers the system switcher when `tapped` and `long pressed`
* `option` - represents the macOS `option` key
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`
* `shiftDown` - changes the keyboard type to `.alphabetic(.lowercased)` when `tapped`
* `space` - sends an empty space to the text proxy when `tapped` and ends the current sentence when `double tapped`
* `systemImage` - represents a system image, with a description, keyboard image name and image name
* `tab` - sends a tab character to the text proxy when `tapped`
* `none`- use this for empty "placeholder" keys that do nothing

These actions can be applied to keyboard buttons or triggered programatically.


## Handling actions

You can use these actions in any way you like, but KeyboardKit lets you specify a `KeyboardActionHandler` that will be used to handle actions.

`KeyboardContext` has an `actionHandler` property that can be used to get and set the current action handler.

KeyboardKit will apply a `StandardKeyboardActionHandler` by default, but you can inject a custom action handler if you want.


## Actions for tap, long press, repeat etc.

The `tap` and `long press` behaviors described above are the standard behaviors that are automatically applied if you use or inherit `StandardKeyboardActionHandler`. Actions that have no explicit `long press` action uses the same action as for `tap`.

Many actions have no standard behavior, since their behavior depend on your application. For instance, `image` requires that you decide what to do with a tapped or long pressed image, and implement it in your keyboard.

You can handle actions that have no standard behavior by implementing a custom action handler, like the demo app does.


## Appearance

The standard system look of each action depends on the current color scheme, keyboard appearance etc. `KeyboardKitSwiftUI` contains utilities to help you with this.


## Icons

Some actions have an icon that is displayed when the action is used in a system keyboard. `KeyboardKitSwiftUI` contains SF Symbols based icons for many actions.


## Texts

Some actions have a text that is displayed when the action is used in a system keyboard. `KeyboardKitSwiftUI` contains extensions for this.




