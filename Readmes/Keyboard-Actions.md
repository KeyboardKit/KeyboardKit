# Keyboard Actions

`KeyboardKit` comes with a set of actions that can be applied to your keyboard buttons:

* `backspace` - sends a backspace to the text proxy when `tapped`
* `capsLock` - can be used to lock the keyboard in upper case
* `character` - sends a text character to the text proxy when `tapped`
* `command` - represents the macOS command key
* `custom(name:)` - a custom fallback if no other actions fits your needs
* `dismissKeyboard` - dismisses the keyboard when `tapped`
* `emoji`  - alias for `.character, but can be used to distict emojis
* `escape` - represents the macOS esc key
* `function` - represents the macOS fn key
* `image` - has a description, keyboard image name and image name
* `moveCursorBackward` - moves the cursor back one position when `tapped`
* `moveCursorForward` - moves the cursor forward one position when `tapped`
* `newLine` - sends a new line character to the text proxy when `tapped`
* `option` - represents the macOS option key
* `shift` - can be used to toggle between upper and lower case
* `shiftDown` - can be used to toggle between upper and lower case
* `space` - sends an empty space to the text proxy when `tapped`
* `switchKeyboard` - triggers the system switcher when `tapped` and `long pressed`
* `switchToKeyboard(type)` - can be used to switch to a specific keyboard type
* `tab` - sends a tab character to the text proxy when `tapped`
* `none`- use this for empty "placeholder" keys that do nothing

`KeyboardInputViewController` has a `keyboardActionHandler` to which you should delegate all actions. It uses a `StandardKeyboardActionHandler` by default, but you can replace with any implementation.

The `tap` and `long press` behavior described above for some actions above is the default behavior that is automatically applied if you use the default handler. If you do not use the default handler, you have to handle the tapped buttons yourself.

Most actions have no standard behavior, since their behavior depend on your application. For instance, `image` only represents an image button, but you have to decide what to do with a tapped or long pressed image.

Some actions in the list represents actions from other platforms. For instance `command`, `function` and `option` doesn't exist in iOS, but may still serve a functional or semantical purpose in your keyboard.
