# Actions

KeyboardKit comes with a set of actions that can be applied to keyboard buttons or triggered programatically:

* `backspace` - sends a backspace to the text proxy when `tapped` and repeats this action until the button is releasd
* `capsLock` - changes the keyboard type to `.alphabetic(.capsLocked)` when `tapped`
* `character` - sends a text character to the text proxy when `tapped`
* `command` - represents the macOS `command` key
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

The `tap` and `long press` behavior described above is the standard behavior that is automatically applied if you use the default action handler. If you don't use the default handler, you can handle any action in any way you like.

All actions that has no explicit `long press` action default uses the same action as for `tap`.

Many actions have no standard behavior, since their behavior depend on your application. For instance, `image` only represents an image button, but you have to decide what to do with a tapped or long pressed image.

Some actions in the list represents actions from other platforms. For instance `command`, `function` and `option` do not exist in iOS, but may still serve a functional or semantical purpose in your keyboard.
