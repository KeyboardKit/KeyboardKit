# Gestures

This article describes the KeyboardKit gesture engine.

@Metadata {
    
    @PageImage(
        purpose: card,
        source: "Page",
        alt: "Page icon"
    )
    
    @PageColor(blue)
}

Native iOS keyboards use more gestures than you may think. For instance, keys can be pressed, released, long pressed, etc. Space can be dragged to move the cursor, shift can be double tapped to toggle caps-lock, etc.

These gestures can be complicated to set up, but KeyboardKit provides you with a ``Keyboard/Gesture`` enum that defines all supported gestures, as well as views and extensions that trigger rich gesture actions that can be handled by a ``KeyboardActionHandler``.



## Namespace

KeyboardKit has a ``Gestures`` namespace with gesture-related types, like ``GestureButton``. It however doesn't contain the ``Keyboard/Gesture`` enum, which is an essential type that is defined in the ``Keyboard`` namespace. 



## View Modifiers

You can use the ``SwiftUICore/View/keyboardButtonGestures(for:actionHandler:repeatTimer:calloutContext:isPressed:isGestureAutoCancellable:scrollState:releaseOutsideTolerance:)``
modifier to apply keyboard gesture to any view:

```swift
Text("😀")
    .keyboardButtonGestures(
        for: .emoji("😀"),
        ...
    )
```

This will apply all standard gestures for the provided action. You can also set up completely custom gesture actions with this modifier.



## Drag gesture handlers

KeyboardKit has a ``DragGestureHandler`` protocol that handles drag gestures. For instance, a ``Gestures/SpaceDragGestureHandler`` handles drag gestures on the space key.
