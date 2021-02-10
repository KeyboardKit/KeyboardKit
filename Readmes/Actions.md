# Actions

KeyboardKit has a `KeyboardAction` enum with these actions:

* `backspace` - sends a backspace to the text document proxy when `tapped` and repeats this action until the button is releasd
* `character` - sends a text character to the text document proxy when `tapped`
* `command` - represents a mac `command` key, does nothing
* `control` - represents a mac `control` key, does nothing
* `dismissKeyboard` - dismisses the keyboard when `tapped`
* `done` - represents a primary `Done` action and triggers a "return" when `tapped`
* `dictation` - can be used to trigger a custom dictation action
* `dismissKeyboard` - dismisses the keyboard
* `emoji` - represents an emoji button with an associated `Emoji` value
* `emojiCategory(category:)` - can be used to show a specific emoji category
* `escape` - represents the macOS `esc` key
* `function` - represents the macOS `fn` key
* `go` - represents a primary `Go` action and triggers a "return" when `tapped`
* `image` - represents an image, with a description, keyboard image name and image name
* `keyboardType(type)` - changes the keyboard type to `.alphabetic(type)` when `tapped`
* `moveCursorBackward` - moves the cursor back one position when `tapped`
* `moveCursorForward` - moves the cursor forward one position when `tapped`
* `newLine` - sends a new line character to the text proxy when `tapped`
* `nextKeyboard` - triggers the system switcher when `tapped` and `long pressed`
* `ok` - represents a primary `OK` action and triggers a "return" when `tapped`
* `option` - represents the macOS `option` key
* `search` - represents a primary `Search` action and triggers a "return" when `tapped`
* `settings` - represents a primary `Search` action
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`
* `systemImage` - represents a system image, with a description, keyboard image name and image name
* `space` - sends an empty space to the text proxy when `tapped` and ends the current sentence when `double tapped`
* `tab` - sends a tab character to the text proxy when `tapped`

* `custom(name:)` - a custom action if no other actions fit your needs

* `none`- use this for empty "placeholder" keys that do nothing 

The behavior described for each action is their standard behavior. You can handle actions in any way you want.


## Handling actions

Keyboard actions can be bound to any view (e.g. using the `keyboardGestures` view modifier) or triggered programmatically. They can be handled with a `KeyboardActionHandler`.

`KeyboardInputViewController` has a `keyboardActionHandler` that can be used to hande keyboard actions. KeyboardKit will setup a `StandardKeyboardActionHandler` by default, but you can replace it with a custom handler if you need custom handling.

To create a custom action handler, you can either start from scratch or inherit `StandardKeyboardActionHandler` and override any parts you like. 


## Gestures

Some keyboard actions have standard gesture actions, like how a `.character` sends text to the document proxy on tap and how `.backspace` repeats the delete action for as long as the button is pressed.

The standard action handler will use these standard gesture actions, but you can handle any gesture on any action in any way you like.







