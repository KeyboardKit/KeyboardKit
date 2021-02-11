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

You can enable haptic feedback globally by providing `StandardKeyboardActionHandler` with a `hapticConfiguration`. The default configuration is `.noFeedback`. You can also trigger the various feedback types manually.


## Full Access

Haptic feedback requires full access. Users must manually enable full access under system settings. 
