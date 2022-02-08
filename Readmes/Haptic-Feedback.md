# Haptic Feedback

KeyboardKit defines haptic feedback types and ways to trigger them.


## Haptic Feedback

KeyboardKit has a `HapticFeedback` enum with some pre-defined feedback types, such as:

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

You can configure the haptic feedback in your keyboard by modifying the `keyboardFeedbackSettings` of the input view controller or registering a custom `keyboardFeedbackHandler`.


## Full Access

Haptic feedback requires full access. 


## Read more

Have a look in the [documentation][Documentation] for more in-depth information on audio and haptic feedback.



[Documentation]: https://github.com/danielsaidi/Documentation/blob/main/Docs/KeyboardKit.doccarchive.zip?raw=true
