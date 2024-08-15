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

Native iOS keyboards use more gestures than you probably realize at first. For instance, keys can be pressed, released, long pressed, etc., space can be dragged to move the cursor, shift can be double tapped to toggle caps-lock, etc.

These gestures can be complicated to set up, but KeyboardKit provides you with handy views and extensions to easily be able to define rich gesture actions that are handled by the ``KeyboardActionHandler``, or any custom actions that you specify.



## Gestures Namespace

KeyboardKit has a ``Gestures`` namespace with gesture-related types, like ``Gestures/GestureButton``, ``Gestures/ScrollViewGestureButton``, etc.



## Keyboard Gestures

KeyboardKit has a ``Gestures/KeyboardGesture`` enum that defines supported keyboard gestures, like ``Gestures/KeyboardGesture/press``, ``Gestures/KeyboardGesture/release``, ``Gestures/KeyboardGesture/doubleTap``, etc.

These gestures are used within the library, e.g. to handle ``KeyboardAction``s in various ways. The built in gestures can also provide drag information when a user presses and drags a view.



## Keyboard gestures view modifier

You can use the ``SwiftUI/View/keyboardButtonGestures(for:actionHandler:calloutContext:isPressed:isInScrollView:releaseOutsideTolerance:)`` view modifier to apply keyboard gestures:

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
