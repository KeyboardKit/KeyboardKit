# Haptic Feedback

KeyboardKit supports haptic feedback, which means that users can get haptic feedback as they type:

KeyboardKit comes with some built-in feedback types:

* `error`
* `success`
* `warning`

* `lightImpact`
* `mediumImpact`
* `heavyImpact`

* `selectionChanged`

* `none`

You can enable haptic feedback by providing the `keyboardActionHandler` with a haptic feedback configuration. The default configuration is `.noFeedback`.

`Important` Users must enable open access for haptic feedback to work.
