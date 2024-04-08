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

In KeyboardKit, the ``KeyboardAction`` enum defines keyboard-specific actions, that can be triggered by the keyboard or by code, and handled with a ``KeyboardActionHandler``.

👑 [KeyboardKit Pro][Pro] extends the action handler, and makes it register the most recently used emojis in a way that automatically updates the ``EmojiCategory/frequent`` category. Information about Pro features can be found at the end of this article.



## Keyboard actions

The ``KeyboardAction`` enum defines many keyboard-specific actions, for instance:

* ``KeyboardAction/character(_:)`` - triggers a character text insertion.
* ``KeyboardAction/backspace`` - triggers a backspace deletion.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher action.

See the ``KeyboardAction`` for a list of all available action types.



## Keyboard action handlers

In KeyboardKit, a ``KeyboardActionHandler`` can be used to handle actions, autocomplete, and to trigger audio & haptic feedback.

KeyboardKit automatically creates an instance of ``KeyboardAction/StandardHandler`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.



## How to trigger keyboard actions

KeyboardKit automatically triggers actions when a user interacts with the keyboard, or when certain system events happen. You can intercept these actions with a custom action handler, to perform any logic you want.

You can trigger actions programmatically by calling any of the ``KeyboardActionHandler/handle(_:on:)`` functions to trigger an action with an optional gesture:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    handler.handle(.backspace)
    handler.handle(.press, on: .character("a")
    handler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by a keyboard ``Keyboard/Button`` or by applying the ``SwiftUI/View/keyboardButton(_:)`` view modifier to any view:

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

You can create a custom ``KeyboardActionHandler`` to customize how certain actions are handled, and to handle actions that don't have any default handling, like ``KeyboardAction/image``. 

You can implement ``KeyboardActionHandler`` from scratch, or inherit and customize the ``KeyboardAction/StandardHandler``. For instance, here's a custom action handler that inherits ``KeyboardAction/StandardHandler`` and prints when space is pressed:

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



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] injects an ``KeyboardAction/StandardHandler/emojiRegistrationAction`` function into the ``KeyboardAction/StandardHandler`` and uses it to automatically register emojis as you use them, which will automatically update the ``EmojiCategory/frequent`` ``EmojiCategory``.

This means that the ``EmojiKeyboard`` is automatically updated with the most recently used emojis when emoji actions are triggered.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
