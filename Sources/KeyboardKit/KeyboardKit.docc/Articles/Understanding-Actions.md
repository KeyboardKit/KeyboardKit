# Understanding Actions

This article describes the KeyboardKit action engine.

In KeyboardKit, the ``KeyboardAction`` enum defines a set of keyboard-specific actions that can be bound to buttons and handled with a ``KeyboardActionHandler``.

A ``KeyboardActionHandler`` can be used to handle actions, trigger feedback, etc. KeyboardKit will by default create a ``StandardKeyboardActionHandler`` and bind it to ``KeyboardInputViewController/keyboardActionHandler`` when the keyboard is loaded.



## Action types

The ``KeyboardAction`` enum can be grouped into categories. The descriptions below are the standard behaviors when actions are handled with a ``StandardKeyboardActionHandler``.

#### Inputs

* ``KeyboardAction/character(_:)`` - inserts a text character when released.
* ``KeyboardAction/characterMargin(_:)`` - inserts a text character when released, rendered as empty space.
* ``KeyboardAction/emoji(_:)`` - inserts an emoji when released.
* ``KeyboardAction/space`` - inserts a space when released and moves the cursor when long pressed.
* ``KeyboardAction/tab`` - inserts a tab when released.

#### Actions

* ``KeyboardAction/backspace`` - deletes backwards when pressed, and repeats that action until it's released.
* ``KeyboardAction/dictation`` - when configured, opens the main app to perform dictation.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard when released.
* ``KeyboardAction/emojiCategory(_:)`` - can be used to show a specific emoji category.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type when pressed.
* ``KeyboardAction/moveCursorBackward`` - moves the input cursor back one step when released.
* ``KeyboardAction/moveCursorForward`` - moves the input cursor forward one step when released.
* ``KeyboardAction/nextKeyboard`` - triggers the keyboard switcher action when tapped and long pressed.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action when long pressed and released.
* ``KeyboardAction/settings`` - can be used to e.g. show a settings screen.
* ``KeyboardAction/shift(currentCasing:)`` - changes the alphabetic keyboard casing when released and double tapped.
* ``KeyboardAction/systemSettings`` - navigates to System Settings.
* ``KeyboardAction/url(_:id:)`` - navigates to any custom URL.

#### System

* ``KeyboardAction/command`` - represents a command (⌘) key.
* ``KeyboardAction/control`` - represents a control (⌃) key.
* ``KeyboardAction/escape`` - represents an escape (esc) key.
* ``KeyboardAction/function`` - represents a function (fn) key.
* ``KeyboardAction/option`` - represents an option (⌥) key.
* ``KeyboardAction/primary(_:)`` - represents a primary button, e.g. `return`, `go`, `search` etc.

#### Images

* ``KeyboardAction/image(description:keyboardImageName:imageName:)`` - can be used to refer to an image asset.
* ``KeyboardAction/systemImage(description:keyboardImageName:imageName:)`` - can be used to refer to a system image (SF Symbol).

#### Other

* ``KeyboardAction/custom(named:)`` - a custom action that you can handle in any way you want.
* ``KeyboardAction/none``- a "no action" placeholder action.



## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that handle keyboard actions. 

You can trigger actions programmatically by calling ``KeyboardActionHandler/handle(_:)`` or call ``KeyboardActionHandler/handle(_:on:)`` to handle a certain ``KeyboardGesture``, such as ``KeyboardGesture/release`` on a certain ``KeyboardAction``:

```swift
let actionHandler: KeyboardActionHandler
actionHandler.handle(.backspace)
actionHandler.handle(.press, on: .character("a")
actionHandler.handle(.release, on: .dismissKeyboard)
```

Keyboard actions can also be triggered by action-specific gestures, e.g. by using a ``KeyboardButton`` view or applying a `keyboardButton` view modifier to any view.

``SystemKeyboard`` automatically applies this modifier to all buttons.



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
