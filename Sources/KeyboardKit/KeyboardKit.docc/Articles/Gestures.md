# Gestures

This article describes the KeyboardKit gesture engine.

Native iOS keyboard, applies a bunch of gestures to its keys. For instance, input keys can be pressed and released, while some actions trigger on press and some on release. 

Furthermore, the space bar can be long pressed to move the input cursor, the backspace can be long pressed to repeat the delete operation, shift can be double tapped, etc.   
 
KeyboardKit comes with keyboard-specific gestures and view modifiers that you can use to apply rich gestures to your keys.



## Keyboard gestures

KeyboardKit has a ``KeyboardGesture`` enum that defines various gestures:

* ``KeyboardGesture/press`` - occurs when a key is pressed.
* ``KeyboardGesture/release`` - occurs when a key is released, inside or outside.
* ``KeyboardGesture/doubleTap`` - occurs when a key is double tapped.
* ``KeyboardGesture/longPress`` - occurs when a key is long pressed.
* ``KeyboardGesture/repeatPress`` - triggers repeatedly while a key is pressed.

You can use the `keyboardButtonGestures` view modifier on any key, to add keyboard-specific gestures for a certain action.



## Gesture buttons

For non-key views, you can use the ``GestureButton`` and ``ScrollViewGestureButton`` to apply complex gestures to any button.
