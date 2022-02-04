# Understanding Keyboard Actions

This article describes keyboard actions and how to use action handlers. 


## Keyboard actions

KeyboardKit has a ``KeyboardAction`` enum that defines keyboard-specific actions that correspond to actions that can be found on various keyboards. Keyboard actions are fundamental building-blocks in the library.

Keyboard actions can be bound to buttons and triggered with a ``KeyboardActionHandler``. Keyboard actions are also used to define keyboard layouts and provide a declarative way to express a layout without having to specify exactly how your actions will be executed.



## Keyboard action handling

KeyboardKit has a ``KeyboardActionHandler`` protocol that describes how to handle actions. 

Many views in the library use actions and an action handler. This gives you a very flexible setup, where you can use the actions you want, then dynamically handle the actions using an action handler. 

Just call ``KeyboardActionHandler/handle(_:on:)`` on an action handler to trigger an action programatically:

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

This is convenient when you have to trigger actions from other parts of your custom keyboard.

KeyboardKit will create a ``StandardKeyboardActionHandler`` instance when the keyboard extension is started, then apply it to ``KeyboardInputViewController/keyboardActionHandler``. It will then use this instance by default to handle actions. You can use this action handler in your own code as well.


## Creating a custom action handler

Many keyboard actions have standard behaviors that are used by default by the library. To customize how the actions are handled, you can implement a custom ``KeyboardActionHandler``.

You can create a custom action handler by either inheriting and customizing the ``StandardKeyboardActionHandler`` class or by implementing ``KeyboardActionHandler`` in a brand new implementation. Inheriting ``StandardKeyboardActionHandler`` is highly recommended, since you get a bunch of implemented logic that you can override with your own custom logic.

For instance, here is a custom action handler that extend ``StandardKeyboardActionHandler`` with the capabilities to copy and save images:


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

This action handler overrides the ``StandardKeyboardActionHandler/action(for:on:)`` function, which is used by the standard action handler to determine whether or not an action can be handled.

To use this action handler instead of the standard one, you can inject it in ``KeyboardInputViewController/viewDidLoad()``:

```swift
class MyKeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        keyboardActionHandler = MyActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom action handler everywhere and add image saving capabilities to your keyboard.
