# Haptic Feedback

KeyboardKit defines haptic feedback types and ways to trigger them.


## Haptic Feedback

KeyboardKit has a `HapticFeedback` enum with these types:

* `error`
* `success`
* `warning`

* `lightImpact`
* `mediumImpact`
* `heavyImpact`

* `selectionChanged`

* `none`

You can prepare and trigger these feedback types directly, using the `prepare()` and `trigger()` functions.


## Configuration

KeyboardKit has a `HapticFeedbackConfiguration` type that lets you configure haptic feedback.

KeyboardKit defines a few predefined configurations:

* `enabled` - enables all haptic feedback 
* `noFeedback` - disables all haptic feedback
* `standard` - only enables long press on `space` feedback 

You can configure haptic feedback by registering a custom `feedback handler`.


## Full Access

Haptic feedback requires full access. 
