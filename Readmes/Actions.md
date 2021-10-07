# Keyboard Actions

KeyboardKit comes with many keyboard-specific actions, like `character` inputs, `emojis`, `backspace`, `space`, `newline`, `image` etc. You can even create your own actions.


## Built-in actions

KeyboardKit has a `KeyboardAction` enum with these actions:

* `backspace` - deletes text backwards in the text document proxy when `tapped` and repeats this action until the button is released.
* `character` - sends a text character to the text document proxy when `tapped`.
* `command` - represents a macOS command key.
* `control` - represents a macOS control key.
* `dictation` - represents an iOS dictation key.
* `dismissKeyboard` - dismisses the keyboard when `tapped`.
* `emoji` - sends an emoji to the text document proxy when `tapped`.
* `emojiCategory(category:)` - can be used to show a specific emoji category.
* `escape` - represents a macOS `esc` key.
* `function` - represents a macOS `fn` key.
* `image` - can be used to show an embedded image asset.
* `keyboardType` - changes the keyboard type when `tapped`.
* `moveCursorBackward` - moves the cursor back one position when `tapped`.
* `moveCursorForward` - moves the cursor forward one position when `tapped`.
* `newLine` - sends a new line character to the text proxy when `tapped`.
* `nextKeyboard` - triggers the main keyboard switcher when `tapped` and `long pressed`.
* `nextLocale` - selects the next locale in the keyboard context when `tapped` and `long pressed`.
* `option` - represents a macOS `option` key.
* `primary` - a primary button, e.g. `go`, `search` etc.
* `return` - has the same behavior as a `newLine`, but is supposed to show a text instead of an arrow.
* `settings` - can be used to show a settings window or trigger a settings action.
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`.
* `space` - sends a space to the text document proxy when `tapped`.
* `systemImage` - can be used to show a system image asset (SF Symbol).
* `tab` - sends a tab to the text document proxy when `tapped`.

* `custom` - a custom, named action that you can handle in a custom action handler (read more below).

* `none`- an "no action" placeholder action.


## Gestures

Some keyboard actions have standard gesture actions, as described above. 

These actions can be accessed with:

* `standardAction(for: gesture)`
* `standardDoubleTapAction`
* `standardLongPressAction`
* `standardPressAction`
* `standardReleaseAction`
* `standardRepeatAction`
* `standardTapAction`

You can trigger these actions manually, but a better and more dynamic way is to use an action handler.


## Action handlers

KeyboardKit has a `KeyboardActionHandler` protocol that can be implemented by any class that can be used to handle keyboard actions. 

Using an action handler instead of triggering actions directly gives you a very flexible way of handling actions, where you can change the behavior or an entire keyboard in one single place.

`KeyboardInputViewController` will automatically create a `StandardKeyboardActionHandler` when the extension is started. You can either use this handler as is or replace it with a custom one.

Note that keyboard actions that haven't got a standard behavior require you to create and inject a custom action handler. 


## Connect an action to a `View`

Keyboard action gestures can be bound to any `SwiftUI` view with the `keyboardGestures` view modifier. This will setup gestures for that will be routed to the provided action handler.
