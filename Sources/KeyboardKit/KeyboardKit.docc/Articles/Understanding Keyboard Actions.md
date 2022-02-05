# Understanding Keyboard Actions

This article describes keyboard actions and how to use action handlers. 


## Keyboard actions

KeyboardKit has a ``KeyboardAction`` enum that defines keyboard-specific actions that correspond to actions that can be found on various keyboards. Keyboard actions are fundamental building-blocks in the library.

Keyboard actions can be bound to buttons and triggered with a ``KeyboardActionHandler``. Keyboard actions are also used to define keyboard layouts and provide a declarative way to express a layout without having to specify exactly how your actions will be executed.



## Keyboard action handler

KeyboardKit has a ``KeyboardActionHandler`` protocol that describes how to handle actions. 

Many views in the library use actions and an action handler to give you a flexible setup, where you can provide actions without having to specify how they are to be handled. 

You can trigger keyboard actions programatically by calling ``KeyboardActionHandler/handle(_:on:)``. This is convenient when you must trigger actions from other parts of your keyboard.

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

KeyboardKit will create a ``StandardKeyboardActionHandler`` instance when the keyboard extension is started, then apply it to ``KeyboardInputViewController/keyboardActionHandler``. It will then use this instance by default to handle actions.


## How to create a custom handler

Many keyboard actions have standard behaviors, while others don't and require custom handling. To customize how actions are handled, you can implement a custom action handler.

You can create a custom action handler by either inheriting and customizing the standard class (which gives you a lot of functionality for free) or by creating a new implementation from scratch. When you're implementation is ready, just replace the controller service with your own implementation to make the library use it instead.

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
