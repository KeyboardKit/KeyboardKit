# Understanding Actions

This article describes KeyboardKit action model and how to use it. 


## Keyboard actions

Keyboard actions are fundamental building-blocks that can be bound to buttons and triggered using a ``KeyboardActionHandler``.

The ``KeyboardAction`` enum defines a bunch of keyboard-specific actions, such as characters, key representations, mode switches, actions etc.

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
* `none`- an "no action" placeholder action.
* `option` - represents a macOS `option` key.
* `primary` - a primary button, e.g. `go`, `search` etc.
* `return` - has the same behavior as a `newLine`, but is supposed to show a text instead of an arrow.
* `settings` - can be used to show a settings window or trigger a settings action.
* `shift` - changes the keyboard type to `.alphabetic(.uppercased)` when `tapped` and `.capslocked` when `double tapped`.
* `space` - sends a space to the text document proxy when `tapped`.
* `systemImage` - can be used to show a system image asset (SF Symbol).
* `tab` - sends a tab to the text document proxy when `tapped`.

You can even create custom actions and handle them based on their unique identifiers.

Keyboard actions are also used to define declarative keyboard layouts, using ``InputSet``s and ``KeyboardLayout``s.


## How to handle actions

Keyboard actions are handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can handle keyboard actions.

KeyboardKit will by default create a ``StandardKeyboardActionHandler`` instance and apply it to ``KeyboardInputViewController/keyboardActionHandler``, which is then used by default. You can replace this standard instance with a custom one.

You can trigger keyboard actions programatically by calling ``KeyboardActionHandler/handle(_:on:)``:

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



## How to create a custom keyboard action handler

Many keyboard actions have standard behaviors, while others require custom handling. To customize how keyboard actions are handled, or to handle actions that have no default behavior, you can implement a custom action handler.

You can create a custom action handler by either inheriting and customizing the ``StandardKeyboardActionHandler`` base class (which gives you a lot of functionality for free) or by implementing the ``KeyboardActionHandler`` protocol from scratch. 

For instance, here is a custom implementation that inherits the base class and extends it with the capabilities to copy and save images:

```swift
class MyActionHandler: StandardKeyboardActionHandler {
    
    public init(inputViewController: KeyboardInputViewController) {
        super.init(inputViewController: inputViewController)
    }
    
    
    // MARK: - Overrides
    
    override func action(for gesture: KeyboardGesture, on action: KeyboardAction) -> KeyboardAction.GestureAction? {
        let standard = super.action(for: gesture, on: action)
        switch gesture {
        case .longPress: return longPressAction(for: action) ?? standard
        case .tap: return tapAction(for: action) ?? standard
        default: return standard
        }
    }
    
    
    // MARK: - Custom actions
    
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
    
    ...
}
```

To use this implementation instead of the standard one, just replace the standard instance like this:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation everywhere instead of the standard one.
