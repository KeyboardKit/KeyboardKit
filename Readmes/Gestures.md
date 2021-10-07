# Gestures

KeyboardKit comes with keyboard-specific gestures that you can use in your own keyboards.


## Keyboard Gesture

KeyboardKit defines a `KeyboardGesture` that defines various gestures:

* `tap` - occurs when a button is pressed then released inside.
* `doubleTap` - occurs when a button is double tapped.
* `press` - occurs when a button is pressed down.
* `release` - occurs when a button is released, inside or outside.
* `longPress` - occurs when a button is long pressed.
* `repeatPress` - occurs repeatedly when a button is pressed and held.

KeyboardKit also defines gesture handlers, timers etc. to implement various gestures like repeat presses, space dragging etc.


## Binding gestures to views

Keyboard action gestures can be bound to any `SwiftUI` view with the `keyboardGestures` view modifier. This will setup gestures for that will be routed to the provided action handler.
