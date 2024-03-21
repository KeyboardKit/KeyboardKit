# Actions

This article describes the KeyboardKit action engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )

    @PageColor(blue)
}

In KeyboardKit, ``KeyboardAction`` defines keyboard-specific actions that can be triggered by the keyboard or by code, and handled with a ``KeyboardActionHandler``.

👑 [KeyboardKit Pro][Pro] makes the action handler automatically register the most recently used emojis. Information about Pro features can be found at the end of this article.



## Keyboard actions

The ``KeyboardAction`` enum defines many keyboard-specific actions, for instance:

* ``KeyboardAction/character(_:)`` - triggers a character text insertion.
* ``KeyboardAction/backspace`` - triggers a backspace deletion.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action.

See the ``KeyboardAction`` for a list of all available action types.



## How to handle keyboard actions

Keyboard actions can be handled with a ``KeyboardActionHandler``, which is a protocol that can be implemented by any class that can handle keyboard actions.

KeyboardKit injects a ``StandardKeyboardActionHandler`` into ``KeyboardInputViewController/services``. You can modify or replace this instance at any time.

KeyboardKit automatically triggers actions when a user interacts with the keyboard, or when certain system events happen. You can intercept these actions with a custom action handler, to perform any logic you want.

You can trigger actions programmatically by calling ``KeyboardActionHandler/handle(_:)-35vwk`` or ``KeyboardActionHandler/handle(_:on:)`` to trigger an action with an optional gesture:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    handler.handle(.backspace)
    handler.handle(.press, on: .character("a")
    handler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by a keyboard ``KeyboardButton/Button`` or by applying the ``SwiftUI/View/keyboardButton(_:)`` view modifier to any view:

```swift
Text("Button")
    .keyboardButton(...)
```

``SystemKeyboard`` applies this modifier to all its buttons, to make them support gestures for press, release, long press, repeat, etc.



## How to handle autocomplete suggestions

A ``KeyboardActionHandler`` can also handle ``Autocomplete/Suggestion``s, which are triggered when tapping items in an autocomplete toolbar:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    let suggestion = Autocomlete.Suggestion(text: "Hello")
    handler.handle(suggestion)
}
```

This will by default insert the suggestion into the text document proxy and reset autocomplete state. You can customize this behavior by creating a custom action handler.



## How to create a custom action handler

You can create a custom action handler to customize certain actions, and to handle actions that don't have default actions, like ``KeyboardAction/image``. 

You can implement ``KeyboardActionHandler`` from scratch, or inherit and customize ``StandardKeyboardActionHandler``. 

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

This will make KeyboardKit use your custom implementation instead of the standard one.



## 👑 Pro features

[KeyboardKit Pro][Pro] injects an ``StandardKeyboardActionHandler/emojiRegistrationAction`` function into the ``StandardKeyboardActionHandler``, then uses it to automatically register emojis as you use them.

This will automatically update the "most recent" **EmojiCategory** and make the **EmojiKeyboard** display the most recently used emojis.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
