# Haptic Feedback

KeyboardKit has an `HapticFeedback` enum with these types:

* `error`
* `success`
* `warning`

* `lightImpact`
* `mediumImpact`
* `heavyImpact`

* `selectionChanged`

* `none`

You can enable haptic feedback globally by providing `StandardKeyboardActionHandler` with a `hapticConfiguration`. The default configuration is `.noFeedback`.

You can also trigger the various haptic feedback types manually.

`IMPORTANT` Users must enable open access for haptic feedback to work.
