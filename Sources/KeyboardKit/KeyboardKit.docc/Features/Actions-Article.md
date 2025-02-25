# Actions

This article describes the KeyboardKit action engine.

@Metadata {

    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
}

The ``KeyboardAction`` type is a central concept in KeyboardKit, where an action can be triggered by the keyboard or by code, then handled with a ``KeyboardActionHandler``.

A ``KeyboardActionHandler`` can either handle a ``KeyboardAction`` in a standard way, or handle it based on a certain ``Keyboard/Gesture`` for more granular control when triggering actions programatically.

👑 [KeyboardKit Pro][Pro] injects more capabilities into the action handler, to make it handle locale-specific input methods like Vietnamese.



## Namespace

KeyboardKit has a ``KeyboardAction`` enum that defines a bunch of keyboard-related actions. It's also a namespace for action-related types and views, like a ``KeyboardAction/StandardActionHandler`` that provides you with a standard way to handle actions.

Here are just some of the many actions that the enum defines. See the full ``KeyboardAction`` documentation for a full list of actions:

* ``KeyboardAction/backspace`` - triggers a backspace deletion.
* ``KeyboardAction/character(_:)`` - inserts a character.
* ``KeyboardAction/dismissKeyboard`` - dismisses the keyboard.
* ``KeyboardAction/diacritic(_:)`` - inserts a diacritic.
* ``KeyboardAction/emoji(_:)-swift.enum.case`` - inserts an emoji.
* ``KeyboardAction/keyboardType(_:)`` - changes the keyboard type.
* ``KeyboardAction/nextKeyboard`` - triggers the system keyboard switcher.
* ``KeyboardAction/nextLocale`` - triggers the locale switcher.

Many actions have a ``KeyboardAction/standardAction``, and a ``KeyboardAction/standardButtonText(for:)`` or ``KeyboardAction/standardButtonImage(for:)`` while others require manual handling by creating a custom ``KeyboardActionHandler``.



## Action Handlers

A ``KeyboardActionHandler`` can handle actions, apply ``Autocomplete/Suggestion`` values, trigger audio & haptic feedback, etc. It's in the center of how actions are handled, and can be customized to fit your needs.

For instance, to customize what happens when a user double-taps space, you can override ``KeyboardActionHandler/handle(_:on:)`` and check if the action is ``KeyboardAction/space`` and the gesture is ``Keyboard/Gesture/doubleTap``. If so, do your custom thing, else call super.

KeyboardKit automatically creates an instance of ``KeyboardAction/StandardActionHandler`` and injects it into ``KeyboardInputViewController/services``. You can replace it at any time, as described further down.



## 👑 KeyboardKit Pro

[KeyboardKit Pro][Pro] injects more capabilities into the ``KeyboardAction/StandardActionHandler``, to make it handle locale-specific input methods like Vietnamese TELEX, VIQR, and VNI, and handle other locale and pro-specific replacements.


---


## How to... 


### ...trigger keyboard actions 

KeyboardKit automatically triggers ``KeyboardAction``s when users interact with the keyboard or when certain events happen. Actions are by default handled with the main ``Keyboard/Services/actionHandler``, which you can replace to customize how actions are handled. 

You can trigger actions programmatically with ``KeyboardActionHandler/handle(action:)``, or trigger ``KeyboardActionHandler/handle(_:on:)`` to simulate a certain action gesture:

```swift
func doStuff(with handler: KeyboardActionHandler) {
    handler.handle(.backspace)
    handler.handle(.press, on: .character("a"))
    handler.handle(.release, on: .dismissKeyboard)
}
```

Keyboard actions can also be triggered by a ``Keyboard``.``Keyboard/Button`` or by applying a `.keyboardButton(...)` modifier to any view:

```swift
Text("Button")
    .keyboardButton(...)
```

``KeyboardView`` applies this modifier to all its buttons, to automatically make them support press, release, long press, repeat, etc.


### ...handle keyboard actions

Actions are by default handled with the main ``Keyboard/Services/actionHandler``, which you can replace to customize how actions are handled. This is required for some actions that don't have a standard or default behavior.

You can either implement the ``KeyboardActionHandler`` protocol from scratch, or inherit the ``KeyboardAction/StandardActionHandler`` class and override any of the many functions that it provides to add your own customizations to the standard behavior.



### ...handle autocomplete suggestions

A ``KeyboardActionHandler`` can also handle ``Autocomplete``.``Autocomplete/Suggestion`` values, which are for instance what happens when a user taps a suggestion in an  ``Autocomplete``.``Autocomplete/Toolbar``:

```swift
func handle(_ suggestion: Autocomplete.Suggestion, with handler: KeyboardActionHandler) {
    handler.handle(.suggestion(suggestion))
}
```

This will by default insert the suggestion into the text document proxy. You can customize this behavior with a custom action handler.


### ...create a custom action handler

You can create a custom ``KeyboardActionHandler`` to customize how certain actions are handled, and to handle actions that don't have a standard or default behavior, like ``KeyboardAction/image``, ``KeyboardAction/command``, etc. 

You can implement the ``KeyboardActionHandler`` protocol from scratch, or inherit and customize ``KeyboardAction/StandardActionHandler``:

```swift
class CustomActionHandler: KeyboardAction.StandardActionHandler {

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
        super.viewDidLoad()
        services.actionHandler = CustomActionHandler(controller: self)
        setup(for: .myApp)  // See the getting-started guide
    }
}
```

This will make KeyboardKit use your custom action handler instead of the standard one.



[Pro]: https://github.com/KeyboardKit/KeyboardKitPro
