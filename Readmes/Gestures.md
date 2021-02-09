# Gestures

KeyboardKit has a `KeyboardAction` enum with these actions:

* `backspace` - sends a backspace to the text proxy when `tapped` and repeats this action until the button is releasd
* `character` - sends a text character to the text proxy when `tapped`
* `command` - represents the macOS `command` key
* `control` - represents the macOS `control` key
* `dismissKeyboard` - dismisses the keyboard when `tapped`
* `done` - represents a primary `Done` action
* `dictation` - can be used to trigger a custom dictation action
* `dismissKeyboard` - dismisses the keyboard
* `emoji` - represents an emoji button with an associated `Emoji` value
* `emojiCategory(category:)` - can be used to show a specific emoji category
* `escape` - represents the macOS `esc` key
* `function` - represents the macOS `fn` key
* `go` - represents a primary `Go` action
* `image` - represents an image, with a description, keyboard image name and image name
* `keyboardType(type)` - changes the keyboard type to `.alphabetic(type)` when `tapped`
* `moveCursorBackward` - moves the cursor back one position when `tapped`
* `moveCursorForward` - moves the cursor forward one position when `tapped`
* `newLine` - sends a new line character to the text proxy when `tapped`
* `nextKeyboard` - triggers the system switcher when `tapped` and `long pressed`
* `ok` - represents a primary `OK` action
* `option` - represents the macOS `option` key
* `search` - represents a primary `Search` action
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`
* `systemImage` - represents a system image, with a description, keyboard image name and image name
* `space` - sends an empty space to the text proxy when `tapped` and ends the current sentence when `double tapped`
* `tab` - sends a tab character to the text proxy when `tapped`

* `custom(name:)` - a custom action if no other actions fit your needs
* `none`- use this for empty "placeholder" keys that do nothing


## Handling actions

Keyboard actions can be applied to any view or triggered programmatically. They can be handled with a `KeyboardActionHandler`.

`KeyboardInputViewController` has a `keyboardActionHandler` property that you can use. KeyboardKit will setup a standard action andler by default, but you can replace it with any custom handler.

You can inherit `StandardKeyboardActionHandler` and override any parts of the standard behavior. This is recommended instead of building a completely new action handler from scratch. 


## Gesture actions

Standard keyboard button gestures include `tap`, `double tap`, `long press`, `repeat press` and `drag`.

You can apply keyboard gestures to any SwiftUI view with the `keyboardGestures` view modifiers, which can apply custom actions or wire up the correct gestures for a certain keyboard action.

Some keyboard actions have standard gesture actions, like how `tap` on a character sends the text to the text document proxy and how `long press` on backspace `repeats` the delete action.

The standard actions will be used by the standard action handler, but you can handle any gesture on any action in any way you want.  

Many actions do not have any standard behavior, since their behavior depend on your application. For instance, `image` requires that you decide what to do with a tapped or long pressed image, and implement it yourself.

You can handle actions that have no standard behavior by implementing a custom action handler, like the demo app does.


## Secondary callout actions

Keyboard actions can have secondary actions that are presented in a callout when a button with the action is long pressed.

`KeyboardInputViewController` has a `keyboardSecondaryCalloutActionProvider` that can be used to provide secondary actions for various keyboard actions. KeyboardKit will set this to a `StandardSecondaryCalloutActionProvider` by default, but you can replace it with any custom provider.

Read more about these callouts in the [callout][Callouts] readme.


[Appearance]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Appearance.md
[Callouts]: https://github.com/danielsaidi/KeyboardKit/blob/master/Readmes/Callouts.md
