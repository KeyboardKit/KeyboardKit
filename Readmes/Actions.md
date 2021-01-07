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

You can use these actions in any way you like, but KeyboardKit also lets you specify a `KeyboardActionHandler` that can be used to handle actions.

`KeyboardContext` has an `actionHandler` that you can use for this. KeyboardKit will apply a `StandardKeyboardActionHandler` by default, but you can replace it with any custom action handler.


## Actions for tap, long press, repeat etc.

The `tap` and `long press` behaviors described above are the standard behaviors that are automatically applied if you use or inherit `StandardKeyboardActionHandler`. Actions that have no explicit `long press` action uses the same action as for `tap`.

Many actions have no standard behavior, since their behavior depend on your application. For instance, `image` requires that you decide what to do with a tapped or long pressed image, and implement it in your keyboard.

You can handle actions that have no standard behavior by implementing a custom action handler, like the demo app does.


## Secondary callout actions

Secondary callout actions are actions that can be presented in a callout when an action is being pressed.

You can use these actions in any way you like, but KeyboardKit also lets you specify a `SecondaryCalloutActionProvider` that can be used to provide secondary callout actions for keyboard actions.

`KeyboardContext` has a `secondaryCalloutActionProvider` that you can use for this. KeyboardKit will apply a `StandardSecondaryCalloutActionProvider` by default, but you can replace it with any custom action handler.


## Callouts

KeyboardKit supports two different kind of callouts - input callouts and secondary input callouts:

* Input callouts highlight the currently pressed keyboard.
* Secondary input callouts present secondary inputs for the currently pressed keyboard. 

These two callouts are SwiftUI exclusive and require `KeyboardKitSwiftUI`. The SwiftUI-based `SystemKeyboard` automatically sets up both callouts and the standard keyboard button gestures will trigger them accordingly.


## Appearance

The standard system look of each action depends on the current color scheme, keyboard appearance etc. 

`KeyboardKitSwiftUI` contains utilities to help you with this, but you can also apply keyboard actions to any views, with completely custom looks and behaviors.


## Icons & Texts

Some actions have standard texts or icons when they are used in a system keyboard. `KeyboardKitSwiftUI` contains SF Symbols-based icons and standard texts for many actions.
