# Understanding Actions

This article describes the KeyboardKit action engine.

In KeyboardKit, the ``KeyboardAction`` enum defines a set of keyboard-specific actions that can be bound to buttons and handled with a ``KeyboardActionHandler``, which can be used to handle actions, trigger feedback, etc.

KeyboardKit will bind a ``StandardKeyboardActionHandler`` to ``KeyboardInputViewController/keyboardActionHandler`` when the keyboard is loaded. You can replace it with a custom implementation at any time.


## Keyboard actions

The ``KeyboardAction`` enum contains a bunch of actions, for instance:

* ``KeyboardAction/character(_:)`` - inserts a text character.
* ``KeyboardAction/backspace`` - deletes backwards.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/emoji(_:)-swift.enum.case`` - inserts an emoji.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/moveCursorBackward`` - moves the input cursor back.
* ``KeyboardAction/moveCursorForward`` - moves the input cursor forward.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action.
* ``KeyboardAction/primary(_:)`` - represents a primary button, e.g. `return`, `go`, `search`, etc.
* ``KeyboardAction/shift(currentCasing:)`` - changes the shift casing.
* ``KeyboardAction/space`` - inserts a space.

The descriptions below are the standard behaviors when actions are handled with a StandardKeyboardActionHandler.


## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can handle keyboard actions. 

You can trigger actions programmatically by calling ``KeyboardActionHandler/handle(_:)`` or call ``KeyboardActionHandler/handle(_:on:)`` to handle a certain gesture on a certain action, e.g. press and release on an input character:

```swift
func doStuff(with actionHandler: KeyboardActionHandler) {
    actionHandler.handle(.backspace)
    actionHandler.handle(.press, on: .character("a")
    actionHandler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by action-specific gestures, e.g. by using a ``KeyboardButton/Button`` view or by applying a `keyboardButton` view modifier to any view:

```swift
Text("Button")
    .keyboardButton(...)
```

``SystemKeyboard`` automatically applies this modifier to all buttons.


## How to customize the action behavior

You can customize the action behavior by replacing ``KeyboardInputViewController/keyboardActionHandler`` with a custom ``KeyboardActionHandler``. This is needed for actions that don't have a default system behavior, like ``KeyboardAction/image``.


## How to create a custom action handler

You can create a custom ``KeyboardActionHandler`` by either inheriting the ``StandardKeyboardActionHandler`` base class and customize the parts you want, or implement the ``KeyboardActionHandler`` protocol from scratch. 

For instance, here is a custom handler that inherits ``StandardKeyboardActionHandler`` and extends it with the image capabilities:

```swift
class CustomActionHandler: StandardKeyboardActionHandler {
    
    init(inputViewController: KeyboardInputViewController) {
        super.init(inputViewController: inputViewController)
    }
    
    override func action(
        for gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) -> KeyboardAction.GestureAction? {
        let standard = super.action(for: gesture, on: action)
        switch gesture {
        case .longPress: return longPressAction(for: action) ?? standard
        case .release: return releaseAction(for: action) ?? standard
        default: return standard
        }
    }
    
    func longPressAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.saveImage(named: imageName) }
        default: return nil
        }
    }
    
    func releaseAction(for action: KeyboardAction) -> KeyboardAction.GestureAction? {
        switch action {
        case .image(_, _, let imageName): return { [weak self] _ in self?.copyImage(named: imageName) }
        default: return nil
        }
    }
}
```

To use this handler instead of the standard one, just set ``KeyboardInputViewController/keyboardActionHandler`` to this custom handler:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.
