# Keyboard Actions

KeyboardKit has a `KeyboardAction` enum with these actions:

* `backspace` - deletes text backwards in the text document proxy when `tapped` and repeats this action until the button is released
* `character` - sends a text character to the text document proxy when `tapped`
* `command` - represents a macOS command key
* `control` - represents a macOS control key
* `dictation` - represents an iOS dictation key
* `dismissKeyboard` - dismisses the keyboard when `tapped`
* `done` - represents a primary `Done` action and triggers a return when `tapped`
* `emoji` - sends an emoji to the text document proxy when `tapped`
* `emojiCategory(category:)` - can be used to show a specific emoji category
* `escape` - represents a macOS `esc` key
* `function` - represents a macOS `fn` key
* `go` - represents a primary `Go` action and triggers a return when `tapped`
* `image` - can be used to show an embedded image asset
* `keyboardType(type)` - changes the keyboard type when `tapped`
* `moveCursorBackward` - moves the cursor back one position when `tapped`
* `moveCursorForward` - moves the cursor forward one position when `tapped`
* `newLine` - sends a new line character to the text proxy when `tapped`
* `nextKeyboard` - triggers the main keyboard switcher when `tapped` and `long pressed`
* `ok` - represents a primary `OK` action and triggers a return when `tapped`
* `option` - represents a macOS `option` key
* `return` - has the same behavior as a `newLine`, but is supposed to show a text instead of an arrow
* `search` - represents a primary `Search` action and triggers a return when `tapped`
* `settings` - can be used to show a settings window or trigger a settings action
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`
* `space` - sends a space to the text document proxy when `tapped` and ends the current sentence when `double tapped`
* `systemImage` - can be used to show a system image asset (SF Symbol)
* `tab` - sends a tab to the text document proxy when `tapped`

* `custom(name:)` - a custom action that you can handle in a custom action handler (read more below)

* `none`- an "empty" action that can be used as a placeholder 


## Standard actions

Some keyboard actions have standard gesture actions, as described above. These actions can be accessed with:

* `standardDoubleTapAction`
* `standardLongPressAction`
* `standardRepeatAction`
* `standardTapAction`

You can trigger these actions manually, but a better and more dynamic way is to use an action handler.


## Action handlers

KeyboardKit has a `KeyboardActionHandler` protocol that can be implemented by any class that can be used to handle keyboard actions. Using an action handler instead of triggering actions directly gives you a very flexible way of handling actions.

`KeyboardInputViewController` will automatically create a standard `keyboardActionHandler` when the extension is started. You can either use this handler as is or replace it with a custom one.

Note that some parts of the library require you to use an action handler and that action that haven't got a standard behavior require you to use a custom action handler. 


## View gestures

Keyboard actions-specific gestures can be bound to any view by using the `keyboardGestures` view modifier.

This will setup gestures for `tap`, `double tap`, `long press`, `repeat press` and `drag`. The events will be routed to the provided action handler. 
