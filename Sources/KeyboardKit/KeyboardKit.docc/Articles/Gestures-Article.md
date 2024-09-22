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



## Gestures Namespace

KeyboardKit has a ``Gestures`` namespace with gesture-related types, like ``Gestures/GestureButton``, ``Gestures/ScrollViewGestureButton``, etc.

This namespace does not contain the ``Keyboard/Gesture`` enum, which is an essential type that is instead defined in the ``Keyboard`` namespace. 



## Keyboard gestures view modifier

You can use the ``SwiftUICore/View/keyboardButtonGestures(for:actionHandler:repeatTimer:calloutContext:isPressed:scrollState:releaseOutsideTolerance:)`` view modifier to apply keyboard gesture to any view:

```swift
Text("😀")
    .keyboardButtonGestures(
        for: .emoji("😀"), 
        doubleTapAction: { ... },
        ...
    )
```



## Drag gesture handlers

KeyboardKit has a ``DragGestureHandler`` protocol that handles drag gestures. For instance, a ``Gestures/SpaceDragGestureHandler`` handles drag gestures on the space key.



## Views

KeyboardKit has a ``Gestures/GestureButton`` & ``Gestures/ScrollViewGestureButton`` that can be used to apply many gestures to the same button.
