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

Triggering and handling ``KeyboardAction`` is a central concept in KeyboardKit, where an action can be triggered by the keyboard or by code, then handled with a ``KeyboardActionHandler``.

A ``KeyboardActionHandler`` can either handle a ``KeyboardAction`` in a standard way, or handle it based on a certain ``Keyboard/Gesture``.



## Keyboard Action Namespace

KeyboardKit has a ``KeyboardAction`` enum that defines all supported keyboard actions. It's also a namespace for action-related types and views, like a ``KeyboardAction/StandardHandler`` that provides you with the standard way of handling actions.



## Keyboard Actions

The ``KeyboardAction`` enum defines many keyboard-specific actions, for instance:

* ``KeyboardAction/backspace`` - triggers a backspace deletion.
* ``KeyboardAction/character(_:)`` - inserts a character.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/diacritic(_:)`` - inserts a diacritic.
* ``KeyboardAction/emoji(_:)-swift.enum.case`` - inserts an emoji.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher.

See the ``KeyboardAction`` for a list of all available action types.



## Keyboard Action Handlers

A ``KeyboardActionHandler`` can be used to handle actions, autocomplete suggestions, and to trigger audio and haptic feedback. The action handler is in the center of how actions are handled, and can be customized to fit your needs. 

KeyboardKit automatically creates an instance of ``KeyboardAction/StandardHandler`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.



## Keyboard Action Handler Shorthands

You can easily resolve various service types with these shorthands:

* ``KeyboardActionHandler/standard(controller:)``
* ``KeyboardActionHandler/preview``



## How to handle keyboard actions 

KeyboardKit automatically triggers ``KeyboardAction`` events when a user interacts with the keyboard, or certain events happen. The events are by default handler with the main ``KeyboardInputViewController/services`` action handler, which you can replace to customize how actions are handled. 

You can trigger actions programmatically by calling any of the ``KeyboardActionHandler/handle(_:on:)`` functions to trigger an action with an optional gesture:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    handler.handle(.backspace)
    handler.handle(.press, on: .character("a")
    handler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by a ``Keyboard``.``Keyboard/Button`` or by applying a ``SwiftUICore/View/keyboardButton(_:)`` view modifier to any view:

```swift
Text("Button")
    .keyboardButton(...)
```

``KeyboardView`` applies this modifier to all its buttons, to make them support gestures for press, release, long press, repeat, etc.



## How to handle autocomplete suggestions

A ``KeyboardActionHandler`` can also handle ``Autocomplete``.``Autocomplete/Suggestion`` values, which are for instance what happens when a user taps on a toolbar item in the ``Autocomplete``.``Autocomplete/Toolbar``:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    let suggestion = Autocomlete.Suggestion(text: "Hello")
    handler.handle(suggestion)
}
```

This will by default insert the suggestion into the text document proxy. You can customize this behavior with a custom action handler.



## How to create a custom action handler

You can create a custom ``KeyboardActionHandler`` to customize how certain actions are handled, and to handle actions that don't have any default handling, like ``KeyboardAction/image``, ``KeyboardAction/command``, etc. 

You can implement ``KeyboardActionHandler`` from scratch, or inherit and customize the ``KeyboardAction/StandardHandler`` base class to get a lot of stuff for free. 

For instance, here's a custom action handler that inherits ``KeyboardAction/StandardHandler`` and prints when space is pressed:

```swift
class CustomActionHandler: KeyboardAction.StandardHandler {

    open override func handle(
        _ gesture: Keyboard.Gesture, 
        on action: KeyboardAction
    ) {
        if gesture == .press && action == .space {
            print("Pressed space!")
        }
        super.handle(gesture, on: action) 
    }
}
```

To use your custom handler instead of the standard one, just inject it into ``KeyboardInputViewController/services`` by replacing its ``Keyboard/Services/actionHandler`` property:

```swift
class KeyboardViewController: KeyboardInputViewController {

    override func viewDidLoad() {
        services.actionHandler = CustomActionHandler(inputViewController: self)
        super.viewDidLoad()
    }
}
```

This will make KeyboardKit use your custom implementation instead of the standard one.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
