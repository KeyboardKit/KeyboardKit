# Actions

This article describes the KeyboardKit action engine and how to use it.

In KeyboardKit, the ``KeyboardAction`` enum defines a set of keyboard-specific actions that can be bound to buttons and handled with a ``KeyboardActionHandler``.



## Keyboard actions

The action descriptions below are the standard action behaviors when using a ``StandardKeyboardActionHandler``.

### Inputs

* ``KeyboardAction/character(_:)`` - inserts a text character when released.
* ``KeyboardAction/characterMargin(_:)`` - inserts a text character when released, rendered as empty space.
* ``KeyboardAction/emoji(_:)`` - inserts an emoji when released.
* ``KeyboardAction/space`` - inserts a space when released and moves the cursor when long pressed.
* ``KeyboardAction/tab`` - inserts a tab when released.

### Actions

* ``KeyboardAction/backspace`` - deletes backwards when pressed, and repeats that action until it's released.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard when released.
* ``KeyboardAction/emojiCategory(_:)`` - can be used to show a specific emoji category.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type when pressed.
* ``KeyboardAction/moveCursorBackward`` - moves the input cursor back one step when released.
* ``KeyboardAction/moveCursorForward`` - moves the input cursor forward one step when released.
* ``KeyboardAction/nextKeyboard`` - triggers the keyboard switcher action when tapped and long pressed.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action when long pressed and released.
* ``KeyboardAction/shift(currentState:)`` - changes the alphabetic keyboard casing when released and double tapped.

### System

* ``KeyboardAction/command`` - represents a command (⌘) key.
* ``KeyboardAction/control`` - represents a control (⌃) key.
* ``KeyboardAction/dictation`` - represents a dictation key.
* ``KeyboardAction/escape`` - represents an escape (esc) key.
* ``KeyboardAction/function`` - represents a function (fn) key.
* ``KeyboardAction/option`` - represents an option (⌥) key.
* ``KeyboardAction/primary(_:)`` - represents a primary button, e.g. `return`, `go`, `search` etc.

### Custom

* ``KeyboardAction/custom(named:)`` - a custom action that you can handle in any way you want.
* ``KeyboardAction/image(description:keyboardImageName:imageName:)`` - can be used to refer to an image asset.
* ``KeyboardAction/none``- a "no action" placeholder action.
* ``KeyboardAction/settings`` - a custom action that can be used to e.g. show a settings screen.
* ``KeyboardAction/systemImage(description:keyboardImageName:imageName:)`` - can be used to refer to a system image (SF Symbol).



## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can be used to handle keyboard actions. 

You can trigger actions programmatically by calling ``KeyboardActionHandler/handle(_:on:)`` with a ``KeyboardGesture`` and a ``KeyboardAction``:

```swift
class MyClass {

    init(actionHandler: KeyboardActionHandler) {
        self.actionHandler = actionHandler
    }

    private let actionHandler: KeyboardActionHandler

    func stopEditingText() {
        actionHandler.handle(.release, on: .dismissKeyboard)
    } 
}
```

Keyboard actions can also be triggered by keyboard-specific gestures that are applied to buttons. If you use a ``SystemKeyboard``, action gestures will be automatically applied to the various buttons.

KeyboardKit will by default create a ``StandardKeyboardActionHandler`` and apply it to the input controller's ``KeyboardInputViewController/keyboardActionHandler``. You can replace it with a custom handler to customize how actions are handled.



## How to create a custom keyboard action handler

You can create a custom ``KeyboardActionHandler`` to customize how keyboard actions are handled, or to handle actions that have no default behavior.

You can create a custom action handler by inheriting the ``StandardKeyboardActionHandler`` base class, which gives you a lot of functionality for free, or by implementing ``KeyboardActionHandler`` from scratch. 

For instance, here is a custom action handler that inherits ``StandardKeyboardActionHandler`` and extends it with the capabilities to copy and save images:

```swift
class MyActionHandler: StandardKeyboardActionHandler {
    
    public init(inputViewController: KeyboardInputViewController) {
        super.init(inputViewController: inputViewController)
    }
    
    override func action(
        for gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) -> KeyboardAction.GestureAction? {
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

To use this action handler instead of the standard one, just set the input controller's ``KeyboardInputViewController/keyboardActionHandler`` to the new handler:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
