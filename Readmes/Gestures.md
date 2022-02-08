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

You can use the `keyboardGestures` view modifier to bind keyboard-specific gestures to any `SwiftUI` view. This will setup view gestures for a certain action.


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on gestures.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
