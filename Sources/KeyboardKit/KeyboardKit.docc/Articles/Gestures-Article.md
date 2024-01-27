# Gestures

This article describes the KeyboardKit gesture engine.

iOS keyboards use many gestures. For instance, keys can be pressed and released, space can be long pressed to move the cursor, shift can be double tapped to toggle caps-lock, etc.

These gestures can be complicated to manage, but KeyboardKit provides you with handy views and extensions, and handles most gestures with the ``KeyboardActionHandler`` concept.



## Gestures namespace

KeyboardKit has a ``Gestures`` namespace that contains gesture-related types.

For instance, a ``Gestures/GestureButton`` can be used to apply many gestures to a single button, a ``Gestures/RepeatTimer`` can be used to repeat an action, etc.

This namespace doesn't have protocols, open classes, or types that are meant to be top-level.



## Keyboard gestures

KeyboardKit has a ``Gestures/KeyboardGesture`` enum that defines keyboard gestures:

* ``Gestures/KeyboardGesture/press``
* ``Gestures/KeyboardGesture/release``
* ``Gestures/KeyboardGesture/doubleTap``
* ``Gestures/KeyboardGesture/longPress``
* ``Gestures/KeyboardGesture/repeatPress``

These gestures are used within the library, e.g. to handle ``KeyboardAction``s in various ways.



## Keyboard gestures view modifier

You can use the **.keyboardButtonGestures(...)** view modifier to apply keyboard gestures:

```swift
Text("😀")
    .keyboardButtonGestures(for: .emoji("😀"), ...)
```

You can provide a ``KeyboardActionHandler`` and an optional ``CalloutContext`` to make the button use the KeyboardKit engine, or provide separate actions for every gesture.



## Drag gesture handlers

KeyboardKit has a ``DragGestureHandler`` protocol that handles drag gestures. For instance, a ``Gestures/SpaceDragGestureHandler`` handles drag gestures on the space key.



## Views

KeyboardKit has a ``Gestures/GestureButton`` and a ``Gestures/ScrollViewGestureButton`` that can be used to apply many gestures to the same button.
