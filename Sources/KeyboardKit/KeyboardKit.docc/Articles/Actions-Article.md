# Actions

This article describes the KeyboardKit action engine.

In KeyboardKit, the ``KeyboardAction`` enum defines keyboard-specific actions that can be bound to buttons and handled with a ``KeyboardActionHandler``.

[KeyboardKit Pro][Pro] makes the keyboard action handler automatically register the most recently used emojis. Information about Pro features can be found at the end of this article.



## Keyboard actions

The ``KeyboardAction`` enum contains a bunch of actions, for instance:

* ``KeyboardAction/character(_:)`` - inserts a text character.
* ``KeyboardAction/backspace`` - deletes backwards.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action.

See the ``KeyboardAction`` documentation for a list of all available action types.



## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can handle keyboard actions.

KeyboardKit injects a ``StandardKeyboardActionHandler`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time.

KeyboardKit automatically triggers actions when a user interacts with the keyboard, or certain system events happen. You can intercept these actions with a custom action handler.

You can trigger actions programmatically by calling `handle(_:)` or `handle(_:on:)` to trigger an action with an optional gesture:

```swift
func doStuff(with actionHandler: KeyboardActionHandler) {
    actionHandler.handle(.backspace)
    actionHandler.handle(.press, on: .character("a")
    actionHandler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by a ``KeyboardButton/Button`` or by applying `.keyboardButton(...)` to any view:

```swift
Text("Button")
    .keyboardButton(...)
```

``SystemKeyboard`` applies this modifier to all its buttons, which makes them support gestures for press, release, long press, repeat press, drag, etc.



## How to handle autocomplete suggestions

A ``KeyboardActionHandler`` can also handle ``Autocomplete/Suggestion`` items, since it must be able to do so when handling various actions and gestures:

```swift
func doStuff(with actionHandler: KeyboardActionHandler) {
    let suggestion = Autocomlete.Suggestion(text: "Hello")
    actionHandler.handle(suggestion)
}
```

This will by default insert the suggestion into the text document proxy and reset autocomplete state. You can customize this behavior by creating a custom action handler.



## How to create a custom action handler

You can create a custom action handler to handle actions that don't have a default behavior, like ``KeyboardAction/image``, or customize the handling of certain actions or gestures.

You can either inherit ``StandardKeyboardActionHandler`` and customize what you want, or implement the ``KeyboardActionHandler`` protocol from scratch. 

For instance, here's a custom handler that inherits ``StandardKeyboardActionHandler`` and prints when space is pressed:

```swift
class CustomActionHandler: StandardActionHandler {

    open override func handle(
        _ gesture: KeyboardGesture, 
        on action: KeyboardAction
    ) {
        if gesture == .press && action == .space {
            print("Pressed space!")
        }
        super.handle(gesture, on: action) 
    }
}
```

To use this handler instead of the standard one, just inject it into ``KeyboardInputViewController/services``:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom handler instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] injects a ``StandardKeyboardActionHandler/emojiRegistrationAction`` into the ``StandardKeyboardActionHandler``, that automatically registers emojis as you use them. 

This will automatically update the "most recent" emojis category in the emoji keyboard with the most recently used emojis.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
