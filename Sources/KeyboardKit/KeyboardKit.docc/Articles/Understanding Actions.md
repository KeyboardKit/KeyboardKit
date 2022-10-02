# Understanding Actions

This article describes the KeyboardKit action model and how to use it. 


## Keyboard actions

In KeyboardKit, keyboard actions are fundamental building-blocks that can be bound to buttons and triggered programmatically, using a ``KeyboardActionHandler``.

The ``KeyboardAction`` enum defines a bunch of keyboard-specific actions, where the descriptions below are the standard behaviors of the various action.

### Inputs

* ``KeyboardAction/character(_:)`` - sends a text character to the text document proxy when tapped.
* ``KeyboardAction/emoji(_:)`` - sends an emoji to the text document proxy when tapped.
* ``KeyboardAction/newLine`` - sends a new line character to the text proxy when tapped.
* ``KeyboardAction/return`` - has the same behavior as a `newLine`, but is supposed to show a erturn text instead of an arrow.
* ``KeyboardAction/space`` - sends a space to the text document proxy when `tapped`.
* ``KeyboardAction/tab`` - sends a tab to the text document proxy when `tapped`.

### Actions

* ``KeyboardAction/backspace`` - deletes text backwards in the text document proxy when tapped and repeats this action until the button is released.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard when tapped.
* ``KeyboardAction/emojiCategory(_:)`` - can be used to show a specific emoji category.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type when tapped.
* ``KeyboardAction/moveCursorBackward`` - moves the input cursor back one step when tapped.
* ``KeyboardAction/moveCursorForward`` - moves the input cursor forward one step when tapped.
* ``KeyboardAction/nextKeyboard`` - triggers the main keyboard switcher when tapped and long pressed.
* ``KeyboardAction/nextLocale`` - selects the next locale in the keyboard context when tapped and long pressed.
* ``KeyboardAction/shift(currentState:)`` - changes the keyboard type to ``KeyboardType/alphabetic(_:)`` `.uppercased` when tapped and `.capslocked` when double tapped.

### System

* ``KeyboardAction/command`` - represents a macOS command key.
* ``KeyboardAction/control`` - represents a macOS control key.
* ``KeyboardAction/dictation`` - represents an iOS dictation key.
* ``KeyboardAction/escape`` - represents a macOS `esc` key.
* ``KeyboardAction/function`` - represents a macOS `fn` key.
* ``KeyboardAction/option`` - represents a macOS `option` key.
* ``KeyboardAction/primary(_:)`` - represents a primary button, e.g. `go`, `search` etc.

### Custom

* ``KeyboardAction/custom(named:)`` - a custom, named action that you can handle in any way.
* ``KeyboardAction/image(description:keyboardImageName:imageName:)`` - can be used to show an embedded image asset.
* ``KeyboardAction/none``- a "no action" placeholder action.
* ``KeyboardAction/settings`` - can be used to show a settings window or trigger a settings action.
* ``KeyboardAction/systemImage(description:keyboardImageName:imageName:)`` - can be used to show a system image asset (SF Symbol).



## How to trigger keyboard actions

Keyboard actions can be triggered by keyboard-specific gestures that are applied to various buttons. If you use a ``SystemKeyboard``, this will be done automatically. You can also trigger a keyboard action programmatically by using a ``KeyboardActionHandler``.



## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can be used to handle various gestures on various keyboard actions.

KeyboardKit will by defaut create a ``StandardKeyboardActionHandler`` and bind it to the input controller's ``KeyboardInputViewController/keyboardActionHandler``. You can replace this instance with any custom action handler if you want to customize how actions are handled.

You can trigger keyboard actions programmatically by calling ``KeyboardActionHandler/handle(_:on:)``:

```swift
class MyClass {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private let actionHandler: KeyboardActionHandler

    func stopEditingText() {
        actionHandler.handle(.tap, on: .dismissKeyboard)
    } 
}
```

This is convenient when you must trigger actions from other parts of your keyboard, for instance as a side-effect when the user does something else than typing.

Although the ``StandardKeyboardActionHandler`` will handle most actions properly, there may come a time when you will have to customize how certain actions are handled. If so, you will have to create a custom keyboard action handler. 



## How to create a custom keyboard action handler

You can create a custom keyboard action handler if you want to customize how keyboard actions are handled, or to handle actions that have no default behavior.

You can create a custom action handler by inheriting the ``StandardKeyboardActionHandler`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardActionHandler`` protocol from scratch. 

For instance, here is a custom action handler that inherits ``StandardKeyboardActionHandler`` and extends it with the capabilities to copy and save images:

```swift
class MyActionHandler: StandardKeyboardActionHandler {
    
    public init(inputViewController: KeyboardInputViewController) {
        super.init(inputViewController: inputViewController)
    }
    
    override func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        let standard = super.action(for: gesture, on: action)
        switch gesture {
        case .longPress: return longPressAction(for: action) ?? standard
        case .tap: return tapAction(for: action) ?? standard
        default: return standard
        }
    }
    
    func longPressAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.saveImage(named: imageName) }
        default: return nil
        }
    }
    
    func tapAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.copyImage(named: imageName) }
        default: return nil
        }
    }
}
```

To use this action handler instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardActionHandler`` like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
