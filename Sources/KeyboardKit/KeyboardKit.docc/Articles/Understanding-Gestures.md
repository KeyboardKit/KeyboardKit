# Understanding Gestures

This article describes the KeyboardKit gesture engine.

Native iOS keyboard applies a bunch of gestures to its keys. For instance, input keys can be pressed and released, while some actions trigger on press and some on release. 

Furthermore, the space bar can be long pressed to either move the input cursor or show a secondary menu, the backspace can be long pressed to repeat the delete operation, shift can be double tapped to enable caps lock, etc.

So, keyboard gestures can be quite complicated. However, KeyboardKit handles most for you with the ``KeyboardActionHandler`` concept. It also comes with keyboard-specific gestures and view modifiers that you can easily apply to your views.



## Gestures namespace

KeyboardKit has a ``Gestures`` namespace that contains gesture-related types and views, except services and contexts.

For instance, a ``Gestures/GestureButton`` can be used to apply many gestures to a single button, a ``Gestures/RepeatTimer`` can be used to repeat an actio, and there are also some types to configure space gestures.



## Keyboard gestures

The ``Gestures`` namespace has a ``Gestures/KeyboardGesture`` enum that defines various keyboard gestures:

* ``Gestures/KeyboardGesture/press`` - occurs when a key is pressed.
* ``Gestures/KeyboardGesture/release`` - occurs when a key is released, inside or outside.
* ``Gestures/KeyboardGesture/doubleTap`` - occurs when a key is double tapped.
* ``Gestures/KeyboardGesture/longPress`` - occurs when a key is long pressed.
* ``Gestures/KeyboardGesture/repeatPress`` - triggers repeatedly while a key is pressed.

These gestures are used quite a bit within the library, to handle ``KeyboardAction``s in various ways.



## Keyboard gestures view modifier

You can use the `keyboardButtonGestures` view modifier to add keyboard-specific gestures to any view:

```swift
Text("😀")
    .keyboardButtonGestures(for: .emoji("😀"), ...)
```

This will make the view behave like a keyboard button, and update the provided contexts and bindings as you interact with the button.



## Drag gesture handlers

KeyboardKit has a ``DragGestureHandler`` protocol that can be used to handle drag gestures. For instance, a ``SpaceCursorDragGestureHandler`` is used to handle drag gestures on the space key.
