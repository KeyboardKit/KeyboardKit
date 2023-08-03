# Gestures

This article describes the KeyboardKit gesture engine.

If you consider a native iOS keyboard, it actually applies a bunch of gestures to its keys. Input keys can be pressed and released, while some actions trigger on press. The space bar can by default be long pressed to enter a cursor drag state, while the backspace can be long pressed to repeat the delete backwards operation. Input keys can also be long pressed to show a callout with secondary actions.   
 
KeyboardKit comes with keyboard-specific gestures and views that you can use in your own keyboards, to simplify adding and handling gestures to a button.


## Keyboard gestures

KeyboardKit has a ``KeyboardGesture`` enum that defines various gestures:

* `tap` - occurs when a button is pressed then released inside.
* `doubleTap` - occurs when a button is double tapped.
* `press` - occurs when a button is pressed down.
* `release` - occurs when a button is released, inside or outside.
* `longPress` - occurs when a button is long pressed.
* `repeatPress` - occurs repeatedly when a button is pressed and held.

KeyboardKit also defines gesture handlers, timers etc. to implement various gestures like repeat presses, space dragging etc.



## Binding gestures to a view

You can use the `keyboardGestures` view modifier to bind keyboard-specific gestures to any view. This will setup view gestures for a certain action. You can also use the ``GestureButton`` and ``ScrollViewGestureButton`` to apply complex gestures to a button.
